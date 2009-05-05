From: Kim Kyuwon <q1.kim@samsung.com>
Subject: OMAP3: PM: Add the wakeup source driver, v4
Date: Tue, 05 May 2009 18:13:18 +0900
Message-ID: <4A00032E.8060307@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:28880 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbZEEJN3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 May 2009 05:13:29 -0400
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KJ5000L5YY630@mailout1.samsung.com> for
 linux-omap@vger.kernel.org; Tue, 05 May 2009 18:13:19 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KJ500H1EYY7G2@mmp2.samsung.com> for
 linux-omap@vger.kernel.org; Tue, 05 May 2009 18:13:19 +0900 (KST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Kyungmin Park <kyungmin.park@samsung.com>, Paul Walmsley <paul@pwsan.com>

Sometimes, it is necessary to find out "what does wake up my board from suspend?". Notifying wake-up source feature may be used to blame unexpected wake-up events which increase power consumption. And user mode applications can act smartly according to the wake-up event from Suspend-to-RAM state to minimize power consumption. Note that this driver can't inform wake-up events from idle state. This driver uses sysfs interface to give information to user mode applications like:

cat /sys/power/omap_resume_irq
cat /sys/power/omap_resume_event

This driver also provides the I/O pad wake-up source configuration. Specific GPIO settings in the board file are:

/* I/O pad wakeup source configuration */
static struct iopad_wake boardname_iopad_wake[] = {
	{
		.mux_index	= AE7_34XX_GPIO24,
		.alias		= "KEY_PWRON",
	},
	{
		.mux_index	= ETK_D9_GPIO23,
		.alias		= "USB_DETECT",
	},
};

static struct omap_wake_platform_data boardname_wake_data = {
	.iopad_wakes		= boardname_iopad_wake,
	.iopad_wake_num		= ARRAY_SIZE(boardname_iopad_wake),
};

static struct platform_device boardname_wakeup = {
	.name			= "omap-wake",
	.id			= -1,
	.dev			= {
		.platform_data	= &boardname_wake_data,
	},
};

The patch adds Kconfig options "OMAP34xx wakeup source support" under "System type"->"TI OMAP implementations" menu.

Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
---
 arch/arm/mach-omap2/Makefile              |    1 +
 arch/arm/mach-omap2/irq.c                 |   21 ++-
 arch/arm/mach-omap2/omapdev-common.h      |    3 +
 arch/arm/mach-omap2/omapdev3xxx.h         |   63 +++++
 arch/arm/mach-omap2/pm34xx.c              |   13 +
 arch/arm/mach-omap2/prcm-common.h         |    4 +
 arch/arm/mach-omap2/prm-regbits-34xx.h    |    5 +
 arch/arm/mach-omap2/wake34xx.c            |  409 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/Kconfig                |    9 +
 arch/arm/plat-omap/include/mach/irqs.h    |    4 +
 arch/arm/plat-omap/include/mach/mux.h     |    3 +
 arch/arm/plat-omap/include/mach/omapdev.h |    3 +
 arch/arm/plat-omap/include/mach/wake.h    |   52 ++++
 arch/arm/plat-omap/mux.c                  |   25 ++-
 14 files changed, 605 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/mach-omap2/wake34xx.c
 create mode 100644 arch/arm/plat-omap/include/mach/wake.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index c58bab4..cfc5a13 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP24XX)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
+obj-$(CONFIG_OMAP3_WAKE)		+= wake34xx.o
 endif
 
 # SmartReflex driver
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 700fc3d..18ac725 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -33,9 +33,6 @@
 #define INTC_MIR_SET0		0x008c
 #define INTC_PENDING_IRQ0	0x0098
 
-/* Number of IRQ state bits in each MIR register */
-#define IRQ_BITS_PER_REG	32
-
 /*
  * OMAP2 has a number of different interrupt controllers, each interrupt
  * controller is identified as its own "bank". Register definitions are
@@ -193,6 +190,24 @@ int omap_irq_pending(void)
 	return 0;
 }
 
+void omap_get_pending_irqs(u32 *pending_irqs, unsigned len)
+{
+	int i, j = 0;
+
+	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
+		struct omap_irq_bank *bank = irq_banks + i;
+		int irq;
+
+		for (irq = 0; irq < bank->nr_irqs && j < len;
+						irq += IRQ_BITS_PER_REG) {
+			int offset = irq & (~(IRQ_BITS_PER_REG - 1));
+
+			pending_irqs[j++] = intc_bank_read_reg(bank,
+					(INTC_PENDING_IRQ0 + offset));
+		}
+	}
+}
+
 void __init omap_init_irq(void)
 {
 	unsigned long nr_of_irqs = 0;
diff --git a/arch/arm/mach-omap2/omapdev-common.h b/arch/arm/mach-omap2/omapdev-common.h
index a2d4855..57b9b0b 100644
--- a/arch/arm/mach-omap2/omapdev-common.h
+++ b/arch/arm/mach-omap2/omapdev-common.h
@@ -228,10 +228,13 @@ static struct omapdev *omapdevs[] = {
 	&hsmmc2_3xxx_omapdev,
 	&mcspi3_3xxx_omapdev,
 	&gptimer1_3xxx_omapdev,
+	&gptimer12_3xxx_omapdev,
 	&prm_3xxx_omapdev,
 	&cm_3xxx_omapdev,
 	&omap_32ksynct_3xxx_omapdev,
 	&gpio1_3xxx_omapdev,
+	&io_3xxx_omapdev,
+	&io_chain_3xxx_omapdev,
 	&wdtimer2_3xxx_omapdev,
 	&wdtimer1_3xxx_omapdev,
 	&rng_3xxx_omapdev,
diff --git a/arch/arm/mach-omap2/omapdev3xxx.h b/arch/arm/mach-omap2/omapdev3xxx.h
index dce87df..9091a88 100644
--- a/arch/arm/mach-omap2/omapdev3xxx.h
+++ b/arch/arm/mach-omap2/omapdev3xxx.h
@@ -19,6 +19,8 @@
 #include <mach/cpu.h>
 #include <mach/omapdev.h>
 
+#include "prm-regbits-34xx.h"
+
 #ifdef CONFIG_ARCH_OMAP3
 
 /* 3xxx data from the 34xx ES2 TRM Rev F */
