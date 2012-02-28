From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 8/9] ARM: OMAP4: hwmod data: uncomment some "excluded" hwmods
Date: Tue, 28 Feb 2012 04:10:56 -0700
Message-ID: <20120228111056.808.12836.stgit@dusk>
References: <20120228110943.808.73639.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35187 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965132Ab2B1LLf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 06:11:35 -0500
In-Reply-To: <20120228110943.808.73639.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Some hwmods were commented out from the OMAP4 data, under the theory
that they shouldn't be added until drivers were ready.  But part of
the utility of the hwmod code is that it can reset and properly
initialize IP blocks that have no drivers associated with them.
Rather than commenting the links in the future hwmod data conversion
patches, discussing this with Benoit, it seems best to simply
uncomment them now.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index f3fd64d..4190385 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5408,10 +5408,10 @@ static __initdata struct omap_hwmod *omap44xx_h=
wmods[] =3D {
 	&omap44xx_mpu_private_hwmod,
=20
 	/* aess class */
-/*	&omap44xx_aess_hwmod, */
+	&omap44xx_aess_hwmod,
=20
 	/* counter class */
-/*	&omap44xx_counter_32k_hwmod, */
+	&omap44xx_counter_32k_hwmod,
=20
 	/* dma class */
 	&omap44xx_dma_system_hwmod,
@@ -5440,7 +5440,7 @@ static __initdata struct omap_hwmod *omap44xx_hwm=
ods[] =3D {
 	&omap44xx_gpio6_hwmod,
=20
 	/* hsi class */
-/*	&omap44xx_hsi_hwmod, */
+	&omap44xx_hsi_hwmod,
=20
 	/* i2c class */
 	&omap44xx_i2c1_hwmod,
@@ -5452,7 +5452,7 @@ static __initdata struct omap_hwmod *omap44xx_hwm=
ods[] =3D {
 	&omap44xx_ipu_hwmod,
=20
 	/* iss class */
-/*	&omap44xx_iss_hwmod, */
+	&omap44xx_iss_hwmod,
=20
 	/* iva class */
 	&omap44xx_iva_hwmod,


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
