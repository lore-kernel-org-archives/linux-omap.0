From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv4 7/7] hwspinlock/omap: enable build for AM33xx, AM43xx & DRA7xx
Date: Mon, 13 Jan 2014 18:19:24 -0600
Message-ID: <1389658764-39199-8-git-send-email-s-anna@ti.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389658764-39199-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Tony Lindgren <tony@atomide.com>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

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
1.8.4.3
