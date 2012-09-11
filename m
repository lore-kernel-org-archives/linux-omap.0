From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 15/17] ARM: OMAP: Split plat/hardware.h,
 use local soc.h for omap2+
Date: Mon, 10 Sep 2012 22:31:17 -0700
Message-ID: <20120911053117.29637.2499.stgit@muffinssi.local>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:14177 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754637Ab2IKFbW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 01:31:22 -0400
In-Reply-To: <20120911052934.29637.9190.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, linux-watchdog@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Wim Van Sebroeck <wim@iguana.be>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

As the plat and mach includes need to disappear for single zImage work,
we need to remove plat/hardware.h.

Do this by splitting plat/hardware.h into omap1 and omap2+ specific files.

The old plat/hardware.h already has omap1 only defines, so it gets moved
to mach/hardware.h for omap1. For omap2+, we use the local soc.h
that for now just includes the related SoC headers to keep this patch more
readable.

Note that the local soc.h still includes plat/cpu.h that can be dealt
with in later patches. Let's also include plat/serial.h from common.h for
all the board-*.c files. This allows making the include files local later
on without patching these files again.

Note that only minimal changes are done in this patch for the
drivers/watchdog/omap_wdt.c driver to keep things compiling. Further
patches are needed to eventually remove cpu_is_omap usage in the drivers.

Also only minimal changes are done to sound/soc/omap/* to remove the
unneeded includes and to define OMAP44XX_MCPDM_L3_BASE locally so there's
no need to include omap44xx.h.

While at it, also sort some of the includes in the standard way.

Cc: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: alsa-devel@alsa-project.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Liam Girdwood <lrg@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/include/mach/hardware.h    |  285 +++++++++++++++++++++++
 arch/arm/mach-omap2/board-3430sdp.c            |    1 
 arch/arm/mach-omap2/board-4430sdp.c            |    2 
 arch/arm/mach-omap2/board-am3517crane.c        |    1 
 arch/arm/mach-omap2/board-am3517evm.c          |    1 
 arch/arm/mach-omap2/board-apollon.c            |    1 
 arch/arm/mach-omap2/board-cm-t3517.c           |    1 
 arch/arm/mach-omap2/board-devkit8000.c         |    3 
 arch/arm/mach-omap2/board-flash.c              |    1 
 arch/arm/mach-omap2/board-generic.c            |    1 
 arch/arm/mach-omap2/board-h4.c                 |    3 
 arch/arm/mach-omap2/board-igep0020.c           |    1 
 arch/arm/mach-omap2/board-ldp.c                |    3 
 arch/arm/mach-omap2/board-n8x0.c               |    1 
 arch/arm/mach-omap2/board-omap3beagle.c        |    1 
 arch/arm/mach-omap2/board-omap3evm.c           |    1 
 arch/arm/mach-omap2/board-omap3logic.c         |   14 -
 arch/arm/mach-omap2/board-omap3pandora.c       |    1 
 arch/arm/mach-omap2/board-omap3stalker.c       |    6 
 arch/arm/mach-omap2/board-omap3touchbook.c     |    1 
 arch/arm/mach-omap2/board-omap4panda.c         |    2 
 arch/arm/mach-omap2/board-overo.c              |    2 
 arch/arm/mach-omap2/board-rx51.c               |    1 
 arch/arm/mach-omap2/board-ti8168evm.c          |    1 
 arch/arm/mach-omap2/board-zoom-debugboard.c    |    4 
 arch/arm/mach-omap2/board-zoom-display.c       |    2 
 arch/arm/mach-omap2/board-zoom-peripherals.c   |    1 
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c   |    2 
 arch/arm/mach-omap2/clkt_dpll.c                |    2 
 arch/arm/mach-omap2/clock.c                    |    8 -
 arch/arm/mach-omap2/clock2420_data.c           |    2 
 arch/arm/mach-omap2/clock2430.c                |    2 
 arch/arm/mach-omap2/clock2430_data.c           |    2 
 arch/arm/mach-omap2/clock2xxx.c                |    2 
 arch/arm/mach-omap2/clock3xxx.c                |    2 
 arch/arm/mach-omap2/clock3xxx_data.c           |    2 
 arch/arm/mach-omap2/clock44xx_data.c           |    2 
 arch/arm/mach-omap2/cm2xxx_3xxx.c              |    3 
 arch/arm/mach-omap2/common.c                   |    2 
 arch/arm/mach-omap2/common.h                   |    6 
 arch/arm/mach-omap2/control.c                  |    2 
 arch/arm/mach-omap2/devices.c                  |    1 
 arch/arm/mach-omap2/dpll3xxx.c                 |    2 
 arch/arm/mach-omap2/dpll44xx.c                 |    2 
 arch/arm/mach-omap2/emu.c                      |    3 
 arch/arm/mach-omap2/gpmc-nand.c                |    3 
 arch/arm/mach-omap2/gpmc-onenand.c             |    3 
 arch/arm/mach-omap2/gpmc-smc91x.c              |    3 
 arch/arm/mach-omap2/gpmc.c                     |    4 
 arch/arm/mach-omap2/i2c.c                      |    1 
 arch/arm/mach-omap2/id.c                       |    2 
 arch/arm/mach-omap2/include/mach/hardware.h    |    2 
 arch/arm/mach-omap2/io.c                       |    3 
 arch/arm/mach-omap2/irq.c                      |    3 
 arch/arm/mach-omap2/mailbox.c                  |    3 
 arch/arm/mach-omap2/mcbsp.c                    |    1 
 arch/arm/mach-omap2/omap-smp.c                 |    2 
 arch/arm/mach-omap2/omap-wakeupgen.c           |    2 
 arch/arm/mach-omap2/omap4-common.c             |    2 
 arch/arm/mach-omap2/omap_hwmod.c               |    8 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c     |    1 
 arch/arm/mach-omap2/omap_hwmod_2430_data.c     |    5 
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c     |    3 
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c     |    1 
 arch/arm/mach-omap2/omap_l3_noc.c              |    3 
 arch/arm/mach-omap2/omap_phy_internal.c        |    2 
 arch/arm/mach-omap2/opp2420_data.c             |    2 
 arch/arm/mach-omap2/opp2430_data.c             |    2 
 arch/arm/mach-omap2/opp3xxx_data.c             |    2 
 arch/arm/mach-omap2/opp4xxx_data.c             |    3 
 arch/arm/mach-omap2/powerdomain.c              |    6 
 arch/arm/mach-omap2/powerdomains3xxx_data.c    |    4 
 arch/arm/mach-omap2/prm2xxx_3xxx.c             |    4 
 arch/arm/mach-omap2/prm44xx.c                  |    3 
 arch/arm/mach-omap2/sdrc2xxx.c                 |    2 
 arch/arm/mach-omap2/sleep34xx.S                |    2 
 arch/arm/mach-omap2/soc.h                      |    6 
 arch/arm/mach-omap2/sram242x.S                 |    3 
 arch/arm/mach-omap2/sram243x.S                 |    3 
 arch/arm/mach-omap2/sram34xx.S                 |    3 
 arch/arm/mach-omap2/timer.c                    |    3 
 arch/arm/mach-omap2/twl-common.c               |    2 
 arch/arm/mach-omap2/usb-host.c                 |    1 
 arch/arm/mach-omap2/usb-musb.c                 |    6 
 arch/arm/mach-omap2/vc.c                       |    3 
 arch/arm/mach-omap2/voltagedomains3xxx_data.c  |    3 
 arch/arm/plat-omap/counter_32k.c               |    2 
 arch/arm/plat-omap/dma.c                       |    3 
 arch/arm/plat-omap/include/plat/cpu.h          |    3 
 arch/arm/plat-omap/include/plat/hardware.h     |  293 ------------------------
 arch/arm/plat-omap/include/plat/omap4-keypad.h |    2 
 arch/arm/plat-omap/include/plat/omap44xx.h     |    1 
 drivers/watchdog/omap_wdt.c                    |    5 
 sound/soc/omap/omap-abe-twl6040.c              |    4 
 sound/soc/omap/omap-mcpdm.c                    |    2 
 95 files changed, 391 insertions(+), 433 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/hardware.h

diff --git a/arch/arm/mach-omap1/include/mach/hardware.h b/arch/arm/mach-omap1/include/mach/hardware.h
index 01e35fa..bd3b95e 100644
--- a/arch/arm/mach-omap1/include/mach/hardware.h
+++ b/arch/arm/mach-omap1/include/mach/hardware.h
@@ -1,11 +1,46 @@
 /*
  * arch/arm/mach-omap1/include/mach/hardware.h
+ *
+ * Hardware definitions for TI OMAP processors and boards
+ *
+ * NOTE: Please put device driver specific defines into a separate header
+ *	 file for each driver.
+ *
+ * Copyright (C) 2001 RidgeRun, Inc.
+ * Author: RidgeRun, Inc. Greg Lonnon <glonnon@ridgerun.com>
+ *
+ * Reorganized for Linux-2.6 by Tony Lindgren <tony@atomide.com>
+ *                          and Dirk Behme <dirk.behme@de.bosch.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#ifndef __MACH_HARDWARE_H
-#define __MACH_HARDWARE_H
+#ifndef __ASM_ARCH_OMAP_HARDWARE_H
+#define __ASM_ARCH_OMAP_HARDWARE_H
 
+#include <asm/sizes.h>
 #ifndef __ASSEMBLER__
+#include <asm/types.h>
+#include <plat/cpu.h>
+
 /*
  * NOTE: Please use ioremap + __raw_read/write where possible instead of these
  */
