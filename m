From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2 1/3] OMAP: McBSP: Fix CLKR and FSR signal muxing
Date: Wed,  6 Oct 2010 08:50:40 +0300
Message-ID: <1286344242-430-2-git-send-email-jhnikula@gmail.com>
References: <1286344242-430-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64717 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756904Ab0JFFuU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 01:50:20 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so2731852ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 05 Oct 2010 22:50:19 -0700 (PDT)
In-Reply-To: <1286344242-430-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jhnikula@gmail.com>

Fix bit clear. Now it clears all other bits than mask bit where it should
clear only it.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
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

