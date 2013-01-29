From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Subject: [PATCH v1 1/5] ARM: cache-l2x0: add 'smc' identifier
Date: Tue, 29 Jan 2013 15:43:31 +0530
Message-ID: <20130129101328.GA11878@bnru10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux@arm.linux.org.uk, avorontsov@mvista.com, gregory.clement@free-electrons.com, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de, shawn.guo@linaro.org, rubini@unipv.it, linus.walleij@linaro.org, linux-omap@vger.kernel.org, tony@atomide.com, horms@verge.net.au, magnus.damm@gmail.com, viresh.linux@gmail.com, shiraz.hashim@st.com
List-Id: linux-omap@vger.kernel.org

Add 'smc' (Secure Monitor Call) identifier to differentiates
the platforms which implements this.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
---
 arch/arm/boot/dts/omap4.dtsi                   |    1 +
 arch/arm/include/asm/hardware/cache-l2x0.h     |    2 +-
 arch/arm/mach-cns3xxx/core.c                   |    4 ++--
 arch/arm/mach-exynos/common.c                  |    4 ++--
 arch/arm/mach-imx/mm-imx3.c                    |    4 ++--
 arch/arm/mach-nomadik/cpu-8815.c               |    4 ++--
 arch/arm/mach-omap2/omap4-common.c             |    2 +-
 arch/arm/mach-realview/realview_eb.c           |    4 ++--
 arch/arm/mach-realview/realview_pb1176.c       |    4 ++--
 arch/arm/mach-realview/realview_pb11mp.c       |    4 ++--
 arch/arm/mach-realview/realview_pbx.c          |    4 ++--
 arch/arm/mach-shmobile/board-ag5evm.c          |    2 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c |    4 ++--
 arch/arm/mach-shmobile/board-bonito.c          |    4 ++--
 arch/arm/mach-shmobile/board-kota2.c           |    4 ++--
 arch/arm/mach-shmobile/board-kzm9g.c           |    4 ++--
 arch/arm/mach-shmobile/setup-r8a7779.c         |    4 ++--
 arch/arm/mach-spear13xx/spear13xx.c            |    2 +-
 arch/arm/mach-ux500/cache-l2x0.c               |    2 +-
 arch/arm/mach-vexpress/ct-ca9x4.c              |    2 +-
 arch/arm/mm/cache-l2x0.c                       |   18 ++++++++++++++----
 21 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 739bb79..9eaac63 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -51,6 +51,7 @@
 		reg = <0x48242000 0x1000>;
 		cache-unified;
 		cache-level = <2>;
+		smc;
 	};
 
 	local-timer@0x48240600 {
diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 3b2c40b..49ac638 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -107,7 +107,7 @@
 #define L2X0_WAY_SIZE_SHIFT		3
 
 #ifndef __ASSEMBLY__
-extern void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask);
+extern void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask, bool smc);
 #if defined(CONFIG_CACHE_L2X0) && defined(CONFIG_OF)
 extern int l2x0_of_init(u32 aux_val, u32 aux_mask);
 #else
diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index 031805b..446bd99 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -282,8 +282,8 @@ void __init cns3xxx_l2x0_init(void)
 	val &= 0xfffff888;
 	writel(val, base + L2X0_DATA_LATENCY_CTRL);
 
-	/* 32 KiB, 8-way, parity disable */
-	l2x0_init(base, 0x00540000, 0xfe000fff);
+	/* 32 KiB, 8-way, parity disable, no secure monitor call (smc) */
+	l2x0_init(base, 0x00540000, 0xfe000fff, false);
 }
 
 #endif /* CONFIG_CACHE_L2X0 */
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 1a89824..6624acc 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -754,8 +754,8 @@ static int __init exynos4_l2x0_cache_init(void)
 		clean_dcache_area(&l2x0_regs_phys, sizeof(unsigned long));
 		clean_dcache_area(&l2x0_saved_regs, sizeof(struct l2x0_regs));
 	}