@@ -35,7 +70,249 @@ static inline u32 omap_cs3_phys(void)
 			? 0 : OMAP_CS3_PHYS;
 }
 
+#endif	/* ifndef __ASSEMBLER__ */
+
+#include <plat/serial.h>
+
+/*
+ * ---------------------------------------------------------------------------
+ * Common definitions for all OMAP processors
+ * NOTE: Put all processor or board specific parts to the special header
+ *	 files.
+ * ---------------------------------------------------------------------------
+ */
+
+/*
+ * ----------------------------------------------------------------------------
+ * Timers
+ * ----------------------------------------------------------------------------
+ */
+#define OMAP_MPU_TIMER1_BASE	(0xfffec500)
+#define OMAP_MPU_TIMER2_BASE	(0xfffec600)
+#define OMAP_MPU_TIMER3_BASE	(0xfffec700)
+#define MPU_TIMER_FREE		(1 << 6)
+#define MPU_TIMER_CLOCK_ENABLE	(1 << 5)
+#define MPU_TIMER_AR		(1 << 1)
+#define MPU_TIMER_ST		(1 << 0)
+
+/*
+ * ----------------------------------------------------------------------------
+ * Clocks
+ * ----------------------------------------------------------------------------
+ */
+#define CLKGEN_REG_BASE		(0xfffece00)
+#define ARM_CKCTL		(CLKGEN_REG_BASE + 0x0)
+#define ARM_IDLECT1		(CLKGEN_REG_BASE + 0x4)
+#define ARM_IDLECT2		(CLKGEN_REG_BASE + 0x8)
+#define ARM_EWUPCT		(CLKGEN_REG_BASE + 0xC)
+#define ARM_RSTCT1		(CLKGEN_REG_BASE + 0x10)
+#define ARM_RSTCT2		(CLKGEN_REG_BASE + 0x14)
+#define ARM_SYSST		(CLKGEN_REG_BASE + 0x18)
+#define ARM_IDLECT3		(CLKGEN_REG_BASE + 0x24)
+
+#define CK_RATEF		1
+#define CK_IDLEF		2
+#define CK_ENABLEF		4
+#define CK_SELECTF		8
+#define SETARM_IDLE_SHIFT
+
+/* DPLL control registers */
+#define DPLL_CTL		(0xfffecf00)
+
+/* DSP clock control. Must use __raw_readw() and __raw_writew() with these */
+#define DSP_CONFIG_REG_BASE     IOMEM(0xe1008000)
+#define DSP_CKCTL		(DSP_CONFIG_REG_BASE + 0x0)
+#define DSP_IDLECT1		(DSP_CONFIG_REG_BASE + 0x4)
+#define DSP_IDLECT2		(DSP_CONFIG_REG_BASE + 0x8)
+#define DSP_RSTCT2		(DSP_CONFIG_REG_BASE + 0x14)
+
+/*
+ * ---------------------------------------------------------------------------
+ * UPLD
+ * ---------------------------------------------------------------------------
+ */
+#define ULPD_REG_BASE		(0xfffe0800)
+#define ULPD_IT_STATUS		(ULPD_REG_BASE + 0x14)
+#define ULPD_SETUP_ANALOG_CELL_3	(ULPD_REG_BASE + 0x24)
+#define ULPD_CLOCK_CTRL		(ULPD_REG_BASE + 0x30)
+#	define DIS_USB_PVCI_CLK		(1 << 5)	/* no USB/FAC synch */
+#	define USB_MCLK_EN		(1 << 4)	/* enable W4_USB_CLKO */
+#define ULPD_SOFT_REQ		(ULPD_REG_BASE + 0x34)
+#	define SOFT_UDC_REQ		(1 << 4)
+#	define SOFT_USB_CLK_REQ		(1 << 3)
+#	define SOFT_DPLL_REQ		(1 << 0)
+#define ULPD_DPLL_CTRL		(ULPD_REG_BASE + 0x3c)
+#define ULPD_STATUS_REQ		(ULPD_REG_BASE + 0x40)
+#define ULPD_APLL_CTRL		(ULPD_REG_BASE + 0x4c)
+#define ULPD_POWER_CTRL		(ULPD_REG_BASE + 0x50)
+#define ULPD_SOFT_DISABLE_REQ_REG	(ULPD_REG_BASE + 0x68)
+#	define DIS_MMC2_DPLL_REQ	(1 << 11)
+#	define DIS_MMC1_DPLL_REQ	(1 << 10)
+#	define DIS_UART3_DPLL_REQ	(1 << 9)
+#	define DIS_UART2_DPLL_REQ	(1 << 8)
+#	define DIS_UART1_DPLL_REQ	(1 << 7)
+#	define DIS_USB_HOST_DPLL_REQ	(1 << 6)
+#define ULPD_SDW_CLK_DIV_CTRL_SEL	(ULPD_REG_BASE + 0x74)
+#define ULPD_CAM_CLK_CTRL	(ULPD_REG_BASE + 0x7c)
+
+/*
+ * ---------------------------------------------------------------------------
+ * Watchdog timer
+ * ---------------------------------------------------------------------------
+ */
+
+/* Watchdog timer within the OMAP3.2 gigacell */
+#define OMAP_MPU_WATCHDOG_BASE	(0xfffec800)
+#define OMAP_WDT_TIMER		(OMAP_MPU_WATCHDOG_BASE + 0x0)
+#define OMAP_WDT_LOAD_TIM	(OMAP_MPU_WATCHDOG_BASE + 0x4)
+#define OMAP_WDT_READ_TIM	(OMAP_MPU_WATCHDOG_BASE + 0x4)
+#define OMAP_WDT_TIMER_MODE	(OMAP_MPU_WATCHDOG_BASE + 0x8)
+
+/*
+ * ---------------------------------------------------------------------------
+ * Interrupts
+ * ---------------------------------------------------------------------------
+ */
+#ifdef CONFIG_ARCH_OMAP1
+
+/*
+ * XXX: These probably want to be moved to arch/arm/mach-omap/omap1/irq.c
+ * or something similar.. -- PFM.
+ */
+
+#define OMAP_IH1_BASE		0xfffecb00
+#define OMAP_IH2_BASE		0xfffe0000
+
+#define OMAP_IH1_ITR		(OMAP_IH1_BASE + 0x00)
+#define OMAP_IH1_MIR		(OMAP_IH1_BASE + 0x04)
+#define OMAP_IH1_SIR_IRQ	(OMAP_IH1_BASE + 0x10)
+#define OMAP_IH1_SIR_FIQ	(OMAP_IH1_BASE + 0x14)
+#define OMAP_IH1_CONTROL	(OMAP_IH1_BASE + 0x18)
+#define OMAP_IH1_ILR0		(OMAP_IH1_BASE + 0x1c)
+#define OMAP_IH1_ISR		(OMAP_IH1_BASE + 0x9c)
+
+#define OMAP_IH2_ITR		(OMAP_IH2_BASE + 0x00)
+#define OMAP_IH2_MIR		(OMAP_IH2_BASE + 0x04)
+#define OMAP_IH2_SIR_IRQ	(OMAP_IH2_BASE + 0x10)
+#define OMAP_IH2_SIR_FIQ	(OMAP_IH2_BASE + 0x14)
+#define OMAP_IH2_CONTROL	(OMAP_IH2_BASE + 0x18)
+#define OMAP_IH2_ILR0		(OMAP_IH2_BASE + 0x1c)
+#define OMAP_IH2_ISR		(OMAP_IH2_BASE + 0x9c)
+
+#define IRQ_ITR_REG_OFFSET	0x00
+#define IRQ_MIR_REG_OFFSET	0x04
+#define IRQ_SIR_IRQ_REG_OFFSET	0x10
+#define IRQ_SIR_FIQ_REG_OFFSET	0x14
+#define IRQ_CONTROL_REG_OFFSET	0x18
+#define IRQ_ISR_REG_OFFSET	0x9c
+#define IRQ_ILR0_REG_OFFSET	0x1c
+#define IRQ_GMR_REG_OFFSET	0xa0
+
 #endif
