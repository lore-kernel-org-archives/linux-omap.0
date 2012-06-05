From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] OMAP DSS for v3.5
Date: Tue, 05 Jun 2012 15:33:13 +0300
Message-ID: <1338899593.4456.6.camel@deskari>
References: <1337681363.4125.10.camel@deskari>
	 <CAORVsuXLhGCEHMbZB_8FrzfL-sMH76wMH9rdUjOzOfL06bLH4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-PLszMeStzgmYFNGlSQX7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:59434 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754838Ab2FEMdl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jun 2012 08:33:41 -0400
Received: by lban1 with SMTP id n1so4127276lba.24
        for <linux-omap@vger.kernel.org>; Tue, 05 Jun 2012 05:33:16 -0700 (PDT)
In-Reply-To: <CAORVsuXLhGCEHMbZB_8FrzfL-sMH76wMH9rdUjOzOfL06bLH4w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-omap@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>, Tony Lindgren <tony@atomide.com>


--=-PLszMeStzgmYFNGlSQX7
Content-Type: multipart/mixed; boundary="=-2SbPLRjJ1L1VM5ENqYAN"


--=-2SbPLRjJ1L1VM5ENqYAN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean,

On Tue, 2012-06-05 at 14:17 +0200, Jean Pihet wrote:
> Hi Tomi,

