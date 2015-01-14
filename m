From: Felipe Balbi <balbi@ti.com>
Subject: Re: dwc3 gadget fails on dra7-evm
Date: Wed, 14 Jan 2015 10:57:33 -0600
Message-ID: <20150114165733.GC16533@saruman>
References: <54B68EC8.9000003@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h+CsNYkJBPxpZ+B/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60892 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752308AbbANQ6Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jan 2015 11:58:16 -0500
Content-Disposition: inline
In-Reply-To: <54B68EC8.9000003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, George Cherian <george.cherian@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

--h+CsNYkJBPxpZ+B/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 14, 2015 at 05:44:08PM +0200, Roger Quadros wrote:
> In 3.19-rc4 on dra7-evm or dra72-evm
>=20
> modprobe g_zero
> [   34.680683] zero gadget: Gadget Zero, version: Cinco de Mayo 2008
> [   34.687074] zero gadget: zero ready
> [   34.694133] dwc3 48890000.usb: failed to enable ep0out
> [   34.701600] zero 48890000.usb: failed to start zero: -110
> ERROR: could not insert 'g_zero': Connection timed out
>=20
> my u-boot version is v2015.01

hmm... it could be that DRA7x also needs the suspend phy quirk. Can you
try this ?

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 22771bc1643a..63f8b007bdc5 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1257,6 +1257,8 @@
 				tx-fifo-resize;
 				maximum-speed =3D "super-speed";
 				dr_mode =3D "otg";
+				snps,dis_u3_susphy_quirk;
+				snps,dis_u2_susphy_quirk;
 			};
 		};
=20
@@ -1278,6 +1280,8 @@
 				tx-fifo-resize;
 				maximum-speed =3D "high-speed";
 				dr_mode =3D "otg";
+				snps,dis_u3_susphy_quirk;
+				snps,dis_u2_susphy_quirk;
 			};
 		};
=20
@@ -1299,6 +1303,8 @@
 				tx-fifo-resize;
 				maximum-speed =3D "high-speed";
 				dr_mode =3D "otg";
+				snps,dis_u3_susphy_quirk;
+				snps,dis_u2_susphy_quirk;
 			};
 		};
=20

Weird, I remeber testing on X15 and not needing this quirk :-s

--=20
balbi

--h+CsNYkJBPxpZ+B/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtp/9AAoJEIaOsuA1yqRETwwP+wdpbcPxM1rhVk0yIXhO1udZ
TQtEpxBYt+ynK7QPWoN3l/ZFhzsb7IkXvOOLVKxzsL0bL6BQnttm72KvSEJ+gVFH
Sj9oNW3nFvuaOA7SyScFT9TH4H5WfZH0Kse5yJqWag2dVMFV7+cZjc2awnu/pRY6
bq2ESpH6q/dL0hQy/FP/RA8uykUPpSw3nhFL7FhD2OQmEeHo+7UcLwGO2YTfvSdH
ZCcitqqvy1VqxVB1B0HREU+adQSOawp3hdh3cU7InNkoQHF+59gwCLFNuY/WtCvx
qlCM7kB7RHH7xbxHaRSlPBnCEe3d9UbVyZyKawwQbd5Q6btDhSNFtsTqBau384KL
T+i48fY3tYBc9/VL3wkGTw0Rp719mNHCqogbfJKxwPsR+A6oarr8Ogz+g5XTveAw
T3IKnP/L8uUbYTymLyymtp1SqSmBiUzbS/qdoaKxeihaEXPiOI4D/hyCItMRh7QW
TDv1ARxrUijf7WewF9qYU5rK7pU//1DTmAz/Ic1J2XiclE4RNLz5CJClveFQtrfw
t6Dfhg8j9GnvtJontVt/H+6gM+pykSMksGI/4j5uxo1AtIM19vsGlxhqgJgjEzC+
Sfg/Hl/xd+6GEeBV0ronoTxKkqlbCslEw8wgu0RfCkKBxzuqgafcgvxO8hWdHcT0
w21VHF+jfGYO4fFSfJXP
=kvdA
-----END PGP SIGNATURE-----

--h+CsNYkJBPxpZ+B/--
