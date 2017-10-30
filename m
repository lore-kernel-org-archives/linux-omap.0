From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 21/27] dt-bindings: clk: add am43xx clkctrl definitions
Date: Mon, 30 Oct 2017 15:04:39 +0200
Message-ID: <1509368685-29112-22-git-send-email-t-kristo@ti.com>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Contains offsets for all am43xx clkctrl main and optional clocks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 include/dt-bindings/clock/am4.h | 113 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 include/dt-bindings/clock/am4.h

diff --git a/include/dt-bindings/clock/am4.h b/include/dt-bindings/clock/am4.h
new file mode 100644
index 0000000..d21df00
--- /dev/null
+++ b/include/dt-bindings/clock/am4.h
@@ -0,0 +1,113 @@
+/*
+ * Copyright 2017 Texas Instruments, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef __DT_BINDINGS_CLK_AM4_H
+#define __DT_BINDINGS_CLK_AM4_H
+
+#define AM4_CLKCTRL_OFFSET	0x20
+#define AM4_CLKCTRL_INDEX(offset)	((offset) - AM4_CLKCTRL_OFFSET)
+
+/* l4_wkup clocks */
+#define AM4_ADC_TSC_CLKCTRL	AM4_CLKCTRL_INDEX(0x120)
+#define AM4_L4_WKUP_CLKCTRL	AM4_CLKCTRL_INDEX(0x220)
+#define AM4_WKUP_M3_CLKCTRL	AM4_CLKCTRL_INDEX(0x228)
+#define AM4_COUNTER_32K_CLKCTRL	AM4_CLKCTRL_INDEX(0x230)
+#define AM4_TIMER1_CLKCTRL	AM4_CLKCTRL_INDEX(0x328)
+#define AM4_WD_TIMER2_CLKCTRL	AM4_CLKCTRL_INDEX(0x338)
+#define AM4_I2C1_CLKCTRL	AM4_CLKCTRL_INDEX(0x340)
+#define AM4_UART1_CLKCTRL	AM4_CLKCTRL_INDEX(0x348)
+#define AM4_SMARTREFLEX0_CLKCTRL	AM4_CLKCTRL_INDEX(0x350)
+#define AM4_SMARTREFLEX1_CLKCTRL	AM4_CLKCTRL_INDEX(0x358)
+#define AM4_CONTROL_CLKCTRL	AM4_CLKCTRL_INDEX(0x360)
+#define AM4_GPIO1_CLKCTRL	AM4_CLKCTRL_INDEX(0x368)
+
+/* mpu clocks */
+#define AM4_MPU_CLKCTRL	AM4_CLKCTRL_INDEX(0x20)
+
+/* gfx_l3 clocks */
+#define AM4_GFX_CLKCTRL	AM4_CLKCTRL_INDEX(0x20)
+
+/* l4_rtc clocks */
+#define AM4_RTC_CLKCTRL	AM4_CLKCTRL_INDEX(0x20)
+
+/* l4_per clocks */
+#define AM4_L3_MAIN_CLKCTRL	AM4_CLKCTRL_INDEX(0x20)
+#define AM4_AES_CLKCTRL	AM4_CLKCTRL_INDEX(0x28)
+#define AM4_DES_CLKCTRL	AM4_CLKCTRL_INDEX(0x30)
+#define AM4_L3_INSTR_CLKCTRL	AM4_CLKCTRL_INDEX(0x40)
+#define AM4_OCMCRAM_CLKCTRL	AM4_CLKCTRL_INDEX(0x50)
+#define AM4_SHAM_CLKCTRL	AM4_CLKCTRL_INDEX(0x58)
+#define AM4_VPFE0_CLKCTRL	AM4_CLKCTRL_INDEX(0x68)
+#define AM4_VPFE1_CLKCTRL	AM4_CLKCTRL_INDEX(0x70)
+#define AM4_TPCC_CLKCTRL	AM4_CLKCTRL_INDEX(0x78)
+#define AM4_TPTC0_CLKCTRL	AM4_CLKCTRL_INDEX(0x80)
+#define AM4_TPTC1_CLKCTRL	AM4_CLKCTRL_INDEX(0x88)
+#define AM4_TPTC2_CLKCTRL	AM4_CLKCTRL_INDEX(0x90)
+#define AM4_L4_HS_CLKCTRL	AM4_CLKCTRL_INDEX(0xa0)
+#define AM4_GPMC_CLKCTRL	AM4_CLKCTRL_INDEX(0x220)
+#define AM4_MCASP0_CLKCTRL	AM4_CLKCTRL_INDEX(0x238)
+#define AM4_MCASP1_CLKCTRL	AM4_CLKCTRL_INDEX(0x240)
+#define AM4_MMC3_CLKCTRL	AM4_CLKCTRL_INDEX(0x248)
+#define AM4_QSPI_CLKCTRL	AM4_CLKCTRL_INDEX(0x258)
+#define AM4_USB_OTG_SS0_CLKCTRL	AM4_CLKCTRL_INDEX(0x260)
+#define AM4_USB_OTG_SS1_CLKCTRL	AM4_CLKCTRL_INDEX(0x268)
+#define AM4_PRUSS_CLKCTRL	AM4_CLKCTRL_INDEX(0x320)
+#define AM4_L4_LS_CLKCTRL	AM4_CLKCTRL_INDEX(0x420)
+#define AM4_D_CAN0_CLKCTRL	AM4_CLKCTRL_INDEX(0x428)
+#define AM4_D_CAN1_CLKCTRL	AM4_CLKCTRL_INDEX(0x430)
+#define AM4_EPWMSS0_CLKCTRL	AM4_CLKCTRL_INDEX(0x438)
+#define AM4_EPWMSS1_CLKCTRL	AM4_CLKCTRL_INDEX(0x440)
+#define AM4_EPWMSS2_CLKCTRL	AM4_CLKCTRL_INDEX(0x448)
+#define AM4_EPWMSS3_CLKCTRL	AM4_CLKCTRL_INDEX(0x450)
+#define AM4_EPWMSS4_CLKCTRL	AM4_CLKCTRL_INDEX(0x458)
+#define AM4_EPWMSS5_CLKCTRL	AM4_CLKCTRL_INDEX(0x460)
+#define AM4_ELM_CLKCTRL	AM4_CLKCTRL_INDEX(0x468)
+#define AM4_GPIO2_CLKCTRL	AM4_CLKCTRL_INDEX(0x478)
+#define AM4_GPIO3_CLKCTRL	AM4_CLKCTRL_INDEX(0x480)
+#define AM4_GPIO4_CLKCTRL	AM4_CLKCTRL_INDEX(0x488)
+#define AM4_GPIO5_CLKCTRL	AM4_CLKCTRL_INDEX(0x490)
+#define AM4_GPIO6_CLKCTRL	AM4_CLKCTRL_INDEX(0x498)
+#define AM4_HDQ1W_CLKCTRL	AM4_CLKCTRL_INDEX(0x4a0)
+#define AM4_I2C2_CLKCTRL	AM4_CLKCTRL_INDEX(0x4a8)
+#define AM4_I2C3_CLKCTRL	AM4_CLKCTRL_INDEX(0x4b0)
+#define AM4_MAILBOX_CLKCTRL	AM4_CLKCTRL_INDEX(0x4b8)
+#define AM4_MMC1_CLKCTRL	AM4_CLKCTRL_INDEX(0x4c0)
+#define AM4_MMC2_CLKCTRL	AM4_CLKCTRL_INDEX(0x4c8)
+#define AM4_RNG_CLKCTRL	AM4_CLKCTRL_INDEX(0x4e0)
+#define AM4_SPI0_CLKCTRL	AM4_CLKCTRL_INDEX(0x500)
+#define AM4_SPI1_CLKCTRL	AM4_CLKCTRL_INDEX(0x508)
+#define AM4_SPI2_CLKCTRL	AM4_CLKCTRL_INDEX(0x510)
+#define AM4_SPI3_CLKCTRL	AM4_CLKCTRL_INDEX(0x518)
+#define AM4_SPI4_CLKCTRL	AM4_CLKCTRL_INDEX(0x520)
+#define AM4_SPINLOCK_CLKCTRL	AM4_CLKCTRL_INDEX(0x528)
+#define AM4_TIMER2_CLKCTRL	AM4_CLKCTRL_INDEX(0x530)
+#define AM4_TIMER3_CLKCTRL	AM4_CLKCTRL_INDEX(0x538)
+#define AM4_TIMER4_CLKCTRL	AM4_CLKCTRL_INDEX(0x540)
+#define AM4_TIMER5_CLKCTRL	AM4_CLKCTRL_INDEX(0x548)
+#define AM4_TIMER6_CLKCTRL	AM4_CLKCTRL_INDEX(0x550)
+#define AM4_TIMER7_CLKCTRL	AM4_CLKCTRL_INDEX(0x558)
+#define AM4_TIMER8_CLKCTRL	AM4_CLKCTRL_INDEX(0x560)
+#define AM4_TIMER9_CLKCTRL	AM4_CLKCTRL_INDEX(0x568)
+#define AM4_TIMER10_CLKCTRL	AM4_CLKCTRL_INDEX(0x570)
+#define AM4_TIMER11_CLKCTRL	AM4_CLKCTRL_INDEX(0x578)
+#define AM4_UART2_CLKCTRL	AM4_CLKCTRL_INDEX(0x580)
+#define AM4_UART3_CLKCTRL	AM4_CLKCTRL_INDEX(0x588)
+#define AM4_UART4_CLKCTRL	AM4_CLKCTRL_INDEX(0x590)
+#define AM4_UART5_CLKCTRL	AM4_CLKCTRL_INDEX(0x598)
+#define AM4_UART6_CLKCTRL	AM4_CLKCTRL_INDEX(0x5a0)
+#define AM4_OCP2SCP0_CLKCTRL	AM4_CLKCTRL_INDEX(0x5b8)
+#define AM4_OCP2SCP1_CLKCTRL	AM4_CLKCTRL_INDEX(0x5c0)
+#define AM4_EMIF_CLKCTRL	AM4_CLKCTRL_INDEX(0x720)
+#define AM4_DSS_CORE_CLKCTRL	AM4_CLKCTRL_INDEX(0xa20)
+#define AM4_CPGMAC0_CLKCTRL	AM4_CLKCTRL_INDEX(0xb20)
+
+#endif
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
