From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/5 v6] arm: omap: usb: register hwmods of usbhs
Date: Fri, 19 Aug 2011 17:04:04 +0530
Message-ID: <1313753646-29089-4-git-send-email-keshava_mgowda@ti.com>
References: <1313753646-29089-1-git-send-email-keshava_mgowda@ti.com>
 <1313753646-29089-2-git-send-email-keshava_mgowda@ti.com>
 <1313753646-29089-3-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1313753646-29089-3-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org, tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, toddpoynor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The hwmod structure of uhh, ohci, ehci and tll are
retrieved and registered with omap device

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/usb-host.c |  114 +++++++++++++++++----------------------
 1 files changed, 50 insertions(+), 64 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index 89ae298..9c37db9 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -28,51 +28,30 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <plat/usb.h>
+#include <plat/omap_device.h>
 
 #include "mux.h"
 
 #ifdef CONFIG_MFD_OMAP_USB_HOST
 
-#define OMAP_USBHS_DEVICE	"usbhs-omap"
-
-static struct resource usbhs_resources[] = {
-	{
-		.name	= "uhh",
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "tll",
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "ehci",
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "ehci-irq",
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.name	= "ohci",
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "ohci-irq",
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static struct platform_device usbhs_device = {
-	.name		= OMAP_USBHS_DEVICE,
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(usbhs_resources),
-	.resource	= usbhs_resources,
-};
+#define OMAP_USBHS_DEVICE	"usbhs_omap"
+#define	USBHS_UHH_HWMODNAME	"usbhs_uhh"
+#define	USBHS_OHCI_HWMODNAME	"usbhs_ohci"
+#define USBHS_EHCI_HWMODNAME	"usbhs_ehci"
+#define USBHS_TLL_HWMODNAME	"usbhs_tll"
 
 static struct usbhs_omap_platform_data		usbhs_data;
 static struct ehci_hcd_omap_platform_data	ehci_data;
 static struct ohci_hcd_omap_platform_data	ohci_data;
 
+static struct omap_device_pm_latency omap_uhhtll_latency[] = {
+	  {
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func	 = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	  },
+};
+
 /* MUX settings for EHCI pins */
 /*
  * setup_ehci_io_mux - initialize IO pad mux for USBHOST
@@ -508,7 +487,10 @@ static void setup_4430ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 
 void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 {
-	int	i;
+	struct omap_hwmod	*oh[4];
+	struct omap_device	*od;
+	int			bus_id = -1;
+	int			i;
 
 	for (i = 0; i < OMAP3_HS_USB_PORTS; i++) {
 		usbhs_data.port_mode[i] = pdata->port_mode[i];
@@ -523,44 +505,48 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 	usbhs_data.ohci_data = &ohci_data;
 
 	if (cpu_is_omap34xx()) {
-		usbhs_resources[0].start = OMAP34XX_UHH_CONFIG_BASE;
-		usbhs_resources[0].end = OMAP34XX_UHH_CONFIG_BASE + SZ_1K - 1;
-		usbhs_resources[1].start = OMAP34XX_USBTLL_BASE;
-		usbhs_resources[1].end = OMAP34XX_USBTLL_BASE + SZ_4K - 1;
-		usbhs_resources[2].start	= OMAP34XX_EHCI_BASE;
-		usbhs_resources[2].end	= OMAP34XX_EHCI_BASE + SZ_1K - 1;
-		usbhs_resources[3].start = INT_34XX_EHCI_IRQ;
-		usbhs_resources[4].start	= OMAP34XX_OHCI_BASE;
-		usbhs_resources[4].end	= OMAP34XX_OHCI_BASE + SZ_1K - 1;
-		usbhs_resources[5].start = INT_34XX_OHCI_IRQ;
 		setup_ehci_io_mux(pdata->port_mode);
 		setup_ohci_io_mux(pdata->port_mode);
 	} else if (cpu_is_omap44xx()) {
-		usbhs_resources[0].start = OMAP44XX_UHH_CONFIG_BASE;
-		usbhs_resources[0].end = OMAP44XX_UHH_CONFIG_BASE + SZ_1K - 1;
-		usbhs_resources[1].start = OMAP44XX_USBTLL_BASE;
-		usbhs_resources[1].end = OMAP44XX_USBTLL_BASE + SZ_4K - 1;
-		usbhs_resources[2].start = OMAP44XX_HSUSB_EHCI_BASE;
-		usbhs_resources[2].end = OMAP44XX_HSUSB_EHCI_BASE + SZ_1K - 1;
-		usbhs_resources[3].start = OMAP44XX_IRQ_EHCI;
-		usbhs_resources[4].start = OMAP44XX_HSUSB_OHCI_BASE;
-		usbhs_resources[4].end = OMAP44XX_HSUSB_OHCI_BASE + SZ_1K - 1;
-		usbhs_resources[5].start = OMAP44XX_IRQ_OHCI;
 		setup_4430ehci_io_mux(pdata->port_mode);
 		setup_4430ohci_io_mux(pdata->port_mode);
 	}
 
-	if (platform_device_add_data(&usbhs_device,
-				&usbhs_data, sizeof(usbhs_data)) < 0) {
-		printk(KERN_ERR "USBHS platform_device_add_data failed\n");
-		goto init_end;
+	oh[0] = omap_hwmod_lookup(USBHS_UHH_HWMODNAME);
+	if (!oh[0]) {
+		pr_err("Could not look up %s\n", USBHS_UHH_HWMODNAME);
+		return;
+	}
+
+	oh[1] = omap_hwmod_lookup(USBHS_OHCI_HWMODNAME);
+	if (!oh[1]) {
+		pr_err("Could not look up %s\n", USBHS_UHH_HWMODNAME);
+		return;
 	}
 
-	if (platform_device_register(&usbhs_device) < 0)
-		printk(KERN_ERR "USBHS platform_device_register failed\n");
+	oh[2] = omap_hwmod_lookup(USBHS_EHCI_HWMODNAME);
+	if (!oh[2]) {
+		pr_err("Could not look up %s\n", USBHS_TLL_HWMODNAME);
+		return;
+	}
 
-init_end:
-	return;
+	oh[3] = omap_hwmod_lookup(USBHS_TLL_HWMODNAME);
+	if (!oh[3]) {
+		pr_err("Could not look up %s\n", USBHS_TLL_HWMODNAME);
+		return;
+	}
+
+	od = omap_device_build_ss(OMAP_USBHS_DEVICE, bus_id, oh, 4,
+				(void *)&usbhs_data, sizeof(usbhs_data),
+				omap_uhhtll_latency,
+				ARRAY_SIZE(omap_uhhtll_latency), false);
+
+	if (IS_ERR(od)) {
+		pr_err("Could not build hwmod devices %s, %s, %s, %s\n",
+			USBHS_UHH_HWMODNAME, USBHS_OHCI_HWMODNAME,
+			USBHS_EHCI_HWMODNAME, USBHS_TLL_HWMODNAME);
+		return;
+	}
 }
 
 #else
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
