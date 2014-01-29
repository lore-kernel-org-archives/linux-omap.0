From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [BISECTED] OMAP: DSS: clk rate mismatch
Date: Wed, 29 Jan 2014 11:38:11 +0200
Message-ID: <52E8CC03.7080207@ti.com>
References: <52E697C0.6000202@gmail.com> <52E7614E.8010903@ti.com> <52E76EE0.2060006@ti.com> <52E7F451.7040708@gmail.com> <52E8C586.7040907@ti.com> <52E8CA00.7060303@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="cNF331xgUCMqlk5jKevrdGI2kPNOVSJKx"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52E8CA00.7060303@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Tero Kristo <t-kristo@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, pavel@ucw.cz, chf.fritz@googlemail.com, nm@ti.com
List-Id: linux-omap@vger.kernel.org

--cNF331xgUCMqlk5jKevrdGI2kPNOVSJKx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2014-01-29 11:29, Ivaylo Dimitrov wrote:
>=20
>=20
> On 29.01.2014 11:10, Tero Kristo wrote:
>=20
>>
>> It looks like the omap36xx version of the omap96m_alwon_fck is modelle=
d
>> improperly in the dts files. I don't have access to omap36xx hardware
>> myself, but give a try for the following patch:
>>
>>
>=20
> It could be that 36xx omap96m_alwon_fck clock is wrongly modeled, but I=

> am testing on 1) 3430es2 (Nokia N900) and 2) legacy boot, so I guess
> that patch won't help much (unless I am missing something and DT is use=
d
> even with legacy boot and 36xx clocks are used on 3430es2)

I think Tero's reply was to Christoph. I believe the issues you see and
what Christoph sees are totally different.

 Tomi



--cNF331xgUCMqlk5jKevrdGI2kPNOVSJKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS6MwDAAoJEPo9qoy8lh71vTAQAItUBDXwX5rx/K7RtNdKCZSy
Um8aT4BPFYvP7yLadMi1JI/b3zVb1WHEzCTWQ4tJKaRv1gFOJXtj9/ufuTMvdT1A
oGRzYFk1vOA3IKfuVXWiQbusA0A+uJVwyNt+dXQnb7YynfsZRYrBSbLpR5wMJVxt
SPbIPdwpplVzPZq7FvgBJR167H80+fbGNMz+Mgw7M+ytO2AN/OoJM8nhFEMnSVPf
PFvzjgcrdURy29gP1gcnMx00Rufvn4Jmv0b4eD4iBCRrCiKmbmBEY/3AyUm4//aG
O6bxm2Nn5vdeTaKznkd3ptNNhWJySNSGoY5l37PdLKurgRFGU1X9WKWE6qESqrD8
ukjZCsvgDLF+3kTTYB4yPzzXwlFYnha1kxbVgM2tyXChEvoc0uWcRqIgYAVqk2oH
ba7o2IDBfmTbCZglEMpKRCtwOwjy4EjSmYwwdjqPODoAzjZsibtO65vOjEoefNkM
Z22i5H9tMfeTsh1tNCrxYlXuTRHVRyzxCDu/iU86IQZ3XWywRb50KZxfwgACTJI3
fm658WH5PNkzr49UikwMsK2hPez8OjIH9rScxMxufCQS7zZT2NJtWxZxOsfY5rEU
192wRVsdq84efVoeahGUXD4mAQ+3Oe/tph7FRaIRBaR8/OGVkct67tC8Bn1PmCX5
mYZy8BrVPZjdn0ZXIhnv
=eath
-----END PGP SIGNATURE-----

--cNF331xgUCMqlk5jKevrdGI2kPNOVSJKx--
