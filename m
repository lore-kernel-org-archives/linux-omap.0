From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: manual merge of the usb tree with the omap tree
Date: Wed, 2 Mar 2011 16:57:46 +1100
Message-ID: <20110302165746.814a45a3.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__2_Mar_2011_16_57_46_+1100_2DSUkOMgxyW=ozlq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Thomas Weber <weber@corscience.de>
List-Id: linux-omap@vger.kernel.org

--Signature=_Wed__2_Mar_2011_16_57_46_+1100_2DSUkOMgxyW=ozlq
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the usb tree got a conflict in
drivers/usb/musb/musb_core.h between commit
59b479e0985f0b795d68331d6443a7f89c47768d ("omap: Start using
CONFIG_SOC_OMAP") from the omap tree and commit
da68ccec210c45eb99e461ad31b499b4e7043c41 ("usb: musb: Remove platform
context save/restore API") from the usb tree.

The latter removed the code modified by the former, so I did that.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__2_Mar_2011_16_57_46_+1100_2DSUkOMgxyW=ozlq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJNbdxaAAoJEDMEi1NhKgbswNAH/1Ab2kV4P6YqegrTyaODODX4
AdIunJab+Uk8J0ol1zLfnOJNaaYzNWs9A5jpm2TM2Ia4JLNV5v9ZUNUZmx60+6mz
FIiqfjbxjh+3RutfbwTQ/8fDD++glmGIpUaIMQ6SQbdEOQyqfZudB5k11/dccqBB
iE+e4uTYXM+uyyn0hgnliuPmGvwjUfgxPfzOsCyQhslGi4KAutpicvSu7B5/R+Cr
D5HzvMMDCnbRQ3VmmSjLTtj/m/MmgXjUYLY/Ubbk1V6wY7PenszadFFg94+FUxWf
OtpgOUrc/p7IUOzvNfwncVVR9mwqYI6INcQhCy1Enj/RGtnXes+Ny9ZkefwAn80=
=6R6N
-----END PGP SIGNATURE-----

--Signature=_Wed__2_Mar_2011_16_57_46_+1100_2DSUkOMgxyW=ozlq--
