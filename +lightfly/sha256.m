function result = sha256(str)
    import java.security.*;
    import java.math.*;
    import java.lang.String;
    md = MessageDigest.getInstance('SHA-256');
    hash = md.digest(unicode2native(str)); 
    bi = BigInteger(1, hash);
    result = char(String.format('%064x', bi));
end
