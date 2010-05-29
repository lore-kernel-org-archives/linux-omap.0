From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 2/4] [OMAP] gpio: Allow for extended GPIO space
Date: Fri, 28 May 2010 22:28:05 -0700
Message-ID: <1275110887-2918-3-git-send-email-darkstar6262@gmail.com>
References: <1275110887-2918-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33300 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab0E2F2s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 May 2010 01:28:48 -0400
Received: by mail-iw0-f174.google.com with SMTP id 6so160874iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 28 May 2010 22:28:48 -0700 (PDT)
In-Reply-To: <1275110887-2918-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linwizard-devel@lists.sf.net, Cory Maccarrone <darkstar6262@gmail.com>

This change copies from the s3c24xx the ability for a board to specify
if it wants 64 or 128 more GPIOs in the board space.  This is needed
to get the HTC Herald board's extra htcpld gpios to work as actual
gpios.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/plat-omap/Kconfig             |   18 ++++++++++++++++++
 arch/arm/plat-omap/include/plat/gpio.h |    7 +++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 78b49a6..52f61f6 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -2,6 +2,24 @@ if ARCH_OMAP
 
 menu "TI OMAP Implementations"
 
+config OMAP_GPIO_EXTRA
+	int
+	default 128 if OMAP_GPIO_EXTRA128
+	default 64 if OMAP_GPIO_EXTRA64
+	default 0
+
+config OMAP_GPIO_EXTRA64
+	bool
+	help
+	  Add an extra 64 gpio numbers to the available GPIO pool. This is
+	  available for boards that need extra gpios for external devices.
+
+config OMAP_GPIO_EXTRA128
+	bool
+	help
+	  Add an extra 128 gpio numbers to the available GPIO pool. This is
+	  available for boards that need extra gpios for external devices.
+
 config ARCH_OMAP_OTG
 	bool
 
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index de1c604..d21b790 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -86,6 +86,13 @@ extern void omap_gpio_restore_context(void);
  * The original OMAP-specfic calls should eventually be removed.
  */
 
+/*
+ * Some boards require extra gpio capacity to support external
+ * devices that need GPIO.
+ */
+
+#define ARCH_NR_GPIOS	(256 + CONFIG_OMAP_GPIO_EXTRA)
+
 #include <linux/errno.h>
 #include <asm-generic/gpio.h>
 
-- 
1.7.0.4

