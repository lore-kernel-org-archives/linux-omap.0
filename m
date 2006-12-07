From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.19] omap camera builds again; Mistral hooks
Date: Wed, 06 Dec 2006 19:45:09 -0800
Message-ID: <20061207034509.5BC701E771D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

Support the camera connector on the OSK Mistral add-on board:
  
  - define muxing for both camera controllers
  - mux both of them for Mistral 
  - teach ov9640 glue about mistral powerup/powerdown

Fix some bitrot, including basic build/load functionality:

  - ov9640 code had syntax errors (!) and referenced missing fields
  - camera core included all kinds of crap, but not the v4l2 stuff
  - both omap16xx and 17xx used the wrong base clock
  - 16xx oopsed because its base clock did not exist
  - misuse of machine_is_omap_h3() in place of cpu_is_omap1710()
  - several exported symbols were goofed up
  - used bad call to reserve mem region
  - didn't destroy platform device correctly
  - ov9640 needed MODULE_LICENSE("GPL")

It's probably best to think of this as just making the camera code
build again, load/unload as modules, stop oopsing on 16xx, and be
a smidgeon cleaner ... since my (early/prototype) Mistral board won't
actually get to UBoot when a camera is connected.  :(

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


Index: osk2/include/asm-arm/arch-omap/mux.h
===================================================================
--- osk2.orig/include/asm-arm/arch-omap/mux.h	2006-12-06 12:57:52.000000000 -0800
+++ osk2/include/asm-arm/arch-omap/mux.h	2006-12-06 12:58:14.000000000 -0800
@@ -406,6 +406,29 @@ enum omap1xxx_index {
 	V10_1610_CF_IREQ,
 	W10_1610_CF_RESET,
 	W11_1610_CF_CD1,
+
+	/* parallel camera */
+	J15_1610_CAM_LCLK,
+	J18_1610_CAM_D7,
+	J19_1610_CAM_D6,
+	J14_1610_CAM_D5,
+	K18_1610_CAM_D4,
+	K19_1610_CAM_D3,
+	K15_1610_CAM_D2,
+	K14_1610_CAM_D1,
+	L19_1610_CAM_D0,
+	L18_1610_CAM_VS,
+	L15_1610_CAM_HS,
+	M19_1610_CAM_RSTZ,
+	Y15_1610_CAM_OUTCLK,
+
+	/* serial camera */
+	H19_1610_CAM_EXCLK,
+	Y12_1610_CCP_CLKP,
+	W13_1610_CCP_CLKM,
+	W14_1610_CCP_DATAP,
+	Y14_1610_CCP_DATAM,
+
 };
 
 enum omap24xx_index {
Index: osk2/arch/arm/mach-omap1/mux.c
===================================================================
--- osk2.orig/arch/arm/mach-omap1/mux.c	2006-12-06 12:57:52.000000000 -0800
+++ osk2/arch/arm/mach-omap1/mux.c	2006-12-06 12:58:14.000000000 -0800
@@ -283,6 +283,30 @@ MUX_CFG("R11_1610_CF_IOIS16",	 B,    0, 
 MUX_CFG("V10_1610_CF_IREQ",	 A,   24,    3,	  2,   14,   0,	  2,	 0,  1)
 MUX_CFG("W10_1610_CF_RESET",	 A,   18,    3,	  2,   12,   1,	  2,	 1,  1)
 MUX_CFG("W11_1610_CF_CD1",	10,   15,    3,	  3,    8,   1,	  3,	 1,  1)
+
+/* parallel camera */
+MUX_CFG("J15_1610_CAM_LCLK",	 4,   24,    0,   0,  18,   1,    0,     0,  0)
+MUX_CFG("J18_1610_CAM_D7",	 4,   27,    0,   0,  19,   1,    0,     0,  0)
+MUX_CFG("J19_1610_CAM_D6",	 5,    0,    0,   0,  20,   1,    0,     0,  0)
+MUX_CFG("J14_1610_CAM_D5",	 5,    3,    0,   0,  21,   1,    0,     0,  0)
+MUX_CFG("K18_1610_CAM_D4",	 5,    6,    0,   0,  22,   1,    0,     0,  0)
+MUX_CFG("K19_1610_CAM_D3",	 5,    9,    0,   0,  23,   1,    0,     0,  0)
+MUX_CFG("K15_1610_CAM_D2",	 5,   12,    0,   0,  24,   1,    0,     0,  0)
+MUX_CFG("K14_1610_CAM_D1",	 5,   15,    0,   0,  25,   1,    0,     0,  0)
+MUX_CFG("L19_1610_CAM_D0",	 5,   18,    0,   0,  26,   1,    0,     0,  0)
+MUX_CFG("L18_1610_CAM_VS",	 5,   21,    0,   0,  27,   1,    0,     0,  0)
+MUX_CFG("L15_1610_CAM_HS",	 5,   24,    0,   0,  28,   1,    0,     0,  0)
+MUX_CFG("M19_1610_CAM_RSTZ",	 5,   27,    0,   0,  29,   0,    0,     0,  0)
+MUX_CFG("Y15_1610_CAM_OUTCLK",	 A,    0,    6,   2,   6,   0,    2,     0,  0)
+
+/* serial camera */
+MUX_CFG("H19_1610_CAM_EXCLK",	 4,   21,    0,   0,  17,   0,    0,     0,  0)
+	/* REVISIT 5912 spec sez CCP_* can't pullup or pulldown ... ? */
+MUX_CFG("Y12_1610_CCP_CLKP",	 8,   18,    6,   1,  24,   1,    1,     0,  0)
+MUX_CFG("W13_1610_CCP_CLKM",	 9,    0,    6,   1,  28,   1,    1,     0,  0)
+MUX_CFG("W14_1610_CCP_DATAP",	 9,   24,    6,   2,   4,   1,    2,     0,  0)
+MUX_CFG("Y14_1610_CCP_DATAM",	 9,   21,    6,   2,   3,   1,    2,     0,  0)
+
 };
 #endif	/* CONFIG_ARCH_OMAP15XX || CONFIG_ARCH_OMAP16XX */
 
Index: osk2/arch/arm/mach-omap1/board-osk.c
===================================================================
--- osk2.orig/arch/arm/mach-omap1/board-osk.c	2006-12-06 12:57:52.000000000 -0800
+++ osk2/arch/arm/mach-omap1/board-osk.c	2006-12-06 12:58:14.000000000 -0800
@@ -342,6 +342,38 @@ static void __init osk_mistral_init(void
 	 * can't talk to the ads or even the i2c eeprom.
 	 */
 
+	/* parallel camera interface */
+	omap_cfg_reg(J15_1610_CAM_LCLK);
+	omap_cfg_reg(J18_1610_CAM_D7);
+	omap_cfg_reg(J19_1610_CAM_D6);
+	omap_cfg_reg(J14_1610_CAM_D5);
+	omap_cfg_reg(K18_1610_CAM_D4);
+	omap_cfg_reg(K19_1610_CAM_D3);
+	omap_cfg_reg(K15_1610_CAM_D2);
+	omap_cfg_reg(K14_1610_CAM_D1);
+	omap_cfg_reg(L19_1610_CAM_D0);
+	omap_cfg_reg(L18_1610_CAM_VS);
+	omap_cfg_reg(L15_1610_CAM_HS);
+	omap_cfg_reg(M19_1610_CAM_RSTZ);
+	omap_cfg_reg(Y15_1610_CAM_OUTCLK);
+
+	/* serial camera interface */
+	omap_cfg_reg(H19_1610_CAM_EXCLK);
+	omap_cfg_reg(W13_1610_CCP_CLKM);
+	omap_cfg_reg(Y12_1610_CCP_CLKP);
+	/* CCP_DATAM CONFLICTS WITH UART1.TX (and serial console) */
+	// omap_cfg_reg(Y14_1610_CCP_DATAM);
+	omap_cfg_reg(W14_1610_CCP_DATAP);
+
+	/* CAM_PWDN */
+	if (omap_request_gpio(11) == 0) {
+		omap_cfg_reg(N20_1610_GPIO11);
+		omap_set_gpio_direction(11, 0 /* out */);
+		omap_set_gpio_dataout(11, 0 /* off */);
+	} else
+		pr_debug("OSK+Mistral: CAM_PWDN is awol\n");
+
+
 	// omap_cfg_reg(P19_1610_GPIO6);	// BUSY
 	omap_cfg_reg(P20_1610_GPIO4);	// PENIRQ
 	set_irq_type(OMAP_GPIO_IRQ(4), IRQT_FALLING);
Index: osk2/drivers/media/video/omap/omap16xxcam.c
===================================================================
--- osk2.orig/drivers/media/video/omap/omap16xxcam.c	2006-12-06 12:57:52.000000000 -0800
+++ osk2/drivers/media/video/omap/omap16xxcam.c	2006-12-06 12:58:14.000000000 -0800
@@ -38,7 +38,8 @@
 #include "omap16xxcam.h"
 #include "camera_hw_if.h"
 #include "camera_core.h"
-  
+ 
+
 #define CONF_CAMERAIF_RESET_R 5
 #define EN_PER	  0
 
@@ -68,7 +69,9 @@ struct omap16xxcam {
 	unsigned long iobase_phys;
 
 	/* frequncy (in Hz) of camera interface functional clock (ocp_clk) */
-	unsigned long ocp_clk; 
+	unsigned long ocp_clk;
+
+	struct clk *func_clk;
 
 	/* dma related stuff */
 	spinlock_t dma_lock;
@@ -79,7 +82,7 @@ struct omap16xxcam {
 	int dma_channel_number2;
 
 	wait_queue_head_t vsync_wait;
-	
+
 	int new;
 };
 static struct omap16xxcam hardware_data;
@@ -124,15 +127,10 @@ omap16xx_cam_init(void)
 			OMAP1610_RESET_CONTROL);
     
 	/* Enable peripheral reset */
-	omap_writew(omap_readw(ARM_RSTCT2) | (1 << EN_PER), ARM_RSTCT2); 
+	omap_writew(omap_readw(ARM_RSTCT2) | (1 << EN_PER), ARM_RSTCT2);
 
 	/* enable peripheral clock */
-	if (machine_is_omap_h3())
-		clk_enable(clk_get(0, "tc2_ck"));
-	else {
-		clk_enable(clk_get(0, "armper_ck"));
-		clk_enable(clk_get(0, "armxor_ck"));
-	}		
+	clk_enable(hardware_data.func_clk);
 }
 
 static void
@@ -321,8 +319,8 @@ omap16xxcam_start_dma(struct sgdma_state
 	data->camdma[count].callback = callback;
 	data->camdma[count].arg1 = arg1;
 	data->camdma[count].arg2 = arg2;
-	
-	if (machine_is_omap_h3())
+
+	if (cpu_is_omap1710())
 		omap_set_dma_src_params(dmach, OMAP_DMA_PORT_OCP_T1,
 			    OMAP_DMA_AMODE_CONSTANT, CAM_CAMDATA_REG,
 			    0, 0);
@@ -507,19 +505,25 @@ omap16xxcam_cleanup(void *priv)
 {
 	struct omap16xxcam *data = (struct omap16xxcam *) priv;
 
+	if (!data->camera_regs)
+		return -EINVAL;
+
 	omap16xxcam_disable(data);
-	if (machine_is_omap_h3()) {
-		if (data->camera_regs) {	
-			iounmap((void *)data->camera_regs);
-			data->camera_regs= NULL;
-		}
-	}
+	if (cpu_is_omap1710())
+		iounmap((void *)data->camera_regs);
+	data->camera_regs= NULL;
 
 	if (data->iobase_phys) {
 		release_mem_region(data->iobase_phys, CAMERA_IOSIZE);
 		data->iobase_phys = 0;
 	}
 
+	if (hardware_data.func_clk) {
+		clk_disable(hardware_data.func_clk);
+		clk_put(hardware_data.func_clk);
+		hardware_data.func_clk = NULL;
+	}
+
 	return 0;
 }
 
@@ -529,13 +533,15 @@ omap16xxcam_init(void)
 {
 	unsigned long cam_iobase;
 
-	if (!request_region(CAMERA_BASE, CAMERA_IOSIZE, "OAMP16xx Camera")) {
-		printk ("OMAP16XX Parallel Camera Interface is already in use\n");
+	if (!request_mem_region(CAMERA_BASE, CAMERA_IOSIZE,
+				camera_hardware_if.name)) {
+		pr_debug("%s is already in use\n", camera_hardware_if.name);
 		return NULL;
 	}
 
-	if (machine_is_omap_h3()) {
-		cam_iobase = (unsigned long) ioremap (CAMERA_BASE, CAMERA_IOSIZE);
+	if (cpu_is_omap1710()) {
+		cam_iobase = (unsigned long) ioremap (CAMERA_BASE,
+				CAMERA_IOSIZE);
 		if (!cam_iobase) {
 			printk("CANNOT MAP CAMERA REGISTER\n");
 			return NULL;
@@ -547,11 +553,13 @@ omap16xxcam_init(void)
 	/* Set the base address of the camera registers */
 	hardware_data.camera_regs = (camera_regs_t *)cam_iobase;
 	hardware_data.iobase_phys = (unsigned long) CAMERA_BASE;
- 	/* get the input clock value to camera interface and store it */
-	if (machine_is_omap_h3())
-		hardware_data.ocp_clk = clk_get_rate(clk_get(0, "tc_ck"));
+
+	/* get the input clock value to camera interface and store it */
+	if (cpu_is_omap1710())
+		hardware_data.func_clk = clk_get(0, "tc2_ck");
 	else
-		hardware_data.ocp_clk = clk_get_rate(clk_get(0, "mpuper_ck"));
+		hardware_data.func_clk = clk_get(0, "armper_ck");
+	hardware_data.ocp_clk = clk_get_rate(hardware_data.func_clk);
 
 	/* Init the camera IF */
 	omap16xx_cam_init();
@@ -566,7 +574,7 @@ omap16xxcam_init(void)
 
 struct camera_hardware camera_hardware_if = {
 	.version	= 0x01,
-	.name		= "OMAP16xx Camera Parallel",
+	.name		= "OMAP16xx Parallel Camera",
 	.init		= omap16xxcam_init,
 	.cleanup	= omap16xxcam_cleanup,
 	.open		= omap16xxcam_open,
Index: osk2/drivers/media/video/omap/sensor_ov9640.c
===================================================================
--- osk2.orig/drivers/media/video/omap/sensor_ov9640.c	2006-12-06 12:57:52.000000000 -0800
+++ osk2/drivers/media/video/omap/sensor_ov9640.c	2006-12-06 12:58:14.000000000 -0800
@@ -20,14 +20,13 @@
 #include <media/video-buf.h>
 #include <linux/delay.h>
 #include <asm/mach-types.h>
+#include <asm/arch/gpio.h>
 
 #include "sensor_if.h"
 #include "ov9640.h"
 #include "h3sensorpower.h"
 #include "h4sensorpower.h"
 
-#define CAMERA_OV9640
-#ifdef CAMERA_OV9640
 
 struct ov9640_sensor {
 	/* I2C parameters */
@@ -696,6 +695,11 @@ ov9640_powerup(void)
 	if (machine_is_omap_h2())
 		return 0;
 
+#ifdef	CONFIG_OMAP_OSK_MISTRAL
+	if (machine_is_omap_osk())
+		omap_set_gpio_dataout(11, 1);
+#endif
+
 	if (machine_is_omap_h3()) {
 		err = h3_sensor_powerup();
 		if (err)
@@ -718,6 +722,11 @@ ov9640_powerdown(void)
 	if (machine_is_omap_h2())
 		return 0;
 
+#ifdef	CONFIG_OMAP_OSK_MISTRAL
+	if (machine_is_omap_osk())
+		omap_set_gpio_dataout(11, 0);
+#endif
+
 	if (machine_is_omap_h3()) {
 		err = h3_sensor_powerdown();
 		if (err)
@@ -806,6 +815,7 @@ ov9640_i2c_attach_client(struct i2c_adap
 	client->addr = addr;
 	client->driver = &ov9640sensor_i2c_driver;
 	client->adapter = adap;
+	strcpy(client->name, ov9640sensor_i2c_driver.driver.name);
 
 	err = i2c_attach_client(client);
 	if (err) {
@@ -1125,7 +1135,7 @@ ov9640sensor_cleanup(void *priv)
 
 
 static struct i2c_driver ov9640sensor_i2c_driver = {
-	.driver {
+	.driver = {
 		.name		= "ov9640",
 	},
 	.id		= I2C_DRIVERID_MISC, /*FIXME:accroding to i2c-ids.h */
@@ -1180,10 +1190,6 @@ ov9640sensor_init(struct v4l2_pix_format
 struct omap_camera_sensor camera_sensor_if = {
 	.version	= 0x01,
 	.name		= "OV9640",
-	.parallel_mode	= PAR_MODE_NOBT8,
-	.hs_polarity	= SYNC_ACTIVE_HIGH,
-	.vs_polarity	= SYNC_ACTIVE_LOW,
-	.image_swap 	= 0,
 	.init		= ov9640sensor_init,
 	.cleanup	= ov9640sensor_cleanup,
 	.enum_pixformat = ov9640sensor_enum_pixformat,
@@ -1196,7 +1202,11 @@ struct omap_camera_sensor camera_sensor_
 	.power_on	= ov9640sensor_power_on,
 	.power_off	= ov9640sensor_power_off,
 };
+EXPORT_SYMBOL_GPL(camera_sensor_if);
 
+MODULE_LICENSE("GPL");
+
+#if 0
 void print_ov9640_regs(void *priv)
 {
 	struct ov9640_sensor *sensor = (struct ov9640_sensor *) priv;
@@ -1207,5 +1217,4 @@ void print_ov9640_regs(void *priv)
 		else
 			printk("reg %x = %x\n", reg, val);	 
 }
-
-#endif	/* ifdef CAMERA_OV9640 */
+#endif
Index: osk2/drivers/media/video/omap/camera_core.c
===================================================================
--- osk2.orig/drivers/media/video/omap/camera_core.c	2006-12-06 12:57:52.000000000 -0800
+++ osk2/drivers/media/video/omap/camera_core.c	2006-12-06 12:58:14.000000000 -0800
@@ -20,40 +20,24 @@
  * History:
  *   27/03/05   Vladimir Barinov - Added support for power management
  */
- 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
-#include <linux/fs.h>
-#include <linux/vmalloc.h>
-#include <linux/slab.h>
-#include <linux/proc_fs.h>
-#include <linux/ctype.h>
-#include <linux/pagemap.h>
-#include <linux/mm.h>
 #include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/videodev.h>
-#include <linux/pci.h>
 #include <linux/version.h>
-#include <asm/semaphore.h>
-#include <asm/processor.h>
 #include <linux/dma-mapping.h>
 #include <linux/fb.h>
 
+#include <media/v4l2-common.h>
+
 #include <asm/io.h>
-#include <asm/byteorder.h>
-#include <asm/irq.h>
 
 #include "sensor_if.h"
 #include "camera_hw_if.h"
 #include "camera_core.h"
- 
-struct camera_device *camera_dev;
-extern struct omap_camera_sensor camera_sensor_if;
-extern struct camera_hardware camera_hardware_if;
- 
+
+
+static struct camera_device *camera_dev;
 static void camera_core_sgdma_process(struct camera_device *cam);
 
 /* module parameters */
@@ -1165,39 +1149,40 @@ static struct platform_driver camera_cor
 #endif
 };
 
-static struct platform_device camera_core_device = {
-	.name	= CAM_NAME,
-	.dev	= {
-			.release 	= NULL,
-		  },
-	.id	= 0,
-};
 
-void __exit
+/* FIXME register omap16xx or omap24xx camera device in arch/arm/...
+ * system init code, with its resources and mux setup, NOT here.
+ * Then MODULE_ALIAS(CAM_NAME) so it hotplugs and coldplugs; this
+ * "legacy" driver style is trouble.
+ */
+static struct platform_device *cam;
+
+static void __exit
 camera_core_cleanup(void)
 {
 	platform_driver_unregister(&camera_core_driver);
-	platform_device_unregister(&camera_core_device);
 
-	return;
+	platform_device_unregister(cam);
 }
 
 static char banner[] __initdata = KERN_INFO "OMAP Camera driver initialzing\n";
 
-int __init 
+static int __init
 camera_core_init(void)
 {
 
 	printk(banner);
-	platform_device_register(&camera_core_device);
 	platform_driver_register(&camera_core_driver);
 
+	cam = platform_device_register_simple(CAM_NAME, -1, NULL, 0);
+
 	return 0;
 }
 
 MODULE_AUTHOR("Texas Instruments.");
 MODULE_DESCRIPTION("OMAP Video for Linux camera driver");
 MODULE_LICENSE("GPL");
+
 module_param(video_nr, int, 0);
 MODULE_PARM_DESC(video_nr, 
 		"Minor number for video device (-1 ==> auto assign)");
Index: osk2/drivers/media/video/omap/sensor_if.h
===================================================================
--- osk2.orig/drivers/media/video/omap/sensor_if.h	2006-12-06 12:57:52.000000000 -0800
+++ osk2/drivers/media/video/omap/sensor_if.h	2006-12-06 12:58:14.000000000 -0800
@@ -44,5 +44,7 @@ struct omap_camera_sensor {
 	int (*set_control)(struct v4l2_control *, void *);
 
 };
-	
+
+extern struct omap_camera_sensor camera_sensor_if;
+
 #endif
Index: osk2/drivers/media/video/omap/camera_core.h
===================================================================
--- osk2.orig/drivers/media/video/omap/camera_core.h	2006-12-06 12:57:52.000000000 -0800
+++ osk2/drivers/media/video/omap/camera_core.h	2006-12-06 12:58:14.000000000 -0800
@@ -151,6 +151,6 @@ struct camera_fh {
 	struct videobuf_queue vbq;
 };
 
-#define CAM_NAME "omap-camera"
+#define CAM_NAME "omap_camera"
 
 #endif /* CAMERA_CORE__H */
Index: osk2/drivers/media/video/omap/camera_hw_if.h
===================================================================
--- osk2.orig/drivers/media/video/omap/camera_hw_if.h	2006-12-06 12:57:52.000000000 -0800
+++ osk2/drivers/media/video/omap/camera_hw_if.h	2006-12-06 12:58:14.000000000 -0800
@@ -44,5 +44,7 @@ struct camera_hardware {
 			void *, void *, void *);
 	int (*finish_dma)(void *);
 };
- 
+
+extern struct camera_hardware camera_hardware_if;
+
 #endif /* OMAP_CAMERA_HW_IF_H */
