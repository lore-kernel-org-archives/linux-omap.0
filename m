From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 2/2] OMAP: RX51: save ATAGS data in the early boot stage
Date: Thu, 24 Dec 2015 18:37:56 +0200
Message-ID: <1450975076-7411-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <20151224153536.GJ30871@n2100.arm.linux.org.uk>
 <1450975076-7411-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450975076-7411-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@arm.linux.org.uk, tony@atomide.com, nicolas.pitre@linaro.org, arnd@arndb.de, pali.rohar@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

Nokia N900 (RX51) legacy userspace needs various ATAGS passed by the
bootloader (boot reason, device serial, boot mode, various GPIO swithes,
etc). Save that data early enough in the boot process, so it can be
exported later in /proc/atags

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 arch/arm/mach-omap2/board-generic.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 04a56cc..8098272 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -16,6 +16,7 @@
 #include <linux/of_platform.h>
 #include <linux/irqdomain.h>
 
+#include <asm/setup.h>
 #include <asm/mach/arch.h>
 
 #include "common.h"
@@ -76,8 +77,17 @@ static const char *const n900_boards_compat[] __initconst = {
 	NULL,
 };
 
+/* Legacy userspace on Nokia N900 needs ATAGS exported in /proc/atags,
+ * save them while the data is still not overwritten
+ */
+static void __init rx51_reserve(void)
+{
+	save_atags((const struct tag *)(PAGE_OFFSET + 0x100));
+	omap_reserve();
+}
+
 DT_MACHINE_START(OMAP3_N900_DT, "Nokia RX-51 board")
-	.reserve	= omap_reserve,
+	.reserve	= rx51_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
 	.init_machine	= omap_generic_init,
-- 
1.9.1