-
-	l2x0_init(S5P_VA_L2CC, L2_AUX_VAL, L2_AUX_MASK);
+	/* no secure monitor call (smc) implemented */
+	l2x0_init(S5P_VA_L2CC, L2_AUX_VAL, L2_AUX_MASK, false);
 	return 0;
 }
 early_initcall(exynos4_l2x0_cache_init);
diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index cefa047..74eedb7 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -111,8 +111,8 @@ void __init imx3_init_l2x0(void)
 		printk(KERN_ERR "remapping L2 cache area failed\n");
 		return;
 	}
-
-	l2x0_init(l2x0_base, 0x00030024, 0x00000000);
+	/* no secure monitor call (smc) implemented */
+	l2x0_init(l2x0_base, 0x00030024, 0x00000000, false);
 #endif
 }
 
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 1273931..7f27151 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -145,8 +145,8 @@ void __init cpu8815_init_irq(void)
  void __init cpu8815_platform_init(void)
 {
 #ifdef CONFIG_CACHE_L2X0
-	/* At full speed latency must be >=2, so 0x249 in low bits */
-	l2x0_init(io_p2v(NOMADIK_L2CC_BASE), 0x00730249, 0xfe000fff);
+	/* At full speed latency must be >=2, so 0x249 in low bits, no smc */
+	l2x0_init(io_p2v(NOMADIK_L2CC_BASE), 0x00730249, 0xfe000fff, false);
 #endif
 	 return;
 }
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 6897ae2..a440fc4 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -214,7 +214,7 @@ static int __init omap_l2_cache_init(void)
 	if (of_have_populated_dt())
 		l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
 	else
-		l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK);
+		l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK, true);
 
 	/*
 	 * Override default outer_cache.disable with a OMAP4
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 28511d4..ca5e75c 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -445,9 +445,9 @@ static void __init realview_eb_init(void)
 		realview_eb11mp_fixup();
 
 #ifdef CONFIG_CACHE_L2X0
-		/* 1MB (128KB/way), 8-way associativity, evmon/parity/share enabled
+		/* 1MB (128KB/way), 8-way associativity, evmon/parity/share enabled, no smc
 		 * Bits:  .... ...0 0111 1001 0000 .... .... .... */
-		l2x0_init(__io_address(REALVIEW_EB11MP_L220_BASE), 0x00790000, 0xfe000fff);
+		l2x0_init(__io_address(REALVIEW_EB11MP_L220_BASE), 0x00790000, 0xfe000fff, false);
 #endif
 		platform_device_register(&pmu_device);
 	}
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 07d6672..f2e851d 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -358,8 +358,8 @@ static void __init realview_pb1176_init(void)
 	int i;
 
 #ifdef CONFIG_CACHE_L2X0