@@ -146,6 +148,7 @@ static struct omapdev sdma_3xxx_omapdev = {
 static struct omapdev i2c1_3xxx_omapdev = {
 	.name		= "i2c1_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_I2C1_MASK,
 	.pdev_name	= "i2c_omap",
 	.pdev_id	= 1,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -154,6 +157,7 @@ static struct omapdev i2c1_3xxx_omapdev = {
 static struct omapdev i2c2_3xxx_omapdev = {
 	.name		= "i2c2_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_I2C2_MASK,
 	.pdev_name	= "i2c_omap",
 	.pdev_id	= 2,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -162,6 +166,7 @@ static struct omapdev i2c2_3xxx_omapdev = {
 static struct omapdev uart1_3xxx_omapdev = {
 	.name		= "uart1_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_UART1_MASK,
 	.pdev_name	= "serial8250",
 	.pdev_id	= PLAT8250_DEV_PLATFORM,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -170,6 +175,7 @@ static struct omapdev uart1_3xxx_omapdev = {
 static struct omapdev uart2_3xxx_omapdev = {
 	.name		= "uart2_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_UART2_MASK,
 	.pdev_name	= "serial8250",
 	.pdev_id	= PLAT8250_DEV_PLATFORM,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -178,6 +184,7 @@ static struct omapdev uart2_3xxx_omapdev = {
 static struct omapdev mcbsp1_3xxx_omapdev = {
 	.name		= "mcbsp1_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_MCBSP1_MASK,
 	.pdev_name	= "omap-mcbsp",
 	.pdev_id	= 1,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -186,12 +193,14 @@ static struct omapdev mcbsp1_3xxx_omapdev = {
 static struct omapdev gptimer10_3xxx_omapdev = {
 	.name		= "gptimer10_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_GPT10_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static struct omapdev gptimer11_3xxx_omapdev = {
 	.name		= "gptimer11_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_GPT11_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
@@ -206,6 +215,7 @@ static struct omapdev mailbox_3xxx_omapdev = {
 static struct omapdev mcspi1_3xxx_omapdev = {
 	.name		= "mcspi1_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_MCSPI1_MASK,
 	.pdev_name	= "omap2_mcspi",
 	.pdev_id	= 1,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -214,6 +224,7 @@ static struct omapdev mcspi1_3xxx_omapdev = {
 static struct omapdev mcspi2_3xxx_omapdev = {
 	.name		= "mcspi2_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_MCSPI2_MASK,
 	.pdev_name	= "omap2_mcspi",
 	.pdev_id	= 2,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -242,6 +253,7 @@ static struct omapdev mspro_3xxx_omapdev = {
 static struct omapdev mcbsp5_3xxx_omapdev = {
 	.name		= "mcbsp5_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_MCBSP5_MASK,
 	.pdev_name	= "omap-mcbsp",
 	.pdev_id	= 5,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -250,6 +262,7 @@ static struct omapdev mcbsp5_3xxx_omapdev = {
 static struct omapdev hsmmc1_3xxx_omapdev = {
 	.name		= "hsmmc1_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_MMC1_MASK,
 	.pdev_name	= "mmci-omap",
 	.pdev_id	= 0,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -258,6 +271,7 @@ static struct omapdev hsmmc1_3xxx_omapdev = {
 static struct omapdev hsmmc2_3xxx_omapdev = {
 	.name		= "hsmmc2_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_MMC2_MASK,
 	.pdev_name	= "mmci-omap",
 	.pdev_id	= 1,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -266,6 +280,7 @@ static struct omapdev hsmmc2_3xxx_omapdev = {
 static struct omapdev mcspi3_3xxx_omapdev = {
 	.name		= "mcspi3_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_MCSPI3_MASK,
 	.pdev_name	= "omap2_mcspi",
 	.pdev_id	= 3,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -278,6 +293,14 @@ static struct omapdev mcspi3_3xxx_omapdev = {
 static struct omapdev gptimer1_3xxx_omapdev = {
 	.name		= "gptimer1_omapdev",
 	.pwrdm		= { .name = "wkup_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_GPT1_MASK,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct omapdev gptimer12_3xxx_omapdev = {
+	.name		= "gptimer12_omapdev",
+	.pwrdm		= { .name = "wkup_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_GPT12_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
@@ -302,9 +325,24 @@ static struct omapdev omap_32ksynct_3xxx_omapdev = {
 static struct omapdev gpio1_3xxx_omapdev = {
 	.name		= "gpio1_omapdev",
 	.pwrdm		= { .name = "wkup_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_GPIO1_MASK,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct omapdev io_3xxx_omapdev = {
+	.name		= "io_omapdev",
+	.pwrdm		= { .name = "wkup_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_IO,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+static struct omapdev io_chain_3xxx_omapdev = {
+	.name		= "io_chain_omapdev",
+	.pwrdm		= { .name = "wkup_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_IO_CHAIN,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES3_1),
+};
+
 /* aka the "omap wdtimer" on 2430 or the "mpu wdtimer" on 3430 */
 static struct omapdev wdtimer2_3xxx_omapdev = {
 	.name		= "wdtimer2_omapdev",
@@ -425,6 +463,7 @@ static struct omapdev control_3xxx_omapdev = {
 static struct omapdev i2c3_3xxx_omapdev = {
 	.name		= "i2c3_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_I2C3_MASK,
 	.pdev_name	= "i2c_omap",
 	.pdev_id	= 3,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -433,6 +472,7 @@ static struct omapdev i2c3_3xxx_omapdev = {
 static struct omapdev hsmmc3_3xxx_omapdev = {
 	.name		= "hsmmc3_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.wkst_mask	= OMAP3430ES2_ST_MMC3_MASK,
 	.pdev_name	= "mmci-omap",
 	.pdev_id	= 2,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
@@ -441,6 +481,7 @@ static struct omapdev hsmmc3_3xxx_omapdev = {
 static struct omapdev mcspi4_3xxx_omapdev = {
 	.name		= "mcspi4_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_MCSPI4_MASK,
 	.pdev_name	= "omap2_mcspi",
 	.pdev_id	= 4,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -461,12 +502,14 @@ static struct omapdev sr2_3xxx_omapdev = {
 static struct omapdev usbhost_es1_3xxx_omapdev = {
 	.name		= "usbhost_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.wkst_mask	= OMAP3430ES1_ST_FSHOSTUSB_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
 };
 
 static struct omapdev usbotg_es1_3xxx_omapdev = {
 	.name		= "usbotg_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.wkst_mask	= OMAP3430ES1_ST_HSOTGUSB_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
 };
 
@@ -475,6 +518,7 @@ static struct omapdev usbotg_es1_3xxx_omapdev = {
 static struct omapdev uart3_3xxx_omapdev = {
 	.name		= "uart3_omapdev",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_UART3_MASK,
 	.pdev_name	= "serial8250",
 	.pdev_id	= PLAT8250_DEV_PLATFORM,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -483,6 +527,7 @@ static struct omapdev uart3_3xxx_omapdev = {
 static struct omapdev mcbsp2_3xxx_omapdev = {
 	.name		= "mcbsp2_omapdev",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.wkst_mask	= OMAP3430_EN_MCBSP2,
 	.pdev_name	= "omap-mcbsp",
 	.pdev_id	= 2,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -491,6 +536,7 @@ static struct omapdev mcbsp2_3xxx_omapdev = {
 static struct omapdev mcbsp3_3xxx_omapdev = {
 	.name		= "mcbsp3_omapdev",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.wkst_mask	= OMAP3430_EN_MCBSP3,
 	.pdev_name	= "omap-mcbsp",
 	.pdev_id	= 3,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -499,6 +545,7 @@ static struct omapdev mcbsp3_3xxx_omapdev = {
 static struct omapdev mcbsp4_3xxx_omapdev = {
 	.name		= "mcbsp4_omapdev",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.wkst_mask	= OMAP3430_EN_MCBSP4,
 	.pdev_name	= "omap-mcbsp",
 	.pdev_id	= 3,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -527,78 +574,91 @@ static struct omapdev wdtimer3_3xxx_omapdev = {
 static struct omapdev gptimer2_3xxx_omapdev = {
 	.name		= "gptimer2_omapdev",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_GPT2_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static struct omapdev gptimer3_3xxx_omapdev = {
 	.name		= "gptimer3_omapdev",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_GPT3_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static struct omapdev gptimer4_3xxx_omapdev = {
 	.name		= "gptimer4_omapdev",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_GPT4_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static struct omapdev gptimer5_3xxx_omapdev = {
 	.name		= "gptimer5_omapdev",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_GPT5_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static struct omapdev gptimer6_3xxx_omapdev = {
 	.name		= "gptimer6_omapdev",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_GPT6_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static struct omapdev gptimer7_3xxx_omapdev = {
 	.name		= "gptimer7_omapdev",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_GPT7_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static struct omapdev gptimer8_3xxx_omapdev = {
 	.name		= "gptimer8_omapdev",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_GPT8_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static struct omapdev gptimer9_3xxx_omapdev = {
 	.name		= "gptimer9_omapdev",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_GPT9_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static struct omapdev gpio2_3xxx_omapdev = {
 	.name		= "gpio2_omapdev",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_GPIO2_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static struct omapdev gpio3_3xxx_omapdev = {
 	.name		= "gpio3_omapdev",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_GPIO3_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static struct omapdev gpio4_3xxx_omapdev = {
 	.name		= "gpio4_omapdev",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_GPIO4_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static struct omapdev gpio5_3xxx_omapdev = {
 	.name		= "gpio5_omapdev",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_GPIO5_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static struct omapdev gpio6_3xxx_omapdev = {
 	.name		= "gpio6_omapdev",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.wkst_mask	= OMAP3430_ST_GPIO6_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
@@ -656,6 +716,7 @@ static struct omapdev dap_3xxx_omapdev = {
 static struct omapdev usbhost_3xxx_omapdev = {
 	.name		= "usbhost_omapdev",
 	.pwrdm		= { .name = "usbhost_pwrdm" },
+	.wkst_mask	= OMAP3430ES2_ST_USBHOST,
 	.pdev_name	= "ehci-omap",
 	.pdev_id	= 0,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
@@ -664,6 +725,7 @@ static struct omapdev usbhost_3xxx_omapdev = {
 static struct omapdev usbotg_3xxx_omapdev = {
 	.name		= "usbotg_omapdev",
 	.pwrdm		= { .name = "usbhost_pwrdm" },
+	.wkst_mask	= OMAP3430ES2_ST_HSOTGUSB_STDBY_MASK,
 	.pdev_name	= "musb_hdrc",
 	.pdev_id	= -1,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
@@ -672,6 +734,7 @@ static struct omapdev usbotg_3xxx_omapdev = {
 static struct omapdev usbtll_3xxx_omapdev = {
 	.name		= "usbtll_omapdev",
 	.pwrdm		= { .name = "usbhost_pwrdm" },
+	.wkst_mask	= OMAP3430ES2_ST_USBTLL_MASK,
 	.pdev_name	= "ehci-omap",
 	.pdev_id	= 0,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7a561db..2832e08 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -42,6 +42,7 @@
 #include <mach/dma.h>
 #include <mach/gpmc.h>
 #include <mach/dma.h>
+#include <mach/wake.h>
 #include <asm/tlbflush.h>
 
 #include "cm.h"
@@ -93,6 +94,13 @@ static struct prm_setup_times prm_setup = {
 	.voltsetup2 = 0xff,
 };
 
+static struct pm_wakeup_status omap3_pm_wkst;
+
+void omap3_get_last_wakeup_state(struct pm_wakeup_status *pm_wkst)
+{
+	*pm_wkst = omap3_pm_wkst;
+}
+
 static inline void omap3_per_save_context(void)
 {
 	omap3_gpio_save_context();
@@ -202,6 +210,7 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 
 	/* WKUP */
 	wkst = prm_read_mod_reg(WKUP_MOD, PM_WKST);
+	omap3_pm_wkst.wkup = wkst;
 	if (wkst) {
 		iclk = cm_read_mod_reg(WKUP_MOD, CM_ICLKEN);
 		fclk = cm_read_mod_reg(WKUP_MOD, CM_FCLKEN);
@@ -215,6 +224,7 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 
 	/* CORE */
 	wkst = prm_read_mod_reg(CORE_MOD, PM_WKST1);
+	omap3_pm_wkst.core1 = wkst;
 	if (wkst) {
 		iclk = cm_read_mod_reg(CORE_MOD, CM_ICLKEN1);
 		fclk = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
@@ -226,6 +236,7 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 		cm_write_mod_reg(fclk, CORE_MOD, CM_FCLKEN1);
 	}
 	wkst = prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_WKST3);
+	omap3_pm_wkst.core3 = wkst;
 	if (wkst) {
 		iclk = cm_read_mod_reg(CORE_MOD, CM_ICLKEN3);
 		fclk = cm_read_mod_reg(CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
@@ -239,6 +250,7 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 
 	/* PER */
 	wkst = prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKST);
+	omap3_pm_wkst.per = wkst;
 	if (wkst) {
 		iclk = cm_read_mod_reg(OMAP3430_PER_MOD, CM_ICLKEN);
 		fclk = cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN);
@@ -253,6 +265,7 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 	if (omap_rev() > OMAP3430_REV_ES1_0) {
 		/* USBHOST */
 		wkst = prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, PM_WKST);
+		omap3_pm_wkst.usbhost = wkst;
 		if (wkst) {
 			iclk = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
 					       CM_ICLKEN);
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index cb1ae84..8ccadcc 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -273,6 +273,10 @@
 #define OMAP3430_ST_D2D_SHIFT				3
 #define OMAP3430_ST_D2D_MASK				(1 << 3)
 
+/* PM_WKST3_CORE, CM_IDLEST3_CORE shared bits */
+#define OMAP3430ES2_ST_USBTLL_SHIFT			2
+#define OMAP3430ES2_ST_USBTLL_MASK				(1 << 2)
+
 /* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
 #define OMAP3430_EN_GPIO1				(1 << 3)
 #define OMAP3430_EN_GPIO1_SHIFT				3
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index 06fee29..6826bf0 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -332,6 +332,8 @@
 /* PM_IVA2GRPSEL1_CORE specific bits */
 
 /* PM_WKST1_CORE specific bits */
+#define OMAP3430ES2_ST_MMC3_SHIFT				30
+#define OMAP3430ES2_ST_MMC3_MASK				(1 << 30)
 
 /* PM_PWSTCTRL_CORE specific bits */
 #define OMAP3430_MEM2ONSTATE_SHIFT			18
@@ -432,6 +434,9 @@
 
 /* PM_PREPWSTST_PER specific bits */
 
+/* PM_WKST_USBHOST specific bits */
+#define OMAP3430ES2_ST_USBHOST				(1 << 0)
+
 /* RM_RSTST_EMU specific bits */
 
 /* PM_PWSTST_EMU specific bits */
diff --git a/arch/arm/mach-omap2/wake34xx.c b/arch/arm/mach-omap2/wake34xx.c
new file mode 100644
index 0000000..52938d8
--- /dev/null
+++ b/arch/arm/mach-omap2/wake34xx.c
@@ -0,0 +1,409 @@
+/*
+ * wake34xx.c
+ *
+ * Copyright (c) 2009 Samsung Eletronics
+ *
+ * Author: Kim Kyuwon <q1.kim@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+
+#include <mach/pm.h>
+#include <mach/mux.h>
+#include <mach/control.h>
+#include <mach/wake.h>
+
+#include "prm-regbits-34xx.h"
+#include "omapdev-common.h"
+
+/*
+ * Sometimes, it is necessary to find out "what does wake up my board from
+ * suspend?". Notifying wake-up source feature may be used to blame
+ * unexpected wake-up events which increase power consumption. And user
+ * mode applications can act smartly according to the wake-up event from
+ * Suspend-to-RAM state to minimize power consumption. Note that this
+ * driver can't inform wake-up events from idle state. This driver uses
+ * sysfs interface to give information to user mode applications.
+ */
+
+#define WAKE_STR_LEN		128
+#define WAKE_BUF_LEN		64
+
+struct omap_wake {
+	u32				pending_irqs[INTCPS_NR_MIR_REGS];
+
+	struct omap_wake_platform_data	*pdata;
+	struct pm_wakeup_status		pm_wkst;
+};
+
+/* Note: Allowed to use Only in the wakeup_source_show() function */
+static struct omap_wake *g_wake;
+
+static ssize_t wakeup_source_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf);
+
+/*
+ * Get the first pending MPU IRQ number from 'irq_start'.
+ * If none, return -EINVAL.
+ */
+static int omap3_wake_get_pending_irq(struct omap_wake *wake,
+						unsigned int irq_start)
+{
+	int i, bits_skip, idx_start;
+
+	if (irq_start >= INTCPS_NR_IRQS)
+		return -EINVAL;
+
+	bits_skip = irq_start % IRQ_BITS_PER_REG;
+	idx_start = irq_start / IRQ_BITS_PER_REG;
+
+	for (i = idx_start; i < ARRAY_SIZE(wake->pending_irqs); i++) {
+		unsigned long val, bit;
+
+		val = wake->pending_irqs[i];
+		if (!val)
+			continue;
+
+		if (idx_start == i)
+			bit = find_next_bit(&val, IRQ_BITS_PER_REG, bits_skip);
+		else
+			bit = find_first_bit(&val, IRQ_BITS_PER_REG);
+
+		if (bit < IRQ_BITS_PER_REG)
+			return i * IRQ_BITS_PER_REG + bit;
+	}
+
+	return -EINVAL;
+}
+
+static void omap3_wake_strncat(char *dest, char *src, size_t count)
+{
+	int len;
+
+	if (!src[0])
+		return;
+
+	if (dest[0])
+		len = strlen(dest) + strlen(src) + 2;
+	else
+		len = strlen(dest) + strlen(src);
+
+	if (len > count) {
+		pr_err("Can't strncat: %s\n", src);
+		return;
+	}
+
+	if (dest[0])
+		strcat(dest, ", ");
+	strcat(dest, src);
+}
+
+static u32 omap3_wake_get_domain_wkst(struct omap_wake *wake,
+						struct omapdev *omap3_dev)
+{
+	struct pm_wakeup_status	*pm_wkst = &wake->pm_wkst;
+	const char *pwrdm_name = omap3_dev->pwrdm.name;
+
+	if (!strcmp(pwrdm_name, "wkup_pwrdm")) {
+		return pm_wkst->wkup;
+	} else if (!strcmp(pwrdm_name, "per_pwrdm")) {
+		return pm_wkst->per;
+	} else if (!strcmp(pwrdm_name, "core_pwrdm")) {
+		return pm_wkst->core1;
+	} else if (!strcmp(pwrdm_name, "usbhost_pwrdm")) {
+		if (!strcmp(omap3_dev->name, "usbtll_omapdev"))
+			return pm_wkst->core3;
+		else if (!strcmp(omap3_dev->name, "usbhost_omapdev"))
+			return pm_wkst->usbhost;
+	}
+
+	return -EINVAL;
+}
+
+static void omap3_wake_lookup_wkst(struct omap_wake *wake,
+					char *wake_event, size_t count)
+{
+	struct omapdev **d;
+
+	for (d = omapdevs; *d; d++) {
+		u32 wkst;
+
+		if (!omap_chip_is((*d)->omap_chip))
+			continue;
+
+		wkst = omap3_wake_get_domain_wkst(wake, *d);
+		if (wkst <= 0)
+			continue;
+
+		if (wkst & (*d)->wkst_mask)
+			omap3_wake_strncat(wake_event,
+						(char *)(*d)->name, count);
+	}
+}
+
+static void omap3_wake_lookup_iopad(struct omap_wake *wake,
+					char *wake_event, size_t count)
+{
+	struct omap_wake_platform_data *pdata = wake->pdata;
+	int i;
+
+	for (i = 0; pdata && i < pdata->iopad_wake_num; i++) {
+		struct iopad_wake *iopad = pdata->iopad_wakes + i;
+		char *wksrc_iopad;
+
+		if (!iopad->is_wake_source)
+			continue;
+
+		if (iopad->alias) {
+			wksrc_iopad = (char *)iopad->alias;
+		} else {
+			struct pin_config *cfg = NULL;
+			int err;
+
+			err = omap_get_pin_config(iopad->mux_index, &cfg);
+			if (err || !cfg)
+				continue;
+
+			wksrc_iopad = cfg->name;
+		}
+
+		omap3_wake_strncat(wake_event, wksrc_iopad, count);
+	}
+}
+
+static void omap3_wake_dump_wksrc(struct omap_wake *wake,
+					char *wake_irq, char *wake_event,
+					size_t irq_size, size_t event_size)
+{
+	int irq, prcm_irq = 0;
+
+	/* IRQ */
+	irq = omap3_wake_get_pending_irq(wake, 0);
+	while (irq >= 0) {
+		char buf[WAKE_BUF_LEN] = {0, };
+		int len;
+
+		if (irq == INT_34XX_SYS_NIRQ)
+			omap3_wake_strncat(wake_event, "sys_nirq",
+							event_size - 1);
+		else if (irq == INT_34XX_PRCM_MPU_IRQ)
+			prcm_irq = 1;
+
+		len = strlen(wake_irq) +
+			snprintf(buf, WAKE_BUF_LEN, "%d", irq);
+		if (len > irq_size - 1)
+			break;
+
+		strcat(wake_irq, buf);
+
+		irq = omap3_wake_get_pending_irq(wake, irq + 1);
+		if (irq >= 0) {
+			len = strlen(wake_irq) + 2;
+			if (len > irq_size - 1)
+				break;
+
+			strcat(wake_irq, ", ");
+		}
+	}
+
+	if (prcm_irq) {
+		omap3_wake_lookup_wkst(wake, wake_event, event_size - 1);
+		if (strstr(wake_event, io_3xxx_omapdev.name)) {
+			omap3_wake_lookup_iopad(wake, wake_event,
+							event_size - 1);
+		}
+	}
+
+	if (!wake_irq[0])
+		strncpy(wake_irq, "Unknown", irq_size - 1);
+
+	if (!wake_event[0])
+		strncpy(wake_event, "Unknown", event_size - 1);
+}
+
+static struct kobj_attribute wakeup_irq_attr =
+	__ATTR(omap_resume_irq, 0644, wakeup_source_show, NULL);
+
+static struct kobj_attribute wakeup_event_attr =
+	__ATTR(omap_resume_event, 0644, wakeup_source_show, NULL);
+
+static ssize_t wakeup_source_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	char wakeup_irq[WAKE_STR_LEN] = {0, };
+	char wakeup_event[WAKE_STR_LEN] = {0, };
+
+	if (!g_wake)
+		return -EINVAL;
+
+	omap3_wake_dump_wksrc(g_wake, wakeup_irq, wakeup_event,
+				sizeof(wakeup_irq), sizeof(wakeup_event));
+
+	if (attr == &wakeup_irq_attr)
+		return sprintf(buf, "%s\n", wakeup_irq);
+	else if (attr == &wakeup_event_attr)
+		return sprintf(buf, "%s\n", wakeup_event);
+	else
+		return -EINVAL;
+}
+
+static int __devinit omap3_wake_probe(struct platform_device *pdev)
+{
+	struct omap_wake *wake;
+	int ret;
+
+	wake = kzalloc(sizeof(struct omap_wake), GFP_KERNEL);
+	if (wake == NULL) {
+		dev_err(&pdev->dev, "failed to allocate driver data\n");
+		return -ENOMEM;
+	}
+
+	wake->pdata = pdev->dev.platform_data;
+	platform_set_drvdata(pdev, wake);
+
+	/*
+	 * In wakeup_source_show(), we can't access platform_device
+	 * or omap_wake structure without a global variable. so 'g_wake' is
+	 * needed, but please use it carefully.
+	 */
+	g_wake = wake;
+
+	ret = sysfs_create_file(power_kobj, &wakeup_irq_attr.attr);
+	if (ret)
+		dev_err(&pdev->dev, "sysfs_create_file %s failed: %d\n",
+					wakeup_irq_attr.attr.name, ret);
+
+	ret = sysfs_create_file(power_kobj, &wakeup_event_attr.attr);
+	if (ret)
+		dev_err(&pdev->dev, "sysfs_create_file %s failed: %d\n",
+					wakeup_event_attr.attr.name, ret);
+
+	return 0;
+}
+
+static int __devexit omap3_wake_remove(struct platform_device *pdev)
+{
+	struct omap_wake *wake = platform_get_drvdata(pdev);
+
+	kfree(wake);
+	g_wake = NULL;
+
+	return 0;
+}
+
+static int omap3_wake_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct omap_wake_platform_data *pdata = pdev->dev.platform_data;
+	int i;
+
+	/*
+	 * Whenever the system enters suspend, set WAKEUPENABLE bits again.
+	 * Because the omap_cfg_reg() function could clear WAKEUPENABLE bits
+	 * at runtime.
+	 */
+	for (i = 0; pdata && i < pdata->iopad_wake_num; i++) {
+		struct iopad_wake *iopad = pdata->iopad_wakes + i;
+		struct pin_config *cfg = NULL;
+		int err;
+		u16 v;
+
+		err = omap_get_pin_config(iopad->mux_index, &cfg);
+		if (err || !cfg)
+			continue;
+
+		v = omap_ctrl_readw(cfg->mux_reg);
+		v |= OMAP3_PADCONF_WAKEUPENABLE0;
+		omap_ctrl_writew(v, cfg->mux_reg);
+
+		/* Reset previsous wake-up event information of each pin */
+		iopad->is_wake_source = false;
+	}
+
+	return 0;
+}
+
+static int omap3_wake_resume_early(struct platform_device *pdev)
+{
+	struct omap_wake *wake = platform_get_drvdata(pdev);
+	struct omap_wake_platform_data *pdata = wake->pdata;
+	int i;
+
+	omap_get_pending_irqs(wake->pending_irqs,
+					ARRAY_SIZE(wake->pending_irqs));
+
+	for (i = 0; pdata && i < pdata->iopad_wake_num; i++) {
+		struct iopad_wake *iopad = pdata->iopad_wakes + i;
+		struct pin_config *cfg = NULL;
+		int err;
+		u16 v;
+
+		err = omap_get_pin_config(iopad->mux_index, &cfg);
+		if (err || !cfg)
+			continue;
+
+		v = omap_ctrl_readw(cfg->mux_reg);
+		v &= ~OMAP3_PADCONF_WAKEUPENABLE0;
+		omap_ctrl_writew(v, cfg->mux_reg);
+
+		if (v & OMAP3_PADCONF_WAKEUPEVENT0)
+			iopad->is_wake_source = true;
+	}
+
+	return 0;
+}
+
+static int omap3_wake_resume(struct platform_device *pdev)
+{
+	struct omap_wake *wake = platform_get_drvdata(pdev);
+
+#ifdef CONFIG_PM_DEBUG
+	char wakeup_irq[WAKE_STR_LEN] = {0, };
+	char wakeup_event[WAKE_STR_LEN] = {0, };
+
+	omap3_wake_dump_wksrc(wake, wakeup_irq, wakeup_event,
+				sizeof(wakeup_irq), sizeof(wakeup_event));
+
+	pr_info("OMAP resume IRQ: %s\n", wakeup_irq);
+	pr_info("OMAP resume event: %s\n", wakeup_event);
+#endif
+
+	omap3_get_last_wakeup_state(&wake->pm_wkst);
+
+	return 0;
+}
+
+static struct platform_driver omap3_wake_driver = {
+	.probe          = omap3_wake_probe,
+	.remove		= __devexit_p(omap3_wake_remove),
+	.suspend	= omap3_wake_suspend,
+	.resume_early	= omap3_wake_resume_early,
+	.resume		= omap3_wake_resume,
+	.driver         = {
+		.name   = "omap-wake",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init omap3_wake_init(void)
+{
+	return platform_driver_register(&omap3_wake_driver);
+}
+late_initcall(omap3_wake_init);
+
+static void __exit omap3_wake_exit(void)
+{
+	platform_driver_unregister(&omap3_wake_driver);
+}
+module_exit(omap3_wake_exit);
+
+MODULE_AUTHOR("Kim Kyuwon <q1.kim@samsung.com>");
+MODULE_DESCRIPTION("OMAP34xx wakeup source driver");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index a2d15a1..24eb6c1 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -236,6 +236,15 @@ config OMAP_DM_TIMER
 	help
 	 Select this option if you want to use OMAP Dual-Mode timers.
 
+config OMAP3_WAKE
+	tristate "OMAP34xx wakeup source support"
+	depends on ARCH_OMAP34XX && PM
+	default n
+	help
+	  Select this option if you want to know what kind of wake-up event
+	  wakes up your board from suspend. This driver also privides the
+	  I/O pad wake-up source configuration.
+
 choice
 	prompt "Low-level debug console UART"
 	depends on ARCH_OMAP
diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
index c9a5b19..ee15402 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -385,9 +385,13 @@
 #define INTCPS_NR_MIR_REGS	3
 #define INTCPS_NR_IRQS		96
 
+/* Number of IRQ state bits in each MIR register */
+#define IRQ_BITS_PER_REG	32
+
 #ifndef __ASSEMBLY__
 extern void omap_init_irq(void);
 extern int omap_irq_pending(void);
+extern void omap_get_pending_irqs(u32 *pending_irqs, unsigned len);
 void omap3_intc_save_context(void);
 void omap3_intc_restore_context(void);
 #endif
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index f7e298a..f6cb7b1 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -816,11 +816,14 @@ struct omap_mux_cfg {
 extern int omap1_mux_init(void);
 extern int omap2_mux_init(void);
 extern int omap_mux_register(struct omap_mux_cfg *);
+extern int omap_get_pin_config(unsigned long index, struct pin_config **cfg);
 extern int omap_cfg_reg(unsigned long reg_cfg);
 #else
 /* boot loader does it all (no warnings from CONFIG_OMAP_MUX_WARNINGS) */
 static inline int omap1_mux_init(void) { return 0; }
 static inline int omap2_mux_init(void) { return 0; }
+static inline int omap_get_pin_config(unsigned long index,
+				struct pin_config **cfg) { return 0; }
 static inline int omap_cfg_reg(unsigned long reg_cfg) { return 0; }
 #endif
 
diff --git a/arch/arm/plat-omap/include/mach/omapdev.h b/arch/arm/plat-omap/include/mach/omapdev.h
index 4b379bc..2359073 100644
--- a/arch/arm/plat-omap/include/mach/omapdev.h
+++ b/arch/arm/plat-omap/include/mach/omapdev.h
@@ -24,6 +24,7 @@
  * struct omapdev - OMAP on-chip hardware devices
  * @name: name of the device - should match TRM
  * @pwrdm: powerdomain that the device resides in
+ * @wkst_mask: wake-up state bit in PM_WKST_<domain> associated with pwrdm
  * @omap_chip: OMAP chips this omapdev is valid for
  * @pdev_name: platform_device name associated with this omapdev (if any)
  * @pdev_id: platform_device id associated with this omapdev (if any)
@@ -38,6 +39,8 @@ struct omapdev {
 		struct powerdomain *ptr;
 	} pwrdm;
 
+	const u32 wkst_mask;
+
 	const struct omap_chip_id omap_chip;
 
 	const char *pdev_name;
diff --git a/arch/arm/plat-omap/include/mach/wake.h b/arch/arm/plat-omap/include/mach/wake.h
new file mode 100644
index 0000000..5b725e3
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/wake.h
@@ -0,0 +1,52 @@
+/*
+ * wake.h
+ *
+ * Copyright (c) 2009 Samsung Eletronics
+ *
+ * Author: Kim Kyuwon <q1.kim@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef _WAKE_H_
+#define _WAKE_H_
+
+/*
+ * struct iopad_wake - used to enable each I/O pad of the device
+ * to wake up the system and detect wake-up events of each I/O pad.
+ *
+ * The mux layer (mux.c/h files) doesn't have resume hook, so checking
+ * WAKEUPEVENT in the CONTROL_PADCONF_X register before being cleared by
+ * PRCM IRQ would be difficult in the mux layer. Thus, this wake source
+ * driver takes charge of Wake-Up Event Detection Scheme
+ *
+ * @mux_index: enumeration index of omapxxxx_index in mux.h
+ * @alias: descriptive name of each pin (optional)
+ * @is_wake_source: automatically set by suspend & resume hooks
+ */
+struct iopad_wake {
+	const u32	mux_index;
+	const char	*alias;
+	bool		is_wake_source;
+};
+
+struct omap_wake_platform_data{
+	struct iopad_wake	*iopad_wakes;
+	int			iopad_wake_num;
+};
+
+struct pm_wakeup_status {
+	u32	wkup;
+	u32	per;
+	u32	core1;
+	u32	core3;
+	u32	usbhost;
+};
+
+void omap3_get_last_wakeup_state(struct pm_wakeup_status *pm_wkst);
+
+#endif /* _WAKE_H_ */
+
diff --git a/arch/arm/plat-omap/mux.c b/arch/arm/plat-omap/mux.c
index 80b040f..6bf321b 100644
--- a/arch/arm/plat-omap/mux.c
+++ b/arch/arm/plat-omap/mux.c
@@ -47,13 +47,8 @@ int __init omap_mux_register(struct omap_mux_cfg *arch_mux_cfg)
 	return 0;
 }
 
-/*
- * Sets the Omap MUX and PULL_DWN registers based on the table
- */
-int __init_or_module omap_cfg_reg(const unsigned long index)
+int omap_get_pin_config(const unsigned long index, struct pin_config **cfg)
 {
-	struct pin_config *reg;
-
 	if (mux_cfg == NULL) {
 		printk(KERN_ERR "Pin mux table not initialized\n");
 		return -ENODEV;
@@ -66,7 +61,23 @@ int __init_or_module omap_cfg_reg(const unsigned long index)
 		return -ENODEV;
 	}
 
-	reg = (struct pin_config *)&mux_cfg->pins[index];
+	*cfg = &mux_cfg->pins[index];
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_get_pin_config);
+
+/*
+ * Sets the Omap MUX and PULL_DWN registers based on the table
+ */
+int __init_or_module omap_cfg_reg(const unsigned long index)
+{
+	struct pin_config *reg = NULL;
+	int err;
+
+	err = omap_get_pin_config(index, &reg);
+	if (err || !reg)
+		return err;
 
 	if (!mux_cfg->cfg_reg)
 		return -ENODEV;
-- 
1.5.2.5
