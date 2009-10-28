From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 1/3] omap2: mux: intoduce omap_mux_{read,write}
Date: Wed, 28 Oct 2009 15:07:43 +0200
Message-ID: <afa6b6ded8db35578a200c71938174a61eaa4ef9.1256734115.git.mike@compulab.co.il>
References: <cover.1256734115.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:55718 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762AbZJ1NRf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Oct 2009 09:17:35 -0400
Received: from mail.linux-boards.com ([192.114.83.142] helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1N38PD-0007Rs-M0
	for linux-omap@vger.kernel.org; Wed, 28 Oct 2009 08:17:40 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 734B89A0367
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 15:17:38 +0200 (IST)
In-Reply-To: <cover.1256734115.git.mike@compulab.co.il>
In-Reply-To: <cover.1256734115.git.mike@compulab.co.il>
References: <cover.1256734115.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Rapoport <mike@compulab.co.il>

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/mux.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 32c953e..eb6e202 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -37,6 +37,22 @@
 
 static struct omap_mux_cfg arch_mux_cfg;
 
+static inline u16 omap_mux_read(u16 reg)
+{
+	if (cpu_is_omap24xx())
+		return omap_ctrl_readb(reg);
+	else
+		return omap_ctrl_readw(reg);
+}
+
+static inline void omap_mux_write(u16 val, u16 reg)
+{
+	if (cpu_is_omap24xx())
+		return omap_ctrl_writeb(val, reg);
+	else
+		return omap_ctrl_writew(val, reg);
+}
+
 /* NOTE: See mux.h for the enumeration */
 
 #ifdef CONFIG_ARCH_OMAP24XX
@@ -566,10 +582,7 @@ static void __init_or_module omap2_cfg_debug(const struct pin_config *cfg, u16 r
 	u16 orig;
 	u8 warn = 0, debug = 0;
 
-	if (cpu_is_omap24xx())
-		orig = omap_ctrl_readb(cfg->mux_reg);
-	else
-		orig = omap_ctrl_readw(cfg->mux_reg);
+	orig = omap_mux_read(cfg->mux_reg);
 
 #ifdef	CONFIG_OMAP_MUX_DEBUG
 	debug = cfg->debug;
@@ -599,7 +612,7 @@ static int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
 	if (cfg->pu_pd_val)
 		reg |= OMAP2_PULL_UP;
 	omap2_cfg_debug(cfg, reg);
-	omap_ctrl_writeb(reg, cfg->mux_reg);
+	omap_mux_write(reg, cfg->mux_reg);
 	spin_unlock_irqrestore(&mux_spin_lock, flags);
 
 	return 0;
@@ -618,7 +631,7 @@ static int __init_or_module omap34xx_cfg_reg(const struct pin_config *cfg)
 	spin_lock_irqsave(&mux_spin_lock, flags);
 	reg |= cfg->mux_val;
 	omap2_cfg_debug(cfg, reg);
-	omap_ctrl_writew(reg, cfg->mux_reg);
+	omap_mux_write(reg, cfg->mux_reg);
 	spin_unlock_irqrestore(&mux_spin_lock, flags);
 
 	return 0;
-- 
1.6.0.6

