From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 11/11] ARM: OMAP4: hwmod data: do not enable or reset the
 McPDM during kernel init
Date: Thu, 07 Jun 2012 00:13:15 -0600
Message-ID: <20120607061314.25532.93570.stgit@dusk>
References: <20120607060901.25532.68354.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60907 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760108Ab2FGGVj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 02:21:39 -0400
In-Reply-To: <20120607060901.25532.68354.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?b?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Resolve this kernel boot message:

omap_hwmod: mcpdm: cannot be enabled for reset (3)

It appears that the McPDM on OMAP4 can only receive its functional
clock from an off-chip source.  This source is not guaranteed to be
present on the board, and when present, it is controlled by I2C.  This
would introduce a board dependency to the early hwmod code which it
was not designed to handle.  Also, neither the driver for this
off-chip clock provider nor the I2C code is available early in boot
when the hwmod code is attempting to enable and reset IP blocks.  This
effectively makes it impossible to enable and reset this device during
hwmod init.

At its core, this patch is a workaround for an OMAP hardware problem.
It should be possible to configure the OMAP to provide any IP block's
functional clock from an on-chip source.  (This is true for almost
every IP block on the chip.  As far as I know, McPDM is the only
exception.)  If the kernel cannot reset and configure IP blocks, it
cannot guarantee a sane SoC state.  Relying on an optional off-chip
clock also creates a board dependency which is beyond the scope of the
early hwmod code.

This patch works around the issue by marking the McPDM hwmod record
with the HWMOD_UNKNOWN_MAIN_FCLK_STATE flag.  This prevents the hwmod
code from touching the device early during boot.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: P=C3=A9ter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 20e45a6..cc1310a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2090,6 +2090,18 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod =3D=
 {
 	.name		=3D "mcpdm",
 	.class		=3D &omap44xx_mcpdm_hwmod_class,
 	.clkdm_name	=3D "abe_clkdm",
+	/*
+	 * It's suspected that the McPDM requires an off-chip main
+	 * functional clock, controlled via I2C.  This IP block is
+	 * currently reset very early during boot, before I2C is
+	 * available, so it doesn't seem that we have any choice in
+	 * the kernel other than to avoid resetting it.  XXX This is
+	 * really a hardware issue workaround: every IP block should
+	 * be able to source its main functional clock from either
+	 * on-chip or off-chip sources.  McPDM seems to be the only
+	 * current exception.
+	 */
+	.flags		=3D HWMOD_EXT_OPT_MAIN_CLK,
 	.mpu_irqs	=3D omap44xx_mcpdm_irqs,
 	.sdma_reqs	=3D omap44xx_mcpdm_sdma_reqs,
 	.main_clk	=3D "mcpdm_fck",


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
