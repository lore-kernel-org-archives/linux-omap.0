From: "George G. Davis" <gdavis@mvista.com>
Subject: [PATCH] ARM: OMAP2: Fix missing system control module exports
Date: Mon, 2 Mar 2009 09:47:23 -0500
Message-ID: <20090302144723.GD18140@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:11834 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbZCBOrZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 09:47:25 -0500
Received: from c-24-61-246-122.hsd1.ma.comcast.net (asshur.mvista.com [10.0.0.11])
	by hermes.mvista.com (Postfix) with ESMTP id 74F2C18389
	for <linux-omap@vger.kernel.org>; Mon,  2 Mar 2009 06:47:23 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

When building ASoC drivers as modules for SND_OMAP_SOC_MCBSP based
targets, the build fails because omap_ctrl_{read,write}l lack exports.
So add the missing exports for omap_ctrl_{read,write}[bwl] to allow
building these ASoC (and other) drivers as modules.

Signed-off-by: George G. Davis <gdavis@mvista.com>
Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/control.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 5f3aad9..6b14639 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -36,29 +36,35 @@ u8 omap_ctrl_readb(u16 offset)
 {
 	return __raw_readb(OMAP_CTRL_REGADDR(offset));
 }
+EXPORT_SYMBOL(omap_ctrl_readb);
 
 u16 omap_ctrl_readw(u16 offset)
 {
 	return __raw_readw(OMAP_CTRL_REGADDR(offset));
 }
+EXPORT_SYMBOL(omap_ctrl_readw);
 
 u32 omap_ctrl_readl(u16 offset)
 {
 	return __raw_readl(OMAP_CTRL_REGADDR(offset));
 }
+EXPORT_SYMBOL(omap_ctrl_readl);
 
 void omap_ctrl_writeb(u8 val, u16 offset)
 {
 	__raw_writeb(val, OMAP_CTRL_REGADDR(offset));
 }
+EXPORT_SYMBOL(omap_ctrl_writeb);
 
 void omap_ctrl_writew(u16 val, u16 offset)
 {
 	__raw_writew(val, OMAP_CTRL_REGADDR(offset));
 }
+EXPORT_SYMBOL(omap_ctrl_writew);
 
 void omap_ctrl_writel(u32 val, u16 offset)
 {
 	__raw_writel(val, OMAP_CTRL_REGADDR(offset));
 }
+EXPORT_SYMBOL(omap_ctrl_writel);
 
-- 
1.6.1.2.MVISTA

