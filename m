From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] OMAP: MMC: Move set_power to platform data
Date: Fri, 3 Mar 2006 05:24:21 -0800 (PST)
Message-ID: <20060303132421.46104.qmail@web32909.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-307864376-1141392261=:43557"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

--0-307864376-1141392261=:43557
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Attached patch moves the set_power function to specific board-*.c
files. For OMAP24xx-H4 I have to used __raw_* functions instead of
OMAP_MMC_WRITE, as it is in local omap.h inside drivers/mmc directory.

Tested on H4, it is able to detect the MMC atleast :) and builds for
innovator_1510, h2 and h3. 24xx custom boards needs to be updated if
they are not using powerpin gpio. 

I am not able to find defconfig for apollon board, so if Kyungmin Park
confirms the changes then I can add h4 like setpower function to
board-apollon.c in the next patch. Thanx.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-307864376-1141392261=:43557
Content-Type: text/x-patch; name="mmc01.patch"
Content-Description: 224716790-mmc01.patch
Content-Disposition: inline; filename="mmc01.patch"

Subject: [PATCH] OMAP: MMC: Move set_power to platform data

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 arch/arm/mach-omap1/board-h2.c        |   10 +++++++
 arch/arm/mach-omap1/board-h3.c        |   11 +++++++
 arch/arm/mach-omap1/board-innovator.c |   15 ++++++++++
 arch/arm/mach-omap2/board-h4.c        |   11 +++++++
 drivers/mmc/omap.c                    |   50 ++++-----------------------------
 include/asm-arm/arch-omap/board.h     |    1 +
 6 files changed, 54 insertions(+), 44 deletions(-)

ba848bda79bfc460c81aed30280f24aa71e4f042
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 680e67e..cd401a1 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -40,6 +40,7 @@
 #include <asm/arch/irda.h>
 #include <asm/arch/usb.h>
 #include <asm/arch/keypad.h>
+#include <asm/arch/tps65010.h>
 #include <asm/arch/common.h>
 
 extern int omap_gpio_init(void);
@@ -316,6 +317,14 @@ static struct omap_usb_config h2_usb_con
 	.pins[1]	= 3,
 };
 
+void h2_mmc_set_power(void __iomem *base, int on)
+{
+	if (on)
+		tps65010_set_gpio_out_value(GPIO3, HIGH);
+	else 
+		tps65010_set_gpio_out_value(GPIO3, LOW);
+}
+
 static struct omap_mmc_config h2_mmc_config __initdata = {
 	.mmc [0] = {
 		.enabled 	= 1,
@@ -323,6 +332,7 @@ static struct omap_mmc_config h2_mmc_con
 		.wp_pin		= OMAP_MPUIO(3),
 		.power_pin	= -1,	/* tps65010 gpio3 */
 		.switch_pin	= OMAP_MPUIO(1),
+		.set_power	= h2_mmc_set_power,
 	},
 };
 
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 9652822..b18fddd 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -43,6 +43,7 @@
 #include <asm/arch/irda.h>
 #include <asm/arch/usb.h>
 #include <asm/arch/keypad.h>
+#include <asm/arch/tps65010.h>
 #include <asm/arch/common.h>
 
 extern int omap_gpio_init(void);
@@ -378,11 +379,21 @@ static struct omap_usb_config h3_usb_con
 	.pins[1]	= 3,
 };
 
+void h3_mmc_set_power(void __iomem *base, int on)
+{
+	if (on)
+		/* GPIO 4 of TPS65010 sends SD_EN signal */
+		tps65010_set_gpio_out_value(GPIO4, HIGH);
+	else 
+		tps65010_set_gpio_out_value(GPIO4, LOW);
+}
+
 static struct omap_mmc_config h3_mmc_config __initdata = {
 	.mmc[0] = {
 		.enabled 	= 1,
 		.power_pin	= -1,   /* tps65010 GPIO4 */
 		.switch_pin	= OMAP_MPUIO(1),
+		.set_power	= h3_mmc_set_power,
 	},
 };
 
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index e90c137..e00ae4b 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -36,6 +36,7 @@
 #include <asm/arch/tc.h>
 #include <asm/arch/usb.h>
 #include <asm/arch/keypad.h>
+#include <asm/arch/fpga.h>
 #include <asm/arch/common.h>
 
 static int innovator_keymap[] = {
@@ -285,6 +286,19 @@ static struct omap_lcd_config innovator1
 };
 #endif
 
