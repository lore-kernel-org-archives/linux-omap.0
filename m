From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
Date: Mon, 22 Mar 2010 18:25:18 -0700
Message-ID: <20100323012518.GZ11448@atomide.com>
References: <20100320024827.GC11448@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94026F126B9C@dbde02.ent.ti.com>
 <20100322212025.GW11448@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J4XPiPrVK1ev6Sgr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60204 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756093Ab0CWBXo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 21:23:44 -0400
Content-Disposition: inline
In-Reply-To: <20100322212025.GW11448@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pais, Allen" <allen.pais@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>


--J4XPiPrVK1ev6Sgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [100322 14:15]:
> 
> BTW, I'm still seeing mux errors on zoom3, have not yet
> looked into those.

Looks like we're currently missing these pins. Still need
to be checked for GPIO values and modes though, posting just
for reference as this fixes the "mux: Unknown ball offset"
on 3630.

Regards,

Tony

--J4XPiPrVK1ev6Sgr
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="mux-missing.patch"

>From 70b0af58f42609cd16bebc8abe17fa065c594898 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 22 Mar 2010 18:22:10 -0700
Subject: [PATCH] omap2/3/4: Add missing uninitialized pins

Otherwise we'll get errors on 3630:

mux: Unknown ball offset 0x5e
mux: Unknown ball offset 0x60
mux: Unknown ball offset 0x62
...

REVISIT: These still need to be checked for the GPIO values
and available modes.

Not-Yet-Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
index 07aa7b3..8712b91 100644
--- a/arch/arm/mach-omap2/mux34xx.c
+++ b/arch/arm/mach-omap2/mux34xx.c
@@ -650,6 +650,224 @@ static struct omap_mux __initdata omap3_muxmodes[] = {
 		"uart3_tx_irtx", NULL, NULL, NULL,
 		"gpio_166", NULL, NULL, "safe_mode"),
 
+	/* REVISIT: The should be initialized with GPIO number and modes */
+	_OMAP3_MUXENTRY(I2C1_SCL, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(I2C1_SDA, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(JTAG_RTCK, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(JTAG_TCK, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(JTAG_TDI, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(JTAG_TDO, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(JTAG_TMS_TMSC, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A0, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A1, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A10, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A11, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A12, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A13, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A14, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A2, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A3, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A4, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A5, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A6, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A7, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A8, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A9, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_BA0, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_BA1, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_CLK, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D0, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D1, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D10, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D11, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D12, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D13, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D14, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D15, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D16, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D17, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D18, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D19, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D2, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D20, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D21, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D22, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D23, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D24, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D25, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D26, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D27, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D28, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D29, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D3, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D30, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D31, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D4, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D5, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D6, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D7, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D8, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D9, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_DM0, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_DM1, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_DM2, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_DM3, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_DQS0, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_DQS1, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_DQS2, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_DQS3, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_NCAS, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_NCLK, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_NCS0, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_NCS1, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_NRAS, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_NWE, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SYS_32K, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+
 	/* Only on 3630, see omap36xx_cbp_subset for the signals */
 	_OMAP3_MUXENTRY(GPMC_A11, 0,
 		NULL, NULL, NULL, NULL,

--J4XPiPrVK1ev6Sgr--
