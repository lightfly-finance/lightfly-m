function token = get_sign(params)
    params("sign_date") = datestr(now, "yyyy-mm-dd");
    token = lightfly.sha256(lightfly.sort_map(params));
end

