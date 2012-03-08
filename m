From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/12] ARM: OMAP2xxx: hwmod data: share common hwmods between
 OMAP2420 and OMAP2430
Date: Wed, 07 Mar 2012 19:38:38 -0700
Message-ID: <20120308023837.8205.66638.stgit@dusk>
References: <20120308023614.8205.78768.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45793 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab2CHCmL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 21:42:11 -0500
In-Reply-To: <20120308023614.8205.78768.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

After the link registration conversion, it's much easier to share some
hwmod data between OMAP2420 and 2430.  Move the shareable data into a
common file.  This should save some memory and lines of source, at the
cost of readability.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  669 ++----------=
-------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  688 ++----------=
--------
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  562 ++++++++++++=
++++
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   32 +
 4 files changed, 740 insertions(+), 1211 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2420_data.c
index f74335f..75c57d3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -43,417 +43,12 @@
  * IP blocks
  */
=20
-/* L3 */
-static struct omap_hwmod omap2420_l3_main_hwmod =3D {
-	.name		=3D "l3_main",
-	.class		=3D &l3_hwmod_class,
-	.flags		=3D HWMOD_NO_IDLEST,
-};
-
-/* L4 CORE */
-static struct omap_hwmod omap2420_l4_core_hwmod =3D {
-	.name		=3D "l4_core",
-	.class		=3D &l4_hwmod_class,
-	.flags		=3D HWMOD_NO_IDLEST,
-};
-
-/* L4 WKUP */
-static struct omap_hwmod omap2420_l4_wkup_hwmod =3D {
-	.name		=3D "l4_wkup",
-	.class		=3D &l4_hwmod_class,
-	.flags		=3D HWMOD_NO_IDLEST,
-};
-
-/* MPU */
-static struct omap_hwmod omap2420_mpu_hwmod =3D {
-	.name		=3D "mpu",
-	.class		=3D &mpu_hwmod_class,
-	.main_clk	=3D "mpu_ck",
-};
-
 /* IVA2 (IVA2) */
 static struct omap_hwmod omap2420_iva_hwmod =3D {
 	.name		=3D "iva",
 	.class		=3D &iva_hwmod_class,
 };
=20
-/* always-on timers dev attribute */
-static struct omap_timer_capability_dev_attr capability_alwon_dev_attr=
 =3D {
-	.timer_capability	=3D OMAP_TIMER_ALWON,
-};
-
-/* pwm timers dev attribute */
-static struct omap_timer_capability_dev_attr capability_pwm_dev_attr =3D=
 {
-	.timer_capability	=3D OMAP_TIMER_HAS_PWM,
-};
-
-/* timer1 */
-static struct omap_hwmod omap2420_timer1_hwmod =3D {
-	.name		=3D "timer1",
-	.mpu_irqs	=3D omap2_timer1_mpu_irqs,
-	.main_clk	=3D "gpt1_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT1_SHIFT,
-			.module_offs =3D WKUP_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT1_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_alwon_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer2 */
-static struct omap_hwmod omap2420_timer2_hwmod =3D {
-	.name		=3D "timer2",
-	.mpu_irqs	=3D omap2_timer2_mpu_irqs,
-	.main_clk	=3D "gpt2_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT2_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT2_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_alwon_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer3 */
-static struct omap_hwmod omap2420_timer3_hwmod =3D {
-	.name		=3D "timer3",
-	.mpu_irqs	=3D omap2_timer3_mpu_irqs,
-	.main_clk	=3D "gpt3_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT3_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT3_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_alwon_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer4 */
-static struct omap_hwmod omap2420_timer4_hwmod =3D {
-	.name		=3D "timer4",
-	.mpu_irqs	=3D omap2_timer4_mpu_irqs,
-	.main_clk	=3D "gpt4_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT4_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT4_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_alwon_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer5 */
-static struct omap_hwmod omap2420_timer5_hwmod =3D {
-	.name		=3D "timer5",
-	.mpu_irqs	=3D omap2_timer5_mpu_irqs,
-	.main_clk	=3D "gpt5_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT5_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT5_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_alwon_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer6 */
-static struct omap_hwmod omap2420_timer6_hwmod =3D {
-	.name		=3D "timer6",
-	.mpu_irqs	=3D omap2_timer6_mpu_irqs,
-	.main_clk	=3D "gpt6_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT6_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT6_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_alwon_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer7 */
-static struct omap_hwmod omap2420_timer7_hwmod =3D {
-	.name		=3D "timer7",
-	.mpu_irqs	=3D omap2_timer7_mpu_irqs,
-	.main_clk	=3D "gpt7_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT7_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT7_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_alwon_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer8 */
-static struct omap_hwmod omap2420_timer8_hwmod =3D {
-	.name		=3D "timer8",
-	.mpu_irqs	=3D omap2_timer8_mpu_irqs,
-	.main_clk	=3D "gpt8_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT8_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT8_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_alwon_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer9 */
-static struct omap_hwmod omap2420_timer9_hwmod =3D {
-	.name		=3D "timer9",
-	.mpu_irqs	=3D omap2_timer9_mpu_irqs,
-	.main_clk	=3D "gpt9_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT9_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT9_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_pwm_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer10 */
-static struct omap_hwmod omap2420_timer10_hwmod =3D {
-	.name		=3D "timer10",
-	.mpu_irqs	=3D omap2_timer10_mpu_irqs,
-	.main_clk	=3D "gpt10_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT10_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT10_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_pwm_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer11 */
-static struct omap_hwmod omap2420_timer11_hwmod =3D {
-	.name		=3D "timer11",
-	.mpu_irqs	=3D omap2_timer11_mpu_irqs,
-	.main_clk	=3D "gpt11_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT11_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT11_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_pwm_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer12 */
-static struct omap_hwmod omap2420_timer12_hwmod =3D {
-	.name		=3D "timer12",
-	.mpu_irqs	=3D omap2xxx_timer12_mpu_irqs,
-	.main_clk	=3D "gpt12_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT12_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT12_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_pwm_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-static struct omap_hwmod omap2420_wd_timer2_hwmod =3D {
-	.name		=3D "wd_timer2",
-	.class		=3D &omap2xxx_wd_timer_hwmod_class,
-	.main_clk	=3D "mpu_wdt_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_MPU_WDT_SHIFT,
-			.module_offs =3D WKUP_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_MPU_WDT_SHIFT,
-		},
-	},
-};
-
-/* UART1 */
-static struct omap_hwmod omap2420_uart1_hwmod =3D {
-	.name		=3D "uart1",
-	.mpu_irqs	=3D omap2_uart1_mpu_irqs,
-	.sdma_reqs	=3D omap2_uart1_sdma_reqs,
-	.main_clk	=3D "uart1_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.module_offs =3D CORE_MOD,
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_UART1_SHIFT,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_EN_UART1_SHIFT,
-		},
-	},
-	.class		=3D &omap2_uart_class,
-};
-
-/* UART2 */
-static struct omap_hwmod omap2420_uart2_hwmod =3D {
-	.name		=3D "uart2",
-	.mpu_irqs	=3D omap2_uart2_mpu_irqs,
-	.sdma_reqs	=3D omap2_uart2_sdma_reqs,
-	.main_clk	=3D "uart2_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.module_offs =3D CORE_MOD,
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_UART2_SHIFT,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_EN_UART2_SHIFT,
-		},
-	},
-	.class		=3D &omap2_uart_class,
-};
-
-/* UART3 */
-static struct omap_hwmod omap2420_uart3_hwmod =3D {
-	.name		=3D "uart3",
-	.mpu_irqs	=3D omap2_uart3_mpu_irqs,
-	.sdma_reqs	=3D omap2_uart3_sdma_reqs,
-	.main_clk	=3D "uart3_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.module_offs =3D CORE_MOD,
-			.prcm_reg_id =3D 2,
-			.module_bit =3D OMAP24XX_EN_UART3_SHIFT,
-			.idlest_reg_id =3D 2,
-			.idlest_idle_bit =3D OMAP24XX_EN_UART3_SHIFT,
-		},
-	},
-	.class		=3D &omap2_uart_class,
-};
-
-/* dss */
-
-static struct omap_hwmod_opt_clk dss_opt_clks[] =3D {
-	/*
-	 * The DSS HW needs all DSS clocks enabled during reset. The dss_core
-	 * driver does not use these clocks.
-	 */
-	{ .role =3D "tv_clk", .clk =3D "dss_54m_fck" },
-	{ .role =3D "sys_clk", .clk =3D "dss2_fck" },
-};
-
-static struct omap_hwmod omap2420_dss_core_hwmod =3D {
-	.name		=3D "dss_core",
-	.class		=3D &omap2_dss_hwmod_class,
-	.main_clk	=3D "dss1_fck", /* instead of dss_fck */
-	.sdma_reqs	=3D omap2xxx_dss_sdma_chs,
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_DSS1_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_stdby_bit =3D OMAP24XX_ST_DSS_SHIFT,
-		},
-	},
-	.opt_clks	=3D dss_opt_clks,
-	.opt_clks_cnt =3D ARRAY_SIZE(dss_opt_clks),
-	.flags		=3D HWMOD_NO_IDLEST | HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-};
-
-static struct omap_hwmod omap2420_dss_dispc_hwmod =3D {
-	.name		=3D "dss_dispc",
-	.class		=3D &omap2_dispc_hwmod_class,
-	.mpu_irqs	=3D omap2_dispc_irqs,
-	.main_clk	=3D "dss1_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_DSS1_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_stdby_bit =3D OMAP24XX_ST_DSS_SHIFT,
-		},
-	},
-	.flags		=3D HWMOD_NO_IDLEST,
-	.dev_attr	=3D &omap2_3_dss_dispc_dev_attr
-};
-
-static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] =3D {
-	{ .role =3D "ick", .clk =3D "dss_ick" },
-};
-
-static struct omap_hwmod omap2420_dss_rfbi_hwmod =3D {
-	.name		=3D "dss_rfbi",
-	.class		=3D &omap2_rfbi_hwmod_class,
-	.main_clk	=3D "dss1_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_DSS1_SHIFT,
-			.module_offs =3D CORE_MOD,
-		},
-	},
-	.opt_clks	=3D dss_rfbi_opt_clks,
-	.opt_clks_cnt	=3D ARRAY_SIZE(dss_rfbi_opt_clks),
-	.flags		=3D HWMOD_NO_IDLEST,
-};
-
-static struct omap_hwmod omap2420_dss_venc_hwmod =3D {
-	.name		=3D "dss_venc",
-	.class		=3D &omap2_venc_hwmod_class,
-	.main_clk	=3D "dss_54m_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_DSS1_SHIFT,
-			.module_offs =3D CORE_MOD,
-		},
-	},
-	.flags		=3D HWMOD_NO_IDLEST,
-};
-
 /* I2C common */
 static struct omap_hwmod_class_sysconfig i2c_sysc =3D {
 	.rev_offs	=3D 0x00,
@@ -517,88 +112,6 @@ static struct omap_hwmod omap2420_i2c2_hwmod =3D {
 	.flags		=3D HWMOD_16BIT_REG,
 };
=20
-/* gpio dev_attr */
-static struct omap_gpio_dev_attr gpio_dev_attr =3D {
-	.bank_width =3D 32,
-	.dbck_flag =3D false,
-};
-
-/* gpio1 */
-static struct omap_hwmod omap2420_gpio1_hwmod =3D {
-	.name		=3D "gpio1",
-	.flags		=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	=3D omap2_gpio1_irqs,
-	.main_clk	=3D "gpios_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPIOS_SHIFT,
-			.module_offs =3D WKUP_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPIOS_SHIFT,
-		},
-	},
-	.class		=3D &omap2xxx_gpio_hwmod_class,
-	.dev_attr	=3D &gpio_dev_attr,
-};
-
-/* gpio2 */
-static struct omap_hwmod omap2420_gpio2_hwmod =3D {
-	.name		=3D "gpio2",
-	.flags		=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	=3D omap2_gpio2_irqs,
-	.main_clk	=3D "gpios_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPIOS_SHIFT,
-			.module_offs =3D WKUP_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPIOS_SHIFT,
-		},
-	},
-	.class		=3D &omap2xxx_gpio_hwmod_class,
-	.dev_attr	=3D &gpio_dev_attr,
-};
-
-/* gpio3 */
-static struct omap_hwmod omap2420_gpio3_hwmod =3D {
-	.name		=3D "gpio3",
-	.flags		=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	=3D omap2_gpio3_irqs,
-	.main_clk	=3D "gpios_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPIOS_SHIFT,
-			.module_offs =3D WKUP_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPIOS_SHIFT,
-		},
-	},
-	.class		=3D &omap2xxx_gpio_hwmod_class,
-	.dev_attr	=3D &gpio_dev_attr,
-};
-
-/* gpio4 */
-static struct omap_hwmod omap2420_gpio4_hwmod =3D {
-	.name		=3D "gpio4",
-	.flags		=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	=3D omap2_gpio4_irqs,
-	.main_clk	=3D "gpios_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPIOS_SHIFT,
-			.module_offs =3D WKUP_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPIOS_SHIFT,
-		},
-	},
-	.class		=3D &omap2xxx_gpio_hwmod_class,
-	.dev_attr	=3D &gpio_dev_attr,
-};
-
 /* dma attributes */
 static struct omap_dma_dev_attr dma_dev_attr =3D {
 	.dev_caps  =3D RESERVE_CHANNEL | DMA_LINKED_LCH | GLOBAL_PRIORITY |
@@ -638,52 +151,6 @@ static struct omap_hwmod omap2420_mailbox_hwmod =3D=
 {
 	},
 };