-	/* 128Kb (16Kb/way) 8-way associativity. evmon/parity/share enabled. */
-	l2x0_init(__io_address(REALVIEW_PB1176_L220_BASE), 0x00730000, 0xfe000fff);
+	/* 128Kb (16Kb/way) 8-way associativity. evmon/parity/share enabled, no smc */
+	l2x0_init(__io_address(REALVIEW_PB1176_L220_BASE), 0x00730000, 0xfe000fff, false);
 #endif
 
 	realview_flash_register(realview_pb1176_flash_resources,
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 7ed53d7..6cb7f60 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -340,9 +340,9 @@ static void __init realview_pb11mp_init(void)
 	int i;
 
 #ifdef CONFIG_CACHE_L2X0
-	/* 1MB (128KB/way), 8-way associativity, evmon/parity/share enabled
+	/* 1MB (128KB/way), 8-way associativity, evmon/parity/share enabled, no smc
 	 * Bits:  .... ...0 0111 1001 0000 .... .... .... */
-	l2x0_init(__io_address(REALVIEW_TC11MP_L220_BASE), 0x00790000, 0xfe000fff);
+	l2x0_init(__io_address(REALVIEW_TC11MP_L220_BASE), 0x00790000, 0xfe000fff, false);
 #endif
 
 	realview_flash_register(realview_pb11mp_flash_resource,
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 4f486f0..d90bdbd 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -376,9 +376,9 @@ static void __init realview_pbx_init(void)
 		writel(0, l2x0_base + L2X0_TAG_LATENCY_CTRL);
 		writel(0, l2x0_base + L2X0_DATA_LATENCY_CTRL);
 
-		/* 16KB way size, 8-way associativity, parity disabled
+		/* 16KB way size, 8-way associativity, parity disabled, no smc
 		 * Bits:  .. 0 0 0 0 1 00 1 0 1 001 0 000 0 .... .... .... */
-		l2x0_init(l2x0_base, 0x02520000, 0xc0000fff);
+		l2x0_init(l2x0_base, 0x02520000, 0xc0000fff, false);
 		platform_device_register(&pmu_device);
 	}
 #endif
diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 032d108..788dc1f 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -656,7 +656,7 @@ static void __init ag5evm_init(void)
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Shared attribute override enable, 64K*8way */
-	l2x0_init(IOMEM(0xf0100000), 0x00460000, 0xc2000fff);
+	l2x0_init(IOMEM(0xf0100000), 0x00460000, 0xc2000fff, false);
 #endif
 	sh73a0_add_standard_devices();
 	platform_add_devices(ag5evm_devices, ARRAY_SIZE(ag5evm_devices));
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 5353adf..2ff7e81 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1163,8 +1163,8 @@ static void __init eva_init(void)
 
 
 #ifdef CONFIG_CACHE_L2X0
-	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
-	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
+	/* Early BRESP enable, Shared attribute override enable, 32K*8way, no smc */
+	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff, false);
 #endif
 
 	i2c_register_board_info(0, i2c0_devices, ARRAY_SIZE(i2c0_devices));
diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index cb8c994..eca8b32 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -380,8 +380,8 @@ static void __init bonito_init(void)
 	 */
 
 #ifdef CONFIG_CACHE_L2X0
-	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
-	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
+	/* Early BRESP enable, Shared attribute override enable, 32K*8way, no smc */
+	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff, false);
 #endif
 
 	r8a7740_add_standard_devices();
diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index bf88f9a..57d0732 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -537,8 +537,8 @@ static void __init kota2_init(void)
 	gpio_request(GPIO_FN_SDHID1_0_PU, NULL);
 
 #ifdef CONFIG_CACHE_L2X0
-	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
-	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
+	/* Early BRESP enable, Shared attribute override enable, 64K*8way, no smc */
+	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff, false);
 #endif
 	sh73a0_add_standard_devices();
 	platform_add_devices(kota2_devices, ARRAY_SIZE(kota2_devices));
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index c02448d..31e9d1a 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -762,8 +762,8 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_VBUS_0,	NULL);
 
 #ifdef CONFIG_CACHE_L2X0
