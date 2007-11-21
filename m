From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 2/2] ARM: OMAP2: Camera: Improve ov9640 code on board-h4.c
Date: Wed, 21 Nov 2007 12:43:51 -0400
Message-ID: <1195663431-20390-3-git-send-email-edubezval@gmail.com>
References: <1195663431-20390-1-git-send-email-edubezval@gmail.com>
	<1195663431-20390-2-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1195663431-20390-2-git-send-email-edubezval@gmail.com>
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
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>, Sakari Ailus <sakari.ailus@nokia.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

- Removes unnecessary structures and functions when config OV9640
is not selected.
- Reduces powerset code for ov9640.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 arch/arm/mach-omap2/board-h4.c |   70 ++++++++++++---------------------------
 1 files changed, 22 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 85649bb..8fde838 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -525,6 +525,7 @@ static void __init tusb_evm_setup(void)
 
 #endif
 
+#if defined(CONFIG_VIDEO_OV9640) || defined(CONFIG_VIDEO_OV9640_MODULE)
 /*
  * Common OV9640 register initialization for all image sizes, pixel formats,
  * and frame rates
@@ -563,63 +564,37 @@ const static struct ov9640_reg ov9640_common[] = {
 	{ OV9640_REG_TERM, OV9640_VAL_TERM }
 };
 
-#if defined(CONFIG_VIDEO_OV9640) || defined(CONFIG_VIDEO_OV9640_MODULE)
-static int ov9640_sensor_powerup(void)
+static int ov9640_sensor_power_set(int power)
 {
 	unsigned char expa;
 	int err;
 
 	/* read current state of GPIO EXPA outputs */
 	if ((err = read_gpio_expa(&expa, 0x20))) {
-		printk(KERN_ERR "Error reading GPIO EXPA\n");
-		return err;
-	}
-	/* Set GPIO EXPA P3 (CAMERA_MODULE_EN) to power-up sensor */
-	if ((err = write_gpio_expa(expa | 0x08, 0x20))) {
-		printk(KERN_ERR "Error writing to GPIO EXPA\n");
-		return err;
-	}
-
-	/* read current state of GPIO EXPA outputs */
-	if ((err = read_gpio_expa(&expa, 0x22))) {
-		printk(KERN_ERR "Error reading GPIO EXPA\n");
-		return err;
-	}
-	/* Clear GPIO EXPA P7 (CAM_RST) */
-	if ((err = write_gpio_expa(expa & ~0x80, 0x22))) {
-		printk(KERN_ERR "Error writing to GPIO EXPA\n");
+		printk(KERN_ERR "Error reading GPIO EXPA 0x20\n");
 		return err;
 	}
 
-	return 0;
-}
-static int ov9640_sensor_powerdown(void)
-{
-	unsigned char expa;
-	int err;
+	expa = power ? expa | 0x80 : expa & ~0x08;
 
-	/* read current state of GPIO EXPA outputs */
-	if ((err = read_gpio_expa(&expa, 0x20))) {
-		printk(KERN_ERR "Error reading GPIO EXPA\n");
-		return err;
-	}
-	/* Clear GPIO EXPA P3 (CAMERA_MODULE_EN) to power-down sensor */
-	if ((err = write_gpio_expa(expa & ~0x08, 0x20))) {
-		printk(KERN_ERR "Error writing to GPIO EXPA\n");
+	/* Set GPIO EXPA P3 (CAMERA_MODULE_EN) to power-up sensor */
+	if ((err = write_gpio_expa(expa, 0x20))) {
+		printk(KERN_ERR "Error writing to GPIO EXPA 0x20\n");
 		return err;
 	}
 
-	return 0;
-}
-
-static int ov9640_sensor_power_set(int power)
-{
-	int err = 0;
-
-	if (power)
-		err = ov9640_sensor_powerup();
-	else
-		err = ov9640_sensor_powerdown();
+	if (power) {
+		/* read current state of GPIO EXPA outputs */
+		if ((err = read_gpio_expa(&expa, 0x22))) {
+			printk(KERN_ERR "Error reading GPIO EXPA\n");
+			return err;
+		}
+		/* Clear GPIO EXPA P7 (CAM_RST) */
+		if ((err = write_gpio_expa(expa & ~0x80, 0x22))) {
+			printk(KERN_ERR "Error writing to GPIO EXPA\n");
+			return err;
+		}
+	}
 
 	return err;
 }
@@ -643,16 +618,13 @@ static int ov9640_ifparm(struct v4l2_ifparm *p)
 
 	return 0;
 }
-#else
-static int ov9640_sensor_power_set(int power) { return 0; }
-static int ov9640_ifparm(struct v4l2_ifparm *p) { return 0; }
-#endif
 
 static struct ov9640_platform_data h4_ov9640_platform_data = {
 	.power_set	= ov9640_sensor_power_set,
 	.default_regs	= ov9640_common,
 	.ifparm		= ov9640_ifparm,
 };
+#endif
 
 static struct i2c_board_info __initdata h4_i2c_board_info[] = {
 	{
@@ -664,10 +636,12 @@ static struct i2c_board_info __initdata h4_i2c_board_info[] = {
 		I2C_BOARD_INFO("menelaus", 0x72),
 		.irq = INT_24XX_SYS_NIRQ,
 	},
+#if defined(CONFIG_VIDEO_OV9640) || defined(CONFIG_VIDEO_OV9640_MODULE)
 	{
 		I2C_BOARD_INFO("ov9640", 0x30),
 		.platform_data = &h4_ov9640_platform_data,
 	},
+#endif
 };
 
 static void __init omap_h4_init(void)
-- 
1.5.3.4.206.g58ba4
