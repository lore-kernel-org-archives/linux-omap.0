From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 5/5] ARM: Kconfig update to support additional GPIOs in OMAP5
Date: Thu, 5 Jul 2012 17:38:46 +0530
Message-ID: <1341490136-25901-9-git-send-email-santosh.shilimkar@ti.com>
References: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34055 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753737Ab2GEMKi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Jul 2012 08:10:38 -0400
In-Reply-To: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

From: Tarun Kanti DebBarma <tarun.kanti@ti.com>

OMAP5 has 8 GPIO banks so that there are 32x8 = 256 GPIOs.
In order for the gpiolib to detect and initialize these
additional GPIOs and other TWL GPIOs, ARCH_NR_GPIO is set
to 512 instead of present 256.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Reported-by: Govindraj.R <govindraj.raja@ti.com>
Tested-by: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a91009c..02fae9a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1581,6 +1581,7 @@ config ARCH_NR_GPIO
 	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
 	default 355 if ARCH_U8500
 	default 264 if MACH_H4700
+	default 512 if SOC_OMAP5
 	default 0
 	help
 	  Maximum number of GPIOs in the system.
-- 
1.7.9.5

