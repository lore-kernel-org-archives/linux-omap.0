From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 04/11] ARM: OMAP: board-am3517evm: Configure McBSP1 CLKR/FSR signal source
Date: Wed,  8 Aug 2012 12:11:34 +0300
Message-ID: <1344417101-5015-5-git-send-email-peter.ujfalusi@ti.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:45084 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964911Ab2HHJMt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 05:12:49 -0400
Received: by obqv19 with SMTP id v19so927410obq.2
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 02:12:44 -0700 (PDT)
In-Reply-To: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

am3517evm board uses McBSP1 for audio with 4pin configuration.
The CLKR/FSR signals need to be connected to CLKX/FSX pin of the SoC in
this case.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 18f6010..592812a 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -264,6 +264,16 @@ static __init void am3517_evm_musb_init(void)
 	usb_musb_init(&musb_board_data);
 }
 
+static __init void am3517_evm_mcbsp1_init(void)
+{
+	u32 devconf0;
+
+	/* McBSP1 CLKR/FSR signal to be connected to CLKX/FSX pin */
+	devconf0 = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+	devconf0 |=  OMAP2_MCBSP1_CLKR_MASK | OMAP2_MCBSP1_FSR_MASK;
+	omap_ctrl_writel(devconf0, OMAP2_CONTROL_DEVCONF0);
+}
+
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
 #if defined(CONFIG_PANEL_SHARP_LQ043T1DG01) || \
@@ -373,6 +383,9 @@ static void __init am3517_evm_init(void)
 	/* MUSB */
 	am3517_evm_musb_init();
 
+	/* McBSP1 */
+	am3517_evm_mcbsp1_init();
+
 	/* MMC init function */
 	omap_hsmmc_init(mmc);
 }
-- 
1.7.8.6