-#endif
 
-#include <plat/hardware.h>
+/*
+ * ----------------------------------------------------------------------------
+ * System control registers
+ * ----------------------------------------------------------------------------
+ */
+#define MOD_CONF_CTRL_0		0xfffe1080
+#define MOD_CONF_CTRL_1		0xfffe1110
+
+/*
+ * ----------------------------------------------------------------------------
+ * Pin multiplexing registers
+ * ----------------------------------------------------------------------------
+ */
+#define FUNC_MUX_CTRL_0		0xfffe1000
+#define FUNC_MUX_CTRL_1		0xfffe1004
+#define FUNC_MUX_CTRL_2		0xfffe1008
+#define COMP_MODE_CTRL_0	0xfffe100c
+#define FUNC_MUX_CTRL_3		0xfffe1010
+#define FUNC_MUX_CTRL_4		0xfffe1014
+#define FUNC_MUX_CTRL_5		0xfffe1018
+#define FUNC_MUX_CTRL_6		0xfffe101C
+#define FUNC_MUX_CTRL_7		0xfffe1020
+#define FUNC_MUX_CTRL_8		0xfffe1024
+#define FUNC_MUX_CTRL_9		0xfffe1028
+#define FUNC_MUX_CTRL_A		0xfffe102C
+#define FUNC_MUX_CTRL_B		0xfffe1030
+#define FUNC_MUX_CTRL_C		0xfffe1034
+#define FUNC_MUX_CTRL_D		0xfffe1038
+#define PULL_DWN_CTRL_0		0xfffe1040
+#define PULL_DWN_CTRL_1		0xfffe1044
+#define PULL_DWN_CTRL_2		0xfffe1048
+#define PULL_DWN_CTRL_3		0xfffe104c
+#define PULL_DWN_CTRL_4		0xfffe10ac
+
+/* OMAP-1610 specific multiplexing registers */
+#define FUNC_MUX_CTRL_E		0xfffe1090
+#define FUNC_MUX_CTRL_F		0xfffe1094
+#define FUNC_MUX_CTRL_10	0xfffe1098
+#define FUNC_MUX_CTRL_11	0xfffe109c
+#define FUNC_MUX_CTRL_12	0xfffe10a0
+#define PU_PD_SEL_0		0xfffe10b4
+#define PU_PD_SEL_1		0xfffe10b8
+#define PU_PD_SEL_2		0xfffe10bc
+#define PU_PD_SEL_3		0xfffe10c0
+#define PU_PD_SEL_4		0xfffe10c4
+
+/* Timer32K for 1610 and 1710*/
+#define OMAP_TIMER32K_BASE	0xFFFBC400
+
+/*
+ * ---------------------------------------------------------------------------
+ * TIPB bus interface
+ * ---------------------------------------------------------------------------
+ */
+#define TIPB_PUBLIC_CNTL_BASE		0xfffed300
+#define MPU_PUBLIC_TIPB_CNTL		(TIPB_PUBLIC_CNTL_BASE + 0x8)
+#define TIPB_PRIVATE_CNTL_BASE		0xfffeca00
+#define MPU_PRIVATE_TIPB_CNTL		(TIPB_PRIVATE_CNTL_BASE + 0x8)
+
+/*
+ * ----------------------------------------------------------------------------
+ * MPUI interface
+ * ----------------------------------------------------------------------------
+ */
+#define MPUI_BASE			(0xfffec900)
+#define MPUI_CTRL			(MPUI_BASE + 0x0)
+#define MPUI_DEBUG_ADDR			(MPUI_BASE + 0x4)
+#define MPUI_DEBUG_DATA			(MPUI_BASE + 0x8)
+#define MPUI_DEBUG_FLAG			(MPUI_BASE + 0xc)
+#define MPUI_STATUS_REG			(MPUI_BASE + 0x10)
+#define MPUI_DSP_STATUS			(MPUI_BASE + 0x14)
+#define MPUI_DSP_BOOT_CONFIG		(MPUI_BASE + 0x18)
+#define MPUI_DSP_API_CONFIG		(MPUI_BASE + 0x1c)
+
+/*
+ * ----------------------------------------------------------------------------
+ * LED Pulse Generator
+ * ----------------------------------------------------------------------------
+ */
+#define OMAP_LPG1_BASE			0xfffbd000
+#define OMAP_LPG2_BASE			0xfffbd800
+#define OMAP_LPG1_LCR			(OMAP_LPG1_BASE + 0x00)
+#define OMAP_LPG1_PMR			(OMAP_LPG1_BASE + 0x04)
+#define OMAP_LPG2_LCR			(OMAP_LPG2_BASE + 0x00)
+#define OMAP_LPG2_PMR			(OMAP_LPG2_BASE + 0x04)
+
+/*
+ * ----------------------------------------------------------------------------
+ * Pulse-Width Light
+ * ----------------------------------------------------------------------------
+ */
+#define OMAP_PWL_BASE			0xfffb5800
+#define OMAP_PWL_ENABLE			(OMAP_PWL_BASE + 0x00)
+#define OMAP_PWL_CLK_ENABLE		(OMAP_PWL_BASE + 0x04)
+
+/*
+ * ---------------------------------------------------------------------------
+ * Processor specific defines
+ * ---------------------------------------------------------------------------
+ */
+
+#include <plat/omap7xx.h>
+#include <plat/omap1510.h>
+#include <plat/omap16xx.h>
+
+#endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index c843d01..5453173 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -25,7 +25,6 @@
 #include <linux/gpio.h>
 #include <linux/mmc/host.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 31456ea..db43e22 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -28,7 +28,6 @@
 #include <linux/leds_pwm.h>
 #include <linux/platform_data/omap4-keypad.h>
 
-#include <mach/hardware.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -44,6 +43,7 @@
 #include <linux/wl12xx.h>
 #include <linux/platform_data/omap-abe-twl6040.h>
 
+#include "soc.h"
 #include "mux.h"
 #include "hsmmc.h"
 #include "control.h"
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index de92b08..318fead 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -21,7 +21,6 @@
 #include <linux/init.h>
 #include <linux/gpio.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index f8bc860..403d048 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -27,7 +27,6 @@
 #include <linux/mmc/host.h>
 #include <linux/platform_data/gpio-omap.h>
 
-#include <mach/hardware.h>
 #include <mach/am35xx.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index a6a1b48..3e2d76f 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -29,7 +29,6 @@
 #include <linux/smc91x.h>
 #include <linux/gpio.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 20fe233..27a5450 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -42,7 +42,6 @@
 #include <plat/usb.h>
 #include <plat/nand.h>
 #include <plat/gpmc.h>
-#include <plat/serial.h>
 
 #include <mach/am35xx.h>
 
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 9032807..18b63ad 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -32,8 +32,6 @@
 
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
-
-#include <mach/hardware.h>
 #include <mach/id.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -55,7 +53,6 @@
 #include <linux/interrupt.h>
 
 #include "sdram-micron-mt46h32m32lf-6.h"
-
 #include "mux.h"
 #include "hsmmc.h"
 #include "common-board-devices.h"
diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 901fa1f..9017813 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -23,6 +23,7 @@
 #include <plat/onenand.h>
 #include <plat/tc.h>
 
+#include "common.h"
 #include "board-flash.h"
 
 #define REG_FPGA_REV			0x10
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 38024a5..2ea7c57 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -16,7 +16,6 @@
 #include <linux/of_platform.h>
 #include <linux/irqdomain.h>
 
-#include <mach/hardware.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 5be30e6..12569cb 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -27,12 +27,10 @@
 #include <linux/io.h>
 #include <linux/input/matrix_keypad.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include "common.h"
 #include <plat/menelaus.h>
 #include <plat/dma.h>
 #include <plat/gpmc.h>
@@ -41,6 +39,7 @@
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
 
+#include "common.h"
 #include "mux.h"
 #include "control.h"
 
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index bacb917..8408bb2 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -32,7 +32,6 @@
 #include "common.h"
 #include <plat/gpmc.h>
 #include <plat/usb.h>
-#include <plat/serial.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-tfp410.h>
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index bea2e3a..3f3a552 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -29,7 +29,6 @@
 #include <linux/smsc911x.h>
 #include <linux/mmc/host.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -38,8 +37,6 @@
 #include "common.h"
 #include <plat/gpmc.h>
 #include <mach/board-zoom.h>
