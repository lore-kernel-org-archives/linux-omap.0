From: Tomi Valkeinen <tomi.valkeinen@iki.fi>
Subject: Re: [PATCH v2] ARM: DTS: OMAP4: Add OMAP4 Blaze Tablet support
Date: Fri, 28 Jun 2013 10:58:43 +0300
Message-ID: <51CD4233.3040209@iki.fi>
References: <1372159970-6361-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2KCGSAMPDOGDKJLXTPATW"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372159970-6361-1-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: b-cousson@ti.com, tony@atomide.com, benoit.cousson@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2KCGSAMPDOGDKJLXTPATW
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/06/13 14:32, Ruslan Bilovol wrote:
> The OMAP4 Blaze Tablet is TI OMAP4 processor-based
> development platform in a tablet formfactor.
> The platform contains many of the features found in
> present-day handsets (such as audio, video, wireless
> functions and user interfaces) and in addition
> contains features for software development and test.
>=20
> This patch adds initial support for the OMAP4 Blaze
> Tablet development platform. Additional functionality
> depends on different drivers and code modifications that
> are not upstreamed yet or do not support DT yet, so will
> be added later.

I think there are (at least) two revisions of the blaze tablet, the
newer one has a higher resolution LCD. I don't know what the other
differences are.

I think you have the newer revision. I have the older. Do you know about
the diff of those revisions, or more importantly, will the same blaze
tablet support work for the older revision also?

 Tomi



------enig2KCGSAMPDOGDKJLXTPATW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRzUI3AAoJEPo9qoy8lh71X10QAI0GTRyNcaK2aEWzd4Wd7oHh
Q2f88YpyYttnEVYEwJqRaLCgqN9OMQ4zzwxcxFH6sGYoAhIhALKZRP88YZr9vhUy
WkaHU8xgOb3oDs7Mz5xPEMGgXXRmBEzuaNxU1o8VPNfgW2nINsQU6Qq4bnQDdKgV
0nperAnILmaVD09zn4bhLhmBOWTGRRHs07Hs5J2auCh0+h7kyEVu9ppPcqeph9VH
NlnEkMHuueaXT1qq84uvMRS9weQefLhEmk66hJRM5AZP47tc5xYWs5ZN++NxZqMO
FvBuRmzqkiAwDKuwyGpNoE0YOZoliQnQP+LfglpTfC3lxVAYS8dxC8iAGOpfGwRx
ivAjdDRrRPi1PnRTri8MnAcc9OR5FfrY4wP56+ZvrffKoXqfsWy309Fj4gYhwFzL
/WEmLldKMFciKUiEtmqbvv50uqm6Tcd6wm8WKV2qilF125h3Aa62LgBEBBDuB9rm
pQpKFER8BL6JyCLUaZDjGwIhishvQnJGvivztieCRRJhJ0kqFGFCItsnNAiTFd2i
bSsjfcXQRSk6ypTli4whYgjmsuNsm0l8mWM6ciRpT+fvzNvKVx+njL0V7mXCbLTp
kFjOE1SNPmpKJ/Yh0/0+FCC2hqyaTMQTQ2X+qVMQBKrmZ375ZYpojFvbDx+8tmXJ
JcPKMqrpG9RXJJz3K+K0
=xf48
-----END PGP SIGNATURE-----

------enig2KCGSAMPDOGDKJLXTPATW--
