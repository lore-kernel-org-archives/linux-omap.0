From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 04/30] ARM: omap: add missing __devexit_p() annotations
Date: Sun,  2 Oct 2011 16:45:34 +0200
Message-ID: <1317566760-25681-5-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

Drivers that refer to a __devexit function in an operations
structure need to annotate that pointer with __devexit_p so
replace it with a NULL pointer when the section gets discarded.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 arch/arm/plat-omap/dma.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 34c01a7..67bc6ce 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1002,7 +1002,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver smartreflex_driver = {
-	.remove         = omap_sr_remove,
+	.remove         = __devexit_p(omap_sr_remove),
 	.driver		= {
 		.name	= "smartreflex",
 	},
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c22217c..f7150ba 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2105,7 +2105,7 @@ static int __devexit omap_system_dma_remove(struct platform_device *pdev)
 
 static struct platform_driver omap_system_dma_driver = {
 	.probe		= omap_system_dma_probe,
-	.remove		= omap_system_dma_remove,
+	.remove		= __devexit_p(omap_system_dma_remove),
 	.driver		= {
 		.name	= "omap_dma_system"
 	},
-- 
1.7.5.4
