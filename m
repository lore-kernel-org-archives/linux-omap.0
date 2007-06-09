From: Vivien Chappelier <vivien.chappelier@free.fr>
Subject: [PATCH 7/12] USB fixes for OMAP730
Date: Sat, 9 Jun 2007 20:42:05 +0200
Message-ID: <20070609184205.GG1889@varda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

This patch fixes support for USB on OMAP730/850. It also adds support to 
disable DMA as it is not working on OMAP730. Finally it adds HTC phones to the
list of devices that do not know how to do VBUS sensing.

Signed-off-by: Vivien Chappelier <vivien.chappelier@free.fr>

---
 arch/arm/plat-omap/usb.c      |   14 ++++++++++----
 drivers/usb/gadget/omap_udc.c |   34 +++++++++++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index a5aedf9..667ebfa 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -148,9 +148,11 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
 		 *  - OTG support on this port not yet written
 		 */
 
-		USB_TRANSCEIVER_CTRL_REG &= ~(7 << 4);
-		if (!is_device)
-			USB_TRANSCEIVER_CTRL_REG |= (3 << 1);
+		if(!cpu_is_omap730()) {
+			USB_TRANSCEIVER_CTRL_REG &= ~(7 << 4);
+			if (!is_device)
+				USB_TRANSCEIVER_CTRL_REG |= (3 << 1);
+		}
 
 		return 3 << 16;
 	}
@@ -574,7 +576,11 @@ omap_otg_init(struct omap_usb_config *config)
 	if (config->otg || config->register_dev) {
 		syscon &= ~DEV_IDLE_EN;
 		udc_device.dev.platform_data = config;
-		/* FIXME patch IRQ numbers for omap730 */
+		if (cpu_is_omap730()) {
+			udc_resources[1].start = INT_730_USB_GENI;
+			udc_resources[2].start = INT_730_USB_NON_ISO;
+			udc_resources[3].start = INT_730_USB_ISO;
+		}
 		status = platform_device_register(&udc_device);
 		if (status)
 			pr_debug("can't register UDC device, %d\n", status);
diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index 1577254..4e2ded7 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -101,7 +101,7 @@ static unsigned fifo_mode = 0;
 #endif
 
 /* "modprobe omap_udc fifo_mode=42", or else as a kernel
- * boot parameter "omap_udc:fifo_mode=42"
+ * boot parameter "omap_udc=fifo_mode:42"
  */
 module_param (fifo_mode, uint, 0);
 MODULE_PARM_DESC (fifo_mode, "endpoint configuration");
@@ -109,8 +109,8 @@ MODULE_PARM_DESC (fifo_mode, "endpoint configuration");
 #ifdef	USE_DMA
 static unsigned use_dma = 1;
 
-/* "modprobe omap_udc use_dma=y", or else as a kernel
- * boot parameter "omap_udc:use_dma=y"
+/* "modprobe omap_udc use_dma=n", or else as a kernel
+ * boot parameter "omap_udc=nodma" to disable DMA
  */
 module_param (use_dma, bool, 0);
 MODULE_PARM_DESC (use_dma, "enable/disable DMA");
@@ -2160,6 +2160,7 @@ static inline int machine_without_vbus_sense(void)
 		|| machine_is_omap_h4()
 #endif
 		|| machine_is_sx1()
+		|| machine_is_typhoon()
 		);
 }
 
@@ -2664,6 +2665,7 @@ omap_ep_setup(char *name, u8 addr, u8 type,
 		 */
 		if ((!use_dma && (addr & USB_DIR_IN))
 				|| machine_is_omap_apollon()
+				|| machine_is_typhoon()
 				|| cpu_is_omap15xx())
 			dbuf = 0;
 
@@ -3176,6 +3178,32 @@ static struct platform_driver udc_driver = {
 	},
 };
 
+#ifndef MODULE
+/* Process kernel command line parameters */
+static int __init udc_setup(char *this_opt)
+{
+	char *options;
+
+	if (!this_opt || !*this_opt)
+		return 0;
+
+	while ((options = strsep(&this_opt, ",")) != NULL) {
+		if (!strncmp(options, "fifo_mode:", 10)) {
+			options += 10;
+			if (*options)
+				fifo_mode = 
+					simple_strtoul(options, &options, 10);
+		}
+
+		if (!strncmp(options, "nodma", 5))
+			use_dma = 0;
+	}
+	return 0;
+}
+
+__setup("omap_udc=", udc_setup);
+#endif
+
 static int __init udc_init(void)
 {
 	INFO("%s, version: " DRIVER_VERSION
-- 
1.5.1.3
