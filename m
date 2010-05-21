From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2t2 13/17] omap: mailbox: always built-in platform data
Date: Sat, 22 May 2010 00:44:45 +0300
Message-ID: <1274478289-22188-14-git-send-email-felipe.contreras@gmail.com>
References: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40510 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318Ab0EUVpb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 17:45:31 -0400
Received: by mail-fx0-f46.google.com with SMTP id 5so1251271fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 14:45:30 -0700 (PDT)
In-Reply-To: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/Makefile |    6 +++---
 arch/arm/mach-omap2/Makefile |    5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index b6a537c..c1e1ae5 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -14,9 +14,9 @@ obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
 # Power Management
 obj-$(CONFIG_PM) += pm.o sleep.o
 
-# DSP
-obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
-mailbox_mach-objs		:= mailbox.o
+ifneq ($(CONFIG_OMAP_MBOX_FWK),)
+obj-y					+= mailbox.o
+endif
 
 i2c-omap-$(CONFIG_I2C_OMAP)		:= i2c.o
 obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4b9fc57..c9757fb 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -86,8 +86,9 @@ obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_3xxx_data.o
 # EMU peripherals
 obj-$(CONFIG_OMAP3_EMU)			+= emu.o
 
-obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
-mailbox_mach-objs			:= mailbox.o
+ifneq ($(CONFIG_OMAP_MBOX_FWK),)
+obj-y					+= mailbox.o
+endif
 
 iommu-y					+= iommu2.o
 iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
-- 
1.7.1

