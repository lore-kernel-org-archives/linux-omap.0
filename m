From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 2/7] ARM: OMAP: devices: create device for usb part of control module
Date: Tue, 15 Jan 2013 14:12:53 +0530
Message-ID: <1358239378-10030-3-git-send-email-kishon@ti.com>
References: <1358239378-10030-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358239378-10030-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grant.likely@secretlab.ca, b-cousson@ti.com, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, arnd@arndb.de, balbi@ti.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

A seperate driver has been added to handle the usb part of control
module. A device for the above driver is created here, using the register
address information to be used by the driver for powering on the PHY and
for writing to the mailbox.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/devices.c |   50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 5e304d0..a761faf4 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -20,6 +20,7 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/omap4-keypad.h>
 #include <linux/platform_data/omap_ocp2scp.h>
+#include <linux/usb/omap_control_usb.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
@@ -254,6 +255,54 @@ static inline void omap_init_camera(void)
 #endif
 }
 
+#if (defined(CONFIG_OMAP_CONTROL_USB) || \
+				defined(CONFIG_OMAP_CONTROL_USB_MODULE))
+
+static struct omap_control_usb_platform_data omap4_control_usb_pdata = {
+	.has_mailbox = true,
+};
+
+struct resource omap4_control_usb_res[] = {
+	{
+		.name	= "control_dev_conf",
+		.start	= 0x4a002300,
+		.end	= 0x4a002303,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.name	= "otghs_control",
+		.start	= 0x4a00233c,
+		.end	= 0x4a00233f,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device omap4_control_usb = {
+	.name		= "omap-control-usb",
+	.id		= -1,
+	.dev = {
+		.platform_data = &omap4_control_usb_pdata,
+	},
+	.num_resources = 2,
+	.resource = omap4_control_usb_res,
+};
+
+static inline void __init omap_init_control_usb(void)
+{
+	int ret = 0;
+
+	if (cpu_is_omap44xx()) {
+		ret = platform_device_register(&omap4_control_usb);
+		if (ret)
+			pr_err("Error registering omap_control_usb device: %d\n"
+			    , ret);
+	}
+}
+
+#else
+static inline void omap_init_control_usb(void) { }
+#endif /* CONFIG_OMAP_CONTROL_USB */
+
 int __init omap4_keyboard_init(struct omap4_keypad_platform_data
 			*sdp4430_keypad_data, struct omap_board_data *bdata)
 {
@@ -721,6 +770,7 @@ static int __init omap2_init_devices(void)
 	omap_init_mbox();
 	/* If dtb is there, the devices will be created dynamically */
 	if (!of_have_populated_dt()) {
+		omap_init_control_usb();
 		omap_init_dmic();
 		omap_init_mcpdm();
 		omap_init_mcspi();
-- 
1.7.9.5