-	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
-	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
+	/* Early BRESP enable, Shared attribute override enable, 64K*8way, no smc */
+	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff, false);
 #endif
 
 	i2c_register_board_info(0, i2c0_devices, ARRAY_SIZE(i2c0_devices));
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 7a1ad4f..15db786 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -323,8 +323,8 @@ static struct platform_device *r8a7779_late_devices[] __initdata = {
 void __init r8a7779_add_standard_devices(void)
 {
 #ifdef CONFIG_CACHE_L2X0
-	/* Early BRESP enable, Shared attribute override enable, 64K*16way */
-	l2x0_init(IOMEM(0xf0100000), 0x40470000, 0x82000fff);
+	/* Early BRESP enable, Shared attribute override enable, 64K*16way, no smc */
+	l2x0_init(IOMEM(0xf0100000), 0x40470000, 0x82000fff, false);
 #endif
 	r8a7779_pm_init();
 
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index c4af775..83671be 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -102,7 +102,7 @@ void __init spear13xx_l2x0_init(void)
 	 */
 	writel_relaxed(0x221, VA_L2CC_BASE + L2X0_TAG_LATENCY_CTRL);
 	writel_relaxed(0x441, VA_L2CC_BASE + L2X0_DATA_LATENCY_CTRL);
-	l2x0_init(VA_L2CC_BASE, 0x70A60001, 0xfe00ffff);
+	l2x0_init(VA_L2CC_BASE, 0x70A60001, 0xfe00ffff, false);
 }
 
 /*
diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 75d5b51..e770156 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -58,7 +58,7 @@ static int __init ux500_l2x0_init(void)
 	if (of_have_populated_dt())
 		l2x0_of_init(aux_val, 0xc0000fff);
 	else
-		l2x0_init(l2x0_base, aux_val, 0xc0000fff);
+		l2x0_init(l2x0_base, aux_val, 0xc0000fff, false);
 
 	/*
 	 * We can't disable l2 as we are in non secure mode, currently
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 60838dd..e3e6644 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -148,7 +148,7 @@ static void __init ct_ca9x4_init(void)
 	writel(0, l2x0_base + L2X0_TAG_LATENCY_CTRL);
 	writel(0, l2x0_base + L2X0_DATA_LATENCY_CTRL);
 
-	l2x0_init(l2x0_base, 0x00400000, 0xfe0fffff);
+	l2x0_init(l2x0_base, 0x00400000, 0xfe0fffff, false);
 #endif
 
 	for (i = 0; i < ARRAY_SIZE(ct_ca9x4_amba_devs); i++)
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index c2f3739..432fef0 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -320,7 +320,7 @@ static void l2x0_unlock(u32 cache_id)
 	}
 }
 
-void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
+void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask, bool smc)
 {
 	u32 aux;
 	u32 cache_id;
@@ -352,8 +352,10 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 		/* Unmapped register. */
 		sync_reg_offset = L2X0_DUMMY_REG;
 #endif
-		if ((cache_id & L2X0_CACHE_ID_RTL_MASK) <= L2X0_CACHE_ID_RTL_R3P0)
+		if (smc)
 			outer_cache.set_debug = pl310_set_debug;
+		else
+			outer_cache.set_debug = NULL;
 		break;
 	case L2X0_CACHE_ID_PART_L210:
 		ways = (aux >> 13) & 0xf;
@@ -425,6 +427,7 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 
 #ifdef CONFIG_OF
 static int l2_wt_override;
+static bool is_smc;
 
 /*
  * Note that the end addresses passed to Linux primitives are
@@ -590,6 +593,14 @@ static void __init pl310_of_setup(const struct device_node *np,
 		writel_relaxed((filter[0] & ~(SZ_1M - 1)) | L2X0_ADDR_FILTER_EN,
 			       l2x0_base + L2X0_ADDR_FILTER_START);
 	}
+
+	is_smc = of_property_read_bool(np, "smc");
+
+	if (is_smc) {
+		/* set the debug interface */
+		outer_cache.set_debug = pl310_set_debug;
+	}
+
 }
 
 static void __init pl310_save(void)
@@ -725,7 +736,6 @@ static const struct l2x0_of_data pl310_data = {
 		.flush_all   = l2x0_flush_all,
 		.inv_all     = l2x0_inv_all,
 		.disable     = l2x0_disable,
-		.set_debug   = pl310_set_debug,
 	},
 };
 
@@ -814,7 +824,7 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 		data->save();
 
 	of_init = true;
-	l2x0_init(l2x0_base, aux_val, aux_mask);
+	l2x0_init(l2x0_base, aux_val, aux_mask, is_smc);
 
 	memcpy(&outer_cache, &data->outer_cache, sizeof(outer_cache));
 
-- 
1.7.2.dirty
