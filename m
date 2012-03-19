From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 7/7] ARM: OMAP2+: Mark omap_hsmmc_init and omap_mux
 related functions as __init
Date: Mon, 19 Mar 2012 12:20:42 +0200
Message-ID: <1332152442.2144.27.camel@deskari>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com>
	 <1329997247-27342-8-git-send-email-rnayak@ti.com>
	 <1332148116.2144.1.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-3qN3AVG+xpfCg9mgKwJR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:54732 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754912Ab2CSKUw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 06:20:52 -0400
Received: by lagr15 with SMTP id r15so5600176lag.2
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 03:20:49 -0700 (PDT)
In-Reply-To: <1332148116.2144.1.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>


--=-3qN3AVG+xpfCg9mgKwJR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-03-19 at 11:08 +0200, Tomi Valkeinen wrote:
> Hi,
>=20
> On Thu, 2012-02-23 at 17:10 +0530, Rajendra Nayak wrote:
> > From: Tony Lindgren <tony@atomide.com>
> >=20
> > Now that omap hsmmc init is split into two functions, it's safe
> > to mark omap_hsmmc_init and omap_mux related functions to __init.
> >=20
> > This basically reverts the following fixes for the case where
> > TWL was compiled as a module:
> >=20
> > a98f77b (ARM: omap: fix section mismatch warning for sdp3430_twl_gpio_s=
etup())
> > 8930b4e (ARM: omap: fix section mismatch warnings in mux.c caused by hs=
mmc.c)
> >=20
> > Additionally it fixes up the remaining section warnings for
> > all callers of omap_mux functions.
>=20
> I only now noticed this patch. This breaks DSI, as the DSI muxing
> functions are used during runtime and cannot be marked as __init.
>=20
> Shall I make a new patch for dss tree that fixes this?

(too little coffee)

Obviously I can't make a fix in my tree for that, as the problematic
patch is not present there... So here's a patch to fix it, based on
arm-soc/for-next



=46rom b00c2464de51ba6f297371b08bb7745c528fde59 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 19 Mar 2012 11:08:54 +0200
Subject: [PATCH] ARM: OMAP2+: Remove __init from DSI mux functions

Commit d1589f0912533e6cb2ac8fd6f1feb3d5989fe8cb (ARM: OMAP2+: Mark
omap_hsmmc_init and omap_mux related functions as __init) changed DSI
muxing functions to __init. This doesn't work, as the muxing functions
are used every time a DSI display is enabled or disabled.

This patch removes the __inits from DSI mux functions.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c
b/arch/arm/mach-omap2/display.c
index 9706c64..400fa37 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -125,7 +125,7 @@ static void omap4_hdmi_mux_pads(enum omap_hdmi_flags
flags)
 	}
 }
=20
-static int __init omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
+static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 {
 	u32 enable_mask, enable_shift;
 	u32 pipd_mask, pipd_shift;
@@ -166,7 +166,7 @@ int __init omap_hdmi_init(enum omap_hdmi_flags
flags)
 	return 0;
 }
=20
-static int __init omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
+static int omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
 {
 	if (cpu_is_omap44xx())
 		return omap4_dsi_mux_pads(dsi_id, lane_mask);
@@ -174,7 +174,7 @@ static int __init omap_dsi_enable_pads(int dsi_id,
unsigned lane_mask)
 	return 0;
 }
=20
-static void __init omap_dsi_disable_pads(int dsi_id, unsigned
lane_mask)
+static void omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
 {
 	if (cpu_is_omap44xx())
 		omap4_dsi_mux_pads(dsi_id, 0);
--=20
1.7.4.1



--=-3qN3AVG+xpfCg9mgKwJR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPZwh6AAoJEPo9qoy8lh71N/YP/Alqo2mp0ywNElPpoaeGHbsS
frg3hgJRV5IdCmgvvnvcTt1OZyAYkPjDjDoXHY1XnSEkiOaMsTjG7b47a7Jg8Bve
ujoIs7UeZWTovaXpqkeZf7pa+3L7dDj6lNk9jNA6BgXiBa3/hHEnP8jdlYubr+pO
OQAtZ2MgmNv6qZhC0tqEVaou1vHsIrIr07poeeNFsFzcOn/BtU+uHF3wO61wyhRG
Rf9LMVbVeHhGVtUFKsQgryYa1W6bIjyOhkXBBwJPweMB6Xv33I8IhdkwHVAUpNwL
you6UCfpw/r7kiunSXUORQ6IaOGPIz8rtLGMZ90bEIM2GgX/DKiEtu433ECw9Fej
QHRnUEnEsPZoZj8v5Q/0430dzyqR5pNEGhwatrk5JdyJkEePxu1R8SRJAYz5vE1k
8bpI+m5nbjnpKGZ2nb2oNRJ8e265fWCP7aKr3oGW8kzxm6/46MmkaVdBtSyxfUDK
t4reKQejG99sgSFhqZ/8ho49vDey7P2S3qv31gmdMei5d0voHN37hzYA82d1K65/
/olfEBkGWMz4Ao69BgXJU9qn9O3mZC+vVbOuVkijydP8iGOhaRxozTT4SiNkU2Vy
hVe2DhkWufJYXSodDqklk0Z6WNAwnNeeD1BE8IoQ+oRLPZWEmdqvFoEbG3kR0QPS
9cdAzYjQP3OwF5RyZivG
=COjQ
-----END PGP SIGNATURE-----

--=-3qN3AVG+xpfCg9mgKwJR--

