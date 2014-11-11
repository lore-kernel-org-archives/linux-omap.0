From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: phy: fix twl4030 build regression
Date: Tue, 11 Nov 2014 08:53:01 -0600
Message-ID: <20141111145301.GC25615@saruman>
References: <7831012.jlbEUURqIo@wuerfel>
 <20141111145217.GB25615@saruman>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45092 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015AbaKKOxE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Nov 2014 09:53:04 -0500
Content-Disposition: inline
In-Reply-To: <20141111145217.GB25615@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Antoine Tenart <antoine.tenart@free-electrons.com>, Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2014 at 08:52:17AM -0600, Felipe Balbi wrote:
> On Tue, Nov 11, 2014 at 10:36:09AM +0100, Arnd Bergmann wrote:
> > Recent changes to the common OTG handling broke building the twl4030
> > OTG driver as found during an allmodconfig build of linux-next:
> >=20
> > drivers/phy/phy-twl4030-usb.c: In function 'twl4030_set_peripheral':
> > drivers/phy/phy-twl4030-usb.c:609:11: error: 'struct phy' has no member=
 named 'state'
> > drivers/phy/phy-twl4030-usb.c: In function 'twl4030_usb_probe':
> > drivers/phy/phy-twl4030-usb.c:679:12: warning: assignment from incompat=
ible pointer type
> >=20
> > This applies the same changes that were done to the other phy drivers
> > to get it to build cleanly.
> >=20
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: 19c1eac2685b6 ("usb: rename phy to usb_phy in OTG")
> > Fixes: e47d92545c297 ("usb: move the OTG state from the USB PHY to the =
OTG structure")
>=20
> on my testing/next already:
>=20
> commit 7e1bbeb4292783dcc079156b8fa08d66d17219e0
> Author: Felipe Balbi <balbi@ti.com>
> Date:   Fri Nov 7 19:43:45 2014 -0600
>=20
>     usb: host: ohci: omap: fix build breakage

wrong commit, here's the correct one:

commit 8b9ca2767b2d1ea405287e530da3a7b234120b95
Author: Felipe Balbi <balbi@ti.com>
Date:   Fri Nov 7 09:06:04 2014 -0600

    phy: twl4030: Fix build breakage
   =20
    commit e47d925 (usb: move the OTG state
    from the USB PHY to the OTG structure) moved
    the OTG state field from struct usb_phy to
    struct usb_otg but, even though I fixed many
    other build breakages, I still missed one
    on phy-twl4030-usb.c.
   =20
    Fix the build breakage now.
   =20
    While at that, also a build warning introduced
    by the same commit.
   =20
    Cc: Kishon Vijay Abraham I <kishon@ti.com>
    Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
    Signed-off-by: Felipe Balbi <balbi@ti.com>

diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 7b04bef..e2698d29 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -606,7 +606,7 @@ static int twl4030_set_peripheral(struct usb_otg *otg,
=20
 	otg->gadget =3D gadget;
 	if (!gadget)
-		otg->phy->state =3D OTG_STATE_UNDEFINED;
+		otg->state =3D OTG_STATE_UNDEFINED;
=20
 	return 0;
 }
@@ -618,7 +618,7 @@ static int twl4030_set_host(struct usb_otg *otg, struct=
 usb_bus *host)
=20
 	otg->host =3D host;
 	if (!host)
-		otg->phy->state =3D OTG_STATE_UNDEFINED;
+		otg->state =3D OTG_STATE_UNDEFINED;
=20
 	return 0;
 }
@@ -676,7 +676,7 @@ static int twl4030_usb_probe(struct platform_device *pd=
ev)
 	twl->phy.otg		=3D otg;
 	twl->phy.type		=3D USB_PHY_TYPE_USB2;
=20
-	otg->phy		=3D &twl->phy;
+	otg->usb_phy		=3D &twl->phy;
 	otg->set_host		=3D twl4030_set_host;
 	otg->set_peripheral	=3D twl4030_set_peripheral;
=20

--=20
balbi

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUYiLNAAoJEIaOsuA1yqREFWgP/0aHs5/unyMiwUT834LJ6xN/
EsT8SDV5FJ+Bdh3GWcs3P/N3D1q6qeg1d2DbOwW/6HqW77GVUSlJNCN7J+2ZVt4j
+AEGOA7/TmLa5tx5mLH2jZCfY64TivfAdGNjBDrfib079yhl+sY/8pu09hvRasGy
uh9/Iv94U8GkbDGwCb+v+2h70l8l/5WPGwkXAsozZ5OWSymIY6zxKg7Mj75WLqnb
poM5Bl4cyN3+Cr1oQ8KcBv9CGfb0BTixvUFbRtzOE0sJSqQvplm7KsbvG4dqyU5F
lOv6V7JNbbkQ43ap0wAfGil+w9/Q9BpVYWy32wqcrdzS/ktToQxDZX6yleRoKScA
cBQPLOBmQ1xcLdVpd1bTDijvTGoztfDynZIcjA4Ax+Le9wJcMuZtv8WhiLgdHFT+
OdFh8O2ifyO7FL1Je/ZD0VTNrwnqRvTiU25x4NU76orGFIR2vksqixAHvwzx9Trb
w51XCmzhM7cGtVq3OmliqJH6Q/EPzCZMkyp+UmgIj8w/yBVuEBXmZSaNzZN9ka9j
pgbUkBGSrNSbKHx1nQB3kJnBALIf9wAcl2iPc/QJeRDdBT7MEoOTtU5ogX18/T3s
AURx2tNC5xM7o88okRpa2E+XMbssowZHzMnBcTsyljKA0kGG9IPFEJsfkGhVduPR
FrwW+8moWdWbZjQ/X/N7
=f2CT
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
