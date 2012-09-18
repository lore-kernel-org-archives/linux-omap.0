From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/3] ARM: OMAP4: hwmod data: add missing HWMOD_NO_IDLEST
 flags to some PRCM IP blocks
Date: Tue, 18 Sep 2012 15:12:48 -0600
Message-ID: <20120918211245.16484.14543.stgit@dusk.lan>
References: <20120918211146.16484.85893.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55033 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281Ab2IRVN1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 17:13:27 -0400
In-Reply-To: <20120918211146.16484.85893.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Some struct omap_hwmod records belonging to PRCM IP blocks are missing
HWMOD_NO_IDLEST flags; add them.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index afb6091..f54b3e5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2537,18 +2537,21 @@ static struct omap_hwmod omap44xx_prcm_mpu_hwmo=
d =3D {
 	.name		=3D "prcm_mpu",
 	.class		=3D &omap44xx_prcm_hwmod_class,
 	.clkdm_name	=3D "l4_wkup_clkdm",
+	.flags		=3D HWMOD_NO_IDLEST,
 };
=20
 /* cm_core_aon */
 static struct omap_hwmod omap44xx_cm_core_aon_hwmod =3D {
 	.name		=3D "cm_core_aon",
 	.class		=3D &omap44xx_prcm_hwmod_class,
+	.flags		=3D HWMOD_NO_IDLEST,
 };
=20
 /* cm_core */
 static struct omap_hwmod omap44xx_cm_core_hwmod =3D {
 	.name		=3D "cm_core",
 	.class		=3D &omap44xx_prcm_hwmod_class,
+	.flags		=3D HWMOD_NO_IDLEST,
 };
=20
 /* prm */


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
