From: "Basheer, Mansoor Ahamed" <mansoor.ahamed@ti.com>
Subject: [PATCH] OMAP: TI816X: Add SATA support
Date: Thu,  7 Apr 2011 15:54:47 +0530
Message-ID: <1302171887-3598-1-git-send-email-mansoor.ahamed@ti.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Sender: linux-ide-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org, Mansoor Ahamed <mansoor.ahamed@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Mansoor Ahamed <mansoor.ahamed@ti.com>

Add support for SATA controller on the
TI816X devices.

TI816X supports 1 HBA with 2 ports (dedicated DMA).
This is a Gen 2 HBA with 3Gbps support.
It supports Port Multiplier but only in
Command Based Switching mode.

The patch adds required platform resource and
SATA controller initialization routine.

The PHY configuration in this patch is
courtesy of the work done by Zegeye Alemu and
Swaminathan from TI.

While testing this patch, enable port multiplier
support if you are actually using one.
Reason for this behaviour is discussed
here: http://patchwork.ozlabs.org/patch/78163/

Signed-off-by: Basheer, Mansoor Ahamed <mansoor.ahamed@ti.com>
---
This patch depends on patch "TI816X: clock: Add clock data"
from Hemant Pedanekar <hemantp@ti.com>

 arch/arm/mach-omap2/devices.c |  126 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 126 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index d478f53..9c33022 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -16,6 +16,8 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/ahci_platform.h>
+#include <linux/dma-mapping.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -100,6 +102,129 @@ static int __init omap4_l3_init(void)
 }
 postcore_initcall(omap4_l3_init);
 
+#if defined(CONFIG_SATA_AHCI_PLATFORM) || \
+	defined(CONFIG_SATA_AHCI_PLATFORM_MODULE)
+
+static struct ahci_platform_data omap_sata_pdata;
+static u64 omap_sata_dmamask = DMA_BIT_MASK(32);
+static struct clk *omap_sata_clk;
+
+/* SATA PHY control register offsets */
+#define SATA_P0PHYCR_REG	0x178
+#define SATA_P1PHYCR_REG	0x1F8
+
+#define SATA_PHY_ENPLL(x)	((x) << 0)
+#define SATA_PHY_MPY(x)		((x) << 1)
+#define SATA_PHY_LB(x)		((x) << 5)
+#define SATA_PHY_CLKBYP(x)	((x) << 7)
+#define SATA_PHY_RXINVPAIR(x)	((x) << 9)
+#define SATA_PHY_LBK(x)		((x) << 10)
+#define SATA_PHY_RXLOS(x)	((x) << 12)
+#define SATA_PHY_RXCDR(x)	((x) << 13)
+#define SATA_PHY_RXEQ(x)	((x) << 16)
+#define SATA_PHY_RXENOC(x)	((x) << 20)
+#define SATA_PHY_TXINVPAIR(x)	((x) << 21)
+#define SATA_PHY_TXCM(x)	((x) << 22)
+#define SATA_PHY_TXSWING(x)	((x) << 23)
+#define SATA_PHY_TXDE(x)	((x) << 27)
+
+#define TI816X_SATA_BASE	0x4A140000
+
+static int ti816x_ahci_plat_init(struct device *dev, void __iomem *base)
+{
+	unsigned int phy_val;
+	int ret;
+
+	omap_sata_clk = clk_get(dev, NULL);
+	if (IS_ERR(omap_sata_clk)) {
+		pr_err("ahci : Failed to get SATA clock\n");
+		return PTR_ERR(omap_sata_clk);
+	}
+
+	if (!base) {
+		pr_err("ahci : SATA reg space not mapped, PHY enable failed\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ret = clk_enable(omap_sata_clk);
+	if (ret) {
+		pr_err("ahci : Clock enable failed\n");
+		goto err;
+	}
+
+	phy_val = SATA_PHY_ENPLL(1) |
+			SATA_PHY_MPY(8) |
+			SATA_PHY_LB(0) |
+			SATA_PHY_CLKBYP(0) |
+			SATA_PHY_RXINVPAIR(0) |
+			SATA_PHY_LBK(0) |
+			SATA_PHY_RXLOS(1) |
+			SATA_PHY_RXCDR(4) |
+			SATA_PHY_RXEQ(1) |
+			SATA_PHY_RXENOC(1) |
+			SATA_PHY_TXINVPAIR(0) |
+			SATA_PHY_TXCM(0) |
+			SATA_PHY_TXSWING(7) |
+			SATA_PHY_TXDE(0);
+
+	writel(phy_val, base + SATA_P0PHYCR_REG);
+	writel(phy_val, base + SATA_P1PHYCR_REG);
+
+	return 0;
+err:
+	clk_put(omap_sata_clk);
+	return ret;
+}
+
+static void ti816x_ahci_plat_exit(struct device *dev)
+{
+	clk_disable(omap_sata_clk);
+	clk_put(omap_sata_clk);
+}
+
+/* resources will be filled by soc specific init routine */
+static struct resource omap_ahci_resources[] = {
+	{
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device omap_ahci_device = {
+	.name	= "ahci",
+	.dev	= {
+		.platform_data = &omap_sata_pdata,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.dma_mask		= &omap_sata_dmamask,
+	},
+	.num_resources	= ARRAY_SIZE(omap_ahci_resources),
+	.resource	= omap_ahci_resources,
+};
+
+static void ti816x_ahci_init(void)
+{
+	/* fixup platform device info for TI816X */
+	omap_ahci_resources[0].start	= TI816X_SATA_BASE;
+	omap_ahci_resources[0].end	= TI816X_SATA_BASE + 0x10fff;
+	omap_ahci_resources[1].start	= 16; /* SATA IRQ */
+	omap_sata_pdata.init		= ti816x_ahci_plat_init;
+	omap_sata_pdata.exit		= ti816x_ahci_plat_exit;
+}
+
+static inline void omap_init_ahci(void)
+{
+	if (cpu_is_ti816x()) {
+		ti816x_ahci_init();
+		platform_device_register(&omap_ahci_device);
+	}
+}
+#else
+static inline void omap_init_ahci(void) {}
+#endif
+
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
 static struct resource cam_resources[] = {
@@ -667,6 +792,7 @@ static int __init omap2_init_devices(void)
 	 * please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
+	omap_init_ahci();
 	omap_init_audio();
 	omap_init_camera();
 	omap_init_mbox();
-- 
1.6.2.4

