From: "Maximilian Schwerin" <Maximilian.Schwerin@tigris.de>
Subject: 1GHz support for OMAP3
Date: Fri, 1 Mar 2013 09:17:04 +0100
Message-ID: <5448984682E7954C9BFF27F747A9C6CA5F34C6@dolphin.TIGRIS.local>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha1"; boundary="----9451F8E7E6F23950CD1CE870FD50F8BF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www45.your-server.de ([213.133.104.45]:60160 "EHLO
	www45.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab3CAIpU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Mar 2013 03:45:20 -0500
Received: from [77.186.59.242] (helo=TIGRIS-Firewall)
	by www45.your-server.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.74)
	(envelope-from <prvs=0772d5bc22=maximilian.schwerin@tigris.de>)
	id 1UBL9W-0007DY-6f
	for linux-omap@vger.kernel.org; Fri, 01 Mar 2013 09:17:15 +0100
Received: from dolphin.tigris.local ([192.168.0.10]:2686)
	by TIGRIS-Firewall with esmtp (Exim 4.76)
	(envelope-from <Maximilian.Schwerin@tigris.de>)
	id 1UBL9M-0004c7-2S
	for linux-omap@vger.kernel.org; Fri, 01 Mar 2013 09:17:04 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is an S/MIME signed message

------9451F8E7E6F23950CD1CE870FD50F8BF
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

we've built a beagleboard xm clone last year and successfully managed to =
get it running it at 1GHz with a 3.1 kernel. Our current 3.3 kernel only =
runs at 800MHz stabely. This fact and some issues we've been having with =
the USB stack make us want to update to a more recent kernel version. So =
my question is what the current state of 1 GHz support for said platform =
is. Last time I looked the beagleboard still did not have this enabled.

Is 1GHz support coming some time soon? Is there a possibility to speed =
up development by paying a developer to finish work on this?

Regards,

Maximilian

_________________________________________________________________________=
_________________

=A0Maximilian Schwerin | maximilian.schwerin@tigris.de

=A0Tigris Elektronik GmbH | Wikingerufer 7 | 10555 Berlin, Germany | =
http://www.tigris.de
=A0Tel: +49 (30) 301048-30 | Fax: +49 (30) 301048-59

=A0Gesch=E4ftsf=FChrer/CEO: Henry Westphal, Guido Kuhlmann
=A0Sitz der Gesellschaft/Company's registered office: Berlin
=A0Amtsgericht/Register: Berlin-Charlottenburg, HRB 71737

=A0PGP-Keys: mailto:pgp@tigris.de
_________________________________________________________________________=
_________________