+void innovator_mmc_set_power(void __iomem *base, int on)
+{
+#if defined(CONFIG_MACH_OMAP_INNOVATOR) && defined(CONFIG_ARCH_OMAP15XX)
+	if (on) {
+		fpga_write(fpga_read(OMAP1510_FPGA_POWER) | (1 << 3),
+		     OMAP1510_FPGA_POWER);
+	} else {
+		fpga_write(fpga_read(OMAP1510_FPGA_POWER) & ~(1 << 3),
+		     OMAP1510_FPGA_POWER);
+	}
+#endif
+}
+
 static struct omap_mmc_config innovator_mmc_config __initdata = {
 	.mmc [0] = {
 		.enabled 	= 1,
@@ -292,6 +306,7 @@ static struct omap_mmc_config innovator_
 		.wp_pin		= OMAP_MPUIO(3),
 		.power_pin	= -1,	/* FPGA F3 UIO42 */
 		.switch_pin	= -1,	/* FPGA F4 UIO43 */
+		.set_power	= innovator_mmc_set_power,
 	},
 };
 
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 913ab3d..fac834a 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -297,6 +297,16 @@ static struct omap_uart_config h4_uart_c
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
+void h4_mmc_set_power(void __iomem *base, int on)
+{
+	u16 reg = __raw_readw((base) + 0x0c);
+
+	if (on)
+		__raw_writew(reg | (1 << 11), (base) + 0x0c);
+	else
+		__raw_writew(reg & ~(1 << 11), (base) + 0x0c);
+}
+
 static struct omap_mmc_config h4_mmc_config __initdata = {
 	.mmc [0] = {
 		.enabled	= 1,
@@ -304,6 +314,7 @@ static struct omap_mmc_config h4_mmc_con
 		.wp_pin		= -1,
 		.power_pin	= -1,
 		.switch_pin	= -1,
+		.set_power	= h4_mmc_set_power,
 	},
 };
 
diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
index 822808d..c81c0a2 100644
--- a/drivers/mmc/omap.c
+++ b/drivers/mmc/omap.c
@@ -42,8 +42,6 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/mux.h>
-#include <asm/arch/fpga.h>
-#include <asm/arch/tps65010.h>
 #include <asm/arch/menelaus.h>
 
 #include "omap.h"
@@ -102,6 +100,7 @@ struct mmc_omap_host {
 	struct work_struct	switch_work;
 	struct timer_list	switch_timer;
 	int			switch_last_state;
+	void (*set_power)(void __iomem *base, int on);
 };
 
 static inline int
@@ -1072,54 +1071,16 @@ static void mmc_omap_request(struct mmc_
 		omap_start_dma(host->dma_ch);
 }
 
-static void innovator_fpga_socket_power(int on)
-{
-#if defined(CONFIG_MACH_OMAP_INNOVATOR) && defined(CONFIG_ARCH_OMAP15XX)
-
-	if (on) {
-		fpga_write(fpga_read(OMAP1510_FPGA_POWER) | (1 << 3),
-		     OMAP1510_FPGA_POWER);
-	} else {
-		fpga_write(fpga_read(OMAP1510_FPGA_POWER) & ~(1 << 3),
-		     OMAP1510_FPGA_POWER);
-	}
-#endif
-}
-
 /*
  * Turn the socket power on/off. Innovator uses FPGA, most boards
  * probably use GPIO.
  */
 static void mmc_omap_power(struct mmc_omap_host *host, int on)
 {
-	if (on) {
-		if (machine_is_omap_innovator())
-			innovator_fpga_socket_power(1);
-		else if (machine_is_omap_h2())
-			tps65010_set_gpio_out_value(GPIO3, HIGH);
-		else if (machine_is_omap_h3())
-			/* GPIO 4 of TPS65010 sends SD_EN signal */
-			tps65010_set_gpio_out_value(GPIO4, HIGH);
-		else if (cpu_is_omap24xx()) {
-			u16 reg = OMAP_MMC_READ(host->base, CON);
-			OMAP_MMC_WRITE(host->base, CON, reg | (1 << 11));
-		} else
-			if (host->power_pin >= 0)
-				omap_set_gpio_dataout(host->power_pin, 1);
-	} else {
-		if (machine_is_omap_innovator())
-			innovator_fpga_socket_power(0);
-		else if (machine_is_omap_h2())
-			tps65010_set_gpio_out_value(GPIO3, LOW);
-		else if (machine_is_omap_h3())
-			tps65010_set_gpio_out_value(GPIO4, LOW);
-		else if (cpu_is_omap24xx()) {
-			u16 reg = OMAP_MMC_READ(host->base, CON);
-			OMAP_MMC_WRITE(host->base, CON, reg & ~(1 << 11));
-		} else
-			if (host->power_pin >= 0)
-				omap_set_gpio_dataout(host->power_pin, 0);
-	}
+	if (host->set_power)
+		host->set_power(host->base, on);
+	else if (host->power_pin >= 0)
+		omap_set_gpio_dataout(host->power_pin, on);
 }
 
 static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
@@ -1278,6 +1239,7 @@ static int __init mmc_omap_probe(struct 
 	host->wp_pin = minfo->wp_pin;
 	host->use_dma = 1;
 	host->dma_ch = -1;
+	host->set_power = minfo->set_power;
 
 	host->irq = pdev->resource[1].start;
 	host->base = (void __iomem *)pdev->resource[0].start;
diff --git a/include/asm-arm/arch-omap/board.h b/include/asm-arm/arch-omap/board.h
index 6d6240a..168662f 100644
--- a/include/asm-arm/arch-omap/board.h
+++ b/include/asm-arm/arch-omap/board.h
@@ -46,6 +46,7 @@ struct omap_mmc_conf {
 	s16 power_pin;
 	s16 switch_pin;
 	s16 wp_pin;
+	void (*set_power)(void __iomem *base, int on);
 };
 
 struct omap_mmc_config {
-- 
1.1.6

--0-307864376-1141392261=:43557
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-307864376-1141392261=:43557--
