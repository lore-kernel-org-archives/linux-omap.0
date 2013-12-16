From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Date: Mon, 16 Dec 2013 09:24:39 +0200
Message-ID: <52AEAAB7.7010308@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1703598.NbqXAMAFOI@avalon> <52AADBE0.3030203@ti.com> <3426377.keoaFgiZkl@avalon> <52AB2C25.6000507@ti.com> <20131213172234.GD28184@atomide.com> <52AC0A18.30405@ti.com> <20131214140913.GA12324@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="I3wMIHoekBSe2OexKcBjHa0s1Mj28q0mD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43780 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903Ab3LPHY6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Dec 2013 02:24:58 -0500
In-Reply-To: <20131214140913.GA12324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>

--I3wMIHoekBSe2OexKcBjHa0s1Mj28q0mD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-14 16:09, Tony Lindgren wrote:

>> Why was e30b06f4d5f000c31a7747a7e7ada78a5fd419a1 merged into -rc2? It'=
s
>> not a fix, just a cleanup.
>=20
> Hmm OK sorry looks like I removed some non-legacy mux framework code
> by accident. The omap_mux_* parts clearly are dead code for omap4 as
> it's been DT only since v3.10, but the omap4_dsi_mux_pads() is not
> using omap_mux_* functions.
>=20
> Yes, let's revert e30b06f4d5f0 except for the dead code parts, which
> seems to be omap4_tpd12s015_mux_pads(), right?

Yes. I tested the below patch on 4430SDP, both DSI and HDMI works.

 Tomi


=46rom cc38cdb5c77c82f526ebce855711a6b4d4c51180 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 16 Dec 2013 09:14:48 +0200
Subject: [PATCH] Revert "ARM: OMAP2+: Remove legacy mux code for display.=
c"

Commit e30b06f4d5f000c31a7747a7e7ada78a5fd419a1 (ARM: OMAP2+: Remove
legacy mux code for display.c) removed non-DT DSI and HDMI pinmuxing.
However, DSI pinmuxing is still needed, and removing that caused DSI
displays not to work.

This reverts the DSI parts of the commit.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c | 38 +++++++++++++++++++++++++++++++++++++=
+
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.=
c
index 58347bb874a0..4cf165502b35 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -101,13 +101,51 @@ static const struct omap_dss_hwmod_data omap4_dss_h=
wmod_data[] __initconst =3D {
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
 };
=20
+static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
+{
+	u32 enable_mask, enable_shift;
+	u32 pipd_mask, pipd_shift;
+	u32 reg;
+
+	if (dsi_id =3D=3D 0) {
+		enable_mask =3D OMAP4_DSI1_LANEENABLE_MASK;
+		enable_shift =3D OMAP4_DSI1_LANEENABLE_SHIFT;
+		pipd_mask =3D OMAP4_DSI1_PIPD_MASK;
+		pipd_shift =3D OMAP4_DSI1_PIPD_SHIFT;
+	} else if (dsi_id =3D=3D 1) {
+		enable_mask =3D OMAP4_DSI2_LANEENABLE_MASK;
+		enable_shift =3D OMAP4_DSI2_LANEENABLE_SHIFT;
+		pipd_mask =3D OMAP4_DSI2_PIPD_MASK;
+		pipd_shift =3D OMAP4_DSI2_PIPD_SHIFT;
+	} else {
+		return -ENODEV;
+	}
+
+	reg =3D omap4_ctrl_pad_readl(OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_DSIPHY)=
;
+
+	reg &=3D ~enable_mask;
+	reg &=3D ~pipd_mask;
+
+	reg |=3D (lanes << enable_shift) & enable_mask;
+	reg |=3D (lanes << pipd_shift) & pipd_mask;
+
+	omap4_ctrl_pad_writel(reg, OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_DSIPHY);
+
+	return 0;
+}
+
 static int omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
 {
+	if (cpu_is_omap44xx())
+		return omap4_dsi_mux_pads(dsi_id, lane_mask);
+
 	return 0;
 }
=20
 static void omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
 {
+	if (cpu_is_omap44xx())
+		omap4_dsi_mux_pads(dsi_id, 0);
 }
=20
 static int omap_dss_set_min_bus_tput(struct device *dev, unsigned long t=
put)
--=20
1.8.3.2




--I3wMIHoekBSe2OexKcBjHa0s1Mj28q0mD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSrqq7AAoJEPo9qoy8lh713XUP/Rc+s4DFkaAtA81SER+qiZrc
W6/6o40Is03XwHx3nXJyrl0ChfzpLFSsxijxvyipD+K6QMtWE0EpxlTXXSjt5vWj
eUtCP23ACMMZGA9mwBD8Zr2TnolwV4oe6L8qqtasDDb+nNnCT5naelUpcvWfJxXI
YVyT98QsBHEyHIikBqcq8BE14DY6C6zSM2IL7TDLcK6GtHr/PxB5j1NmuKwY7lkQ
lDIlAfbVFcHdbCF1G73D3ESiUU/6Q3kTyqsHa8S4rlesUI8MIWbY00F2yIYuKfFo
rqHEY/5LbpwKrQI8bOTIaGh3bBf2BkQMj1PaUZyHwo+VDlLSgdljDQfx9rIhLNks
GMjON7LbNkpqAh3Dq3dEQjvq02FV//horHLJ2wi3PgdifQcJ0PB9Mx8tk7tUXzR4
C7ecq3NLFUn0aDrGGczM6d1S7j/1nYVAN5JMiyozh/NSyEKH4dHCmxhRpC6FpcWz
e0b3mGbUC4kSGXycyFc5J2RqIzNXFYxJ1WNW9YEr2r2w5GAOmKfk6vC3RhsjYiQk
Ik9w2i+Tz5GBpV/zQW2N9htcTdo/X0K5GNel0Jm1mhfarTTkxfNTdIoG0HwcKlBi
wZO8u9f18zFDzAou01FhnnqExRsRJGFSglOXN10J09ULGiZKLyz3qE8QdIRr9L4O
XQD7VkN5FjUsRjqZ+NyU
=/kjL
-----END PGP SIGNATURE-----

--I3wMIHoekBSe2OexKcBjHa0s1Mj28q0mD--
