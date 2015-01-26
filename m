From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: hdmi5: remove unneeded check
Date: Mon, 26 Jan 2015 14:41:42 +0200
Message-ID: <54C63606.30002@ti.com>
References: <1421167620-17290-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="83rKs0qH6sFP7O5ktTRcJLWXMwmpmwDhW"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421167620-17290-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--83rKs0qH6sFP7O5ktTRcJLWXMwmpmwDhW
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 13/01/15 18:46, Sudip Mukherjee wrote:
> prior to this check we are checking for word_length_16b and if word_len=
gth_16b
> is false then we are returning with -EINVAL.
> So at this point word_length_16b can only be true.

True, but it looks to me the code may be extended in the future.

And if it would be clear that it won't be extended in the future, then
there's more code changes needed to reflect that (the whole
word_length_16b can be removed, etc).

 Tomi



--83rKs0qH6sFP7O5ktTRcJLWXMwmpmwDhW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUxjYGAAoJEPo9qoy8lh712nwP/j8/gAztbH+lyD8lx3wXU3vU
3bZmI2N8fg/DPCdr578O+smRcLnOguWiyo0rzRumvktU1okxDZl+OOxKZ0Cwq+Ir
tP8kqdQl78jK/bv/RQ1vvhM5WcLbE5AWAsWLkkC5fW2oSbvdQV3OgVQBXFxww2Gw
t1MLD0k/9omv6O4XTjOT3GQlNo37q15hPYvNsEE95Q/VHpqiSDyY1Qc+Koj2IxA9
PG2/HJwOxcxsOSbjHvcUYc12buy++fETmJHTTGGGsZ5R9R1TegqApRwd2Hu8vBhN
yoOaQBkK0Z9bp+8FPFhYUsRskYJwEtYYYK+YN8qIj+fDa9aCyCL1CqXFuPm6fQ8f
I296BOSmN/j+4SqmXaz9W1ykb/osomdB5PxCfXbJo2fQbMhaM+DByWhyYUbIoUnx
hGBvQfThAS9NOZy4eMVgGG8eSw526BrDpA7NwfFN4uFXLc+mNAevtBbBWyoW9AGX
tIahmCQW++ui04LKVOl1pN+gnm0c8C7cEl2MkDLvKf2SLqnLuAV7wytDd+io6v3b
lTnahU8AJLWpNwZV5IuN6ciRoU2bW1/Lv430Qblhxt/whoutHsOaI3LeQksS9BdI
XCPgCKlLs5qhl65d+42ji+Cbio5ujhR6OZ8T1Z3kDlgR618HLfOW144MzrMm9xDX
v39GAS8tHZFkP6OI7/Q4
=YGRp
-----END PGP SIGNATURE-----

--83rKs0qH6sFP7O5ktTRcJLWXMwmpmwDhW--
