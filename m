From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 13/30] ARM: omap2+: fix omap_hdq_init compilation
Date: Sun,  2 Oct 2011 16:45:43 +0200
Message-ID: <1317566760-25681-14-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The definition of the device must depend on the hardware
we run on, not on the kernel configuration.

arch/arm/mach-omap2/devices.c:624:13: error: 'OMAP_HDQ_BASE' undeclared here (not in a function)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/devices.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 1077ad6..392f2b0 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -29,6 +29,7 @@
 #include <mach/gpio.h>
 #include <plat/mmc.h>
 #include <plat/dma.h>
+#include <plat/cpu.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 #include <plat/omap4-keypad.h>
@@ -615,10 +616,8 @@ void __init omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
 
 /*-------------------------------------------------------------------------*/
 
-#if defined(CONFIG_HDQ_MASTER_OMAP) || defined(CONFIG_HDQ_MASTER_OMAP_MODULE)
 #if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_SOC_OMAP3430)
 #define OMAP_HDQ_BASE	0x480B2000
-#endif
 static struct resource omap_hdq_resources[] = {
 	{
 		.start		= OMAP_HDQ_BASE,
@@ -641,10 +640,13 @@ static struct platform_device omap_hdq_dev = {
 };
 static inline void omap_hdq_init(void)
 {
-	(void) platform_device_register(&omap_hdq_dev);
+	if (cpu_is_omap2430() || cpu_is_omap3430())
+		(void) platform_device_register(&omap_hdq_dev);
 }
 #else
-static inline void omap_hdq_init(void) {}
+static inline void omap_hdq_init(void)
+{
+}
 #endif
 
 /*---------------------------------------------------------------------------*/
-- 
1.7.5.4
