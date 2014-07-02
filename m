From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/2] hwspinlock/omap: enable build for AM33xx, AM43xx & DRA7xx
Date: Wed, 2 Jul 2014 18:01:00 -0500
Message-ID: <1404342060-2919-3-git-send-email-s-anna@ti.com>
References: <1404342060-2919-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36020 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbaGBXBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2014 19:01:36 -0400
In-Reply-To: <1404342060-2919-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

HwSpinlocks are supported on AM33xx, AM43xx and DRA7xx SoC
device families as well. The IPs are identical to that of
OMAP4/OMAP5, except for the number of locks.

Add a depends on to the above family of SoCs to enable the
build support for OMAP hwspinlock driver for any of the above
SoC configs.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/hwspinlock/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index 70637d2..3612cb5 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -10,7 +10,7 @@ menu "Hardware Spinlock drivers"
 
 config HWSPINLOCK_OMAP
 	tristate "OMAP Hardware Spinlock device"
-	depends on ARCH_OMAP4 || SOC_OMAP5
+	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX || SOC_AM33XX || SOC_AM43XX
 	select HWSPINLOCK
 	help
 	  Say y here to support the OMAP Hardware Spinlock device (firstly
-- 
2.0.0