=20
-/* mcspi1 */
-static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr =3D {
-	.num_chipselect =3D 4,
-};
-
-static struct omap_hwmod omap2420_mcspi1_hwmod =3D {
-	.name		=3D "mcspi1",
-	.mpu_irqs	=3D omap2_mcspi1_mpu_irqs,
-	.sdma_reqs	=3D omap2_mcspi1_sdma_reqs,
-	.main_clk	=3D "mcspi1_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.module_offs =3D CORE_MOD,
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_MCSPI1_SHIFT,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_MCSPI1_SHIFT,
-		},
-	},
-	.class		=3D &omap2xxx_mcspi_class,
-	.dev_attr	=3D &omap_mcspi1_dev_attr,
-};
-
-/* mcspi2 */
-static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr =3D {
-	.num_chipselect =3D 2,
-};
-
-static struct omap_hwmod omap2420_mcspi2_hwmod =3D {
-	.name		=3D "mcspi2",
-	.mpu_irqs	=3D omap2_mcspi2_mpu_irqs,
-	.sdma_reqs	=3D omap2_mcspi2_sdma_reqs,
-	.main_clk	=3D "mcspi2_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.module_offs =3D CORE_MOD,
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_MCSPI2_SHIFT,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_MCSPI2_SHIFT,
-		},
-	},
-	.class		=3D &omap2xxx_mcspi_class,
-	.dev_attr	=3D &omap_mcspi2_dev_attr,
-};
-
 /*
  * 'mcbsp' class
  * multi channel buffered serial port controller
@@ -747,22 +214,22 @@ static struct omap_hwmod omap2420_mcbsp2_hwmod =3D=
 {
=20
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap2420_l3_main__l4_core =3D {
-	.master	=3D &omap2420_l3_main_hwmod,
-	.slave	=3D &omap2420_l4_core_hwmod,
+	.master	=3D &omap2xxx_l3_main_hwmod,
+	.slave	=3D &omap2xxx_l4_core_hwmod,
 	.user	=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
 /* MPU -> L3 interface */
 static struct omap_hwmod_ocp_if omap2420_mpu__l3_main =3D {
-	.master =3D &omap2420_mpu_hwmod,
-	.slave	=3D &omap2420_l3_main_hwmod,
+	.master =3D &omap2xxx_mpu_hwmod,
+	.slave	=3D &omap2xxx_l3_main_hwmod,
 	.user	=3D OCP_USER_MPU,
 };
