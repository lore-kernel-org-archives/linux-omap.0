From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH 2/3] ARM: OMAP: Add support for TWL4030 USB Transceiver on
	OMAP34xx
Date: Wed, 5 Dec 2007 18:40:28 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08804F64BA7@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source <linux-omap-open-source@linux.omap.com>
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch adds support for TWL4030 USB transceiver chip.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Nishant Kamat <nskamat@ti.com>
---
 drivers/i2c/chips/Kconfig       |   19 +
 drivers/i2c/chips/Makefile      |    3=20
 drivers/i2c/chips/twl4030_usb.c |  655 =
++++++++++++++++++++++++++++++++++++++++
 3 files changed, 676 insertions(+), 1 deletion(-)

Index: linux-omap-2.6-NOV26/drivers/i2c/chips/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-2.6-NOV26.orig/drivers/i2c/chips/Kconfig	2007-11-30 =
03:07:10.144742976 -0500
+++ linux-omap-2.6-NOV26/drivers/i2c/chips/Kconfig	2007-11-30 =
05:02:25.943381776 -0500
@@ -140,6 +140,25 @@
 	bool "TWL4030 GPIO Driver"
 	depends on TWL4030_CORE
=20
+config TWL4030_USB
+	bool "TWL4030 USB Transceiver Driver"
+	depends on TWL4030_CORE
+
+choice
+	prompt "Transceiver mode"
+	depends on TWL4030_USB
+	help
+	  TWL4030 USB transceiver can operate in various
+	  mutually-exclusive modes. Select one of them.
+
+config TWL4030_USB_HS_ULPI
+	depends on TWL4030_USB
+	bool "High-speed ULPI"
+	help
+	  Say Y here if the TWL4030 is connected to high-speed USB
+	  controller through a ULPI interface.
+endchoice
+
 config SENSORS_M41T00
 	tristate "ST M41T00 RTC chip (DEPRECATED)"
 	depends on PPC32
Index: linux-omap-2.6-NOV26/drivers/i2c/chips/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-2.6-NOV26.orig/drivers/i2c/chips/Makefile	2007-11-30 =
03:07:10.144742976 -0500
+++ linux-omap-2.6-NOV26/drivers/i2c/chips/Makefile	2007-11-30 =
04:23:23.087550000 -0500
@@ -17,8 +17,9 @@
 obj-$(CONFIG_GPIOEXPANDER_OMAP)	+=3D gpio_expander_omap.o
 obj-$(CONFIG_MENELAUS)		+=3D menelaus.o
 obj-$(CONFIG_SENSORS_TSL2550)	+=3D tsl2550.o
-obj-$(CONFIG_TWL4030_CORE)      +=3D twl4030_core.o
+obj-$(CONFIG_TWL4030_CORE)	+=3D twl4030_core.o
 obj-$(CONFIG_TWL4030_GPIO)	+=3D twl4030_gpio.o
+obj-$(CONFIG_TWL4030_USB)	+=3D twl4030_usb.o
 obj-$(CONFIG_RTC_X1205_I2C)	+=3D x1205.o
