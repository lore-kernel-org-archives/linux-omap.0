From: David Sin <davidsin@ti.com>
Subject: [RFC 8/8] TILER-DMM: Linking TILER driver into the Linux kernel build
Date: Fri, 23 Jul 2010 18:22:28 -0500
Message-ID: <1279927348-21750-9-git-send-email-davidsin@ti.com>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com>
 <1279927348-21750-2-git-send-email-davidsin@ti.com>
 <1279927348-21750-3-git-send-email-davidsin@ti.com>
 <1279927348-21750-4-git-send-email-davidsin@ti.com>
 <1279927348-21750-5-git-send-email-davidsin@ti.com>
 <1279927348-21750-6-git-send-email-davidsin@ti.com>
 <1279927348-21750-7-git-send-email-davidsin@ti.com>
 <1279927348-21750-8-git-send-email-davidsin@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43178 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757523Ab0GWXHE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jul 2010 19:07:04 -0400
In-Reply-To: <1279927348-21750-8-git-send-email-davidsin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <rmk@arm.linux.org.uk>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Lajos Molnar <molnar@ti.com>, David Sin <davidsin@ti.com>

From: Lajos Molnar <molnar@ti.com>

This patch links the TILER driver into the Linux kernel build
and config system.

Signed-off-by: Lajos Molnar <molnar@ti.com>
Signed-off-by: David Sin <davidsin@ti.com>
---
 drivers/media/Kconfig  |    6 ++++++
 drivers/media/Makefile |    2 ++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index a28541b..96ebc1d 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -98,6 +98,12 @@ config VIDEO_MEDIA
 
 comment "Multimedia drivers"
 
+#
+# TI TILER driver support
+#
+
+source "drivers/media/video/tiler/Kconfig"
+
 source "drivers/media/common/Kconfig"
 source "drivers/media/IR/Kconfig"
 
diff --git a/drivers/media/Makefile b/drivers/media/Makefile
index 499b081..922d71c 100644
--- a/drivers/media/Makefile
+++ b/drivers/media/Makefile
@@ -4,5 +4,7 @@
 
 obj-y += common/ IR/ video/
 
+obj-${CONFIG_TI_TILER} += video/tiler/
+
 obj-$(CONFIG_VIDEO_DEV) += radio/
 obj-$(CONFIG_DVB_CORE)  += dvb/
-- 
1.6.3.3

