From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv5 07/15] hwspinlock/omap: enable build for AM33xx, AM43xx & DRA7xx
Date: Wed, 30 Apr 2014 19:34:28 -0500
Message-ID: <1398904476-26200-8-git-send-email-s-anna@ti.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398904476-26200-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>
Cc: Tony Lindgren <tony@atomide.com>, Josh Cartwright <joshc@codeaurora.org>, Bjorn Andersson <bjorn@kryo.se>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>
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
1.9.2
