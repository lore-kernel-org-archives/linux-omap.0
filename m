From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/3] OMAP: McBSP: Fix CLKR and FSR signal muxing
Date: Tue,  5 Oct 2010 15:29:33 +0300
Message-ID: <1286281775-27692-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46523 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab0JEM3I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 08:29:08 -0400
Received: by ewy23 with SMTP id 23so2438284ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 05 Oct 2010 05:29:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Paul Walmsley <paul@pwsan.com>

Fix bit clear. Now it clears all other bits than mask bit where it should
clear only it.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/mcbsp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index eba9fa1..f6b772e 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -34,7 +34,7 @@ void omap2_mcbsp1_mux_clkr_src(u8 mux)
 
 	v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
 	if (mux == CLKR_SRC_CLKR)
-		v &= OMAP2_MCBSP1_CLKR_MASK;
+		v &= ~OMAP2_MCBSP1_CLKR_MASK;
 	else if (mux == CLKR_SRC_CLKX)
 		v |= OMAP2_MCBSP1_CLKR_MASK;
 	omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
@@ -47,7 +47,7 @@ void omap2_mcbsp1_mux_fsr_src(u8 mux)
 
 	v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
 	if (mux == FSR_SRC_FSR)
-		v &= OMAP2_MCBSP1_FSR_MASK;
+		v &= ~OMAP2_MCBSP1_FSR_MASK;
 	else if (mux == FSR_SRC_FSX)
 		v |= OMAP2_MCBSP1_FSR_MASK;
 	omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
-- 
1.7.1