-
-#include <asm/delay.h>
 #include <plat/usb.h>
 #include <plat/gpmc-smsc911x.h>
 
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 6e6b175..d8deaea 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -30,7 +30,6 @@
 #include <plat/mcspi.h>
 #include <plat/onenand.h>
 #include <plat/mmc.h>
-#include <plat/serial.h>
 
 #include "mux.h"
 
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 9d9b2ab..801bcb4 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -33,7 +33,6 @@
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 493bd96..b94873d 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -40,7 +40,6 @@
 #include <linux/mmc/host.h>
 #include <linux/export.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 8fe7f0c..b5e56fa 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -30,23 +30,21 @@
 #include <linux/i2c/twl.h>
 #include <linux/mmc/host.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include "mux.h"
-#include "hsmmc.h"
-#include "control.h"
-#include "common-board-devices.h"
-
-#include <plat/mux.h>
-#include "common.h"
 #include <plat/gpmc-smsc911x.h>
 #include <plat/gpmc.h>
 #include <plat/sdrc.h>
 #include <plat/usb.h>
 
+#include "common.h"
+#include "mux.h"
+#include "hsmmc.h"
+#include "control.h"
+#include "common-board-devices.h"
+
 #define OMAP3LOGIC_SMSC911X_CS			1
 
 #define OMAP3530_LV_SOM_MMC_GPIO_CD		110
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 38521d4..e700a98 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -41,7 +41,6 @@
 #include <asm/mach/map.h>
 
 #include "common.h"
-#include <mach/hardware.h>
 #include <plat/mcspi.h>
 #include <plat/usb.h>
 #include <video/omapdss.h>
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 87aa5b1..b8756f0 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -28,8 +28,12 @@
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
 #include <linux/mmc/host.h>
+#include <linux/input/matrix_keypad.h>
+#include <linux/spi/spi.h>
+#include <linux/interrupt.h>
+#include <linux/smsc911x.h>
+#include <linux/i2c/at24.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 88dc913..0e2f838 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -37,7 +37,6 @@
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index cbf6fd5..45fe2d3 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -32,7 +32,6 @@
 #include <linux/wl12xx.h>
 #include <linux/platform_data/omap-abe-twl6040.h>
 
-#include <mach/hardware.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -44,6 +43,7 @@
 #include <plat/mmc.h>
 #include <video/omap-panel-tfp410.h>
 
+#include "soc.h"
 #include "hsmmc.h"
 #include "control.h"
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 4754f05..7a62d13 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -47,10 +47,8 @@
 #include <video/omap-panel-generic-dpi.h>
 #include <video/omap-panel-tfp410.h>
 #include <plat/gpmc.h>
-#include <mach/hardware.h>
 #include <plat/nand.h>
 #include <plat/mcspi.h>
-#include <plat/mux.h>
 #include <plat/usb.h>
 
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 92924eb..93b4661 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -18,7 +18,6 @@
 #include <linux/gpio.h>
 #include <linux/leds.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index 4ca16e3..c4f8833 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -15,7 +15,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index f1100c2..5ec069e 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -19,10 +19,12 @@
 
 #include <plat/gpmc.h>
 #include <plat/gpmc-smsc911x.h>
-#include <plat/serial.h>
 
 #include <mach/board-zoom.h>
 
+#include "soc.h"
+#include "common.h"
+
 #define ZOOM_SMSC911X_CS	7
 #define ZOOM_SMSC911X_GPIO	158
 #define ZOOM_QUADUART_CS	3
diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index d64f35f..ea79bc2 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -18,7 +18,7 @@
 #include <video/omapdss.h>
 #include <mach/board-zoom.h>
 
-#include <plat/cpu.h>
+#include "common.h"
 
 #define LCD_PANEL_RESET_GPIO_PROD	96
 #define LCD_PANEL_RESET_GPIO_PILOT	55
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 089024c..6bcc107 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -27,7 +27,6 @@
 
 #include "common.h"
 #include <plat/usb.h>
-#include <plat/serial.h>
 
 #include <mach/board-zoom.h>
 
diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index 3d9d746..cabcfdb 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -33,11 +33,11 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 
-#include <plat/cpu.h>
 #include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/sdrc.h>
 
+#include "soc.h"
 #include "clock.h"
 #include "clock2xxx.h"
 #include "opp2xxx.h"
diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index cd7fd0f..ae624c3 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -22,8 +22,8 @@
 #include <asm/div64.h>
 
 #include <plat/clock.h>
-#include <plat/cpu.h>
 
+#include "soc.h"
 #include "clock.h"
 #include "cm-regbits-24xx.h"
 #include "cm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index ea3f565..1a1f97f 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -22,14 +22,16 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/bitops.h>
-#include <trace/events/power.h>
 
 #include <asm/cpu.h>
+
 #include <plat/clock.h>
-#include "clockdomain.h"
-#include <plat/cpu.h>
 #include <plat/prcm.h>
 
+#include <trace/events/power.h>
+
+#include "soc.h"
+#include "clockdomain.h"
 #include "clock.h"
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 0027451..12c178d 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -18,9 +18,9 @@
 #include <linux/clk.h>
 #include <linux/list.h>
 
-#include <plat/hardware.h>
 #include <plat/clkdev_omap.h>
 
+#include "soc.h"
 #include "iomap.h"
 #include "clock.h"
 #include "clock2xxx.h"
diff --git a/arch/arm/mach-omap2/clock2430.c b/arch/arm/mach-omap2/clock2430.c
index dfda9a3..a8e3261 100644
--- a/arch/arm/mach-omap2/clock2430.c
+++ b/arch/arm/mach-omap2/clock2430.c
@@ -21,9 +21,9 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/hardware.h>
 #include <plat/clock.h>
 
+#include "soc.h"
 #include "iomap.h"
 #include "clock.h"
 #include "clock2xxx.h"
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index cacabb0..02fe1f2 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -17,9 +17,9 @@
 #include <linux/clk.h>
 #include <linux/list.h>
 
-#include <plat/hardware.h>
 #include <plat/clkdev_omap.h>
 
+#include "soc.h"
 #include "iomap.h"
 #include "clock.h"
 #include "clock2xxx.h"
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index 1250009..e92be1f 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -22,9 +22,9 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/cpu.h>
 #include <plat/clock.h>
 
+#include "soc.h"
 #include "clock.h"
 #include "clock2xxx.h"
 #include "cm.h"
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index 794d827..fc2765b 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -21,9 +21,9 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/hardware.h>
 #include <plat/clock.h>
 
+#include "soc.h"
 #include "clock.h"
 #include "clock3xxx.h"
 #include "prm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 83bed9a..10a2398 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -21,9 +21,9 @@
 #include <linux/list.h>
 #include <linux/io.h>
 
-#include <plat/hardware.h>
 #include <plat/clkdev_omap.h>
 
+#include "soc.h"
 #include "iomap.h"
 #include "clock.h"
 #include "clock3xxx.h"
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index d7f55e4..500682c 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -28,9 +28,9 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/hardware.h>
 #include <plat/clkdev_omap.h>
 
+#include "soc.h"
 #include "iomap.h"
 #include "clock.h"
 #include "clock44xx.h"
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm2xxx_3xxx.c
index 389f9f8..a911e76 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
@@ -18,8 +18,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include <plat/hardware.h>
-
+#include "soc.h"
 #include "iomap.h"
 #include "common.h"
 #include "cm.h"
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 6c2ff4f..8e43c4d8 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -17,10 +17,10 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/hardware.h>
 #include <plat/mux.h>
 #include <plat/clock.h>
 
+#include "soc.h"
 #include "iomap.h"
 #include "common.h"
 #include "sdrc.h"
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 4cdb08c..da0f5c1 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -29,9 +29,13 @@
 #include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/i2c/twl.h>
-#include <plat/common.h>
+
 #include <asm/proc-fns.h>
 
+#include <plat/cpu.h>
+#include <plat/serial.h>
+#include <plat/common.h>
+
 #define OMAP_INTC_START		NR_IRQS
 
 #ifdef CONFIG_SOC_OMAP2420
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 3223b81..d1ff839 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -15,9 +15,9 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 
-#include <plat/hardware.h>
 #include <plat/sdrc.h>
 
+#include "soc.h"
 #include "iomap.h"
 #include "common.h"
 #include "cm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 626e98e..1efa984 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -19,7 +19,6 @@
 #include <linux/of.h>
 #include <linux/platform_data/omap4-keypad.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/pmu.h>
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index b9c8d2f..d8318dc 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -28,9 +28,9 @@
 #include <linux/bitops.h>
 #include <linux/clkdev.h>
 
