
// autogenerated tests for w3strings (require modBase-Utils)
// language: fr

function _test_verifyW3strings() : int {
    var failed: int;
    failed = 0;

    // test by id
    if (!assertTrue(GetLocStringById(2116006000) == "Mods", "w3string.byId: 2116006000")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006001) == "JL102LM", "w3string.byId: 2116006001")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006002) == "SSAO", "w3string.byId: 2116006002")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006003) == "Environmement intérieurs personnalisés", "w3string.byId: 2116006003")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006004) == "Type de filtre du Shadow Mapping", "w3string.byId: 2116006004")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006005) == "Flou", "w3string.byId: 2116006005")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006006) == "Intermédiaire", "w3string.byId: 2116006006")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006007) == "Net", "w3string.byId: 2116006007")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006008) == "Mod d'éclairage de Jojolapin102", "w3string.byId: 2116006008")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006009) == "Multiplicateur SSAO : Intérieur", "w3string.byId: 2116006009")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006010) == "HBAO", "w3string.byId: 2116006010")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006011) == "2048", "w3string.byId: 2116006011")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006012) == "3072", "w3string.byId: 2116006012")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006013) == "4096", "w3string.byId: 2116006013")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006014) == "5120", "w3string.byId: 2116006014")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006015) == "6144", "w3string.byId: 2116006015")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006016) == "7680", "w3string.byId: 2116006016")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006017) == "8192", "w3string.byId: 2116006017")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006018) == "Résolution des ombres projetées", "w3string.byId: 2116006018")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006019) == "Défaut", "w3string.byId: 2116006019")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006020) == "FLOU", "w3string.byId: 2116006020")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006021) == "MÉDIUM", "w3string.byId: 2116006021")) failed += 1;
    if (!assertTrue(GetLocStringById(2116006022) == "NET", "w3string.byId: 2116006022")) failed += 1;

    // test by key
    if (!assertTrue(GetLocStringByKey("panel_Mods") == "Mods", "w3string.byKey: panel_Mods")) failed += 1;
    if (!assertTrue(GetLocStringByKey("panel_jl102Config") == "JL102LM", "w3string.byKey: panel_jl102Config")) failed += 1;
    if (!assertTrue(GetLocStringByKey("preset_value_jl102_defaultSSAO") == "SSAO", "w3string.byKey: preset_value_jl102_defaultSSAO")) failed += 1;
    if (!assertTrue(GetLocStringByKey("option_jl102_envIntEn") == "Environmement intérieurs personnalisés", "w3string.byKey: option_jl102_envIntEn")) failed += 1;
    if (!assertTrue(GetLocStringByKey("option_jl102_shadow_filter") == "Type de filtre du Shadow Mapping", "w3string.byKey: option_jl102_shadow_filter")) failed += 1;
    if (!assertTrue(GetLocStringByKey("preset_value_jl102_smooth") == "Flou", "w3string.byKey: preset_value_jl102_smooth")) failed += 1;
    if (!assertTrue(GetLocStringByKey("preset_value_jl102_medium") == "Intermédiaire", "w3string.byKey: preset_value_jl102_medium")) failed += 1;
    if (!assertTrue(GetLocStringByKey("preset_value_jl102_sharp") == "Net", "w3string.byKey: preset_value_jl102_sharp")) failed += 1;
    if (!assertTrue(GetLocStringByKey("preset_Mods_jl102Config") == "Mod d'éclairage de Jojolapin102", "w3string.byKey: preset_Mods_jl102Config")) failed += 1;
    if (!assertTrue(GetLocStringByKey("option_jl102_ssaoIntMul") == "Multiplicateur SSAO : Intérieur", "w3string.byKey: option_jl102_ssaoIntMul")) failed += 1;
    if (!assertTrue(GetLocStringByKey("preset_value_jl102_defaultHBAO") == "HBAO", "w3string.byKey: preset_value_jl102_defaultHBAO")) failed += 1;
    if (!assertTrue(GetLocStringByKey("preset_value_2048") == "2048", "w3string.byKey: preset_value_2048")) failed += 1;
    if (!assertTrue(GetLocStringByKey("preset_value_3072") == "3072", "w3string.byKey: preset_value_3072")) failed += 1;
    if (!assertTrue(GetLocStringByKey("preset_value_4096") == "4096", "w3string.byKey: preset_value_4096")) failed += 1;
    if (!assertTrue(GetLocStringByKey("preset_value_5120") == "5120", "w3string.byKey: preset_value_5120")) failed += 1;
    if (!assertTrue(GetLocStringByKey("preset_value_6144") == "6144", "w3string.byKey: preset_value_6144")) failed += 1;
    if (!assertTrue(GetLocStringByKey("preset_value_7680") == "7680", "w3string.byKey: preset_value_7680")) failed += 1;
    if (!assertTrue(GetLocStringByKey("preset_value_8192") == "8192", "w3string.byKey: preset_value_8192")) failed += 1;
    if (!assertTrue(GetLocStringByKey("option_cascade_shadowmap_size") == "Résolution des ombres projetées", "w3string.byKey: option_cascade_shadowmap_size")) failed += 1;
    if (!assertTrue(GetLocStringByKey("preset_value_jl102_default") == "Défaut", "w3string.byKey: preset_value_jl102_default")) failed += 1;
    if (!assertTrue(GetLocStringByKey("preset_value_jl102_smooth_default") == "FLOU", "w3string.byKey: preset_value_jl102_smooth_default")) failed += 1;
    if (!assertTrue(GetLocStringByKey("preset_value_jl102_medium_default") == "MÉDIUM", "w3string.byKey: preset_value_jl102_medium_default")) failed += 1;
    if (!assertTrue(GetLocStringByKey("preset_value_jl102_sharp_default") == "NET", "w3string.byKey: preset_value_jl102_sharp_default")) failed += 1;

    // return number of failed
    return failed;
}

exec function test_verifyW3Strings() {
    logTestResult("Verify W3Strings", _test_verifyW3strings(), true);
}
