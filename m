From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] To Cleanup TWL-Core driver
Date: Wed, 25 Jul 2007 19:19:49 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47016A3486@dlee13.ent.ti.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Patch to cleanup few spellings in TWL4030 Core and export TWLGPIO APIs

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 drivers/i2c/chips/twl4030_core.c
 include/asm-arm/arch-omap/twl4030.h

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=


diff -purN linux-omap/drivers/i2c/chips/twl4030_core.c =
lin_for_mmc/drivers/i2c/chips/twl4030_core.c
--- linux-omap/drivers/i2c/chips/twl4030_core.c	2007-06-08 =
08:09:38.000000000 -0500
+++ lin_for_mmc/drivers/i2c/chips/twl4030_core.c	2007-07-18 =
12:02:56.000000000 -0500
@@ -111,7 +111,7 @@
 #define TWL4030_BASEADD_BACKUP		0x0014
 #define TWL4030_BASEADD_INT		0x002E
 #define TWL4030_BASEADD_PM_MASTER	0x0036
-#define TWL4030_BASEADD_PM_RECIEVER	0x005B
+#define TWL4030_BASEADD_PM_RECEIVER	0x005B
 #define TWL4030_BASEADD_RTC		0x001C
 #define TWL4030_BASEADD_SECURED_REG	0x0000
=20
@@ -189,7 +189,7 @@ static struct twl4030mapping twl4030_map
 	{ TWL4030_SLAVENUM_NUM3, TWL4030_BASEADD_BACKUP },
 	{ TWL4030_SLAVENUM_NUM3, TWL4030_BASEADD_INT },
 	{ TWL4030_SLAVENUM_NUM3, TWL4030_BASEADD_PM_MASTER },
-	{ TWL4030_SLAVENUM_NUM3, TWL4030_BASEADD_PM_RECIEVER },
+	{ TWL4030_SLAVENUM_NUM3, TWL4030_BASEADD_PM_RECEIVER },
 	{ TWL4030_SLAVENUM_NUM3, TWL4030_BASEADD_RTC },
 	{ TWL4030_SLAVENUM_NUM3, TWL4030_BASEADD_SECURED_REG },
 };

diff -purN linux-omap/include/asm-arm/arch-omap/twl4030.h =
lin_for_mmc/include/asm-arm/arch-omap/twl4030.h
--- linux-omap/include/asm-arm/arch-omap/twl4030.h	2007-05-23 =
23:29:31.000000000 -0500
+++ lin_for_mmc/include/asm-arm/arch-omap/twl4030.h	2007-07-25 =
18:17:19.000000000 -0500
@@ -48,7 +48,7 @@
 #define TWL4030_MODULE_BACKUP		0x10
 #define TWL4030_MODULE_INT		0x11
 #define TWL4030_MODULE_PM_MASTER	0x12
-#define TWL4030_MODULE_PM_RECIEVER	0x13
+#define TWL4030_MODULE_PM_RECEIVER	0x13
 #define TWL4030_MODULE_RTC		0x14
 #define TWL4030_MODULE_SECURED_REG	0x15
=20
@@ -106,4 +106,13 @@ int twl4030_i2c_read_u8(u8 mod_no, u8* v
 int twl4030_i2c_write(u8 mod_no, u8 * value, u8 reg, u8 num_bytes);
 int twl4030_i2c_read(u8 mod_no, u8 * value, u8 reg, u8 num_bytes);
=20
+/*
+ * Exported TWL4030 GPIO APIs
+ */
+int twl4030_get_gpio_datain(int gpio);
+int twl4030_request_gpio(int gpio);
+int twl4030_set_gpio_edge_ctrl(int gpio, int edge);
+int twl4030_set_gpio_debounce(int gpio, int enable);
+int twl4030_free_gpio(int gpio);
+
 #endif /* End of __TWL4030_H */