=20
 /* DSS -> l3 */
 static struct omap_hwmod_ocp_if omap2420_dss__l3 =3D {
-	.master		=3D &omap2420_dss_core_hwmod,
-	.slave		=3D &omap2420_l3_main_hwmod,
+	.master		=3D &omap2xxx_dss_core_hwmod,
+	.slave		=3D &omap2xxx_l3_main_hwmod,
 	.fw =3D {
 		.omap2 =3D {
 			.l3_perm_bit  =3D OMAP2_L3_CORE_FW_CONNID_DSS,
@@ -774,8 +241,8 @@ static struct omap_hwmod_ocp_if omap2420_dss__l3 =3D=
 {
=20
 /* l4 core -> mcspi1 interface */
 static struct omap_hwmod_ocp_if omap2420_l4_core__mcspi1 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_mcspi1_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_mcspi1_hwmod,
 	.clk		=3D "mcspi1_ick",
 	.addr		=3D omap2_mcspi1_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -783,8 +250,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__m=
cspi1 =3D {
=20
 /* l4 core -> mcspi2 interface */
 static struct omap_hwmod_ocp_if omap2420_l4_core__mcspi2 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_mcspi2_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_mcspi2_hwmod,
 	.clk		=3D "mcspi2_ick",
 	.addr		=3D omap2_mcspi2_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -792,15 +259,15 @@ static struct omap_hwmod_ocp_if omap2420_l4_core_=
_mcspi2 =3D {
=20
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2420_l4_core__l4_wkup =3D {
-	.master	=3D &omap2420_l4_core_hwmod,
-	.slave	=3D &omap2420_l4_wkup_hwmod,
+	.master	=3D &omap2xxx_l4_core_hwmod,
+	.slave	=3D &omap2xxx_l4_wkup_hwmod,
 	.user	=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
 /* L4 CORE -> UART1 interface */
 static struct omap_hwmod_ocp_if omap2_l4_core__uart1 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_uart1_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_uart1_hwmod,
 	.clk		=3D "uart1_ick",
 	.addr		=3D omap2xxx_uart1_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -808,8 +275,8 @@ static struct omap_hwmod_ocp_if omap2_l4_core__uart=
1 =3D {
=20
 /* L4 CORE -> UART2 interface */
 static struct omap_hwmod_ocp_if omap2_l4_core__uart2 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_uart2_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_uart2_hwmod,
 	.clk		=3D "uart2_ick",
 	.addr		=3D omap2xxx_uart2_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -817,8 +284,8 @@ static struct omap_hwmod_ocp_if omap2_l4_core__uart=
2 =3D {
=20
 /* L4 PER -> UART3 interface */
 static struct omap_hwmod_ocp_if omap2_l4_core__uart3 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_uart3_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_uart3_hwmod,
 	.clk		=3D "uart3_ick",
 	.addr		=3D omap2xxx_uart3_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -826,7 +293,7 @@ static struct omap_hwmod_ocp_if omap2_l4_core__uart=
3 =3D {
=20
 /* L4 CORE -> I2C1 interface */
 static struct omap_hwmod_ocp_if omap2420_l4_core__i2c1 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2420_i2c1_hwmod,
 	.clk		=3D "i2c1_ick",
 	.addr		=3D omap2_i2c1_addr_space,
@@ -835,7 +302,7 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__i=
2c1 =3D {
=20
 /* L4 CORE -> I2C2 interface */
 static struct omap_hwmod_ocp_if omap2420_l4_core__i2c2 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2420_i2c2_hwmod,
 	.clk		=3D "i2c2_ick",
 	.addr		=3D omap2_i2c2_addr_space,
@@ -844,7 +311,7 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__i=
2c2 =3D {
=20
 /* IVA <- L3 interface */
 static struct omap_hwmod_ocp_if omap2420_l3__iva =3D {
-	.master		=3D &omap2420_l3_main_hwmod,
+	.master		=3D &omap2xxx_l3_main_hwmod,
 	.slave		=3D &omap2420_iva_hwmod,
 	.clk		=3D "iva1_ifck",
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -861,8 +328,8 @@ static struct omap_hwmod_addr_space omap2420_timer1=
_addrs[] =3D {
=20
 /* l4_wkup -> timer1 */
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__timer1 =3D {
-	.master		=3D &omap2420_l4_wkup_hwmod,
-	.slave		=3D &omap2420_timer1_hwmod,
+	.master		=3D &omap2xxx_l4_wkup_hwmod,
+	.slave		=3D &omap2xxx_timer1_hwmod,
 	.clk		=3D "gpt1_ick",
 	.addr		=3D omap2420_timer1_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -870,8 +337,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_wkup__t=
imer1 =3D {
=20
 /* l4_core -> timer2 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer2 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_timer2_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer2_hwmod,
 	.clk		=3D "gpt2_ick",
 	.addr		=3D omap2xxx_timer2_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -879,8 +346,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__t=
imer2 =3D {
=20
 /* l4_core -> timer3 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer3 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_timer3_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer3_hwmod,
 	.clk		=3D "gpt3_ick",
 	.addr		=3D omap2xxx_timer3_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -888,8 +355,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__t=
imer3 =3D {
=20
 /* l4_core -> timer4 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer4 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_timer4_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer4_hwmod,
 	.clk		=3D "gpt4_ick",
 	.addr		=3D omap2xxx_timer4_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -897,8 +364,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__t=
imer4 =3D {
=20
 /* l4_core -> timer5 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer5 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_timer5_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer5_hwmod,
 	.clk		=3D "gpt5_ick",
 	.addr		=3D omap2xxx_timer5_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -906,8 +373,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__t=
imer5 =3D {
=20
 /* l4_core -> timer6 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer6 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_timer6_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer6_hwmod,
 	.clk		=3D "gpt6_ick",
 	.addr		=3D omap2xxx_timer6_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -915,8 +382,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__t=
imer6 =3D {
=20
 /* l4_core -> timer7 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer7 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_timer7_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer7_hwmod,
 	.clk		=3D "gpt7_ick",
 	.addr		=3D omap2xxx_timer7_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -924,8 +391,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__t=
imer7 =3D {
=20
 /* l4_core -> timer8 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer8 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_timer8_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer8_hwmod,
 	.clk		=3D "gpt8_ick",
 	.addr		=3D omap2xxx_timer8_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -933,8 +400,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__t=
imer8 =3D {
=20
 /* l4_core -> timer9 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer9 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_timer9_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer9_hwmod,
 	.clk		=3D "gpt9_ick",
 	.addr		=3D omap2xxx_timer9_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -942,8 +409,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__t=
imer9 =3D {
=20
 /* l4_core -> timer10 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer10 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_timer10_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer10_hwmod,
 	.clk		=3D "gpt10_ick",
 	.addr		=3D omap2_timer10_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -951,8 +418,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__t=
imer10 =3D {
=20
 /* l4_core -> timer11 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer11 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_timer11_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer11_hwmod,
 	.clk		=3D "gpt11_ick",
 	.addr		=3D omap2_timer11_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -960,8 +427,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__t=
imer11 =3D {
=20
 /* l4_core -> timer12 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer12 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_timer12_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer12_hwmod,
 	.clk		=3D "gpt12_ick",
 	.addr		=3D omap2xxx_timer12_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -978,8 +445,8 @@ static struct omap_hwmod_addr_space omap2420_wd_tim=
er2_addrs[] =3D {
 };
=20
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__wd_timer2 =3D {
-	.master		=3D &omap2420_l4_wkup_hwmod,
-	.slave		=3D &omap2420_wd_timer2_hwmod,
+	.master		=3D &omap2xxx_l4_wkup_hwmod,
+	.slave		=3D &omap2xxx_wd_timer2_hwmod,
 	.clk		=3D "mpu_wdt_ick",
 	.addr		=3D omap2420_wd_timer2_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -987,8 +454,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_wkup__w=
d_timer2 =3D {
=20
 /* l4_core -> dss */
 static struct omap_hwmod_ocp_if omap2420_l4_core__dss =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_dss_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_dss_core_hwmod,
 	.clk		=3D "dss_ick",
 	.addr		=3D omap2_dss_addrs,
 	.fw =3D {
@@ -1002,8 +469,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__=
dss =3D {
=20
 /* l4_core -> dss_dispc */
 static struct omap_hwmod_ocp_if omap2420_l4_core__dss_dispc =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_dss_dispc_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_dss_dispc_hwmod,
 	.clk		=3D "dss_ick",
 	.addr		=3D omap2_dss_dispc_addrs,
 	.fw =3D {
@@ -1017,8 +484,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__=
dss_dispc =3D {
=20
 /* l4_core -> dss_rfbi */
 static struct omap_hwmod_ocp_if omap2420_l4_core__dss_rfbi =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_dss_rfbi_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_dss_rfbi_hwmod,
 	.clk		=3D "dss_ick",
 	.addr		=3D omap2_dss_rfbi_addrs,
 	.fw =3D {
@@ -1032,8 +499,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__=
dss_rfbi =3D {
=20
 /* l4_core -> dss_venc */
 static struct omap_hwmod_ocp_if omap2420_l4_core__dss_venc =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
-	.slave		=3D &omap2420_dss_venc_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_dss_venc_hwmod,
 	.clk		=3D "dss_ick",
 	.addr		=3D omap2_dss_venc_addrs,
 	.fw =3D {
@@ -1057,8 +524,8 @@ static struct omap_hwmod_addr_space omap2420_gpio1=
_addr_space[] =3D {
 };
=20
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio1 =3D {
-	.master		=3D &omap2420_l4_wkup_hwmod,
-	.slave		=3D &omap2420_gpio1_hwmod,
+	.master		=3D &omap2xxx_l4_wkup_hwmod,
+	.slave		=3D &omap2xxx_gpio1_hwmod,
 	.clk		=3D "gpios_ick",
 	.addr		=3D omap2420_gpio1_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1075,8 +542,8 @@ static struct omap_hwmod_addr_space omap2420_gpio2=
_addr_space[] =3D {
 };
=20
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio2 =3D {
-	.master		=3D &omap2420_l4_wkup_hwmod,
-	.slave		=3D &omap2420_gpio2_hwmod,
+	.master		=3D &omap2xxx_l4_wkup_hwmod,
+	.slave		=3D &omap2xxx_gpio2_hwmod,
 	.clk		=3D "gpios_ick",
 	.addr		=3D omap2420_gpio2_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1093,8 +560,8 @@ static struct omap_hwmod_addr_space omap2420_gpio3=
_addr_space[] =3D {
 };
=20
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio3 =3D {
-	.master		=3D &omap2420_l4_wkup_hwmod,
-	.slave		=3D &omap2420_gpio3_hwmod,
+	.master		=3D &omap2xxx_l4_wkup_hwmod,
+	.slave		=3D &omap2xxx_gpio3_hwmod,
 	.clk		=3D "gpios_ick",
 	.addr		=3D omap2420_gpio3_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1111,8 +578,8 @@ static struct omap_hwmod_addr_space omap2420_gpio4=
_addr_space[] =3D {
 };
=20
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio4 =3D {
-	.master		=3D &omap2420_l4_wkup_hwmod,
-	.slave		=3D &omap2420_gpio4_hwmod,
+	.master		=3D &omap2xxx_l4_wkup_hwmod,
+	.slave		=3D &omap2xxx_gpio4_hwmod,
 	.clk		=3D "gpios_ick",
 	.addr		=3D omap2420_gpio4_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1121,14 +588,14 @@ static struct omap_hwmod_ocp_if omap2420_l4_wkup=
__gpio4 =3D {
 /* dma_system -> L3 */
 static struct omap_hwmod_ocp_if omap2420_dma_system__l3 =3D {
 	.master		=3D &omap2420_dma_system_hwmod,
-	.slave		=3D &omap2420_l3_main_hwmod,
+	.slave		=3D &omap2xxx_l3_main_hwmod,
 	.clk		=3D "core_l3_ck",
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
 /* l4_core -> dma_system */
 static struct omap_hwmod_ocp_if omap2420_l4_core__dma_system =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2420_dma_system_hwmod,
 	.clk		=3D "sdma_ick",
 	.addr		=3D omap2_dma_system_addrs,
@@ -1137,7 +604,7 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__=
dma_system =3D {
=20
 /* l4_core -> mailbox */
 static struct omap_hwmod_ocp_if omap2420_l4_core__mailbox =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2420_mailbox_hwmod,
 	.addr		=3D omap2_mailbox_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1145,7 +612,7 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__=
mailbox =3D {
=20
 /* l4_core -> mcbsp1 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp1 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2420_mcbsp1_hwmod,
 	.clk		=3D "mcbsp1_ick",
 	.addr		=3D omap2_mcbsp1_addrs,
@@ -1154,7 +621,7 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__=
mcbsp1 =3D {
=20
 /* l4_core -> mcbsp2 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp2 =3D {
-	.master		=3D &omap2420_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2420_mcbsp2_hwmod,
 	.clk		=3D "mcbsp2_ick",
 	.addr		=3D omap2xxx_mcbsp2_addrs,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2430_data.c
index da8fef0..8b04938 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -44,416 +44,12 @@
  * IP blocks
  */
=20
-/* L3 */
-static struct omap_hwmod omap2430_l3_main_hwmod =3D {
-	.name		=3D "l3_main",
-	.class		=3D &l3_hwmod_class,
-	.flags		=3D HWMOD_NO_IDLEST,
-};
-
-/* L4 CORE */
-static struct omap_hwmod omap2430_l4_core_hwmod =3D {
-	.name		=3D "l4_core",
-	.class		=3D &l4_hwmod_class,
-	.flags		=3D HWMOD_NO_IDLEST,
-};
-
-/* L4 WKUP */
-static struct omap_hwmod omap2430_l4_wkup_hwmod =3D {
-	.name		=3D "l4_wkup",
-	.class		=3D &l4_hwmod_class,
-	.flags		=3D HWMOD_NO_IDLEST,
-};
-
-/* MPU */
-static struct omap_hwmod omap2430_mpu_hwmod =3D {
-	.name		=3D "mpu",
-	.class		=3D &mpu_hwmod_class,
-	.main_clk	=3D "mpu_ck",
-};
-
 /* IVA2 (IVA2) */
 static struct omap_hwmod omap2430_iva_hwmod =3D {
 	.name		=3D "iva",
 	.class		=3D &iva_hwmod_class,
 };
=20
-/* always-on timers dev attribute */
-static struct omap_timer_capability_dev_attr capability_alwon_dev_attr=
 =3D {
-	.timer_capability	=3D OMAP_TIMER_ALWON,
-};
-
-/* pwm timers dev attribute */
-static struct omap_timer_capability_dev_attr capability_pwm_dev_attr =3D=
 {
-	.timer_capability	=3D OMAP_TIMER_HAS_PWM,
-};
-
-/* timer1 */
-static struct omap_hwmod omap2430_timer1_hwmod =3D {
-	.name		=3D "timer1",
-	.mpu_irqs	=3D omap2_timer1_mpu_irqs,
-	.main_clk	=3D "gpt1_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT1_SHIFT,
-			.module_offs =3D WKUP_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT1_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_alwon_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer2 */
-static struct omap_hwmod omap2430_timer2_hwmod =3D {
-	.name		=3D "timer2",
-	.mpu_irqs	=3D omap2_timer2_mpu_irqs,
-	.main_clk	=3D "gpt2_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT2_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT2_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_alwon_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer3 */
-static struct omap_hwmod omap2430_timer3_hwmod =3D {
-	.name		=3D "timer3",
-	.mpu_irqs	=3D omap2_timer3_mpu_irqs,
-	.main_clk	=3D "gpt3_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT3_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT3_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_alwon_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer4 */
-static struct omap_hwmod omap2430_timer4_hwmod =3D {
-	.name		=3D "timer4",
-	.mpu_irqs	=3D omap2_timer4_mpu_irqs,
-	.main_clk	=3D "gpt4_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT4_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT4_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_alwon_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer5 */
-static struct omap_hwmod omap2430_timer5_hwmod =3D {
-	.name		=3D "timer5",
-	.mpu_irqs	=3D omap2_timer5_mpu_irqs,
-	.main_clk	=3D "gpt5_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT5_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT5_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_alwon_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer6 */
-static struct omap_hwmod omap2430_timer6_hwmod =3D {
-	.name		=3D "timer6",
-	.mpu_irqs	=3D omap2_timer6_mpu_irqs,
-	.main_clk	=3D "gpt6_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT6_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT6_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_alwon_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer7 */
-static struct omap_hwmod omap2430_timer7_hwmod =3D {
-	.name		=3D "timer7",
-	.mpu_irqs	=3D omap2_timer7_mpu_irqs,
-	.main_clk	=3D "gpt7_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT7_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT7_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_alwon_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer8 */
-static struct omap_hwmod omap2430_timer8_hwmod =3D {
-	.name		=3D "timer8",
-	.mpu_irqs	=3D omap2_timer8_mpu_irqs,
-	.main_clk	=3D "gpt8_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT8_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT8_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_alwon_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer9 */
-static struct omap_hwmod omap2430_timer9_hwmod =3D {
-	.name		=3D "timer9",
-	.mpu_irqs	=3D omap2_timer9_mpu_irqs,
-	.main_clk	=3D "gpt9_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT9_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT9_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_pwm_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer10 */
-static struct omap_hwmod omap2430_timer10_hwmod =3D {
-	.name		=3D "timer10",
-	.mpu_irqs	=3D omap2_timer10_mpu_irqs,
-	.main_clk	=3D "gpt10_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT10_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT10_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_pwm_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer11 */
-static struct omap_hwmod omap2430_timer11_hwmod =3D {
-	.name		=3D "timer11",
-	.mpu_irqs	=3D omap2_timer11_mpu_irqs,
-	.main_clk	=3D "gpt11_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT11_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT11_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_pwm_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-/* timer12 */
-static struct omap_hwmod omap2430_timer12_hwmod =3D {
-	.name		=3D "timer12",
-	.mpu_irqs	=3D omap2xxx_timer12_mpu_irqs,
-	.main_clk	=3D "gpt12_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPT12_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPT12_SHIFT,
-		},
-	},
-	.dev_attr	=3D &capability_pwm_dev_attr,
-	.class		=3D &omap2xxx_timer_hwmod_class,
-};
-
-static struct omap_hwmod omap2430_wd_timer2_hwmod =3D {
-	.name		=3D "wd_timer2",
-	.class		=3D &omap2xxx_wd_timer_hwmod_class,
-	.main_clk	=3D "mpu_wdt_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_MPU_WDT_SHIFT,
-			.module_offs =3D WKUP_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_MPU_WDT_SHIFT,
-		},
-	},
-};
-
-/* UART1 */
-static struct omap_hwmod omap2430_uart1_hwmod =3D {
-	.name		=3D "uart1",
-	.mpu_irqs	=3D omap2_uart1_mpu_irqs,
-	.sdma_reqs	=3D omap2_uart1_sdma_reqs,
-	.main_clk	=3D "uart1_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.module_offs =3D CORE_MOD,
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_UART1_SHIFT,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_EN_UART1_SHIFT,
-		},
-	},
-	.class		=3D &omap2_uart_class,
-};
-
-/* UART2 */
-static struct omap_hwmod omap2430_uart2_hwmod =3D {
-	.name		=3D "uart2",
-	.mpu_irqs	=3D omap2_uart2_mpu_irqs,
-	.sdma_reqs	=3D omap2_uart2_sdma_reqs,
-	.main_clk	=3D "uart2_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.module_offs =3D CORE_MOD,
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_UART2_SHIFT,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_EN_UART2_SHIFT,
-		},
-	},
-	.class		=3D &omap2_uart_class,
-};
-
-/* UART3 */
-static struct omap_hwmod omap2430_uart3_hwmod =3D {
-	.name		=3D "uart3",
-	.mpu_irqs	=3D omap2_uart3_mpu_irqs,
-	.sdma_reqs	=3D omap2_uart3_sdma_reqs,
-	.main_clk	=3D "uart3_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.module_offs =3D CORE_MOD,
-			.prcm_reg_id =3D 2,
-			.module_bit =3D OMAP24XX_EN_UART3_SHIFT,
-			.idlest_reg_id =3D 2,
-			.idlest_idle_bit =3D OMAP24XX_EN_UART3_SHIFT,
-		},
-	},
-	.class		=3D &omap2_uart_class,
-};
-
-/* dss */
-static struct omap_hwmod_opt_clk dss_opt_clks[] =3D {
-	/*
-	 * The DSS HW needs all DSS clocks enabled during reset. The dss_core
-	 * driver does not use these clocks.
-	 */
-	{ .role =3D "tv_clk", .clk =3D "dss_54m_fck" },
-	{ .role =3D "sys_clk", .clk =3D "dss2_fck" },
-};
-
-static struct omap_hwmod omap2430_dss_core_hwmod =3D {
-	.name		=3D "dss_core",
-	.class		=3D &omap2_dss_hwmod_class,
-	.main_clk	=3D "dss1_fck", /* instead of dss_fck */
-	.sdma_reqs	=3D omap2xxx_dss_sdma_chs,
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_DSS1_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_stdby_bit =3D OMAP24XX_ST_DSS_SHIFT,
-		},
-	},
-	.opt_clks	=3D dss_opt_clks,
-	.opt_clks_cnt =3D ARRAY_SIZE(dss_opt_clks),
-	.flags		=3D HWMOD_NO_IDLEST | HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-};
-
-static struct omap_hwmod omap2430_dss_dispc_hwmod =3D {
-	.name		=3D "dss_dispc",
-	.class		=3D &omap2_dispc_hwmod_class,
-	.mpu_irqs	=3D omap2_dispc_irqs,
-	.main_clk	=3D "dss1_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_DSS1_SHIFT,
-			.module_offs =3D CORE_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_stdby_bit =3D OMAP24XX_ST_DSS_SHIFT,
-		},
-	},
-	.flags		=3D HWMOD_NO_IDLEST,
-	.dev_attr	=3D &omap2_3_dss_dispc_dev_attr
-};
-
-static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] =3D {
-	{ .role =3D "ick", .clk =3D "dss_ick" },
-};
-
-static struct omap_hwmod omap2430_dss_rfbi_hwmod =3D {
-	.name		=3D "dss_rfbi",
-	.class		=3D &omap2_rfbi_hwmod_class,
-	.main_clk	=3D "dss1_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_DSS1_SHIFT,
-			.module_offs =3D CORE_MOD,
-		},
-	},
-	.opt_clks	=3D dss_rfbi_opt_clks,
-	.opt_clks_cnt	=3D ARRAY_SIZE(dss_rfbi_opt_clks),
-	.flags		=3D HWMOD_NO_IDLEST,
-};
-
-static struct omap_hwmod omap2430_dss_venc_hwmod =3D {
-	.name		=3D "dss_venc",
-	.class		=3D &omap2_venc_hwmod_class,
-	.main_clk	=3D "dss_54m_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_DSS1_SHIFT,
-			.module_offs =3D CORE_MOD,
-		},
-	},
-	.flags		=3D HWMOD_NO_IDLEST,
-};
-
 /* I2C common */
 static struct omap_hwmod_class_sysconfig i2c_sysc =3D {
 	.rev_offs	=3D 0x00,
@@ -526,88 +122,6 @@ static struct omap_hwmod omap2430_i2c2_hwmod =3D {
 	.dev_attr	=3D &i2c_dev_attr,
 };
=20
-/* gpio dev_attr */
-static struct omap_gpio_dev_attr gpio_dev_attr =3D {
-	.bank_width =3D 32,
-	.dbck_flag =3D false,
-};
-
-/* gpio1 */
-static struct omap_hwmod omap2430_gpio1_hwmod =3D {
-	.name		=3D "gpio1",
-	.flags		=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	=3D omap2_gpio1_irqs,
-	.main_clk	=3D "gpios_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPIOS_SHIFT,
-			.module_offs =3D WKUP_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_EN_GPIOS_SHIFT,
-		},
-	},
-	.class		=3D &omap2xxx_gpio_hwmod_class,
-	.dev_attr	=3D &gpio_dev_attr,
-};
-
-/* gpio2 */
-static struct omap_hwmod omap2430_gpio2_hwmod =3D {
-	.name		=3D "gpio2",
-	.flags		=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	=3D omap2_gpio2_irqs,
-	.main_clk	=3D "gpios_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPIOS_SHIFT,
-			.module_offs =3D WKUP_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPIOS_SHIFT,
-		},
-	},
-	.class		=3D &omap2xxx_gpio_hwmod_class,
-	.dev_attr	=3D &gpio_dev_attr,
-};
-
-/* gpio3 */
-static struct omap_hwmod omap2430_gpio3_hwmod =3D {
-	.name		=3D "gpio3",
-	.flags		=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	=3D omap2_gpio3_irqs,
-	.main_clk	=3D "gpios_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPIOS_SHIFT,
-			.module_offs =3D WKUP_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPIOS_SHIFT,
-		},
-	},
-	.class		=3D &omap2xxx_gpio_hwmod_class,
-	.dev_attr	=3D &gpio_dev_attr,
-};
-
-/* gpio4 */
-static struct omap_hwmod omap2430_gpio4_hwmod =3D {
-	.name		=3D "gpio4",
-	.flags		=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	=3D omap2_gpio4_irqs,
-	.main_clk	=3D "gpios_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_GPIOS_SHIFT,
-			.module_offs =3D WKUP_MOD,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_GPIOS_SHIFT,
-		},
-	},
-	.class		=3D &omap2xxx_gpio_hwmod_class,
-	.dev_attr	=3D &gpio_dev_attr,
-};
-
 /* gpio5 */
 static struct omap_hwmod_irq_info omap243x_gpio5_irqs[] =3D {
 	{ .irq =3D 33 }, /* INT_24XX_GPIO_BANK5 */
@@ -629,7 +143,7 @@ static struct omap_hwmod omap2430_gpio5_hwmod =3D {
 		},
 	},
 	.class		=3D &omap2xxx_gpio_hwmod_class,
-	.dev_attr	=3D &gpio_dev_attr,
+	.dev_attr	=3D &omap2xxx_gpio_dev_attr,
 };
=20
 /* dma attributes */
@@ -670,52 +184,6 @@ static struct omap_hwmod omap2430_mailbox_hwmod =3D=
 {
 	},
 };
=20
-/* mcspi1 */
-static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr =3D {
-	.num_chipselect =3D 4,
-};
-
-static struct omap_hwmod omap2430_mcspi1_hwmod =3D {
-	.name		=3D "mcspi1",
-	.mpu_irqs	=3D omap2_mcspi1_mpu_irqs,
-	.sdma_reqs	=3D omap2_mcspi1_sdma_reqs,
-	.main_clk	=3D "mcspi1_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.module_offs =3D CORE_MOD,
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_MCSPI1_SHIFT,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_MCSPI1_SHIFT,
-		},
-	},
-	.class		=3D &omap2xxx_mcspi_class,
-	.dev_attr	=3D &omap_mcspi1_dev_attr,
-};
-
-/* mcspi2 */
-static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr =3D {
-	.num_chipselect =3D 2,
-};
-
-static struct omap_hwmod omap2430_mcspi2_hwmod =3D {
-	.name		=3D "mcspi2",
-	.mpu_irqs	=3D omap2_mcspi2_mpu_irqs,
-	.sdma_reqs	=3D omap2_mcspi2_sdma_reqs,
-	.main_clk	=3D "mcspi2_fck",
-	.prcm		=3D {
-		.omap2 =3D {
-			.module_offs =3D CORE_MOD,
-			.prcm_reg_id =3D 1,
-			.module_bit =3D OMAP24XX_EN_MCSPI2_SHIFT,
-			.idlest_reg_id =3D 1,
-			.idlest_idle_bit =3D OMAP24XX_ST_MCSPI2_SHIFT,
-		},
-	},
-	.class		=3D &omap2xxx_mcspi_class,
-	.dev_attr	=3D &omap_mcspi2_dev_attr,
-};
-
 /* mcspi3 */
 static struct omap_hwmod_irq_info omap2430_mcspi3_mpu_irqs[] =3D {
 	{ .irq =3D 91 },
@@ -1057,22 +525,22 @@ static struct omap_hwmod omap2430_mmc2_hwmod =3D=
 {
=20
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap2430_l3_main__l4_core =3D {
-	.master	=3D &omap2430_l3_main_hwmod,
-	.slave	=3D &omap2430_l4_core_hwmod,
+	.master	=3D &omap2xxx_l3_main_hwmod,
+	.slave	=3D &omap2xxx_l4_core_hwmod,
 	.user	=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
 /* MPU -> L3 interface */
 static struct omap_hwmod_ocp_if omap2430_mpu__l3_main =3D {
-	.master =3D &omap2430_mpu_hwmod,
-	.slave	=3D &omap2430_l3_main_hwmod,
+	.master =3D &omap2xxx_mpu_hwmod,
+	.slave	=3D &omap2xxx_l3_main_hwmod,
 	.user	=3D OCP_USER_MPU,
 };
=20
 /* DSS -> l3 */
 static struct omap_hwmod_ocp_if omap2430_dss__l3 =3D {
-	.master		=3D &omap2430_dss_core_hwmod,
-	.slave		=3D &omap2430_l3_main_hwmod,
+	.master		=3D &omap2xxx_dss_core_hwmod,
+	.slave		=3D &omap2xxx_l3_main_hwmod,
 	.fw =3D {
 		.omap2 =3D {
 			.l3_perm_bit  =3D OMAP2_L3_CORE_FW_CONNID_DSS,
@@ -1085,14 +553,14 @@ static struct omap_hwmod_ocp_if omap2430_dss__l3=
 =3D {
 /* l3_core -> usbhsotg  interface */
 static struct omap_hwmod_ocp_if omap2430_usbhsotg__l3 =3D {
 	.master		=3D &omap2430_usbhsotg_hwmod,
-	.slave		=3D &omap2430_l3_main_hwmod,
+	.slave		=3D &omap2xxx_l3_main_hwmod,
 	.clk		=3D "core_l3_ck",
 	.user		=3D OCP_USER_MPU,
 };
=20
 /* L4 CORE -> I2C1 interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__i2c1 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2430_i2c1_hwmod,
 	.clk		=3D "i2c1_ick",
 	.addr		=3D omap2_i2c1_addr_space,
@@ -1101,7 +569,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
i2c1 =3D {
=20
 /* L4 CORE -> I2C2 interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__i2c2 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2430_i2c2_hwmod,
 	.clk		=3D "i2c2_ick",
 	.addr		=3D omap2_i2c2_addr_space,
@@ -1110,15 +578,15 @@ static struct omap_hwmod_ocp_if omap2430_l4_core=
__i2c2 =3D {
=20
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__l4_wkup =3D {
-	.master	=3D &omap2430_l4_core_hwmod,
-	.slave	=3D &omap2430_l4_wkup_hwmod,
+	.master	=3D &omap2xxx_l4_core_hwmod,
+	.slave	=3D &omap2xxx_l4_wkup_hwmod,
 	.user	=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
 /* L4 CORE -> UART1 interface */
 static struct omap_hwmod_ocp_if omap2_l4_core__uart1 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_uart1_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_uart1_hwmod,
 	.clk		=3D "uart1_ick",
 	.addr		=3D omap2xxx_uart1_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1126,8 +594,8 @@ static struct omap_hwmod_ocp_if omap2_l4_core__uar=
t1 =3D {
=20
 /* L4 CORE -> UART2 interface */
 static struct omap_hwmod_ocp_if omap2_l4_core__uart2 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_uart2_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_uart2_hwmod,
 	.clk		=3D "uart2_ick",
 	.addr		=3D omap2xxx_uart2_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1135,8 +603,8 @@ static struct omap_hwmod_ocp_if omap2_l4_core__uar=
t2 =3D {
=20
 /* L4 PER -> UART3 interface */
 static struct omap_hwmod_ocp_if omap2_l4_core__uart3 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_uart3_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_uart3_hwmod,
 	.clk		=3D "uart3_ick",
 	.addr		=3D omap2xxx_uart3_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1153,7 +621,7 @@ static struct omap_hwmod_addr_space omap2430_usbhs=
otg_addrs[] =3D {
=20
 /*  l4_core ->usbhsotg  interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__usbhsotg =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2430_usbhsotg_hwmod,
 	.clk		=3D "usb_l4_ick",
 	.addr		=3D omap2430_usbhsotg_addrs,
@@ -1162,7 +630,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
usbhsotg =3D {
=20
 /* L4 CORE -> MMC1 interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mmc1 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2430_mmc1_hwmod,
 	.clk		=3D "mmchs1_ick",
 	.addr		=3D omap2430_mmc1_addr_space,
@@ -1171,7 +639,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
mmc1 =3D {
=20
 /* L4 CORE -> MMC2 interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mmc2 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2430_mmc2_hwmod,
 	.clk		=3D "mmchs2_ick",
 	.addr		=3D omap2430_mmc2_addr_space,
@@ -1180,8 +648,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
mmc2 =3D {
=20
 /* l4 core -> mcspi1 interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi1 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_mcspi1_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_mcspi1_hwmod,
 	.clk		=3D "mcspi1_ick",
 	.addr		=3D omap2_mcspi1_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1189,8 +657,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
mcspi1 =3D {
=20
 /* l4 core -> mcspi2 interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi2 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_mcspi2_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_mcspi2_hwmod,
 	.clk		=3D "mcspi2_ick",
 	.addr		=3D omap2_mcspi2_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1198,7 +666,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
mcspi2 =3D {
=20
 /* l4 core -> mcspi3 interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi3 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2430_mcspi3_hwmod,
 	.clk		=3D "mcspi3_ick",
 	.addr		=3D omap2430_mcspi3_addr_space,
@@ -1207,7 +675,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
mcspi3 =3D {
=20
 /* IVA2 <- L3 interface */
 static struct omap_hwmod_ocp_if omap2430_l3__iva =3D {
-	.master		=3D &omap2430_l3_main_hwmod,
+	.master		=3D &omap2xxx_l3_main_hwmod,
 	.slave		=3D &omap2430_iva_hwmod,
 	.clk		=3D "dsp_fck",
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1224,8 +692,8 @@ static struct omap_hwmod_addr_space omap2430_timer=
1_addrs[] =3D {
=20
 /* l4_wkup -> timer1 */
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__timer1 =3D {
-	.master		=3D &omap2430_l4_wkup_hwmod,
-	.slave		=3D &omap2430_timer1_hwmod,
+	.master		=3D &omap2xxx_l4_wkup_hwmod,
+	.slave		=3D &omap2xxx_timer1_hwmod,
 	.clk		=3D "gpt1_ick",
 	.addr		=3D omap2430_timer1_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1233,8 +701,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_wkup__=
timer1 =3D {
=20
 /* l4_core -> timer2 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer2 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_timer2_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer2_hwmod,
 	.clk		=3D "gpt2_ick",
 	.addr		=3D omap2xxx_timer2_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1242,8 +710,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
timer2 =3D {
=20
 /* l4_core -> timer3 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer3 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_timer3_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer3_hwmod,
 	.clk		=3D "gpt3_ick",
 	.addr		=3D omap2xxx_timer3_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1251,8 +719,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
timer3 =3D {
=20
 /* l4_core -> timer4 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer4 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_timer4_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer4_hwmod,
 	.clk		=3D "gpt4_ick",
 	.addr		=3D omap2xxx_timer4_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1260,8 +728,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
timer4 =3D {
=20
 /* l4_core -> timer5 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer5 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_timer5_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer5_hwmod,
 	.clk		=3D "gpt5_ick",
 	.addr		=3D omap2xxx_timer5_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1269,8 +737,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
timer5 =3D {
=20
 /* l4_core -> timer6 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer6 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_timer6_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer6_hwmod,
 	.clk		=3D "gpt6_ick",
 	.addr		=3D omap2xxx_timer6_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1278,8 +746,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
timer6 =3D {
=20
 /* l4_core -> timer7 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer7 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_timer7_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer7_hwmod,
 	.clk		=3D "gpt7_ick",
 	.addr		=3D omap2xxx_timer7_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1287,8 +755,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
timer7 =3D {
=20
 /* l4_core -> timer8 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer8 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_timer8_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer8_hwmod,
 	.clk		=3D "gpt8_ick",
 	.addr		=3D omap2xxx_timer8_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1296,8 +764,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
timer8 =3D {
=20
 /* l4_core -> timer9 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer9 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_timer9_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer9_hwmod,
 	.clk		=3D "gpt9_ick",
 	.addr		=3D omap2xxx_timer9_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1305,8 +773,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
timer9 =3D {
=20
 /* l4_core -> timer10 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer10 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_timer10_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer10_hwmod,
 	.clk		=3D "gpt10_ick",
 	.addr		=3D omap2_timer10_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1314,8 +782,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
timer10 =3D {
=20
 /* l4_core -> timer11 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer11 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_timer11_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer11_hwmod,
 	.clk		=3D "gpt11_ick",
 	.addr		=3D omap2_timer11_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1323,8 +791,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
timer11 =3D {
=20
 /* l4_core -> timer12 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer12 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_timer12_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_timer12_hwmod,
 	.clk		=3D "gpt12_ick",
 	.addr		=3D omap2xxx_timer12_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1341,8 +809,8 @@ static struct omap_hwmod_addr_space omap2430_wd_ti=
mer2_addrs[] =3D {
 };
=20
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__wd_timer2 =3D {
-	.master		=3D &omap2430_l4_wkup_hwmod,
-	.slave		=3D &omap2430_wd_timer2_hwmod,
+	.master		=3D &omap2xxx_l4_wkup_hwmod,
+	.slave		=3D &omap2xxx_wd_timer2_hwmod,
 	.clk		=3D "mpu_wdt_ick",
 	.addr		=3D omap2430_wd_timer2_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1350,8 +818,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_wkup__=
wd_timer2 =3D {
=20
 /* l4_core -> dss */
 static struct omap_hwmod_ocp_if omap2430_l4_core__dss =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_dss_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_dss_core_hwmod,
 	.clk		=3D "dss_ick",
 	.addr		=3D omap2_dss_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1359,8 +827,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
dss =3D {
=20
 /* l4_core -> dss_dispc */
 static struct omap_hwmod_ocp_if omap2430_l4_core__dss_dispc =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_dss_dispc_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_dss_dispc_hwmod,
 	.clk		=3D "dss_ick",
 	.addr		=3D omap2_dss_dispc_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1368,8 +836,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
dss_dispc =3D {
=20
 /* l4_core -> dss_rfbi */
 static struct omap_hwmod_ocp_if omap2430_l4_core__dss_rfbi =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_dss_rfbi_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_dss_rfbi_hwmod,
 	.clk		=3D "dss_ick",
 	.addr		=3D omap2_dss_rfbi_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1377,8 +845,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
dss_rfbi =3D {
=20
 /* l4_core -> dss_venc */
 static struct omap_hwmod_ocp_if omap2430_l4_core__dss_venc =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
-	.slave		=3D &omap2430_dss_venc_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_dss_venc_hwmod,
 	.clk		=3D "dss_ick",
 	.addr		=3D omap2_dss_venc_addrs,
 	.flags		=3D OCPIF_SWSUP_IDLE,
@@ -1396,8 +864,8 @@ static struct omap_hwmod_addr_space omap2430_gpio1=
_addr_space[] =3D {
 };
=20
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio1 =3D {
-	.master		=3D &omap2430_l4_wkup_hwmod,
-	.slave		=3D &omap2430_gpio1_hwmod,
+	.master		=3D &omap2xxx_l4_wkup_hwmod,
+	.slave		=3D &omap2xxx_gpio1_hwmod,
 	.clk		=3D "gpios_ick",
 	.addr		=3D omap2430_gpio1_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1414,8 +882,8 @@ static struct omap_hwmod_addr_space omap2430_gpio2=
_addr_space[] =3D {
 };
=20
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio2 =3D {
-	.master		=3D &omap2430_l4_wkup_hwmod,
-	.slave		=3D &omap2430_gpio2_hwmod,
+	.master		=3D &omap2xxx_l4_wkup_hwmod,
+	.slave		=3D &omap2xxx_gpio2_hwmod,
 	.clk		=3D "gpios_ick",
 	.addr		=3D omap2430_gpio2_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1432,8 +900,8 @@ static struct omap_hwmod_addr_space omap2430_gpio3=
_addr_space[] =3D {
 };
=20
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio3 =3D {
-	.master		=3D &omap2430_l4_wkup_hwmod,
-	.slave		=3D &omap2430_gpio3_hwmod,
+	.master		=3D &omap2xxx_l4_wkup_hwmod,
+	.slave		=3D &omap2xxx_gpio3_hwmod,
 	.clk		=3D "gpios_ick",
 	.addr		=3D omap2430_gpio3_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1450,8 +918,8 @@ static struct omap_hwmod_addr_space omap2430_gpio4=
_addr_space[] =3D {
 };
=20
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio4 =3D {
-	.master		=3D &omap2430_l4_wkup_hwmod,
-	.slave		=3D &omap2430_gpio4_hwmod,
+	.master		=3D &omap2xxx_l4_wkup_hwmod,
+	.slave		=3D &omap2xxx_gpio4_hwmod,
 	.clk		=3D "gpios_ick",
 	.addr		=3D omap2430_gpio4_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1468,7 +936,7 @@ static struct omap_hwmod_addr_space omap2430_gpio5=
_addr_space[] =3D {
 };
=20
 static struct omap_hwmod_ocp_if omap2430_l4_core__gpio5 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2430_gpio5_hwmod,
 	.clk		=3D "gpio5_ick",
 	.addr		=3D omap2430_gpio5_addr_space,
@@ -1478,14 +946,14 @@ static struct omap_hwmod_ocp_if omap2430_l4_core=
__gpio5 =3D {
 /* dma_system -> L3 */
 static struct omap_hwmod_ocp_if omap2430_dma_system__l3 =3D {
 	.master		=3D &omap2430_dma_system_hwmod,
-	.slave		=3D &omap2430_l3_main_hwmod,
+	.slave		=3D &omap2xxx_l3_main_hwmod,
 	.clk		=3D "core_l3_ck",
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
 /* l4_core -> dma_system */
 static struct omap_hwmod_ocp_if omap2430_l4_core__dma_system =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2430_dma_system_hwmod,
 	.clk		=3D "sdma_ick",
 	.addr		=3D omap2_dma_system_addrs,
@@ -1494,7 +962,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
dma_system =3D {
=20
 /* l4_core -> mailbox */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mailbox =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2430_mailbox_hwmod,
 	.addr		=3D omap2_mailbox_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
@@ -1502,7 +970,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
mailbox =3D {
=20
 /* l4_core -> mcbsp1 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp1 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2430_mcbsp1_hwmod,
 	.clk		=3D "mcbsp1_ick",
 	.addr		=3D omap2_mcbsp1_addrs,
@@ -1511,7 +979,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
mcbsp1 =3D {
=20
 /* l4_core -> mcbsp2 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp2 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2430_mcbsp2_hwmod,
 	.clk		=3D "mcbsp2_ick",
 	.addr		=3D omap2xxx_mcbsp2_addrs,
@@ -1530,7 +998,7 @@ static struct omap_hwmod_addr_space omap2430_mcbsp=
3_addrs[] =3D {
=20
 /* l4_core -> mcbsp3 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp3 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2430_mcbsp3_hwmod,
 	.clk		=3D "mcbsp3_ick",
 	.addr		=3D omap2430_mcbsp3_addrs,
@@ -1549,7 +1017,7 @@ static struct omap_hwmod_addr_space omap2430_mcbs=
p4_addrs[] =3D {
=20
 /* l4_core -> mcbsp4 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp4 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2430_mcbsp4_hwmod,
 	.clk		=3D "mcbsp4_ick",
 	.addr		=3D omap2430_mcbsp4_addrs,
@@ -1568,7 +1036,7 @@ static struct omap_hwmod_addr_space omap2430_mcbs=
p5_addrs[] =3D {
=20
 /* l4_core -> mcbsp5 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp5 =3D {
-	.master		=3D &omap2430_l4_core_hwmod,
+	.master		=3D &omap2xxx_l4_core_hwmod,
 	.slave		=3D &omap2430_mcbsp5_hwmod,
 	.clk		=3D "mcbsp5_ick",
 	.addr		=3D omap2430_mcbsp5_addrs,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/=
arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 2a67297..45aaa07 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -10,6 +10,7 @@
  */
 #include <plat/omap_hwmod.h>
 #include <plat/serial.h>
+#include <plat/gpio.h>
 #include <plat/dma.h>
 #include <plat/dmtimer.h>
 #include <plat/mcspi.h>
@@ -17,6 +18,8 @@
 #include <mach/irqs.h>
=20
 #include "omap_hwmod_common_data.h"
+#include "cm-regbits-24xx.h"
+#include "prm-regbits-24xx.h"
 #include "wd_timer.h"
=20
 struct omap_hwmod_irq_info omap2xxx_timer12_mpu_irqs[] =3D {
@@ -170,3 +173,562 @@ struct omap_hwmod_class omap2xxx_mcspi_class =3D =
{
 	.sysc	=3D &omap2xxx_mcspi_sysc,
 	.rev	=3D OMAP2_MCSPI_REV,
 };
+
+/*
+ * IP blocks
+ */
+
+/* L3 */
+struct omap_hwmod omap2xxx_l3_main_hwmod =3D {
+	.name		=3D "l3_main",
+	.class		=3D &l3_hwmod_class,
+	.flags		=3D HWMOD_NO_IDLEST,
+};
+
+/* L4 CORE */
+struct omap_hwmod omap2xxx_l4_core_hwmod =3D {
+	.name		=3D "l4_core",
+	.class		=3D &l4_hwmod_class,
+	.flags		=3D HWMOD_NO_IDLEST,
+};
+
+/* L4 WKUP */
+struct omap_hwmod omap2xxx_l4_wkup_hwmod =3D {
+	.name		=3D "l4_wkup",
+	.class		=3D &l4_hwmod_class,
+	.flags		=3D HWMOD_NO_IDLEST,
+};
+
+/* MPU */
+struct omap_hwmod omap2xxx_mpu_hwmod =3D {
+	.name		=3D "mpu",
+	.class		=3D &mpu_hwmod_class,
+	.main_clk	=3D "mpu_ck",
+};
+
+/* IVA2 */
+struct omap_hwmod omap2xxx_iva_hwmod =3D {
+	.name		=3D "iva",
+	.class		=3D &iva_hwmod_class,
+};
+
+/* always-on timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_alwon_dev_attr=
 =3D {
+	.timer_capability       =3D OMAP_TIMER_ALWON,
+};
+
+/* pwm timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_pwm_dev_attr =3D=
 {
+	.timer_capability       =3D OMAP_TIMER_HAS_PWM,
+};
+
+/* timer1 */
+
+struct omap_hwmod omap2xxx_timer1_hwmod =3D {
+	.name		=3D "timer1",
+	.mpu_irqs	=3D omap2_timer1_mpu_irqs,
+	.main_clk	=3D "gpt1_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_GPT1_SHIFT,
+			.module_offs =3D WKUP_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_GPT1_SHIFT,
+		},
+	},
+	.dev_attr	=3D &capability_alwon_dev_attr,
+	.class		=3D &omap2xxx_timer_hwmod_class,
+};
+
+/* timer2 */
+
+struct omap_hwmod omap2xxx_timer2_hwmod =3D {
+	.name		=3D "timer2",
+	.mpu_irqs	=3D omap2_timer2_mpu_irqs,
+	.main_clk	=3D "gpt2_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_GPT2_SHIFT,
+			.module_offs =3D CORE_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_GPT2_SHIFT,
+		},
+	},
+	.dev_attr	=3D &capability_alwon_dev_attr,
+	.class		=3D &omap2xxx_timer_hwmod_class,
+};
+
+/* timer3 */
+
+struct omap_hwmod omap2xxx_timer3_hwmod =3D {
+	.name		=3D "timer3",
+	.mpu_irqs	=3D omap2_timer3_mpu_irqs,
+	.main_clk	=3D "gpt3_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_GPT3_SHIFT,
+			.module_offs =3D CORE_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_GPT3_SHIFT,
+		},
+	},
+	.dev_attr	=3D &capability_alwon_dev_attr,
+	.class		=3D &omap2xxx_timer_hwmod_class,
+};
+
+/* timer4 */
+
+struct omap_hwmod omap2xxx_timer4_hwmod =3D {
+	.name		=3D "timer4",
+	.mpu_irqs	=3D omap2_timer4_mpu_irqs,
+	.main_clk	=3D "gpt4_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_GPT4_SHIFT,
+			.module_offs =3D CORE_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_GPT4_SHIFT,
+		},
+	},
+	.dev_attr	=3D &capability_alwon_dev_attr,
+	.class		=3D &omap2xxx_timer_hwmod_class,
+};
+
+/* timer5 */
+
+struct omap_hwmod omap2xxx_timer5_hwmod =3D {
+	.name		=3D "timer5",
+	.mpu_irqs	=3D omap2_timer5_mpu_irqs,
+	.main_clk	=3D "gpt5_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_GPT5_SHIFT,
+			.module_offs =3D CORE_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_GPT5_SHIFT,
+		},
+	},
+	.dev_attr	=3D &capability_alwon_dev_attr,
+	.class		=3D &omap2xxx_timer_hwmod_class,
+};
+
+/* timer6 */
+
+struct omap_hwmod omap2xxx_timer6_hwmod =3D {
+	.name		=3D "timer6",
+	.mpu_irqs	=3D omap2_timer6_mpu_irqs,
+	.main_clk	=3D "gpt6_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_GPT6_SHIFT,
+			.module_offs =3D CORE_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_GPT6_SHIFT,
+		},
+	},
+	.dev_attr	=3D &capability_alwon_dev_attr,
+	.class		=3D &omap2xxx_timer_hwmod_class,
+};
+
+/* timer7 */
+
+struct omap_hwmod omap2xxx_timer7_hwmod =3D {
+	.name		=3D "timer7",
+	.mpu_irqs	=3D omap2_timer7_mpu_irqs,
+	.main_clk	=3D "gpt7_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_GPT7_SHIFT,
+			.module_offs =3D CORE_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_GPT7_SHIFT,
+		},
+	},
+	.dev_attr	=3D &capability_alwon_dev_attr,
+	.class		=3D &omap2xxx_timer_hwmod_class,
+};
+
+/* timer8 */
+
+struct omap_hwmod omap2xxx_timer8_hwmod =3D {
+	.name		=3D "timer8",
+	.mpu_irqs	=3D omap2_timer8_mpu_irqs,
+	.main_clk	=3D "gpt8_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_GPT8_SHIFT,
+			.module_offs =3D CORE_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_GPT8_SHIFT,
+		},
+	},
+	.dev_attr	=3D &capability_alwon_dev_attr,
+	.class		=3D &omap2xxx_timer_hwmod_class,
+};
+
+/* timer9 */
+
+struct omap_hwmod omap2xxx_timer9_hwmod =3D {
+	.name		=3D "timer9",
+	.mpu_irqs	=3D omap2_timer9_mpu_irqs,
+	.main_clk	=3D "gpt9_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_GPT9_SHIFT,
+			.module_offs =3D CORE_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_GPT9_SHIFT,
+		},
+	},
+	.dev_attr	=3D &capability_pwm_dev_attr,
+	.class		=3D &omap2xxx_timer_hwmod_class,
+};
+
+/* timer10 */
+
+struct omap_hwmod omap2xxx_timer10_hwmod =3D {
+	.name		=3D "timer10",
+	.mpu_irqs	=3D omap2_timer10_mpu_irqs,
+	.main_clk	=3D "gpt10_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_GPT10_SHIFT,
+			.module_offs =3D CORE_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_GPT10_SHIFT,
+		},
+	},
+	.dev_attr	=3D &capability_pwm_dev_attr,
+	.class		=3D &omap2xxx_timer_hwmod_class,
+};
+
+/* timer11 */
+
+struct omap_hwmod omap2xxx_timer11_hwmod =3D {
+	.name		=3D "timer11",
+	.mpu_irqs	=3D omap2_timer11_mpu_irqs,
+	.main_clk	=3D "gpt11_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_GPT11_SHIFT,
+			.module_offs =3D CORE_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_GPT11_SHIFT,
+		},
+	},
+	.dev_attr	=3D &capability_pwm_dev_attr,
+	.class		=3D &omap2xxx_timer_hwmod_class,
+};
+
+/* timer12 */
+
+struct omap_hwmod omap2xxx_timer12_hwmod =3D {
+	.name		=3D "timer12",
+	.mpu_irqs	=3D omap2xxx_timer12_mpu_irqs,
+	.main_clk	=3D "gpt12_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_GPT12_SHIFT,
+			.module_offs =3D CORE_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_GPT12_SHIFT,
+		},
+	},
+	.dev_attr	=3D &capability_pwm_dev_attr,
+	.class		=3D &omap2xxx_timer_hwmod_class,
+};
+
+/* wd_timer2 */
+struct omap_hwmod omap2xxx_wd_timer2_hwmod =3D {
+	.name		=3D "wd_timer2",
+	.class		=3D &omap2xxx_wd_timer_hwmod_class,
+	.main_clk	=3D "mpu_wdt_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_MPU_WDT_SHIFT,
+			.module_offs =3D WKUP_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_MPU_WDT_SHIFT,
+		},
+	},
+};
+
+/* UART1 */
+
+struct omap_hwmod omap2xxx_uart1_hwmod =3D {
+	.name		=3D "uart1",
+	.mpu_irqs	=3D omap2_uart1_mpu_irqs,
+	.sdma_reqs	=3D omap2_uart1_sdma_reqs,
+	.main_clk	=3D "uart1_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.module_offs =3D CORE_MOD,
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_UART1_SHIFT,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_EN_UART1_SHIFT,
+		},
+	},
+	.class		=3D &omap2_uart_class,
+};
+
+/* UART2 */
+
+struct omap_hwmod omap2xxx_uart2_hwmod =3D {
+	.name		=3D "uart2",
+	.mpu_irqs	=3D omap2_uart2_mpu_irqs,
+	.sdma_reqs	=3D omap2_uart2_sdma_reqs,
+	.main_clk	=3D "uart2_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.module_offs =3D CORE_MOD,
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_UART2_SHIFT,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_EN_UART2_SHIFT,
+		},
+	},
+	.class		=3D &omap2_uart_class,
+};
+
+/* UART3 */
+
+struct omap_hwmod omap2xxx_uart3_hwmod =3D {
+	.name		=3D "uart3",
+	.mpu_irqs	=3D omap2_uart3_mpu_irqs,
+	.sdma_reqs	=3D omap2_uart3_sdma_reqs,
+	.main_clk	=3D "uart3_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.module_offs =3D CORE_MOD,
+			.prcm_reg_id =3D 2,
+			.module_bit =3D OMAP24XX_EN_UART3_SHIFT,
+			.idlest_reg_id =3D 2,
+			.idlest_idle_bit =3D OMAP24XX_EN_UART3_SHIFT,
+		},
+	},
+	.class		=3D &omap2_uart_class,
+};
+
+/* dss */
+
+static struct omap_hwmod_opt_clk dss_opt_clks[] =3D {
+	/*
+	 * The DSS HW needs all DSS clocks enabled during reset. The dss_core
+	 * driver does not use these clocks.
+	 */
+	{ .role =3D "tv_clk", .clk =3D "dss_54m_fck" },
+	{ .role =3D "sys_clk", .clk =3D "dss2_fck" },
+};
+
+struct omap_hwmod omap2xxx_dss_core_hwmod =3D {
+	.name		=3D "dss_core",
+	.class		=3D &omap2_dss_hwmod_class,
+	.main_clk	=3D "dss1_fck", /* instead of dss_fck */
+	.sdma_reqs	=3D omap2xxx_dss_sdma_chs,
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_DSS1_SHIFT,
+			.module_offs =3D CORE_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_stdby_bit =3D OMAP24XX_ST_DSS_SHIFT,
+		},
+	},
+	.opt_clks	=3D dss_opt_clks,
+	.opt_clks_cnt =3D ARRAY_SIZE(dss_opt_clks),
+	.flags		=3D HWMOD_NO_IDLEST | HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+};
+
+struct omap_hwmod omap2xxx_dss_dispc_hwmod =3D {
+	.name		=3D "dss_dispc",
+	.class		=3D &omap2_dispc_hwmod_class,
+	.mpu_irqs	=3D omap2_dispc_irqs,
+	.main_clk	=3D "dss1_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_DSS1_SHIFT,
+			.module_offs =3D CORE_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_stdby_bit =3D OMAP24XX_ST_DSS_SHIFT,
+		},
+	},
+	.flags		=3D HWMOD_NO_IDLEST,
+	.dev_attr	=3D &omap2_3_dss_dispc_dev_attr
+};
+
+static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] =3D {
+	{ .role =3D "ick", .clk =3D "dss_ick" },
+};
+
+struct omap_hwmod omap2xxx_dss_rfbi_hwmod =3D {
+	.name		=3D "dss_rfbi",
+	.class		=3D &omap2_rfbi_hwmod_class,
+	.main_clk	=3D "dss1_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_DSS1_SHIFT,
+			.module_offs =3D CORE_MOD,
+		},
+	},
+	.opt_clks	=3D dss_rfbi_opt_clks,
+	.opt_clks_cnt	=3D ARRAY_SIZE(dss_rfbi_opt_clks),
+	.flags		=3D HWMOD_NO_IDLEST,
+};
+
+struct omap_hwmod omap2xxx_dss_venc_hwmod =3D {
+	.name		=3D "dss_venc",
+	.class		=3D &omap2_venc_hwmod_class,
+	.main_clk	=3D "dss_54m_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_DSS1_SHIFT,
+			.module_offs =3D CORE_MOD,
+		},
+	},
+	.flags		=3D HWMOD_NO_IDLEST,
+};
+
+/* gpio dev_attr */
+struct omap_gpio_dev_attr omap2xxx_gpio_dev_attr =3D {
+	.bank_width =3D 32,
+	.dbck_flag =3D false,
+};
+
+/* gpio1 */
+struct omap_hwmod omap2xxx_gpio1_hwmod =3D {
+	.name		=3D "gpio1",
+	.flags		=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+	.mpu_irqs	=3D omap2_gpio1_irqs,
+	.main_clk	=3D "gpios_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_GPIOS_SHIFT,
+			.module_offs =3D WKUP_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_GPIOS_SHIFT,
+		},
+	},
+	.class		=3D &omap2xxx_gpio_hwmod_class,
+	.dev_attr	=3D &omap2xxx_gpio_dev_attr,
+};
+
+/* gpio2 */
+struct omap_hwmod omap2xxx_gpio2_hwmod =3D {
+	.name		=3D "gpio2",
+	.flags		=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+	.mpu_irqs	=3D omap2_gpio2_irqs,
+	.main_clk	=3D "gpios_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_GPIOS_SHIFT,
+			.module_offs =3D WKUP_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_GPIOS_SHIFT,
+		},
+	},
+	.class		=3D &omap2xxx_gpio_hwmod_class,
+	.dev_attr	=3D &omap2xxx_gpio_dev_attr,
+};
+
+/* gpio3 */
+struct omap_hwmod omap2xxx_gpio3_hwmod =3D {
+	.name		=3D "gpio3",
+	.flags		=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+	.mpu_irqs	=3D omap2_gpio3_irqs,
+	.main_clk	=3D "gpios_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_GPIOS_SHIFT,
+			.module_offs =3D WKUP_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_GPIOS_SHIFT,
+		},
+	},
+	.class		=3D &omap2xxx_gpio_hwmod_class,
+	.dev_attr	=3D &omap2xxx_gpio_dev_attr,
+};
+
+/* gpio4 */
+struct omap_hwmod omap2xxx_gpio4_hwmod =3D {
+	.name		=3D "gpio4",
+	.flags		=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+	.mpu_irqs	=3D omap2_gpio4_irqs,
+	.main_clk	=3D "gpios_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_GPIOS_SHIFT,
+			.module_offs =3D WKUP_MOD,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_GPIOS_SHIFT,
+		},
+	},
+	.class		=3D &omap2xxx_gpio_hwmod_class,
+	.dev_attr	=3D &omap2xxx_gpio_dev_attr,
+};
+
+/* mcspi1 */
+static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr =3D {
+	.num_chipselect =3D 4,
+};
+
+struct omap_hwmod omap2xxx_mcspi1_hwmod =3D {
+	.name		=3D "mcspi1",
+	.mpu_irqs	=3D omap2_mcspi1_mpu_irqs,
+	.sdma_reqs	=3D omap2_mcspi1_sdma_reqs,
+	.main_clk	=3D "mcspi1_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.module_offs =3D CORE_MOD,
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_MCSPI1_SHIFT,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_MCSPI1_SHIFT,
+		},
+	},
+	.class		=3D &omap2xxx_mcspi_class,
+	.dev_attr	=3D &omap_mcspi1_dev_attr,
+};
+
+/* mcspi2 */
+static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr =3D {
+	.num_chipselect =3D 2,
+};
+
+struct omap_hwmod omap2xxx_mcspi2_hwmod =3D {
+	.name		=3D "mcspi2",
+	.mpu_irqs	=3D omap2_mcspi2_mpu_irqs,
+	.sdma_reqs	=3D omap2_mcspi2_sdma_reqs,
+	.main_clk	=3D "mcspi2_fck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.module_offs =3D CORE_MOD,
+			.prcm_reg_id =3D 1,
+			.module_bit =3D OMAP24XX_EN_MCSPI2_SHIFT,
+			.idlest_reg_id =3D 1,
+			.idlest_idle_bit =3D OMAP24XX_ST_MCSPI2_SHIFT,
+		},
+	},
+	.class		=3D &omap2xxx_mcspi_class,
+	.dev_attr	=3D &omap_mcspi2_dev_attr,
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/ma=
ch-omap2/omap_hwmod_common_data.h
index ad5d8f0..65757f3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -54,6 +54,38 @@ extern struct omap_hwmod_addr_space omap2_mcbsp1_add=
rs[];
 /* Common IP block data across OMAP2xxx */
 extern struct omap_hwmod_irq_info omap2xxx_timer12_mpu_irqs[];
 extern struct omap_hwmod_dma_info omap2xxx_dss_sdma_chs[];
