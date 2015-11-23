From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP: RX-51: fix a typo in log writing
Date: Mon, 23 Nov 2015 23:32:57 +0200
Message-ID: <1448314377-28848-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Fix a typo when registering HW RNG.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c | 2 +-
 arch/arm/mach-omap2/pdata-quirks.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 14edcd7..ff1520b 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -1257,7 +1257,7 @@ static struct platform_device omap3_rom_rng_device = {
 static void __init rx51_init_omap3_rom_rng(void)
 {
 	if (omap_type() == OMAP2_DEVICE_TYPE_SEC) {
-		pr_info("RX-51: Registring OMAP3 HWRNG device\n");
+		pr_info("RX-51: Registering OMAP3 HWRNG device\n");
 		platform_device_register(&omap3_rom_rng_device);
 	}
 }
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 1dfe346..35ea6c0 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -268,7 +268,7 @@ static void __init nokia_n900_legacy_init(void)
 			pr_warn("Thumb binaries may crash randomly without this workaround\n");
 		}
 
-		pr_info("RX-51: Registring OMAP3 HWRNG device\n");
+		pr_info("RX-51: Registering OMAP3 HWRNG device\n");
 		platform_device_register(&omap3_rom_rng_device);
 
 	}
-- 
2.4.0
