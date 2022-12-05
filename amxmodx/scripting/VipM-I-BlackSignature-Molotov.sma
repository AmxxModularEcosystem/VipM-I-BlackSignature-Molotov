#include <amxmodx>
#include <VipModular>
#include <molotov_cocktail>

#pragma semicolon 1
#pragma compress 1

public stock const PluginName[] = "[VipM-I] BlackSignature's Molotov";
public stock const PluginVersion[] = "1.0.0";
public stock const PluginAuthor[] = "ArKaNeMaN";
public stock const PluginURL[] = "t.me/arkanaplugins";
public stock const PluginDescription[] = "BlackSignature's molotov support for Vip Modular";

new const TYPE_NAME[] = "BlackSignature-Molotov";

public VipM_IC_OnInitTypes() {
    register_plugin(PluginName, PluginVersion, PluginAuthor);

    VipM_IC_RegisterType(TYPE_NAME);
    VipM_IC_RegisterTypeEvent(TYPE_NAME, ItemType_OnRead, "@OnRead");
    VipM_IC_RegisterTypeEvent(TYPE_NAME, ItemType_OnGive, "@OnGive");
}

@OnRead(const JSON:jCfg, Trie:tParams) {
    TrieDeleteKey(tParams, "Name");

    if (json_object_has_value(jCfg, "Count", JSONNumber)) {
        TrieSetCell(tParams, "Count", json_object_get_number(jCfg, "Count"));
    }

    if (json_object_has_value(jCfg, "Max", JSONNumber)) {
        TrieSetCell(tParams, "Max", json_object_get_number(jCfg, "Max"));
    }

    return VIPM_CONTINUE;
}

@OnGive(const UserId, const Trie:tParams) {
    return Molotov_GiveNade(
        UserId,
        VipM_Params_GetInt(tParams, "Count", 1),
        VipM_Params_GetInt(tParams, "Max", 1)
    ) >= 0 ? VIPM_CONTINUE : VIPM_STOP;
}
