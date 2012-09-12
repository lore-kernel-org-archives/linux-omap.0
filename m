From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 1/2] ARM: AM33XX: hwmod: Remove platform specific header files
Date: Thu, 13 Sep 2012 02:45:50 +0530
Message-ID: <1347484551-11775-2-git-send-email-hvaibhav@ti.com>
References: <1347484551-11775-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347484551-11775-1-git-send-email-hvaibhav@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, paul@pwsan.com, Vaibhav Hiremath <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

With recent mainline changes on gpio and mcspi drivers, the
platform specific header files (plat/gpio.h and plat/mcspi.h)
have been removed, which results into build failure on
AM33XX hwmod data, which was still using these headers.

This patch removes such both gpio and spi header file entry
from omap_hwmod_33xx_data.c.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index de7a3ab..7b7ed08 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -14,12 +14,14 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/io.h>
+#include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/spi-omap2-mcspi.h>
+
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
-#include <plat/gpio.h>
 #include <plat/dma.h>
 #include <plat/mmc.h>
-#include <plat/mcspi.h>
 #include <plat/i2c.h>
 
 #include "omap_hwmod_common_data.h"
-- 
1.7.0.4
