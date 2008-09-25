From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH] Adds MCBSP mux settings
Date: Thu, 25 Sep 2008 13:04:28 +0530
Message-ID: <dfeb90390809250034x15494498p8109d52e1df44c77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:35347 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbYIYHea (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 03:34:30 -0400
Received: by ti-out-0910.google.com with SMTP id b6so188884tic.23
        for <linux-omap@vger.kernel.org>; Thu, 25 Sep 2008 00:34:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Adding MCBSP port 1, 3, 4 and 5 ports mux settings for 2430.

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 arch/arm/mach-omap2/mux.c             |   24 ++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/mux.h |   24 ++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 3e877ab..f272bfa 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -202,6 +202,15 @@ MUX_CFG_24XX("AE9_2430_USB0HS_NXT",	0x13D,	0,	0,	0,	1)
 MUX_CFG_24XX("AC7_2430_USB0HS_DATA7",	0x13E,	0,	0,	0,	1)

 /* 2430 McBSP */
+MUX_CFG_24XX("AD6_2430_MCBSP_CLKS",	0x011E,	0,	0,	0,	1)
+
+MUX_CFG_24XX("AB2_2430_MCBSP1_CLKR",	0x011A,	0,	0,	0,	1)
+MUX_CFG_24XX("AD5_2430_MCBSP1_FSR",	0x011B,	0,	0,	0,	1)
+MUX_CFG_24XX("AA1_2430_MCBSP1_DX",	0x011C,	0,	0,	0,	1)
+MUX_CFG_24XX("AF3_2430_MCBSP1_DR",	0x011D,	0,	0,	0,	1)
+MUX_CFG_24XX("AB3_2430_MCBSP1_FSX",	0x011F,	0,	0,	0,	1)
+MUX_CFG_24XX("Y9_2430_MCBSP1_CLKX",	0x0120,	0,	0,	0,	1)
+
 MUX_CFG_24XX("AC10_2430_MCBSP2_FSX",	0x012E,	1,	0,	0,	1)
 MUX_CFG_24XX("AD16_2430_MCBSP2_CLX",	0x012F,	1,	0,	0,	1)
 MUX_CFG_24XX("AE13_2430_MCBSP2_DX",	0x0130,	1,	0,	0,	1)
@@ -211,6 +220,21 @@ MUX_CFG_24XX("AD16_2430_MCBSP2_CLX_OFF",0x012F,	0,	0,	0,	1)
 MUX_CFG_24XX("AE13_2430_MCBSP2_DX_OFF",	0x0130,	0,	0,	0,	1)
 MUX_CFG_24XX("AD13_2430_MCBSP2_DR_OFF",	0x0131,	0,	0,	0,	1)

+MUX_CFG_24XX("AC9_2430_MCBSP3_CLKX",	0x0103,	0,	0,	0,	1)
+MUX_CFG_24XX("AE4_2430_MCBSP3_FSX",	0x0104,	0,	0,	0,	1)
+MUX_CFG_24XX("AE2_2430_MCBSP3_DR",	0x0105,	0,	0,	0,	1)
+MUX_CFG_24XX("AF4_2430_MCBSP3_DX",	0x0106,	0,	0,	0,	1)
+
+MUX_CFG_24XX("N3_2430_MCBSP4_CLKX",	0x010B,	1,	0,	0,	1)
+MUX_CFG_24XX("AD23_2430_MCBSP4_DR",	0x010C,	1,	0,	0,	1)
+MUX_CFG_24XX("AB25_2430_MCBSP4_DX",	0x010D,	1,	0,	0,	1)
+MUX_CFG_24XX("AC25_2430_MCBSP4_FSX",	0x010E,	1,	0,	0,	1)
+
+MUX_CFG_24XX("AE16_2430_MCBSP5_CLKX",	0x00ED,	1,	0,	0,	1)
+MUX_CFG_24XX("AF12_2430_MCBSP5_FSX",	0x00ED,	1,	0,	0,	1)
+MUX_CFG_24XX("K7_2430_MCBSP5_DX",	0x00EF,	1,	0,	0,	1)
+MUX_CFG_24XX("M1_2430_MCBSP5_DR",	0x00F0,	1,	0,	0,	1)
+
 /* 2430 MCSPI1 */
 MUX_CFG_24XX("Y18_2430_MCSPI1_CLK",	0x010F,	0,	0,	0,	1)
 MUX_CFG_24XX("AD15_2430_MCSPI1_SIMO",	0x0110,	0,	0,	0,	1)
diff --git a/arch/arm/plat-omap/include/mach/mux.h
b/arch/arm/plat-omap/include/mach/mux.h
index 683474f..1798bfe 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -632,6 +632,15 @@ enum omap24xx_index {
 	AC7_2430_USB0HS_DATA7,

 	/* 2430 McBSP */
+	AD6_2430_MCBSP_CLKS,
+
+	AB2_2430_MCBSP1_CLKR,
+	AD5_2430_MCBSP1_FSR,
+	AA1_2430_MCBSP1_DX,
+	AF3_2430_MCBSP1_DR,
+	AB3_2430_MCBSP1_FSX,
+	Y9_2430_MCBSP1_CLKX,
+
 	AC10_2430_MCBSP2_FSX,
 	AD16_2430_MCBSP2_CLX,
 	AE13_2430_MCBSP2_DX,
@@ -641,6 +650,21 @@ enum omap24xx_index {
 	AE13_2430_MCBSP2_DX_OFF,
 	AD13_2430_MCBSP2_DR_OFF,

+	AC9_2430_MCBSP3_CLKX,
+	AE4_2430_MCBSP3_FSX,
+	AE2_2430_MCBSP3_DR,
+	AF4_2430_MCBSP3_DX,
+
+	N3_2430_MCBSP4_CLKX,
+	AD23_2430_MCBSP4_DR,
+	AB25_2430_MCBSP4_DX,
+	AC25_2430_MCBSP4_FSX,
+
+	AE16_2430_MCBSP5_CLKX,
+	AF12_2430_MCBSP5_FSX,
+	K7_2430_MCBSP5_DX,
+	M1_2430_MCBSP5_DR,
+
 	/* 2430 McSPI*/
 	Y18_2430_MCSPI1_CLK,
 	AD15_2430_MCSPI1_SIMO,
-- 
1.5.3.4
