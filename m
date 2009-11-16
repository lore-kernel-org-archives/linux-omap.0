From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH] OMAP: Exporting functions doing common register access
Date: Mon, 16 Nov 2009 20:50:36 +0530
Message-ID: <1258384836-24854-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46527 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285AbZKPPUf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Nov 2009 10:20:35 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAGFKcFi026452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2009 09:20:40 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>

These functions need to be exported so that drivers (e.g. McBSP) can
be configured as modules.

McBSP driver gets built as a module when ASoC driver for OMAP3 EVM
is configured as module. McBSP driver uses functions like
omap_ctrl_readl/omap_ctrl_writel, which are defined in control.c
file but not exported. Without that, McBSP driver fails to build as
a module.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/control.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 6adb360..8285e1f 100644
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
1.6.2.4

