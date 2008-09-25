From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [Resend] [PATCH 1/3] Add MCSPI1 and gpio_85 Mux configuration
Date: Thu, 25 Sep 2008 11:04:07 +0530
Message-ID: <dfeb90390809242234h2264c7acw3003d6895574f002@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:21029 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbYIYFeJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 01:34:09 -0400
Received: by rv-out-0506.google.com with SMTP id k40so290300rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 24 Sep 2008 22:34:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This patch adds mcspi1 and gpio_85 mux configuration for 2430.

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 arch/arm/mach-omap2/mux.c             |   10 ++++++++++
 arch/arm/plat-omap/include/mach/mux.h |    9 +++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 741ab18..3e877ab 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -210,6 +210,16 @@ MUX_CFG_24XX("AC10_2430_MCBSP2_FSX_OFF",0x012E,	0,	0,	0,	1)
 MUX_CFG_24XX("AD16_2430_MCBSP2_CLX_OFF",0x012F,	0,	0,	0,	1)
 MUX_CFG_24XX("AE13_2430_MCBSP2_DX_OFF",	0x0130,	0,	0,	0,	1)
 MUX_CFG_24XX("AD13_2430_MCBSP2_DR_OFF",	0x0131,	0,	0,	0,	1)
+
+/* 2430 MCSPI1 */
+MUX_CFG_24XX("Y18_2430_MCSPI1_CLK",	0x010F,	0,	0,	0,	1)
+MUX_CFG_24XX("AD15_2430_MCSPI1_SIMO",	0x0110,	0,	0,	0,	1)
+MUX_CFG_24XX("AE17_2430_MCSPI1_SOMI",	0x0111,	0,	0,	0,	1)
+MUX_CFG_24XX("U1_2430_MCSPI1_CS0",	0x0112,	0,	0,	0,	1)
+
+/* Touchscreen GPIO */
+MUX_CFG_24XX("AF19_2430_GPIO_85",	0x0113,	3,	0,	0,	1)
+
 };

 #define OMAP24XX_PINS_SZ	ARRAY_SIZE(omap24xx_pins)
diff --git a/arch/arm/plat-omap/include/mach/mux.h
b/arch/arm/plat-omap/include/mach/mux.h
index 5670d56..683474f 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -641,6 +641,15 @@ enum omap24xx_index {
 	AE13_2430_MCBSP2_DX_OFF,
 	AD13_2430_MCBSP2_DR_OFF,

+	/* 2430 McSPI*/
+	Y18_2430_MCSPI1_CLK,
+	AD15_2430_MCSPI1_SIMO,
+	AE17_2430_MCSPI1_SOMI,
+	U1_2430_MCSPI1_CS0,
+
+	/* Touchscreen GPIO */
+	AF19_2430_GPIO_85,
+
 };

 enum omap34xx_index {
-- 
1.5.3.4
