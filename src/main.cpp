#include "defaultObjects.h"
#include "events.h"
#include "hooks.h"
#include "papyrus.h"

void MessageHandler(SKSE::MessagingInterface::Message* a_message) {
    if (a_message->type == SKSE::MessagingInterface::kDataLoaded) {
        SKSE::GetPapyrusInterface()->Register(Papyrus::RegisterFunctions);
        Events::SoulTrapListener::GetSingleton()->RegisterListener();
        Events::ActorDeathListener::GetSingleton()->RegisterListener();
        Events::HitEventListener::GetSingleton()->RegisterListener();
        Events::InputEventListener::GetSingleton()->RegisterListener();

        if (!DefaultObjects::Storage::GetSingleton()->Initialize()) {
            _loggerError("Failed to get the default objects for Prelude to Purgatory.");
        }
        Hooks::Install();
    }
}

extern "C" DLLEXPORT constinit auto SKSEPlugin_Version = []() {
    SKSE::PluginVersionData v;
    v.PluginVersion(Plugin::VERSION);
    v.PluginName(Plugin::NAME);
    v.AuthorName("SeaSparrow");
    v.UsesAddressLibrary();
    v.UsesUpdatedStructs();
    v.CompatibleVersions({ SKSE::RUNTIME_SSE_LATEST_AE });
    return v;
    }();

extern "C" DLLEXPORT bool __cdecl SKSEPlugin_Load(const SKSE::LoadInterface* a_skse) {
    // alloc
    SKSE::InitInfo info{};
    info.log = true;
    info.trampoline = true;
    info.trampolineSize = 280u; // temporary, FIX LATER
    SKSE::Init(a_skse, info);

    auto messaging = SKSE::GetMessagingInterface();
    messaging->RegisterListener(MessageHandler);

    SKSE::GetMessagingInterface()->RegisterListener(
        "CustomSkills",
        [](auto msg)
        {
            CustomSkills::QueryCustomSkillsInterface(msg, PluginAPIStorage::get().customSkills);
            const auto customSkills = PluginAPIStorage::get().customSkills;
            if (!customSkills)
                return;
        });
    return true;
}