------9451F8E7E6F23950CD1CE870FD50F8BF
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIK+wYJKoZIhvcNAQcCoIIK7DCCCugCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3
DQEHAaCCCFIwggQeMIIDBqADAgECAgkA2/wCRO4eMnwwDQYJKoZIhvcNAQEFBQAw
ZzELMAkGA1UEBhMCZGUxDzANBgNVBAcTBkJlcmxpbjEfMB0GA1UEChMWVElHUklT
IEVsZWt0cm9uaWsgR21iSDEQMA4GA1UECxMHR2F0ZXdheTEUMBIGA1UEAxMLSVQt
VVRNMTEwLTEwHhcNMTMwMTE4MTk0ODI1WhcNMzcxMjMxMTk0ODI1WjBnMQswCQYD
VQQGEwJkZTEPMA0GA1UEBxMGQmVybGluMR8wHQYDVQQKExZUSUdSSVMgRWxla3Ry
b25payBHbWJIMRAwDgYDVQQLEwdHYXRld2F5MRQwEgYDVQQDEwtJVC1VVE0xMTAt
MTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL22qaDPxjnURGMSqAHh
bazQDjQuUrjgfztSea0q1HDqvSh0s46mcDaH4fQ0ZgSDHfKI68RA5zGZGUM3uxUP
ljA/Whxyel4eC4x2v7j2l2+FbwD6yE4P2NdMhlRdhShI62jFyk1zBAabfsHF4Bwx
qS9NK6lcCtYeCMrFaKZ6ljYDPKrTGoxlCpoJcRV5k2CSLgvwrfSQm8ak96D/73xE
mbjz3F2I8VnePr31sHsLLtrYRS6IVtYERPk0mFRawKhWfZfG3i+rjkwdHLheSHnv
X0n2WPsvGjioh3+mD1dU1zovnQhA3pccc4XszADMcTBNewtYyWzpb9sKr3xi7sZI
P+kCAwEAAaOBzDCByTAdBgNVHQ4EFgQU6mWdO7KvJFHkCkEssZu8Bj/BPIUwgZkG
A1UdIwSBkTCBjoAU6mWdO7KvJFHkCkEssZu8Bj/BPIWha6RpMGcxCzAJBgNVBAYT
AmRlMQ8wDQYDVQQHEwZCZXJsaW4xHzAdBgNVBAoTFlRJR1JJUyBFbGVrdHJvbmlr
IEdtYkgxEDAOBgNVBAsTB0dhdGV3YXkxFDASBgNVBAMTC0lULVVUTTExMC0xggkA
2/wCRO4eMnwwDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQUFAAOCAQEAnYB+fTOK
EL0MHLTM+thX5JntcJEPq4B5gBSLu6EvATFbIuaeqO7IKfOSbHumDWHSnhRPN997
NNgEaQQdInrP5Pv5ny4fUO6OAqDNHvnQYLvJsT8aAXW+IB4/gd2b6Mk44pyRZYvz
sEIsS92WJQ5SwqfmcdW4zwz0uJUonYbFpb3BbLtKMruWP3ETwEPH4DeijpgTpvSK
vxd4r1T8JLGtm2ofDOGIQmR9PXH8NYZ2gPzKG/7733HEeCp5/4uenEYE7tNY/1pJ
0UFvMvCwU7AFfq1R9v8NRJ8BQHwgWphqKVTxsxjGuie2W8lKGa/HylCCje9EKvqM
fe1PXdjZW4pp2DCCBCwwggMUoAMCAQICBFEAC28wDQYJKoZIhvcNAQEFBQAwZzEL
MAkGA1UEBhMCZGUxDzANBgNVBAcTBkJlcmxpbjEfMB0GA1UEChMWVElHUklTIEVs
ZWt0cm9uaWsgR21iSDEQMA4GA1UECxMHR2F0ZXdheTEUMBIGA1UEAxMLSVQtVVRN
MTEwLTEwHhcNMTMwMTIzMTYxMDI2WhcNMzMwMTE4MTYxMDI2WjCBjDELMAkGA1UE
BhMCZGUxHzAdBgNVBAoTFlRJR1JJUyBFbGVrdHJvbmlrIEdtYkgxEDAOBgNVBAsT
B0dhdGV3YXkxHDAaBgNVBAMTE01heGltaWxpYW4gU2Nod2VyaW4xLDAqBgkqhkiG
9w0BCQEWHU1heGltaWxpYW4uU2Nod2VyaW5AdGlncmlzLmRlMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEArctwEgU8ol7Ja3LKvcMZLoXIQXkFDBHQbCFC
G5whbJJSreOn6edddBhiCspnJo7BAy6ZkoOehZ018ndux9dVVtzBga4xQBkANNIx
sHcLVcg5ux2IMQYD5OuUgwCGUqgRpRgzsTPNLe1Rz2rsjiJhFsuMQDLtSrqqPYRj
NN532qKTo73uKvFnqkJrXSUe5pfUUs4Q3Be2v3bj/z3xm5tugSIw383qwN345KQj
RYAudObwsJANgA3bG2ZoRbjITm6B4rSLl2M3+cGFQPjLLM7/JgNxqcN8LSL7AJJH
6elgPkqOFMQcBElSg+I3DT3OXGPaF3IALc3YhojZXcmQVF87EwIDAQABo4G5MIG2
MAkGA1UdEwQCMAAwEQYJYIZIAYb4QgEBBAQDAgSwMCwGCWCGSAGG+EIBDQQfFh1P
cGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQUofgM7snJ0yVM
GqdHHKxtCfyh+PgwHwYDVR0jBBgwFoAU6mWdO7KvJFHkCkEssZu8Bj/BPIUwKAYD
VR0RBCEwH4EdTWF4aW1pbGlhbi5TY2h3ZXJpbkB0aWdyaXMuZGUwDQYJKoZIhvcN
AQEFBQADggEBALvTWg4UNW8JjdWpkR2sR8l5wRYYcnrgcjwboh9jBHjQq36j6mOu
GjgvMJyh7mPJfAcUU709MsE29O9xRMAAiv6iMthe8flbb8Pw3anCw6ey6gL0TU+G
z/jLUiuv56E5wdWyGs47w+A70dsC54LyLvWp897OP2PAbJYbh0Mf1jUdYbBwHhMx
KGnkVbmCeXLgp48cd1vJynxLiG7/+ioNpgCKlBB+8CElxX7z9XKX5M6Pb2KjhbgW
71lcRjanX5yEN5rDcQFdw7XT/IcjOAw4avs9VpFX+KJEVafxa3j50zWdDr0YXJwc
X6Jyd1BYE42KGB11CZ+fQLZbdLNqwjwVvMwxggJxMIICbQIBATBvMGcxCzAJBgNV
BAYTAmRlMQ8wDQYDVQQHEwZCZXJsaW4xHzAdBgNVBAoTFlRJR1JJUyBFbGVrdHJv
bmlrIEdtYkgxEDAOBgNVBAsTB0dhdGV3YXkxFDASBgNVBAMTC0lULVVUTTExMC0x
AgRRAAtvMAkGBSsOAwIaBQCggdgwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMTMwMzAxMDgxNzEwWjAjBgkqhkiG9w0BCQQxFgQUg0ts
/CwZvxz3qV2S1vYTxkzp2KIweQYJKoZIhvcNAQkPMWwwajALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0D
AgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJ
KoZIhvcNAQEBBQAEggEAizKAEEYmsysNY6mt0lpLYLiWh0Hk64G7h+u7BsVYCwP5
awMhNT37Mcikd5KgaMWWYNdVWy1JE6f3B7Rhw3wri7mAqXm7EyyOGBCtJ8a1HFmv
6ouT1EQ7ReYA2uyuIk75ow8jbp9/4tgC1+kZvk+5x5x/ZNNHX9owqWtVoJWKYEda
lHfOvzbdXYiBVjifRJMDPzR5RraP9k8Bjz3/U9V2Se2Vx01J6JSB4Twr6ylV96yx
KviAEYrXEgPdTKJ/rN2VwBVZ0HxrovuFE+rztCBpH+/rFg/ZToR+v60e2hlOdTQ0
2syjMv5N2BYcHKfOTdtGRzdCkDRBPSOdszrSUK8pPQ==

------9451F8E7E6F23950CD1CE870FD50F8BF--

