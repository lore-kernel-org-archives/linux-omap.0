From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 6/9] hwspinlock/omap: support AM33xx
Date: Tue, 17 Sep 2013 14:31:10 -0500
Message-ID: <85e0d8604a7ca66ed38f82e0ef6b2ce5c908f728.1379445653.git.s-anna@ti.com>
References: <cover.1379445653.git.s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379445653.git.s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

AM33XX device family also supports hwspinlocks. The IP
is identical to that of OMAP4/OMAP5, except for the
number of locks.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/hwspinlock/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index 70637d2..34ff9cd 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -10,7 +10,7 @@ menu "Hardware Spinlock drivers"
 
 config HWSPINLOCK_OMAP
 	tristate "OMAP Hardware Spinlock device"
-	depends on ARCH_OMAP4 || SOC_OMAP5
+	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_AM33XX
 	select HWSPINLOCK
 	help
 	  Say y here to support the OMAP Hardware Spinlock device (firstly
-- 
1.8.3.3