-#include <plat/cpu.h>
 #include <plat/clock.h>
 
+#include "soc.h"
 #include "clock.h"
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index 9c6a296..09d0ccc 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -15,9 +15,9 @@
 #include <linux/io.h>
 #include <linux/bitops.h>
 
-#include <plat/cpu.h>
 #include <plat/clock.h>
 
+#include "soc.h"
 #include "clock.h"
 #include "clock44xx.h"
 #include "cm-regbits-44xx.h"
diff --git a/arch/arm/mach-omap2/emu.c b/arch/arm/mach-omap2/emu.c
index e28e761..b3566f6 100644
--- a/arch/arm/mach-omap2/emu.c
+++ b/arch/arm/mach-omap2/emu.c
@@ -21,8 +21,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 
-#include <mach/hardware.h>
-
+#include "soc.h"
 #include "iomap.h"
 
 MODULE_LICENSE("GPL");
diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 96fcc641..9e9f47a 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -16,10 +16,11 @@
 
 #include <asm/mach/flash.h>
 
-#include <plat/cpu.h>
 #include <plat/nand.h>
 #include <plat/gpmc.h>
 
+#include "soc.h"
+
 static struct resource gpmc_nand_resource[] = {
 	{
 		.flags		= IORESOURCE_MEM,
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index b12a39e..b66fb8e 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -18,10 +18,11 @@
 
 #include <asm/mach/flash.h>
 
-#include <plat/cpu.h>
 #include <plat/onenand.h>
 #include <plat/gpmc.h>
 
+#include "soc.h"
+
 #define	ONENAND_IO_SIZE	SZ_128K
 
 static struct omap_onenand_platform_data *gpmc_onenand_data;
diff --git a/arch/arm/mach-omap2/gpmc-smc91x.c b/arch/arm/mach-omap2/gpmc-smc91x.c
index e8ff2da..245839d 100644
--- a/arch/arm/mach-omap2/gpmc-smc91x.c
+++ b/arch/arm/mach-omap2/gpmc-smc91x.c
@@ -17,10 +17,11 @@
 #include <linux/io.h>
 #include <linux/smc91x.h>
 
-#include <plat/cpu.h>
 #include <plat/gpmc.h>
 #include <plat/gpmc-smc91x.h>
 
+#include "soc.h"
+
 static struct omap_smc91x_platform_data *gpmc_cfg;
 
 static struct resource gpmc_smc91x_resources[] = {
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 68eead8..055ae8b 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -29,10 +29,10 @@
 #include <plat/gpmc.h>
 
 #include <plat/cpu.h>
+#include <plat/gpmc.h>
 #include <plat/sdrc.h>
 
-#include <mach/hardware.h>
-
+#include "soc.h"
 #include "common.h"
 
 /* GPMC register offsets */
diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index a12e224..fc57e67 100644
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -19,7 +19,6 @@
  *
  */
 
-#include <plat/cpu.h>
 #include <plat/i2c.h>
 #include "common.h"
 #include <plat/omap_hwmod.h>
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 40373db..7219df0 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -22,10 +22,10 @@
 #include <asm/cputype.h>
 
 #include "common.h"
-#include <plat/cpu.h>
 
 #include <mach/id.h>
 
+#include "soc.h"
 #include "control.h"
 
 static unsigned int omap_revision;
diff --git a/arch/arm/mach-omap2/include/mach/hardware.h b/arch/arm/mach-omap2/include/mach/hardware.h
index 78edf9d..54492db 100644
--- a/arch/arm/mach-omap2/include/mach/hardware.h
+++ b/arch/arm/mach-omap2/include/mach/hardware.h
@@ -1,5 +1,3 @@
 /*
  * arch/arm/mach-omap2/include/mach/hardware.h
  */
-
-#include <plat/hardware.h>
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index ff6fc5b..0d79c23 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -33,8 +33,7 @@
 #include <plat/multi.h>
 #include <plat/dma.h>
 
-#include <mach/hardware.h>
-
+#include "soc.h"
 #include "iomap.h"
 #include "voltage.h"
 #include "powerdomain.h"
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index ac59f96..efed4f5 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -23,8 +23,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
-#include <mach/hardware.h>
-
+#include "soc.h"
 #include "iomap.h"
 #include "common.h"
 
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index e032a73..0d97456 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -17,9 +17,10 @@
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
 
-#include <plat/cpu.h>
 #include <plat/mailbox.h>
 
+#include "soc.h"
+
 #define MAILBOX_REVISION		0x000
 #define MAILBOX_MESSAGE(m)		(0x040 + 4 * (m))
 #define MAILBOX_FIFOSTATUS(m)		(0x080 + 4 * (m))
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 219a6e8..d493727 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -19,7 +19,6 @@
 #include <linux/slab.h>
 
 #include <plat/dma.h>
-#include <plat/cpu.h>
 #include <plat/mcbsp.h>
 #include <plat/omap_device.h>
 #include <linux/pm_runtime.h>
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 9a35adf..19cc5f5 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -24,11 +24,11 @@
 #include <asm/hardware/gic.h>
 #include <asm/smp_scu.h>
 
-#include <mach/hardware.h>
 #include <mach/omap-secure.h>
 #include <mach/omap-wakeupgen.h>
 #include <asm/cputype.h>
 
+#include "soc.h"
 #include "iomap.h"
 #include "common.h"
 #include "clockdomain.h"
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 95ee7dd..b54427d 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -27,10 +27,10 @@
 
 #include <asm/hardware/gic.h>
 
-#include <mach/hardware.h>
 #include <mach/omap-wakeupgen.h>
 #include <mach/omap-secure.h>
 
+#include "soc.h"
 #include "omap4-sar-layout.h"
 #include "common.h"
 
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index c886325..73c1440 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -29,9 +29,9 @@
 #include <plat/omap-secure.h>
 #include <plat/mmc.h>
 
-#include <mach/hardware.h>
 #include <mach/omap-wakeupgen.h>
 
+#include "soc.h"
 #include "common.h"
 #include "hsmmc.h"
 #include "omap4-sar-layout.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6ca8e51..9db1684 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -139,14 +139,14 @@
 #include <linux/slab.h>
 #include <linux/bootmem.h>
 
-#include "common.h"
-#include <plat/cpu.h>
-#include "clockdomain.h"
-#include "powerdomain.h"
 #include <plat/clock.h>
 #include <plat/omap_hwmod.h>
 #include <plat/prcm.h>
 
+#include "soc.h"
+#include "common.h"
+#include "clockdomain.h"
+#include "powerdomain.h"
 #include "cm2xxx_3xxx.h"
 #include "cminst44xx.h"
 #include "prm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 1645d3f..4e81637 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -13,7 +13,6 @@
  * XXX these should be marked initdata for multi-OMAP kernels
  */
 #include <plat/omap_hwmod.h>
-#include <plat/cpu.h>
 #include <plat/dma.h>
 #include <plat/serial.h>
 #include <plat/i2c.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 23582fc..ceb23c3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -13,7 +13,6 @@
  * XXX these should be marked initdata for multi-OMAP kernels
  */
 #include <plat/omap_hwmod.h>
-#include <plat/cpu.h>
 #include <plat/dma.h>
 #include <plat/serial.h>
 #include <plat/i2c.h>
@@ -23,10 +22,8 @@
 #include <plat/mmc.h>
 #include <plat/l3_2xxx.h>
 
-#include <plat/hardware.h>
-
+#include "soc.h"
 #include "omap_hwmod_common_data.h"
-
 #include "prm-regbits-24xx.h"
 #include "cm-regbits-24xx.h"
 #include "wd_timer.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 9605e5f..75fbbac 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -18,7 +18,6 @@
 #include <linux/platform_data/gpio-omap.h>
 
 #include <plat/omap_hwmod.h>
-#include <plat/cpu.h>
 #include <plat/dma.h>
 #include <plat/serial.h>
 #include <plat/l3_3xxx.h>
@@ -29,9 +28,9 @@
 #include <plat/mcspi.h>
 #include <plat/dmtimer.h>
 
-#include <mach/hardware.h>
 #include <mach/am35xx.h>
 
+#include "soc.h"
 #include "omap_hwmod_common_data.h"
 #include "prm-regbits-34xx.h"
 #include "cm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index fe987f8..b95244b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -23,7 +23,6 @@
 #include <linux/power/smartreflex.h>
 
 #include <plat/omap_hwmod.h>
-#include <plat/cpu.h>
 #include <plat/i2c.h>
 #include <plat/dma.h>
 #include <plat/mcspi.h>
diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index f0992fd..f447e02 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -28,8 +28,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 
-#include <plat/hardware.h>
-
+#include "soc.h"
 #include "omap_l3_noc.h"
 
 /*
diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index d0b4dc7..593eaea 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -28,9 +28,9 @@
 #include <linux/err.h>
 #include <linux/usb.h>
 
-#include <plat/hardware.h>
 #include <plat/usb.h>
 
+#include "soc.h"
 #include "control.h"
 
 /* OMAP control module register for UTMI PHY */
diff --git a/arch/arm/mach-omap2/opp2420_data.c b/arch/arm/mach-omap2/opp2420_data.c
index 5037e76..a9e8cf2 100644
--- a/arch/arm/mach-omap2/opp2420_data.c
+++ b/arch/arm/mach-omap2/opp2420_data.c
@@ -28,7 +28,7 @@
  *     http://repository.maemo.org/pool/diablo/free/k/kernel-source-diablo/
  */
 
-#include <plat/hardware.h>
+#include <linux/kernel.h>
 
 #include "opp2xxx.h"
 #include "sdrc.h"
diff --git a/arch/arm/mach-omap2/opp2430_data.c b/arch/arm/mach-omap2/opp2430_data.c
index 750805c..0e75ec3 100644
--- a/arch/arm/mach-omap2/opp2430_data.c
+++ b/arch/arm/mach-omap2/opp2430_data.c
@@ -26,7 +26,7 @@
  * This is technically part of the OMAP2xxx clock code.
  */
 
-#include <plat/hardware.h>
+#include <linux/kernel.h>
 
 #include "opp2xxx.h"
 #include "sdrc.h"
diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
index d95f3f9..75cef5f 100644
--- a/arch/arm/mach-omap2/opp3xxx_data.c
+++ b/arch/arm/mach-omap2/opp3xxx_data.c
@@ -19,8 +19,6 @@
  */
 #include <linux/module.h>
 
-#include <plat/cpu.h>
-
 #include "control.h"
 #include "omap_opp_data.h"
 #include "pm.h"
diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
index c95415d..a9fd6d5 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -20,8 +20,7 @@
  */
 #include <linux/module.h>
 
-#include <plat/cpu.h>
-
+#include "soc.h"
 #include "control.h"
 #include "omap_opp_data.h"
 #include "pm.h"
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 69b36e1..ca5be83 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -28,11 +28,13 @@
 #include "prm44xx.h"
 
 #include <asm/cpu.h>
-#include <plat/cpu.h>
+
+#include <plat/prcm.h>
+
 #include "powerdomain.h"
 #include "clockdomain.h"
-#include <plat/prcm.h>
 
+#include "soc.h"
 #include "pm.h"
 
 #define PWRDM_TRACE_STATES_FLAG	(1<<31)
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index bb883e4..8b23d23 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -15,11 +15,9 @@
 #include <linux/init.h>
 #include <linux/bug.h>
 
-#include <plat/cpu.h>
-
+#include "soc.h"
 #include "powerdomain.h"
 #include "powerdomains2xxx_3xxx_data.h"
-
 #include "prcm-common.h"
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 3601763..9529984 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -17,10 +17,10 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 
-#include "common.h"
-#include <plat/cpu.h>
 #include <plat/prcm.h>
 
+#include "soc.h"
+#include "common.h"
 #include "vp.h"
 
 #include "prm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index df2cfe1..f0c4d5f 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -17,10 +17,9 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include <plat/cpu.h>
 #include <plat/prcm.h>
-#include <plat/hardware.h>
 
+#include "soc.h"
 #include "iomap.h"
 #include "common.h"
 #include "vp.h"
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 1133bb2..73e55e4 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -24,11 +24,11 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/hardware.h>
 #include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/sdrc.h>
 
+#include "soc.h"
 #include "iomap.h"
 #include "common.h"
 #include "prm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 1f62f23..3fbe496 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -26,7 +26,7 @@
 
 #include <asm/assembler.h>
 
-#include <plat/hardware.h>
+#include <plat/omap34xx.h>
 #include <plat/sram.h>
 
 #include "iomap.h"
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index 40195f1..93c08de 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -1 +1,7 @@
 #include <plat/cpu.h>
+#include <plat/omap24xx.h>
+#include <plat/omap34xx.h>
+#include <plat/omap44xx.h>
+#include <plat/ti81xx.h>
+#include <plat/am33xx.h>
+#include <plat/omap54xx.h>
diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram242x.S
index ee0bfcc..8f7326c 100644
--- a/arch/arm/mach-omap2/sram242x.S
+++ b/arch/arm/mach-omap2/sram242x.S
@@ -32,8 +32,7 @@
 
 #include <asm/assembler.h>
 
-#include <mach/hardware.h>
-
+#include "soc.h"
 #include "iomap.h"
 #include "prm2xxx_3xxx.h"
 #include "cm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sram243x.S
index d4d39ef..b140d65 100644
--- a/arch/arm/mach-omap2/sram243x.S
+++ b/arch/arm/mach-omap2/sram243x.S
@@ -32,8 +32,7 @@
 
 #include <asm/assembler.h>
 
-#include <mach/hardware.h>
-
+#include "soc.h"
 #include "iomap.h"
 #include "prm2xxx_3xxx.h"
 #include "cm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index df5a213..2d0ceaa 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -29,8 +29,7 @@
 
 #include <asm/assembler.h>
 
-#include <mach/hardware.h>
-
+#include "soc.h"
 #include "iomap.h"
 #include "sdrc.h"
 #include "cm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 3bdaf98..25cbe73 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -46,8 +46,7 @@
 #include <plat/dmtimer.h>
 #include <plat/omap-pm.h>
 
-#include <mach/hardware.h>
-
+#include "soc.h"
 #include "common.h"
 #include "powerdomain.h"
 
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index b0384ce..99be94e 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -26,10 +26,10 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
 
-#include <plat/hardware.h>
 #include <plat/i2c.h>
 #include <plat/usb.h>
 
+#include "soc.h"
 #include "twl-common.h"
 #include "pm.h"
 #include "voltage.h"
diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index 14368c3..ac95daa 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -25,7 +25,6 @@
 
 #include <asm/io.h>
 
-#include <mach/hardware.h>
 #include <plat/usb.h>
 #include <plat/omap_device.h>
 
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 3f35e6c..89150b2 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -23,13 +23,13 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
-
 #include <linux/usb/musb.h>
 
-#include <mach/hardware.h>
-#include <mach/am35xx.h>
 #include <plat/usb.h>
 #include <plat/omap_device.h>
+
+#include <mach/am35xx.h>
+
 #include "mux.h"
 
 static struct musb_hdrc_config musb_config = {
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 84da34f..b451f3c 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -12,8 +12,7 @@
 #include <linux/init.h>
 #include <linux/bug.h>
 
-#include <plat/cpu.h>
-
+#include "soc.h"
 #include "voltage.h"
 #include "vc.h"
 #include "prm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index d0103c8..63afbfe 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -18,9 +18,8 @@
 #include <linux/err.h>
 #include <linux/init.h>
 
+#include "soc.h"
 #include "common.h"
-#include <plat/cpu.h>
-
 #include "prm-regbits-34xx.h"
 #include "omap_opp_data.h"
 #include "voltage.h"
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 902d2ff..2e826f1 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -22,9 +22,7 @@
 #include <asm/mach/time.h>
 #include <asm/sched_clock.h>
 
-#include <plat/hardware.h>
 #include <plat/common.h>
-
 #include <plat/clock.h>
 
 /* OMAP2_32KSYNCNT_CR_OFF: offset of 32ksync counter register */
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 7fe6267..6dcad58 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -36,9 +36,8 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 
-#include <mach/hardware.h>
+#include <plat/cpu.h>
 #include <plat/dma.h>
-
 #include <plat/tc.h>
 
 /*
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index bb5d08a..67da857 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -30,6 +30,8 @@
 #ifndef __ASM_ARCH_OMAP_CPU_H
 #define __ASM_ARCH_OMAP_CPU_H
 
+#ifndef __ASSEMBLY__
+
 #include <linux/bitops.h>
 #include <plat/multi.h>
 
@@ -493,4 +495,5 @@ OMAP4_HAS_FEATURE(mpu_1ghz, MPU_1GHZ)
 OMAP4_HAS_FEATURE(mpu_1_2ghz, MPU_1_2GHZ)
 OMAP4_HAS_FEATURE(mpu_1_5ghz, MPU_1_5GHZ)
 
+#endif	/* __ASSEMBLY__ */
 #endif
diff --git a/arch/arm/plat-omap/include/plat/hardware.h b/arch/arm/plat-omap/include/plat/hardware.h
deleted file mode 100644
index ddbde38..0000000
--- a/arch/arm/plat-omap/include/plat/hardware.h
+++ /dev/null
@@ -1,293 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/hardware.h
- *
- * Hardware definitions for TI OMAP processors and boards
- *
- * NOTE: Please put device driver specific defines into a separate header
- *	 file for each driver.
- *
- * Copyright (C) 2001 RidgeRun, Inc.
- * Author: RidgeRun, Inc. Greg Lonnon <glonnon@ridgerun.com>
- *
- * Reorganized for Linux-2.6 by Tony Lindgren <tony@atomide.com>
- *                          and Dirk Behme <dirk.behme@de.bosch.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef __ASM_ARCH_OMAP_HARDWARE_H
-#define __ASM_ARCH_OMAP_HARDWARE_H
-
-#include <asm/sizes.h>
-#ifndef __ASSEMBLER__
-#include <asm/types.h>
-#include <plat/cpu.h>
-#endif
-#include <plat/serial.h>
-
-/*
- * ---------------------------------------------------------------------------
- * Common definitions for all OMAP processors
- * NOTE: Put all processor or board specific parts to the special header
- *	 files.
- * ---------------------------------------------------------------------------
- */
-
-/*
- * ----------------------------------------------------------------------------
- * Timers
- * ----------------------------------------------------------------------------
- */
-#define OMAP_MPU_TIMER1_BASE	(0xfffec500)
-#define OMAP_MPU_TIMER2_BASE	(0xfffec600)
-#define OMAP_MPU_TIMER3_BASE	(0xfffec700)
-#define MPU_TIMER_FREE		(1 << 6)
-#define MPU_TIMER_CLOCK_ENABLE	(1 << 5)
-#define MPU_TIMER_AR		(1 << 1)
-#define MPU_TIMER_ST		(1 << 0)
-
-/*
- * ----------------------------------------------------------------------------
- * Clocks
- * ----------------------------------------------------------------------------
- */
-#define CLKGEN_REG_BASE		(0xfffece00)
-#define ARM_CKCTL		(CLKGEN_REG_BASE + 0x0)
-#define ARM_IDLECT1		(CLKGEN_REG_BASE + 0x4)
-#define ARM_IDLECT2		(CLKGEN_REG_BASE + 0x8)
-#define ARM_EWUPCT		(CLKGEN_REG_BASE + 0xC)
-#define ARM_RSTCT1		(CLKGEN_REG_BASE + 0x10)
-#define ARM_RSTCT2		(CLKGEN_REG_BASE + 0x14)
-#define ARM_SYSST		(CLKGEN_REG_BASE + 0x18)
-#define ARM_IDLECT3		(CLKGEN_REG_BASE + 0x24)
-
-#define CK_RATEF		1
-#define CK_IDLEF		2
-#define CK_ENABLEF		4
-#define CK_SELECTF		8
-#define SETARM_IDLE_SHIFT
-
-/* DPLL control registers */
-#define DPLL_CTL		(0xfffecf00)
-
-/* DSP clock control. Must use __raw_readw() and __raw_writew() with these */
-#define DSP_CONFIG_REG_BASE     IOMEM(0xe1008000)
-#define DSP_CKCTL		(DSP_CONFIG_REG_BASE + 0x0)
-#define DSP_IDLECT1		(DSP_CONFIG_REG_BASE + 0x4)
-#define DSP_IDLECT2		(DSP_CONFIG_REG_BASE + 0x8)
-#define DSP_RSTCT2		(DSP_CONFIG_REG_BASE + 0x14)
-
-/*
- * ---------------------------------------------------------------------------
- * UPLD
- * ---------------------------------------------------------------------------
- */
-#define ULPD_REG_BASE		(0xfffe0800)
-#define ULPD_IT_STATUS		(ULPD_REG_BASE + 0x14)
-#define ULPD_SETUP_ANALOG_CELL_3	(ULPD_REG_BASE + 0x24)
-#define ULPD_CLOCK_CTRL		(ULPD_REG_BASE + 0x30)
-#	define DIS_USB_PVCI_CLK		(1 << 5)	/* no USB/FAC synch */
-#	define USB_MCLK_EN		(1 << 4)	/* enable W4_USB_CLKO */
-#define ULPD_SOFT_REQ		(ULPD_REG_BASE + 0x34)
-#	define SOFT_UDC_REQ		(1 << 4)
-#	define SOFT_USB_CLK_REQ		(1 << 3)
-#	define SOFT_DPLL_REQ		(1 << 0)
-#define ULPD_DPLL_CTRL		(ULPD_REG_BASE + 0x3c)
-#define ULPD_STATUS_REQ		(ULPD_REG_BASE + 0x40)
-#define ULPD_APLL_CTRL		(ULPD_REG_BASE + 0x4c)
-#define ULPD_POWER_CTRL		(ULPD_REG_BASE + 0x50)
-#define ULPD_SOFT_DISABLE_REQ_REG	(ULPD_REG_BASE + 0x68)
-#	define DIS_MMC2_DPLL_REQ	(1 << 11)
-#	define DIS_MMC1_DPLL_REQ	(1 << 10)
-#	define DIS_UART3_DPLL_REQ	(1 << 9)
-#	define DIS_UART2_DPLL_REQ	(1 << 8)
-#	define DIS_UART1_DPLL_REQ	(1 << 7)
-#	define DIS_USB_HOST_DPLL_REQ	(1 << 6)
-#define ULPD_SDW_CLK_DIV_CTRL_SEL	(ULPD_REG_BASE + 0x74)
-#define ULPD_CAM_CLK_CTRL	(ULPD_REG_BASE + 0x7c)
-
-/*
- * ---------------------------------------------------------------------------
- * Watchdog timer
- * ---------------------------------------------------------------------------
- */
-
-/* Watchdog timer within the OMAP3.2 gigacell */
-#define OMAP_MPU_WATCHDOG_BASE	(0xfffec800)
-#define OMAP_WDT_TIMER		(OMAP_MPU_WATCHDOG_BASE + 0x0)
-#define OMAP_WDT_LOAD_TIM	(OMAP_MPU_WATCHDOG_BASE + 0x4)
-#define OMAP_WDT_READ_TIM	(OMAP_MPU_WATCHDOG_BASE + 0x4)
-#define OMAP_WDT_TIMER_MODE	(OMAP_MPU_WATCHDOG_BASE + 0x8)
-
-/*
- * ---------------------------------------------------------------------------
- * Interrupts
- * ---------------------------------------------------------------------------
- */
-#ifdef CONFIG_ARCH_OMAP1
-
-/*
- * XXX: These probably want to be moved to arch/arm/mach-omap/omap1/irq.c
- * or something similar.. -- PFM.
- */
-
-#define OMAP_IH1_BASE		0xfffecb00
-#define OMAP_IH2_BASE		0xfffe0000
-
-#define OMAP_IH1_ITR		(OMAP_IH1_BASE + 0x00)
-#define OMAP_IH1_MIR		(OMAP_IH1_BASE + 0x04)
-#define OMAP_IH1_SIR_IRQ	(OMAP_IH1_BASE + 0x10)
-#define OMAP_IH1_SIR_FIQ	(OMAP_IH1_BASE + 0x14)
-#define OMAP_IH1_CONTROL	(OMAP_IH1_BASE + 0x18)
-#define OMAP_IH1_ILR0		(OMAP_IH1_BASE + 0x1c)
-#define OMAP_IH1_ISR		(OMAP_IH1_BASE + 0x9c)
-
-#define OMAP_IH2_ITR		(OMAP_IH2_BASE + 0x00)
-#define OMAP_IH2_MIR		(OMAP_IH2_BASE + 0x04)
-#define OMAP_IH2_SIR_IRQ	(OMAP_IH2_BASE + 0x10)
-#define OMAP_IH2_SIR_FIQ	(OMAP_IH2_BASE + 0x14)
-#define OMAP_IH2_CONTROL	(OMAP_IH2_BASE + 0x18)
-#define OMAP_IH2_ILR0		(OMAP_IH2_BASE + 0x1c)
-#define OMAP_IH2_ISR		(OMAP_IH2_BASE + 0x9c)
-
-#define IRQ_ITR_REG_OFFSET	0x00
-#define IRQ_MIR_REG_OFFSET	0x04
-#define IRQ_SIR_IRQ_REG_OFFSET	0x10
-#define IRQ_SIR_FIQ_REG_OFFSET	0x14
-#define IRQ_CONTROL_REG_OFFSET	0x18
-#define IRQ_ISR_REG_OFFSET	0x9c
-#define IRQ_ILR0_REG_OFFSET	0x1c
-#define IRQ_GMR_REG_OFFSET	0xa0
-
-#endif
-
-/*
- * ----------------------------------------------------------------------------
- * System control registers
- * ----------------------------------------------------------------------------
- */
-#define MOD_CONF_CTRL_0		0xfffe1080
-#define MOD_CONF_CTRL_1		0xfffe1110
-
-/*
- * ----------------------------------------------------------------------------
- * Pin multiplexing registers
- * ----------------------------------------------------------------------------
- */
-#define FUNC_MUX_CTRL_0		0xfffe1000
-#define FUNC_MUX_CTRL_1		0xfffe1004
-#define FUNC_MUX_CTRL_2		0xfffe1008
-#define COMP_MODE_CTRL_0	0xfffe100c
-#define FUNC_MUX_CTRL_3		0xfffe1010
-#define FUNC_MUX_CTRL_4		0xfffe1014
-#define FUNC_MUX_CTRL_5		0xfffe1018
-#define FUNC_MUX_CTRL_6		0xfffe101C
-#define FUNC_MUX_CTRL_7		0xfffe1020
-#define FUNC_MUX_CTRL_8		0xfffe1024
-#define FUNC_MUX_CTRL_9		0xfffe1028
-#define FUNC_MUX_CTRL_A		0xfffe102C
-#define FUNC_MUX_CTRL_B		0xfffe1030
-#define FUNC_MUX_CTRL_C		0xfffe1034
-#define FUNC_MUX_CTRL_D		0xfffe1038
-#define PULL_DWN_CTRL_0		0xfffe1040
-#define PULL_DWN_CTRL_1		0xfffe1044
-#define PULL_DWN_CTRL_2		0xfffe1048
-#define PULL_DWN_CTRL_3		0xfffe104c
-#define PULL_DWN_CTRL_4		0xfffe10ac
-
-/* OMAP-1610 specific multiplexing registers */
-#define FUNC_MUX_CTRL_E		0xfffe1090
-#define FUNC_MUX_CTRL_F		0xfffe1094
-#define FUNC_MUX_CTRL_10	0xfffe1098
-#define FUNC_MUX_CTRL_11	0xfffe109c
-#define FUNC_MUX_CTRL_12	0xfffe10a0
-#define PU_PD_SEL_0		0xfffe10b4
-#define PU_PD_SEL_1		0xfffe10b8
-#define PU_PD_SEL_2		0xfffe10bc
-#define PU_PD_SEL_3		0xfffe10c0
-#define PU_PD_SEL_4		0xfffe10c4
-
-/* Timer32K for 1610 and 1710*/
-#define OMAP_TIMER32K_BASE	0xFFFBC400
-
-/*
- * ---------------------------------------------------------------------------
- * TIPB bus interface
- * ---------------------------------------------------------------------------
- */
-#define TIPB_PUBLIC_CNTL_BASE		0xfffed300
-#define MPU_PUBLIC_TIPB_CNTL		(TIPB_PUBLIC_CNTL_BASE + 0x8)
-#define TIPB_PRIVATE_CNTL_BASE		0xfffeca00
-#define MPU_PRIVATE_TIPB_CNTL		(TIPB_PRIVATE_CNTL_BASE + 0x8)
-
-/*
- * ----------------------------------------------------------------------------
- * MPUI interface
- * ----------------------------------------------------------------------------
- */
-#define MPUI_BASE			(0xfffec900)
-#define MPUI_CTRL			(MPUI_BASE + 0x0)
-#define MPUI_DEBUG_ADDR			(MPUI_BASE + 0x4)
-#define MPUI_DEBUG_DATA			(MPUI_BASE + 0x8)
-#define MPUI_DEBUG_FLAG			(MPUI_BASE + 0xc)
-#define MPUI_STATUS_REG			(MPUI_BASE + 0x10)
-#define MPUI_DSP_STATUS			(MPUI_BASE + 0x14)
-#define MPUI_DSP_BOOT_CONFIG		(MPUI_BASE + 0x18)
-#define MPUI_DSP_API_CONFIG		(MPUI_BASE + 0x1c)
-
-/*
- * ----------------------------------------------------------------------------
- * LED Pulse Generator
- * ----------------------------------------------------------------------------
- */
-#define OMAP_LPG1_BASE			0xfffbd000
-#define OMAP_LPG2_BASE			0xfffbd800
-#define OMAP_LPG1_LCR			(OMAP_LPG1_BASE + 0x00)
-#define OMAP_LPG1_PMR			(OMAP_LPG1_BASE + 0x04)
-#define OMAP_LPG2_LCR			(OMAP_LPG2_BASE + 0x00)
-#define OMAP_LPG2_PMR			(OMAP_LPG2_BASE + 0x04)
-
-/*
- * ----------------------------------------------------------------------------
- * Pulse-Width Light
- * ----------------------------------------------------------------------------
- */
-#define OMAP_PWL_BASE			0xfffb5800
-#define OMAP_PWL_ENABLE			(OMAP_PWL_BASE + 0x00)
-#define OMAP_PWL_CLK_ENABLE		(OMAP_PWL_BASE + 0x04)
-
-/*
- * ---------------------------------------------------------------------------
- * Processor specific defines
- * ---------------------------------------------------------------------------
- */
-
-#include <plat/omap7xx.h>
-#include <plat/omap1510.h>
-#include <plat/omap16xx.h>
-#include <plat/omap24xx.h>
-#include <plat/omap34xx.h>
-#include <plat/omap44xx.h>
-#include <plat/ti81xx.h>
-#include <plat/am33xx.h>
-#include <plat/omap54xx.h>
-
-#endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
diff --git a/arch/arm/plat-omap/include/plat/omap4-keypad.h b/arch/arm/plat-omap/include/plat/omap4-keypad.h
index 8ad0a37..20de0d5 100644
--- a/arch/arm/plat-omap/include/plat/omap4-keypad.h
+++ b/arch/arm/plat-omap/include/plat/omap4-keypad.h
@@ -1,6 +1,8 @@
 #ifndef ARCH_ARM_PLAT_OMAP4_KEYPAD_H
 #define ARCH_ARM_PLAT_OMAP4_KEYPAD_H
 
+struct omap_board_data;
+
 extern int omap4_keyboard_init(struct omap4_keypad_platform_data *,
 				struct omap_board_data *);
 #endif
diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index 5da9735..43b927b 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -45,7 +45,6 @@
 #define OMAP44XX_L2CACHE_BASE		0x48242000
 #define OMAP44XX_WKUPGEN_BASE		0x48281000
 #define OMAP44XX_MCPDM_BASE		0x40132000
-#define OMAP44XX_MCPDM_L3_BASE		0x49032000
 #define OMAP44XX_SAR_RAM_BASE		0x4a326000
 
 #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index fceec4f..f5db18db 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -46,6 +46,7 @@
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 #include <mach/hardware.h>
+#include <plat/cpu.h>
 #include <plat/prcm.h>
 
 #include "omap_wdt.h"
@@ -218,12 +219,16 @@ static long omap_wdt_ioctl(struct file *file, unsigned int cmd,
 	case WDIOC_GETSTATUS:
 		return put_user(0, (int __user *)arg);
 	case WDIOC_GETBOOTSTATUS:
+#ifdef CONFIG_ARCH_OMAP1
 		if (cpu_is_omap16xx())
 			return put_user(__raw_readw(ARM_SYSST),
 					(int __user *)arg);
+#endif
+#ifdef CONFIG_ARCH_OMAP2PLUS
 		if (cpu_is_omap24xx())
 			return put_user(omap_prcm_get_reset_sources(),
 					(int __user *)arg);
+#endif
 		return put_user(0, (int __user *)arg);
 	case WDIOC_KEEPALIVE:
 		spin_lock(&wdt_lock);
diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 9d93793..45909ca 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -31,10 +31,6 @@
 #include <sound/soc.h>
 #include <sound/jack.h>
 
-#include <asm/mach-types.h>
-#include <plat/hardware.h>
-#include <plat/mux.h>
-
 #include "omap-dmic.h"
 #include "omap-mcpdm.h"
 #include "omap-pcm.h"
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 2c66e24..ea053c3 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -45,6 +45,8 @@
 #include "omap-mcpdm.h"
 #include "omap-pcm.h"
 
+#define OMAP44XX_MCPDM_L3_BASE		0x49032000
+
 struct omap_mcpdm {
 	struct device *dev;
 	unsigned long phys_base;

