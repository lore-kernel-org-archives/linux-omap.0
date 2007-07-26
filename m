From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [RFC 2/2] MMC/SD Controller driver for OMAP2430
Date: Wed, 25 Jul 2007 19:18:50 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47016A3482@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk, Pierre Ossman <drzeus@drzeus.cx>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello:

Here is board (OMAP2430 SDP) dependent driver for OMAP2430 MMC driver.

TBD:
 - Multi-slot support
 - Card detection is untested.
 - 1.8v cards are not tested.

It would very kind of you to review this code and pass your comments.

Thanks & Regards,
Khasim

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/arch/arm/mach-omap2/board-sdp-hsmmc.c =
lin_for_mmc/arch/arm/mach-omap2/board-sdp-hsmmc.c
--- linux-omap/arch/arm/mach-omap2/board-sdp-hsmmc.c	1969-12-31 =
18:00:00.000000000 -0600
+++ lin_for_mmc/arch/arm/mach-omap2/board-sdp-hsmmc.c	2007-07-25 =
18:22:01.000000000 -0500
@@ -0,0 +1,255 @@
+/*
+ * linux/arch/arm/mach-omap2/board-sdp-hsmmc.c
+ *
+ * Copyright (C) 2007 Texas Instruments
+ * Author: Texas Instruments
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <asm/hardware.h>
+#include <asm/arch/twl4030.h>
+#include <asm/arch/mmc.h>
+#include <asm/arch/board.h>
+#include <asm/io.h>
+
+#ifdef CONFIG_MMC_OMAP
+
+#define VMMC1_DEV_GRP		0x27
+#define P1_DEV_GRP		0x20
+#define VMMC1_DEDICATED		0x2A
+#define VSEL_3V			0x02
+#define VSEL_18V		0x00
+#define TWL_GPIO_PUPDCTR1	0x13
+#define TWL_GPIO_IMR1A		0x1C
+#define TWL_GPIO_ISR1A		0x19
+#define LDO_CLR			0x00
+#define VSEL_S2_CLR		0x40
+#define GPIO_0_BIT_POS		1 << 0
+#define MMC1_CD_IRQ		0
+#define MMC2_CD_IRQ		1
+
+static irqreturn_t mmc_omap_cd_handler(int irq, void *dev_id)
+{
+	int detect;
+
+	detect =3D twl4030_get_gpio_datain(TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ));
+	omap_mmc_notify_card_detect(dev_id, 0, detect);
+	return IRQ_HANDLED;
+}
+
+/*
+ * MMC Slot Initialization.
+ */
+static int sdp_mmc_late_init(struct device *dev)
+{
+	int ret =3D 0;
+
+	/*
+	 * Configure TWL4030 GPIO parameters for MMC hotplug irq
+	 */
+	ret =3D twl4030_request_gpio(MMC1_CD_IRQ);
+	if (ret !=3D  0)
+		goto err;
+
+	ret =3D  twl4030_set_gpio_edge_ctrl(MMC1_CD_IRQ,
+			TWL4030_GPIO_EDGE_RISING | TWL4030_GPIO_EDGE_FALLING);
+	if (ret !=3D  0)
+		goto err;
+
+	ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, 0x02,
+						TWL_GPIO_PUPDCTR1);
+	if (ret !=3D  0)
+		goto err;
+
+	ret =3D twl4030_set_gpio_debounce(MMC1_CD_IRQ,TWL4030_GPIO_IS_ENABLE);
+	if (ret !=3D  0)
+		goto err;
+
+	ret =3D request_irq(TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ),
+	                mmc_omap_cd_handler, IRQF_DISABLED, "MMC1_CD_IRQ", =
dev);
+        if (ret < 0)
+		goto err;
+
+	return ret;
+err:
+	dev_err(dev, "Failed to configure TWL4030 GPIO IRQ\n");
+
+	return ret;
+}
+
+static void sdp_mmc_cleanup(struct device *dev)
+{
+	int ret =3D0;
+
+	ret =3D twl4030_free_gpio(MMC1_CD_IRQ);
+	free_irq(TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ), dev);
+	if (ret !=3D  0)
+		dev_err(dev,"Failed to configure TWL4030 GPIO IRQ\n");
+}
+
+#ifdef CONFIG_PM
+
+/*
+ * To mask and unmask MMC Card Detect Interrupt
+ * mask   : 1
+ * unmask : 0
+ */
+static int mask_cd_interrupt(int mask)
+{
+	u8 reg =3D 0, ret =3D 0;
+
+	ret =3D twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &reg,TWL_GPIO_IMR1A);
+	if (ret !=3D 0)
+		goto err;
+
+	reg =3D (mask =3D=3D 1) ? (reg | GPIO_0_BIT_POS) : (reg & =
~GPIO_0_BIT_POS);
+
+	ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, reg, =
TWL_GPIO_IMR1A);
+	if (ret !=3D 0)
+		goto err;
+
+	ret =3D twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &reg, =
TWL_GPIO_ISR1A);
+	if (ret !=3D 0)
+		goto err;
+
+	reg =3D (mask =3D=3D 1) ? (reg | GPIO_0_BIT_POS) : (reg & =
~GPIO_0_BIT_POS);
+
+	ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, reg, =
TWL_GPIO_ISR1A);
+	if (ret !=3D 0)
+		goto err;
+err:
+	return ret;
+}
+
+static int sdp_mmc_suspend(struct device *dev, int slot)
+{
+	int ret =3D0;
+
+	disable_irq(TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ));
+	ret =3D mask_cd_interrupt(1);
+
+	return ret;
+}
+
+static int sdp_mmc_resume(struct device *dev, int slot)
+{
+	int ret =3D0;
+
+	enable_irq(TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ));
+	ret =3D mask_cd_interrupt(0);
+
+	return ret;
+}
+
+#endif
+
+static int sdp_mmc_set_power(struct device *dev, int slot, int =
power_on,
+				int vdd)
+{
+	u32 vdd_sel =3D 0, devconf =3D 0,reg =3D 0;
+	int ret =3D 0;
+
+	if (power_on =3D=3D 1) {
+		devconf =3D omap_readl(CONTROL_DEVCONF1);
+
+		switch (1 << vdd) {
+		case MMC_VDD_33_34:
+		case MMC_VDD_32_33:
+			vdd_sel =3D  VSEL_3V;
+			devconf =3D (reg | (1 << 31));
+			break;
+		case MMC_VDD_165_195:
+			vdd_sel =3D VSEL_18V;
+			devconf =3D (devconf & ~(1 << 31));
+		}
+		omap_writel(devconf, CONTROL_DEVCONF1);
+
+		omap_writel(omap_readl(CONTROL_PBIAS_LITE_1) & 0x8,
+						CONTROL_PBIAS_LITE_1);
+
+		ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+						P1_DEV_GRP, VMMC1_DEV_GRP);
+		if (ret !=3D 0)
+			goto err;
+
+		ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+						vdd_sel, VMMC1_DEDICATED);
+		if (ret !=3D 0)
+			goto err;
+
+		mdelay(100);
+		reg =3D omap_readl(CONTROL_PBIAS_LITE_1);
+		reg =3D (vdd_sel =3D=3D VSEL_18V) ? ((reg | 0x6) & ~0x1)
+							: (reg | 0x7);
+		omap_writel(reg, CONTROL_PBIAS_LITE_1);
+
+		return ret;
+
+	} else if (power_on =3D=3D 0) {
+		/* Power OFF */
+
+		/* For MMC1, Toggle PBIAS before every power up sequence  */
+		omap_writel(omap_readl(CONTROL_PBIAS_LITE_1) & 0x8,
+						CONTROL_PBIAS_LITE_1);
+		ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+						LDO_CLR, VMMC1_DEV_GRP);
+		if (ret !=3D 0)
+			goto err;
+
+		ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+						VSEL_S2_CLR, VMMC1_DEDICATED);
+		if (ret !=3D 0)
+			goto err;
+
+		/* 100ms delay required for PBIAS configuration */
+		mdelay(100);
+		omap_writel(omap_readl(CONTROL_PBIAS_LITE_1) | 0x7, =
CONTROL_PBIAS_LITE_1);
+	} else {
+		ret =3D -1;
+		goto err;
+	}
+
+	return 1;
+err:
+	return 0;
+}
+
+static struct omap_mmc_platform_data sdp_mmc_data =3D {
+	.enabled		=3D 1,
+	.nr_slots		=3D 1,
+	.wire4			=3D 1,
+	.switch_slot		=3D NULL,
+	.init			=3D sdp_mmc_late_init,
+	.cleanup		=3D sdp_mmc_cleanup,
+	.suspend		=3D sdp_mmc_suspend,
+	.resume			=3D sdp_mmc_resume,
+	.slots[0] =3D {
+		.set_power	=3D sdp_mmc_set_power,
+		.set_bus_mode	=3D NULL,
+		.get_ro		=3D NULL,
+		.get_cover_state=3D NULL,
+		.ocr_mask	=3D MMC_VDD_32_33 | MMC_VDD_33_34 | MMC_VDD_165_195,
+		.name		=3D "first slot",
+	},
+};
+
+void __init sdp_mmc_init(void)
+{
+	omap_set_mmc_info(1, &sdp_mmc_data);
+}
+
+#else
+
+void __init sdp_mmc_init(void)
+{
+
+}
+
+#endif

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
