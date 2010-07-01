From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [RFC 6/6] omap: enable remoteproc building
Date: Fri,  2 Jul 2010 01:23:14 +0300
Message-ID: <1278022994-28476-7-git-send-email-ohad@wizery.com>
References: <1278022994-28476-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39213 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933515Ab0GAWXo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 18:23:44 -0400
Received: by mail-bw0-f46.google.com with SMTP id 1so1212641bwz.19
        for <linux-omap@vger.kernel.org>; Thu, 01 Jul 2010 15:23:44 -0700 (PDT)
In-Reply-To: <1278022994-28476-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohadb@ti.com>

From: Ohad Ben-Cohen <ohadb@ti.com>

Make it possible to build omap's remoteproc module

Signed-off-by: Ohad Ben-Cohen <ohadb@ti.com>
Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/Makefile |    6 ++++++
 arch/arm/plat-omap/Kconfig   |    7 +++++++
 arch/arm/plat-omap/Makefile  |    1 +
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 307f8b0..edb65b3 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -59,6 +59,12 @@ obj-$(CONFIG_OMAP3_EMU)		+= emu.o
 obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
 mailbox_mach-objs			:= mailbox.o
 
+ifneq ($(CONFIG_OMAP_REMOTE_PROC),)
+obj-$(CONFIG_ARCH_OMAP2)		+= remoteproc24xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= remoteproc3xxx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= remoteproc44xx.o
+endif
+
 iommu-y					+= iommu2.o
 iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
 
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index e2ea04a..e7d7372 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -96,6 +96,13 @@ config OMAP_MBOX_FWK
 	  Say Y here if you want to use OMAP Mailbox framework support for
 	  DSP, IVA1.0 and IVA2 in OMAP1/2/3.
 
+config OMAP_REMOTE_PROC
+	bool "Remote Processor framework support"
+	depends on ARCH_OMAP
+	help
+	  Say Y here if you want to use OMAP Remote Processor framework
+	  support for DSP, Tesla and/or Ducati (OMAP3/4).
+
 config OMAP_IOMMU
 	tristate
 
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 98f0191..bacb5c3 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -29,5 +29,6 @@ obj-y += $(i2c-omap-m) $(i2c-omap-y)
 
 # OMAP mailbox framework
 obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
+obj-$(CONFIG_OMAP_REMOTE_PROC) += remoteproc.o
 
 obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
\ No newline at end of file
-- 
1.7.0.4

