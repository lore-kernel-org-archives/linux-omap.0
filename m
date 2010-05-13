From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 12/15] omap: mailbox: always built-in platform data
Date: Thu, 13 May 2010 20:47:33 +0300
Message-ID: <1273772856-10881-13-git-send-email-felipe.contreras@gmail.com>
References: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:11171 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756559Ab0EMRsy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 13:48:54 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2624632fgg.1
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 10:48:53 -0700 (PDT)
In-Reply-To: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/Makefile |    6 +++---
 arch/arm/mach-omap2/Makefile |    5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 9ce17f1..af2b2ea 100644
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
index 307f8b0..9fcd87b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -56,8 +56,9 @@ obj-$(CONFIG_ARCH_OMAP4)		+= clock44xx.o clock44xx_data.o
 # EMU peripherals
 obj-$(CONFIG_OMAP3_EMU)		+= emu.o
 
-obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
-mailbox_mach-objs			:= mailbox.o
+ifneq ($(CONFIG_OMAP_MBOX_FWK),)
+obj-y					+= mailbox.o
+endif
 
 iommu-y					+= iommu2.o
 iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
-- 
1.7.1

