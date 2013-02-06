From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/5] ARM: OMAP: devices: create device for usb part of control
 module
Date: Wed, 6 Feb 2013 11:28:10 +0530
Message-ID: <1360130294-5976-3-git-send-email-kishon@ti.com>
References: <1360130294-5976-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1360130294-5976-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, tony@atomide.com, linux@arm.linux.org.uk, eballetbo@gmail.com, javier@dowhile0.org, b-cousson@ti.com, balbi@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc: kishon@ti.com
List-Id: linux-omap@vger.kernel.org

A seperate driver has been added to handle the usb part of control
module. A device for the above driver is created here, using the register
address information to be used by the driver for powering on the PHY and
for writing to the mailbox.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c |   45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 626f3ea..6cda103 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -20,6 +20,7 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/omap4-keypad.h>
 #include <linux/platform_data/omap_ocp2scp.h>
+#include <linux/usb/omap_control_usb.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
@@ -254,6 +255,49 @@ static inline void omap_init_camera(void)
 #endif
 }
 
+#if IS_ENABLED(CONFIG_OMAP_CONTROL_USB)
+static struct omap_control_usb_platform_data omap4_control_usb_pdata = {
+	.type = 1,
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
+	if (!cpu_is_omap44xx())
+		return;
+
+	if (platform_device_register(&omap4_control_usb))
+		pr_err("Error registering omap_control_usb device\n");
+}
+
+#else
+static inline void omap_init_control_usb(void) { }
+#endif /* CONFIG_OMAP_CONTROL_USB */
+
 int __init omap4_keyboard_init(struct omap4_keypad_platform_data
 			*sdp4430_keypad_data, struct omap_board_data *bdata)
 {
@@ -721,6 +765,7 @@ static int __init omap2_init_devices(void)
 	omap_init_mbox();
 	/* If dtb is there, the devices will be created dynamically */
 	if (!of_have_populated_dt()) {
+		omap_init_control_usb();
 		omap_init_dmic();
 		omap_init_mcpdm();
 		omap_init_mcspi();
-- 
1.7.10.4