=20
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
Index: linux-omap-2.6-NOV26/drivers/i2c/chips/twl4030_usb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6-NOV26/drivers/i2c/chips/twl4030_usb.c	2007-11-30 =
05:04:47.969790480 -0500
@@ -0,0 +1,655 @@
+/*
+ * twl4030_usb - TWL4030 USB transceiver, talking to OMAP OTG =
controller
+ *
+ * Copyright (C) 2004-2007 Texas Instruments
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Current status:
+ *	- HS USB ULPI mode works.
+ *	- 3-pin mode support may be added in future.
+ */
+
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/time.h>
+#include <linux/interrupt.h>
+#include <linux/usb.h>
+
+#include <asm/arch/twl4030.h>
+
+/* Register defines */
+
+#define	VENDOR_ID_LO		(0x00)
+#define	VENDOR_ID_HI		(0x01)
+#define	PRODUCT_ID_LO		(0x02)
+#define	PRODUCT_ID_HI		(0x03)
+
+#define	FUNC_CTRL		(0x04)
+#define	FUNC_CTRL_SET		(0x05)
+#define	FUNC_CTRL_CLR		(0x06)
+#define	SUSPENDM		(1 << 6)
+#define	RESET			(1 << 5)
+#define	OPMODE_MASK		(3 << 3) /* bits 3 and 4 */
+#define	OPMODE_NORMAL		(0 << 3)
+#define	OPMODE_NONDRIVING	(1 << 3)
+#define	OPMODE_DISABLE_BIT_NRZI	(2 << 3)
+#define	TERMSELECT		(1 << 2)
+#define	XCVRSELECT_MASK		(3 << 0) /* bits 0 and 1 */
+#define	XCVRSELECT_HS		(0 << 0)
+#define	XCVRSELECT_FS		(1 << 0)
+#define	XCVRSELECT_LS		(2 << 0)
+#define	XCVRSELECT_FS4LS	(3 << 0)
+
+#define	IFC_CTRL     		(0x07)
+#define	IFC_CTRL_SET		(0x08)
+#define	IFC_CTRL_CLR		(0x09)
+#define	INTERFACE_PROTECT_DISABLE	(1 << 7)
+#define	AUTORESUME		(1 << 4)
+#define	CLOCKSUSPENDM		(1 << 3)
+#define	CARKITMODE		(1 << 2)
+#define	FSLSSERIALMODE_3PIN	(1 << 1)
+
+#define	OTG_CTRL		(0x0A)
+#define	OTG_CTRL_SET		(0x0B)
+#define	OTG_CTRL_CLR		(0x0C)
+#define	DRVVBUS			(1 << 5)
+#define	CHRGVBUS		(1 << 4)
+#define	DISCHRGVBUS		(1 << 3)
+#define	DMPULLDOWN		(1 << 2)
+#define	DPPULLDOWN		(1 << 1)
+#define	IDPULLUP		(1 << 0)
+
+#define	USB_INT_EN_RISE		(0x0D)
+#define	USB_INT_EN_RISE_SET	(0x0E)
+#define	USB_INT_EN_RISE_CLR	(0x0F)
+#define	USB_INT_EN_FALL		(0x10)
+#define	USB_INT_EN_FALL_SET	(0x11)
+#define	USB_INT_EN_FALL_CLR	(0x12)
+#define	USB_INT_STS		(0x13)
+#define	USB_INT_LATCH		(0x14)
+#define	IDGND			(1 << 4)
+#define	SESSEND			(1 << 3)
+#define	SESSVALID		(1 << 2)
+#define	VBUSVALID		(1 << 1)
+#define	HOSTDISCONNECT		(1 << 0)
+
+#define	CARKIT_CTRL		(0x19)
+#define	CARKIT_CTRL_SET		(0x1A)
+#define	CARKIT_CTRL_CLR		(0x1B)
+#define	MICEN			(1 << 6)
+#define	SPKRIGHTEN		(1 << 5)
+#define	SPKLEFTEN		(1 << 4)
+#define	RXDEN			(1 << 3)
+#define	TXDEN			(1 << 2)
+#define	IDGNDDRV		(1 << 1)
+#define	CARKITPWR		(1 << 0)
+#define	CARKIT_PLS_CTRL		(0x22)
+#define	CARKIT_PLS_CTRL_SET	(0x23)
+#define	CARKIT_PLS_CTRL_CLR	(0x24)
+#define	SPKRRIGHT_BIASEN	(1 << 3)
+#define	SPKRLEFT_BIASEN		(1 << 2)
+#define	RXPLSEN			(1 << 1)
+#define	TXPLSEN			(1 << 0)
+
+#define	MCPC_CTRL		(0x30)
+#define	MCPC_CTRL_SET		(0x31)
+#define	MCPC_CTRL_CLR		(0x32)
+#define	RTSOL			(1 << 7)
+#define	EXTSWR			(1 << 6)
+#define	EXTSWC			(1 << 5)
+#define	VOICESW			(1 << 4)
+#define	OUT64K			(1 << 3)
+#define	RTSCTSSW		(1 << 2)
+#define	HS_UART			(1 << 0)
+
+#define	MCPC_IO_CTRL		(0x33)
+#define	MCPC_IO_CTRL_SET	(0x34)
+#define	MCPC_IO_CTRL_CLR	(0x35)
+#define	MICBIASEN		(1 << 5)
+#define	CTS_NPU			(1 << 4)
+#define	RXD_PU			(1 << 3)
+#define	TXDTYP			(1 << 2)
+#define	CTSTYP			(1 << 1)
+#define	RTSTYP			(1 << 0)
+
+#define	MCPC_CTRL2		(0x36)
+#define	MCPC_CTRL2_SET		(0x37)
+#define	MCPC_CTRL2_CLR		(0x38)
+#define	MCPC_CK_EN		(1 << 0)
+
+#define	OTHER_FUNC_CTRL		(0x80)
+#define	OTHER_FUNC_CTRL_SET	(0x81)
+#define	OTHER_FUNC_CTRL_CLR	(0x82)
+#define	BDIS_ACON_EN		(1 << 4)
+#define	FIVEWIRE_MODE		(1 << 2)
+
+#define	OTHER_IFC_CTRL		(0x83)
+#define	OTHER_IFC_CTRL_SET	(0x84)
+#define	OTHER_IFC_CTRL_CLR	(0x85)
+#define	OE_INT_EN		(1 << 6)
+#define	CEA2011_MODE		(1 << 5)
+#define	FSLSSERIALMODE_4PIN	(1 << 4)
+#define	HIZ_ULPI_60MHZ_OUT	(1 << 3)
+#define	HIZ_ULPI		(1 << 2)
+#define	ALT_INT_REROUTE		(1 << 0)
+
+#define	OTHER_INT_EN_RISE	(0x86)
+#define	OTHER_INT_EN_RISE_SET	(0x87)
+#define	OTHER_INT_EN_RISE_CLR	(0x88)
+#define	OTHER_INT_EN_FALL	(0x89)
+#define	OTHER_INT_EN_FALL_SET	(0x8A)
+#define	OTHER_INT_EN_FALL_CLR	(0x8B)
+#define	OTHER_INT_STS		(0x8C)
+#define	OTHER_INT_LATCH		(0x8D)
+#define	VB_SESS_VLD		(1 << 7)
+#define	DM_HI			(1 << 6) /* not valid for "latch" reg */
+#define	DP_HI			(1 << 5) /* not valid for "latch" reg */
+#define	BDIS_ACON		(1 << 3) /* not valid for "fall" regs */
+#define	MANU			(1 << 1)
+#define	ABNORMAL_STRESS		(1 << 0)
+
+#define	ID_STATUS		(0x96)
+#define	ID_RES_FLOAT		(1 << 4)
+#define	ID_RES_440K		(1 << 3)
+#define	ID_RES_200K		(1 << 2)
+#define	ID_RES_102K		(1 << 1)
+#define	ID_RES_GND		(1 << 0)
+
+#define	POWER_CTRL		(0xAC)
+#define	POWER_CTRL_SET		(0xAD)
+#define	POWER_CTRL_CLR		(0xAE)
+#define	OTG_ENAB		(1 << 5)
+
+#define	OTHER_IFC_CTRL2		(0xAF)
+#define	OTHER_IFC_CTRL2_SET	(0xB0)
+#define	OTHER_IFC_CTRL2_CLR	(0xB1)
+#define	ULPI_STP_LOW		(1 << 4)
+#define	ULPI_TXEN_POL		(1 << 3)
+#define	ULPI_4PIN_2430		(1 << 2)
+#define	USB_INT_OUTSEL_MASK	(3 << 0) /* bits 0 and 1 */
+#define	USB_INT_OUTSEL_INT1N	(0 << 0)
+#define	USB_INT_OUTSEL_INT2N	(1 << 0)
+
+#define	REG_CTRL_EN		(0xB2)
+#define	REG_CTRL_EN_SET		(0xB3)
+#define	REG_CTRL_EN_CLR		(0xB4)
+#define	REG_CTRL_ERROR		(0xB5)
+#define	ULPI_I2C_CONFLICT_INTEN	(1 << 0)
+
+#define	OTHER_FUNC_CTRL2	(0xB8)
+#define	OTHER_FUNC_CTRL2_SET	(0xB9)
+#define	OTHER_FUNC_CTRL2_CLR	(0xBA)
+#define	VBAT_TIMER_EN		(1 << 0)
+
+/* following registers do not have separate _clr and _set registers */
+#define	VBUS_DEBOUNCE		(0xC0)
+#define	ID_DEBOUNCE		(0xC1)
+#define	VBAT_TIMER		(0xD3)
+#define	PHY_PWR_CTRL		(0xFD)
+#define	PHYPWD			(1 << 0)
+#define	PHY_CLK_CTRL		(0xFE)
+#define	CLOCKGATING_EN		(1 << 2)
+#define	CLK32K_EN      		(1 << 1)
+#define	REQ_PHY_DPLL_CLK	(1 << 0)
+#define	PHY_CLK_CTRL_STS	(0xFF)
+#define	PHY_DPLL_CLK		(1 << 0)
+
+/* In module TWL4030_MODULE_PM_MASTER */
+#define	PROTECT_KEY		(0x0E)
+
+/* In module TWL4030_MODULE_PM_RECEIVER */
+#define	VUSB_DEDICATED1		(0x7D)
+#define	VUSB_DEDICATED2		(0x7E)
+#define	VUSB1V5_DEV_GRP		(0x71)
+#define	VUSB1V5_TYPE		(0x72)
+#define	VUSB1V5_REMAP		(0x73)
+#define	VUSB1V8_DEV_GRP		(0x74)
+#define	VUSB1V8_TYPE		(0x75)
+#define	VUSB1V8_REMAP		(0x76)
+#define	VUSB3V1_DEV_GRP		(0x77)
+#define	VUSB3V1_TYPE		(0x78)
+#define	VUSB3V1_REMAP		(0x79)
+
+#define	ID_STATUS		(0x96)
+#define	ID_RES_FLOAT		(1 << 4) /* mini-B */
+#define	ID_RES_440K		(1 << 3) /* type 2 charger */
+#define	ID_RES_200K		(1 << 2) /* 5-wire carkit or
+						    type 1 charger */
+#define	ID_RES_102K		(1 << 1) /* phone */
+#define	ID_RES_GND		(1 << 0) /* mini-A */
+
+/* In module TWL4030_MODULE_INTBR */
+#define	PMBR1			(0x0D)
+#define	GPIO_USB_4PIN_ULPI_2430C	(3 << 0)
+
+/* In module TWL4030_MODULE_INT */
+#define	REG_PWR_ISR1		(0x00)
+#define	REG_PWR_IMR1		(0x01)
+#define	USB_PRES		(1 << 2)
+#define	REG_PWR_EDR1		(0x05)
+#define	USB_PRES_FALLING	(1 << 4)
+#define	USB_PRES_RISING		(1 << 5)
+#define	REG_PWR_SIH_CTRL	(0x07)
+#define	COR			(1 << 2)
+
+/*----------------------------------------------------------------------=
---*/
+
+#define twl4030_i2c_read_u8_verify(module, data, address)		\
+do {									\
+	if (twl4030_i2c_read_u8(module, data, address) < 0) {		\
+		printk(KERN_ERR "twl4030_usb: i2c read failed,		\
+			line %d\n", __LINE__);				\
+		goto i2c_failed;					\
+	}								\
+} while (0)
+
+#define twl4030_i2c_write_u8_verify(module, data, address)		  \
+do {									  \
+	u8 check;							  \
+	if (!((twl4030_i2c_write_u8((module), (data), (address)) >=3D 0) && \
+	      (twl4030_i2c_read_u8((module), &check, (address)) >=3D 0) &&  \
+	      (check =3D=3D data))	&&					  \
+	    !((twl4030_i2c_write_u8((module), (data), (address)) >=3D 0) && \
+	      (twl4030_i2c_read_u8((module), &check, (address)) >=3D 0) &&  \
+	      (check =3D=3D (data))))	{				  \
+		printk(KERN_ERR "twl4030_usb: i2c write failed,		  \
+			line %d\n", __LINE__);				  \
+		goto i2c_failed;					  \
+	}								  \
+} while (0)
+
+#define twl4030_usb_write_verify(address, data)	\
+	twl4030_i2c_write_u8_verify(TWL4030_MODULE_USB, (data), (address))
+
+static inline int twl4030_usb_write(u8 address, u8 data)
+{
+	int ret =3D 0;
+	ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_USB, data, address);
+	if (ret >=3D 0) {
+#if 0	/* debug */
+		u8 data1;
+		if (twl4030_i2c_read_u8(TWL4030_MODULE_USB, &data1,
+					address) < 0)
+			printk(KERN_ERR "re-read failed\n");
+		else
+			printk(KERN_INFO
+			       "Write %s wrote %x read %x from reg %x\n",
+			       (data1 =3D=3D data) ? "succeed" : "mismatch",
+			       data, data1, address);
+#endif
+	} else {
+		printk(KERN_WARNING
+			"TWL4030:USB:Write[0x%x] Error %d\n", address, ret);
+	}
+	return ret;
+}
+
+static inline int twl4030_usb_read(u8 address)
+{
+	u8 data;
+	int ret =3D 0;
+	ret =3D twl4030_i2c_read_u8(TWL4030_MODULE_USB, &data, address);
+	if (ret >=3D 0) {
+		ret =3D data;
+	} else {
+		printk(KERN_WARNING
+			"TWL4030:USB:Read[0x%x] Error %d\n", address, ret);
+	}
+	return ret;
+}
+
+/*----------------------------------------------------------------------=
---*/
+
+struct twl4030_usb {
+	int			irq;
+	u8 			usb_mode;	/* pin configuration */
+#define T2_USB_MODE_ULPI		1
+/* #define T2_USB_MODE_CEA2011_3PIN	2 */
+	u8			alseep;
+};
+
+static struct twl4030_usb *the_transceiver;
+
+/*----------------------------------------------------------------------=
---*/
+
+static inline int
+twl4030_usb_set_bits(struct twl4030_usb *twl, u8 reg, u8 bits)
+{
+	return twl4030_usb_write(reg + 1, bits);
+}
+
+static inline int
+twl4030_usb_clear_bits(struct twl4030_usb *twl, u8 reg, u8 bits)
+{
+	return twl4030_usb_write(reg + 2, bits);
+}
+
+/*----------------------------------------------------------------------=
---*/
+
+static void twl4030_usb_set_mode(struct twl4030_usb *twl, int mode)
+{
+	twl->usb_mode =3D mode;
+
+	switch (mode) {
+	case T2_USB_MODE_ULPI:
+		twl4030_usb_clear_bits(twl, IFC_CTRL, CARKITMODE);
+		twl4030_usb_set_bits(twl, POWER_CTRL, OTG_ENAB);
+		twl4030_usb_clear_bits(twl, FUNC_CTRL,
+					XCVRSELECT_MASK | OPMODE_MASK);
+		break;
+/*
+	case T2_USB_MODE_CEA2011_3PIN:
+		twl4030_cea2011_3_pin_FS_setup(twl);
+		break;
+*/
+	default:
+		/* FIXME: power on defaults */
+		break;
+	};
+}
+
+#ifdef CONFIG_TWL4030_USB_HS_ULPI
+static void hs_usb_init(struct twl4030_usb *twl)
+{
+	twl->usb_mode =3D T2_USB_MODE_ULPI;
+	return;
+}
+
+#endif
+
+static void twl4030_i2c_access(int on)
+{
+	unsigned long timeout;
+	int val =3D twl4030_usb_read(PHY_CLK_CTRL);
+
+	if (val >=3D 0) {
+		if (on) {
+			/* enable DPLL to access PHY registers over I2C */
+			val |=3D REQ_PHY_DPLL_CLK;
+			twl4030_usb_write_verify(PHY_CLK_CTRL, (u8)val);
+
+			timeout =3D jiffies + HZ;
+			while (!(twl4030_usb_read(PHY_CLK_CTRL_STS) &
+							PHY_DPLL_CLK)
+				&& time_before(jiffies, timeout))
+					udelay(10);
+			if (!(twl4030_usb_read(PHY_CLK_CTRL_STS) &
+							PHY_DPLL_CLK))
+				printk(KERN_ERR "Timeout setting T2 HSUSB "
+						"PHY DPLL clock\n");
+		} else {
+			/* let ULPI control the DPLL clock */
+			val &=3D ~REQ_PHY_DPLL_CLK;
+			twl4030_usb_write_verify(PHY_CLK_CTRL, (u8)val);
+		}
+	}
+i2c_failed:
+	return;
+}
+
+static void usb_irq_enable(int rising, int falling)
+{
+	u8 val;
+
+	/* edge setup */
+	twl4030_i2c_read_u8_verify(TWL4030_MODULE_INT, &val, REG_PWR_EDR1);
+	val &=3D ~(USB_PRES_RISING | USB_PRES_FALLING);
+	if (rising)
+		val =3D val | USB_PRES_RISING;
+	if (falling)
+		val =3D val | USB_PRES_FALLING;
+	twl4030_i2c_write_u8_verify(TWL4030_MODULE_INT, val, REG_PWR_EDR1);
+
+	/* un-mask interrupt */
+	twl4030_i2c_read_u8_verify(TWL4030_MODULE_INT, &val, REG_PWR_IMR1);
+	val &=3D ~USB_PRES;
+	twl4030_i2c_write_u8_verify(TWL4030_MODULE_INT, val, REG_PWR_IMR1);
+
+i2c_failed:
+	return;
+}
+
+static void usb_irq_disable(void)
+{
+	u8 val;
+
+	/* undo edge setup */
+	twl4030_i2c_read_u8_verify(TWL4030_MODULE_INT, &val, REG_PWR_EDR1);
+	val &=3D ~(USB_PRES_RISING | USB_PRES_FALLING);
+	twl4030_i2c_write_u8_verify(TWL4030_MODULE_INT, val, REG_PWR_EDR1);
+
+	/* mask interrupt */
+	twl4030_i2c_read_u8_verify(TWL4030_MODULE_INT, &val, REG_PWR_IMR1);
+	val |=3D USB_PRES;
+	twl4030_i2c_write_u8_verify(TWL4030_MODULE_INT, val, REG_PWR_IMR1);
+
+i2c_failed:
+	return;
+}
+
+void twl4030_phy_suspend(int controller_off);
+void twl4030_phy_resume(void);
+
+static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
+{
+	int ret =3D IRQ_NONE;
+	u8 val;
+	u8 sih_ctrl;
+
+	/* save previous value of SIH_CTRL and disable clear_on_read */
+	twl4030_i2c_read_u8(TWL4030_MODULE_INT, &sih_ctrl, REG_PWR_SIH_CTRL);
+	twl4030_i2c_write_u8(TWL4030_MODULE_INT, (sih_ctrl & ~COR),
+			     REG_PWR_SIH_CTRL);
+
+	twl4030_i2c_read_u8_verify(TWL4030_MODULE_INT, &val, REG_PWR_ISR1);
+
+	/* this interrupt line may be shared */
+	if (!(val & USB_PRES))
+		goto done;
+
+	/* clear the interrupt */
+	twl4030_i2c_write_u8(TWL4030_MODULE_INT, USB_PRES, REG_PWR_ISR1);
+
+	/* action based on cable attach or detach */
+	twl4030_i2c_read_u8_verify(TWL4030_MODULE_INT, &val, REG_PWR_EDR1);
+
+	if (val & USB_PRES_RISING)
+		twl4030_phy_resume();
+	else
+		twl4030_phy_suspend(0);
+
+	ret =3D IRQ_HANDLED;
+
+i2c_failed:
+done:
+	/* restore previous value of SIH_CTRL */
+	twl4030_i2c_write_u8(TWL4030_MODULE_INT, sih_ctrl, REG_PWR_SIH_CTRL);
+	return ret;
+}
+
+static void twl4030_phy_power(struct twl4030_usb *twl, int on)
+{
+	u8 pwr;
+
+	pwr =3D twl4030_usb_read(PHY_PWR_CTRL);
+	if (on) {
+		pwr &=3D ~PHYPWD;
+		twl4030_usb_write_verify(PHY_PWR_CTRL, pwr);
+		twl4030_usb_write(PHY_CLK_CTRL,
+				  twl4030_usb_read(PHY_CLK_CTRL) |
+					(CLOCKGATING_EN | CLK32K_EN));
+	} else  {
+		pwr |=3D PHYPWD;
+		twl4030_usb_write_verify(PHY_PWR_CTRL, pwr);
+	}
+i2c_failed:
+	return;
+}
+
+static void twl4030_usb_ldo_init(struct twl4030_usb *twl)
+{
+	/* Enable writing to power configuration registers */
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0xC0, PROTECT_KEY);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0x0C, PROTECT_KEY);
+
+	/* put VUSB3V1 LDO in active state */
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB_DEDICATED2);
+
+	/* input to VUSB3V1 LDO is from VBAT, not VBUS */
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x14, =
VUSB_DEDICATED1);
+
+	/* turn on 3.1V regulator */
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x20, =
VUSB3V1_DEV_GRP);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB3V1_TYPE);
+
+	/* turn on 1.5V regulator */
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x20, =
VUSB1V5_DEV_GRP);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V5_TYPE);
+
+	/* turn on 1.8V regulator */
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x20, =
VUSB1V8_DEV_GRP);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V8_TYPE);
+
+	/* disable access to power configuration registers */
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, PROTECT_KEY);
+}
+
+void twl4030_phy_suspend(int controller_off)
+{
+	struct twl4030_usb *twl =3D the_transceiver;
+
+	if (controller_off)
+		usb_irq_disable();
+
+	if (twl->alseep)
+		return;
+
+	if (!controller_off)
+		/* enable rising edge interrupt to detect cable attach */
+		usb_irq_enable(1, 0);
+
+	twl4030_phy_power(twl, 0);
+	twl->alseep =3D 1;
+	return;
+}
+EXPORT_SYMBOL(twl4030_phy_suspend);
+
+
+void twl4030_phy_resume(void)
+{
+	struct twl4030_usb *twl =3D the_transceiver;
+
+	if (!twl->alseep)
+		return;
+
+	/* enable falling edge interrupt to detect cable detach */
+	usb_irq_enable(0, 1);
+
+	twl4030_phy_power(twl, 1);
+	twl4030_i2c_access(1);
+	twl4030_usb_set_mode(twl, twl->usb_mode);
+	if (twl->usb_mode =3D=3D T2_USB_MODE_ULPI)
+		twl4030_i2c_access(0);
+	twl->alseep =3D 0;
+	return;
+}
+EXPORT_SYMBOL(twl4030_phy_resume);
+
+
+static int __init twl4030_usb_init(void)
+{
+	struct twl4030_usb	*twl;
+	int status;
+
+	if (the_transceiver)
+		return 0;
+
+	twl =3D kcalloc(1, sizeof *twl, GFP_KERNEL);
+	if (!twl)
+		return 0;
+
+	the_transceiver =3D twl;
+
+	twl->irq =3D TWL4030_MODIRQ_PWR;
+
+	usb_irq_disable();
+	status =3D request_irq(twl->irq, twl4030_usb_irq,
+		IRQF_DISABLED | IRQF_SHARED, "twl4030_usb", twl);
+	if (status < 0) {
+		printk(KERN_DEBUG "can't get IRQ %d, err %d\n",
+			twl->irq, status);
+		kfree(twl);
+		return -ENODEV;
+	}
+
+#if defined(CONFIG_TWL4030_USB_HS_ULPI)
+	hs_usb_init(twl);
+#endif
+	twl4030_usb_ldo_init(twl);
+	twl4030_phy_power(twl, 1);
+	twl4030_i2c_access(1);
+	twl4030_usb_set_mode(twl, twl->usb_mode);
+	if (twl->usb_mode =3D=3D T2_USB_MODE_ULPI)
+		twl4030_i2c_access(0);
+
+	twl->alseep =3D 0;
+
+	if (twl->usb_mode =3D=3D T2_USB_MODE_ULPI)
+		twl4030_phy_suspend(1);
+
+	printk(KERN_INFO "Initialized TWL4030 USB module");
+
+	return 0;
+}
+
+
+static void __exit twl4030_usb_exit(void)
+{
+	struct twl4030_usb *twl =3D the_transceiver;
+	int val;
+
+	usb_irq_disable();
+	free_irq(twl->irq, twl);
+
+	/* set transceiver mode to power on defaults */
+	twl4030_usb_set_mode(twl, -1);
+
+	/* autogate 60MHz ULPI clock,
+	 * clear dpll clock request for i2c access,
+	 * disable 32KHz
+	 */
+	val =3D twl4030_usb_read(PHY_CLK_CTRL);
+	if (val >=3D 0) {
+		val |=3D CLOCKGATING_EN;
+		val &=3D ~(CLK32K_EN | REQ_PHY_DPLL_CLK);
+		twl4030_usb_write(PHY_CLK_CTRL, (u8)val);
+	}
+
+	/* disable complete OTG block */
+	twl4030_usb_clear_bits(twl, POWER_CTRL, OTG_ENAB);
+
+	twl4030_phy_power(twl, 0);
+
+	kfree(twl);
+}
+
+subsys_initcall(twl4030_usb_init);
+module_exit(twl4030_usb_exit);
+
+MODULE_AUTHOR("Texas Instruments, Inc.");
+MODULE_DESCRIPTION("TWL4030 USB transceiver driver");
+MODULE_LICENSE("GPL");
