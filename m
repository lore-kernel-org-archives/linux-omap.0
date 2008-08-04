From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] Add option for DSP bridge debugging.
Date: Mon,  4 Aug 2008 16:47:36 +0300
Message-ID: <1217857656-31431-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:27097 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245AbYHDNsy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 09:48:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Contreras <felipe.contreras@gmail.com>

---
 drivers/dsp/dspbridge/Kconfig               |    3 +++
 drivers/dsp/dspbridge/mpu_driver/src/Kbuild |    2 +-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/dspbridge/Kconfig b/drivers/dsp/dspbridge/Kconfig
index 5d5622d..580c148 100644
--- a/drivers/dsp/dspbridge/Kconfig
+++ b/drivers/dsp/dspbridge/Kconfig
@@ -29,4 +29,7 @@ config BRIDGE_PM
 	DSP Bridge employs power management techniques to save dynamic and
 	static power consumption of the IVA sub system.
 
+config BRIDGE_DEBUG
+	bool "DSP Bridge Debug Support"
+
 endif
diff --git a/drivers/dsp/dspbridge/mpu_driver/src/Kbuild b/drivers/dsp/dspbridge/mpu_driver/src/Kbuild
index b6ad62a..62ca643 100644
--- a/drivers/dsp/dspbridge/mpu_driver/src/Kbuild
+++ b/drivers/dsp/dspbridge/mpu_driver/src/Kbuild
@@ -33,7 +33,7 @@ ccflags-y = -DDISABLE_BRIDGE_PM
 endif
 
 # Debug
-ifeq ($(CONFIG_DEBUG_KERNEL),y)
+ifeq ($(CONFIG_BRIDGE_DEBUG),y)
 ccflags-y += -DGT_TRACE -DDEBUG
 endif
 
-- 
1.5.6.2.1.g1a51b