> I am using a mainline kernel (3.5.0-rc1) with the patches below integrate=
d.
> I have an issue with suspend/resume on OMAP3 Beagleboard, where the
> system hangs at resume time.
>=20
> Here below is a log with the option no_console_suspend set and a few
> added messages in case of null pointer in _od_resume_noirq.
> It looks like there is no omap_device associated to the "omapdss_dpi" pde=
v.
>=20
> What do you think? How to fix this?
> Sorry I know there have been some discussions on the lists but I am
> not aware of all the details in the devices creation for DSS.
>=20
> / # echo mem > /sys/power/state
> [   23.262298] PM: Syncing filesystems ... done.
> [   23.295501] Freezing user space processes ... (elapsed 0.02 seconds) d=
one.
> [   23.326507] Freezing remaining freezable tasks ... (elapsed 0.02 secon=
ds) don
> e.
> [   23.502197] PM: suspend of devices complete after 163.766 msecs
> [   23.511932] PM: late suspend of devices complete after 3.418 msecs
> [   23.524444] PM: noirq suspend of devices complete after 5.860 msecs
> [   23.531249] Disabling non-boot CPUs ...
> [   24.476562] Powerdomain (per_pwrdm) didn't enter target state 1
> [   24.482818] Powerdomain (core_pwrdm) didn't enter target state 1
> [   24.489166] Could not enter target state in pm_suspend
> [   24.495147] *** _od_resume_noirq: od=3DNULL, dev=3D0xc78bcc08
> [   24.500915] *** _od_resume_noirq: od=3DNULL, pdev=3D0xc78bcc00
> [   24.506805] *** _od_resume_noirq: od=3DNULL, pdev->name:omapdss_dpi
> [   24.513336] Unable to handle kernel NULL pointer dereference at virtua=
l addre
> ss 00000018
> [   24.521942] pgd =3D c62f0000
> [   24.524841] [00000018] *pgd=3D862c1831, *pte=3D00000000, *ppte=3D00000=
000
> [   24.531524] Internal error: Oops: 17 [#1] SMP ARM
> [   24.536529] Modules linked in:
> [   24.539764] CPU: 0    Not tainted  (3.5.0-rc1-00010-g5041caa-dirty #13=
1)
> [   24.546844] PC is at _od_resume_noirq+0x1c/0xac
> [   24.551635] LR is at _od_resume_noirq+0x94/0xac
> ...

I'm on leave currently, so I can't test it right now. But can you try
the attached patch? Or even better, try merging the tag:

git://gitorious.org/linux-omap-dss2/linux.git tags/omapdss-for-3.5-rc2

which contains the included patch plus a couple other fixes.

 Tomi


--=-2SbPLRjJ1L1VM5ENqYAN
Content-Disposition: attachment;
	filename="0001-OMAPDSS-fix-registration-of-DPI-and-SDI-devices.patch"
Content-Type: text/x-patch;
	name="0001-OMAPDSS-fix-registration-of-DPI-and-SDI-devices.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA0ZWEzMGU5ZTBmMjk1NmIyZWJjZjFlODFhYzA4ZDdjNjY5MWNmMzJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogVG9taSBWYWxrZWluZW4gPHRvbWkudmFsa2VpbmVuQHRpLmNv
bT4NCkRhdGU6IFR1ZSwgNSBKdW4gMjAxMiAxMzoxNzozMiArMDMwMA0KU3ViamVjdDogW1BBVENI
XSBPTUFQRFNTOiBmaXggcmVnaXN0cmF0aW9uIG9mIERQSSBhbmQgU0RJIGRldmljZXMNCg0KVGhl
IG9tYXBkc3MgYXJjaCBpbml0aWFsaXphdGlvbiBjb2RlIHJlZ2lzdGVycyBhbGwgdGhlIG91dHB1
dCBkZXZpY2VzIGFzDQpvbWFwX2RldmljZXMuIEhvd2V2ZXIsIERQSSBhbmQgU0RJIGFyZSBub3Qg
cHJvcGVyIG9tYXBfZGV2aWNlcywgYXMgdGhleQ0KZG8gbm90IGhhdmUgYW55IGNvcnJlc3BvbmRp
bmcgSFdNT0QuIFRoaXMgbGVhZHMgdG8gY3Jhc2hlcyBvciBwcm9ibGVtcw0Kd2hlbiB0aGUgcGxh
dGZvcm0gY29kZSB0cmllcyB0byB1c2Ugb21hcF9kZXZpY2UgZnVuY3Rpb25zIGZvciBEUEkgYW5k
DQpTREkgZGV2aWNlcy4NCg0KT25lIHN1Y2ggY3Jhc2ggd2FzIHJlcG9ydGVkIGJ5IEpvaG4gU3R1
bHR6IDxqb2huc3R1bEB1cy5pYm0uY29tPjoNCg0KWyAgIDE4Ljc1NjgzNV0gVW5hYmxlIHRvIGhh
bmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0DQp2aXJ0dWFsIGFkZHI4DQpb
ICAgMTguNzY1MzE5XSBwZ2QgPSBlYTZiODAwMA0KWyAgIDE4Ljc2ODE4OF0gWzAwMDAwMDE4XSAq
cGdkPWFhOTQyODMxLCAqcHRlPTAwMDAwMDAwLCAqcHB0ZT0wMDAwMDAwMA0KWyAgIDE4Ljc3NDc0
OV0gSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDE3IFsjMV0gU01QIEFSTQ0KWyAgIDE4Ljc3OTY2M10g
TW9kdWxlcyBsaW5rZWQgaW46DQpbICAgMTguNzgyODM2XSBDUFU6IDAgICAgTm90IHRhaW50ZWQg
ICgzLjUuMC1yYzEtZGlydHkgIzQ1NikNClsgICAxOC43ODg0ODJdIFBDIGlzIGF0IF9vZF9yZXN1
bWVfbm9pcnErMHgxYy8weDc4DQpbICAgMTguNzkzMjEyXSBMUiBpcyBhdCBfb2RfcmVzdW1lX25v
aXJxKzB4NmMvMHg3OA0KWyAgIDE4Ljc5Nzk0M10gcGMgOiBbPGMwMDMwN2VjPl0gICAgbHIgOiBb
PGMwMDMwODNjPl0gICAgcHNyOiAyMDAwMDExMw0KWyAgIDE4Ljc5Nzk0M10gc3AgOiBlYzNhYmU4
MCAgaXAgOiBlYzNhYmRiOCAgZnAgOiAwMDAwMDAwNg0KWyAgIDE4LjgwOTkzNl0gcjEwOiBlYzEx
NDhiOCAgcjkgOiBjMDhhNDhmMCAgcjggOiBjMDAzMDdkMA0KWyAgIDE4LjgxNTM2OF0gcjcgOiAw
MDAwMDAwMCAgcjYgOiAwMDAwMDAwMCAgcjUgOiBlYzExNDgwMCAgcjQgOg0KZWMxMTQ4MDgNClsg
ICAxOC44MjIxNzRdIHIzIDogMDAwMDAwMDAgIHIyIDogMDAwMDAwMDAgIHIxIDogZWMxNTRmZTgg
IHIwIDoNCjAwMDAwMDA2DQpbICAgMTguODI5MDEwXSBGbGFnczogbnpDdiAgSVJRcyBvbiAgRklR
cyBvbiAgTW9kZSBTVkNfMzIgIElTQSBBUk0NClNlZ21lbnQgdXNlcg0KWyAgIDE4LjgzNjQ1Nl0g
Q29udHJvbDogMTBjNTM4N2QgIFRhYmxlOiBhYTZiODA0YSAgREFDOiAwMDAwMDAxNQ0KWyAgIDE4
Ljg0MjQzN10gUHJvY2VzcyBzaCAocGlkOiAxMTM5LCBzdGFjayBsaW1pdCA9IDB4ZWMzYWEyZjAp
DQpbICAgMTguODQ4MzU4XSBTdGFjazogKDB4ZWMzYWJlODAgdG8gMHhlYzNhYzAwMCkNCg0KRFBJ
IGFuZCBTREkgY2FuIGJlIHBsYWluIHBsYXRmb3JtX2RldmljZXMuIFRoaXMgcGF0Y2ggY2hhbmdl
cyB0aGUNCnJlZ2lzdHJhdGlvbiBmcm9tIG9tYXBfZGV2aWNlX3JlZ2lzdGVyKCkgdG8gcGxhdGZv
cm1fZGV2aWNlX2FkZCgpLg0KDQpTaWduZWQtb2ZmLWJ5OiBUb21pIFZhbGtlaW5lbiA8dG9taS52
YWxrZWluZW5AdGkuY29tPg0KUmVwb3J0ZWQtYnk6IEpvaG4gU3R1bHR6IDxqb2huc3R1bEB1cy5p
Ym0uY29tPg0KLS0tDQogYXJjaC9hcm0vbWFjaC1vbWFwMi9kaXNwbGF5LmMgfCAgICA0ICsrLS0N
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9kaXNwbGF5LmMgYi9hcmNoL2FybS9tYWNoLW9t
YXAyL2Rpc3BsYXkuYw0KaW5kZXggNTRkNDlkZC4uNWZiNDdhMSAxMDA2NDQNCi0tLSBhL2FyY2gv
YXJtL21hY2gtb21hcDIvZGlzcGxheS5jDQorKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2Rpc3Bs
YXkuYw0KQEAgLTI3MSw5ICsyNzEsOSBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
Y3JlYXRlX3NpbXBsZV9kc3NfcGRldihjb25zdCBjaGFyICpwZGV2X25hbWUsDQogCQlnb3RvIGVy
cjsNCiAJfQ0KIA0KLQlyID0gb21hcF9kZXZpY2VfcmVnaXN0ZXIocGRldik7DQorCXIgPSBwbGF0
Zm9ybV9kZXZpY2VfYWRkKHBkZXYpOw0KIAlpZiAocikgew0KLQkJcHJfZXJyKCJDb3VsZCBub3Qg
cmVnaXN0ZXIgb21hcF9kZXZpY2UgZm9yICVzXG4iLCBwZGV2X25hbWUpOw0KKwkJcHJfZXJyKCJD
b3VsZCBub3QgcmVnaXN0ZXIgcGxhdGZvcm1fZGV2aWNlIGZvciAlc1xuIiwgcGRldl9uYW1lKTsN
CiAJCWdvdG8gZXJyOw0KIAl9DQogDQotLSANCjEuNy45LjUNCg0K


--=-2SbPLRjJ1L1VM5ENqYAN--

--=-PLszMeStzgmYFNGlSQX7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPzfyJAAoJEPo9qoy8lh71HL0P/29TT2ayl1NNpnDK5d7lFHi6
yuj9eiZswVUB5GbU/EttK7NuCU/Gl/Rh4GHHvCw7AC99M7FnPeezPdX45NtefCQj
zU9mKupoZDjLDJJw4yTocRh0MPVVsaFOKuCfxFZZQRmfUFmu1va81MCKV3Z/66sX
dtVRbMo3mIJ1Y/lZZw44gEqjr7iGv/bt6Gu0u43e1ItUTBoQeTnJMP4VMcD/AMwi
85BJ++fuwVlvCYBE+pTOlLMdl5WmiTW8SLnbz9W0E5ehFR0DlKEfQWiHYMssNjXc
lEAS7jjL6fbSKZ4zuL7kUQjv/a9BVD6d52tE2J+hgZMHNUdONRrrhz7Q+SOJEH8Y
PFj+U0UUCsNYnkTVghiulNGq7ua3ZF4iyJlxdgqNeP5gk0UxQzYY7qVxuM+0gi+c
S2SIElou68x0alWRy18U1mK1+xDeKMKb5Pp4tefMujS0mf8xNsZI+47O5iy3mxtX
IWy9CBf77Y0hrjWQpqEbqSCDTY3CRkXGnoIPJr7pUaWbbGK9FmmN8jpnSJxwKXBI
yPp+ubp0FIg9mDhM+2IvCxZlPp8peHN9KuRH03cmnbmiDvSWQpWGYEbKKKtg1SC9
me/JFNTAcJ1uVLPeZ8pFr6mXbBKNqT0r4GWy2jkpj7sURagI5+g9Lfh5E0jO3JPL
TJDETspa/ll8ArssaNs+
=6Guz
-----END PGP SIGNATURE-----

--=-PLszMeStzgmYFNGlSQX7--

