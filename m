From: David Sin <davidsin@ti.com>
Subject: [PATCH 8/9] TILER-DMM: Linking TILER driver into the Linux kernel build
Date: Mon,  6 Dec 2010 16:27:25 -0600
Message-ID: <1291674446-10766-9-git-send-email-davidsin@ti.com>
References: <1291674446-10766-1-git-send-email-davidsin@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35691 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754653Ab0LFWQT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Dec 2010 17:16:19 -0500
In-Reply-To: <1291674446-10766-1-git-send-email-davidsin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>, Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@li
Cc: Lajos Molnar <molnar@ti.com>, David Sin <davidsin@ti.com>

From: Lajos Molnar <molnar@ti.com>

This patch links the TILER driver into the Linux kernel build
and config system.

Signed-off-by: Lajos Molnar <molnar@ti.com>
Signed-off-by: David Sin <davidsin@ti.com>
---
 drivers/misc/Kconfig  |    1 +
 drivers/misc/Makefile |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4d073f1..1ebc655 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -457,5 +457,6 @@ source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
 source "drivers/misc/iwmc3200top/Kconfig"
 source "drivers/misc/ti-st/Kconfig"
+source "drivers/misc/tiler/Kconfig"
 
 endif # MISC_DEVICES
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 98009cc..3716c49 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -42,3 +42,4 @@ obj-$(CONFIG_ARM_CHARLCD)	+= arm-charlcd.o
 obj-$(CONFIG_PCH_PHUB)		+= pch_phub.o
 obj-y				+= ti-st/
 obj-$(CONFIG_AB8500_PWM)	+= ab8500-pwm.o
+obj-$(CONFIG_TI_TILER)		+= tiler/
-- 
1.7.0.4