+extern struct omap_gpio_dev_attr omap2xxx_gpio_dev_attr;
+extern struct omap_hwmod omap2xxx_l3_main_hwmod;
+extern struct omap_hwmod omap2xxx_l4_core_hwmod;
+extern struct omap_hwmod omap2xxx_l4_wkup_hwmod;
+extern struct omap_hwmod omap2xxx_mpu_hwmod;
+extern struct omap_hwmod omap2xxx_iva_hwmod;
+extern struct omap_hwmod omap2xxx_timer1_hwmod;
+extern struct omap_hwmod omap2xxx_timer2_hwmod;
+extern struct omap_hwmod omap2xxx_timer3_hwmod;
+extern struct omap_hwmod omap2xxx_timer4_hwmod;
+extern struct omap_hwmod omap2xxx_timer5_hwmod;
+extern struct omap_hwmod omap2xxx_timer6_hwmod;
+extern struct omap_hwmod omap2xxx_timer7_hwmod;
+extern struct omap_hwmod omap2xxx_timer8_hwmod;
+extern struct omap_hwmod omap2xxx_timer9_hwmod;
+extern struct omap_hwmod omap2xxx_timer10_hwmod;
+extern struct omap_hwmod omap2xxx_timer11_hwmod;
+extern struct omap_hwmod omap2xxx_timer12_hwmod;
+extern struct omap_hwmod omap2xxx_wd_timer2_hwmod;
+extern struct omap_hwmod omap2xxx_uart1_hwmod;
+extern struct omap_hwmod omap2xxx_uart2_hwmod;
+extern struct omap_hwmod omap2xxx_uart3_hwmod;
+extern struct omap_hwmod omap2xxx_dss_core_hwmod;
+extern struct omap_hwmod omap2xxx_dss_dispc_hwmod;
+extern struct omap_hwmod omap2xxx_dss_rfbi_hwmod;
+extern struct omap_hwmod omap2xxx_dss_venc_hwmod;
+extern struct omap_hwmod omap2xxx_gpio1_hwmod;
+extern struct omap_hwmod omap2xxx_gpio2_hwmod;
+extern struct omap_hwmod omap2xxx_gpio3_hwmod;
+extern struct omap_hwmod omap2xxx_gpio4_hwmod;
+extern struct omap_hwmod omap2xxx_mcspi1_hwmod;
+extern struct omap_hwmod omap2xxx_mcspi2_hwmod;
=20
 /* Common IP block data */
 extern struct omap_hwmod_dma_info omap2_uart1_sdma_reqs[];


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
