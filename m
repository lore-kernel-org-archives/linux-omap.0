From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARM: OMAP3: Fix 3430 legacy mux names for ssi1 signals.
Date: Mon, 22 Oct 2012 13:34:11 -0700
Message-ID: <20121022203411.22746.29979.stgit@muffinssi.local>
References: <20121022203324.22746.54210.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58262 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756184Ab2JVUeM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 16:34:12 -0400
In-Reply-To: <20121022203324.22746.54210.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

On n900 uart1 pins are not not used for uart, instead they are
used to connect to a cell modem over ssi. Looks like we're
currently missing these signal names for 3430 for some reason,
and only have some of them listed for 3630. Obviously the signals
are there for 3430 if n900 is using them and they are documented
in some TRMs.

Note that these will eventually be replaced by device tree
based pinctrl-single.c driver. But for now these are needed
to verify the SSI pins for devices like Nokia N900.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 0 files changed

diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
index 17f80e4..c47140b 100644
--- a/arch/arm/mach-omap2/mux34xx.c
+++ b/arch/arm/mach-omap2/mux34xx.c
@@ -614,16 +614,16 @@ static struct omap_mux __initdata omap3_muxmodes[] = {
 		"sys_off_mode", NULL, NULL, NULL,
 		"gpio_9", NULL, NULL, "safe_mode"),
 	_OMAP3_MUXENTRY(UART1_CTS, 150,
-		"uart1_cts", NULL, NULL, NULL,
+		"uart1_cts", "ssi1_rdy_tx", NULL, NULL,
 		"gpio_150", "hsusb3_tll_clk", NULL, "safe_mode"),
 	_OMAP3_MUXENTRY(UART1_RTS, 149,
-		"uart1_rts", NULL, NULL, NULL,
+		"uart1_rts", "ssi1_flag_tx", NULL, NULL,
 		"gpio_149", NULL, NULL, "safe_mode"),
 	_OMAP3_MUXENTRY(UART1_RX, 151,
-		"uart1_rx", NULL, "mcbsp1_clkr", "mcspi4_clk",
+		"uart1_rx", "ss1_wake_tx", "mcbsp1_clkr", "mcspi4_clk",
 		"gpio_151", NULL, NULL, "safe_mode"),
 	_OMAP3_MUXENTRY(UART1_TX, 148,
-		"uart1_tx", NULL, NULL, NULL,
+		"uart1_tx", "ssi1_dat_tx", NULL, NULL,
 		"gpio_148", NULL, NULL, "safe_mode"),
 	_OMAP3_MUXENTRY(UART2_CTS, 144,
 		"uart2_cts", "mcbsp3_dx", "gpt9_pwm_evt", NULL,

