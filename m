From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH V2 2/5] ARM: OMAP: USB: Build the USB HOST TLL omap device
Date: Wed, 20 Jun 2012 17:31:46 +0530
Message-ID: <1340193709-26547-3-git-send-email-keshava_mgowda@ti.com>
References: <1340193709-26547-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36189 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756099Ab2FTMCA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jun 2012 08:02:00 -0400
In-Reply-To: <1340193709-26547-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, sameo@linux.intel.com, parthab@india.ti.com, paul@pwsan.com, b-cousson@ti.com, sshtylyov@mvista.com

The hwmod of the usb tll is retrieved and omap device build is
performed to created the platform device for the usb tll component.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
Reviewed-by: Partha Basak <parthab@india.ti.com>
---
 arch/arm/mach-omap2/usb-host.c |   31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index dde8a11..b2a2dd7 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -35,10 +35,12 @@
 #ifdef CONFIG_MFD_OMAP_USB_HOST
 
 #define OMAP_USBHS_DEVICE	"usbhs_omap"
+#define OMAP_USBTLL_DEVICE	"usbhs_tll"
 #define	USBHS_UHH_HWMODNAME	"usb_host_hs"
 #define USBHS_TLL_HWMODNAME	"usb_tll_hs"
 
 static struct usbhs_omap_platform_data		usbhs_data;
+static struct usbtll_omap_platform_data		usbtll_data;
 static struct ehci_hcd_omap_platform_data	ehci_data;
 static struct ohci_hcd_omap_platform_data	ohci_data;
 
@@ -487,13 +489,14 @@ void __init setup_4430ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 
 void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 {
-	struct omap_hwmod	*oh[2];
+	struct omap_hwmod	*uhh_hwm, *tll_hwm;
 	struct platform_device	*pdev;
 	int			bus_id = -1;
 	int			i;
 
 	for (i = 0; i < OMAP3_HS_USB_PORTS; i++) {
 		usbhs_data.port_mode[i] = pdata->port_mode[i];
+		usbtll_data.port_mode[i] = pdata->port_mode[i];
 		ohci_data.port_mode[i] = pdata->port_mode[i];
 		ehci_data.port_mode[i] = pdata->port_mode[i];
 		ehci_data.reset_gpio_port[i] = pdata->reset_gpio_port[i];
@@ -512,25 +515,35 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 		setup_4430ohci_io_mux(pdata->port_mode);
 	}
 
-	oh[0] = omap_hwmod_lookup(USBHS_UHH_HWMODNAME);
-	if (!oh[0]) {
+	uhh_hwm = omap_hwmod_lookup(USBHS_UHH_HWMODNAME);
+	if (!uhh_hwm) {
 		pr_err("Could not look up %s\n", USBHS_UHH_HWMODNAME);
 		return;
 	}
 
-	oh[1] = omap_hwmod_lookup(USBHS_TLL_HWMODNAME);
-	if (!oh[1]) {
+	tll_hwm = omap_hwmod_lookup(USBHS_TLL_HWMODNAME);
+	if (!tll_hwm) {
 		pr_err("Could not look up %s\n", USBHS_TLL_HWMODNAME);
 		return;
 	}
 
-	pdev = omap_device_build_ss(OMAP_USBHS_DEVICE, bus_id, oh, 2,
-				(void *)&usbhs_data, sizeof(usbhs_data),
+	pdev = omap_device_build(OMAP_USBTLL_DEVICE, bus_id, tll_hwm,
+				&usbtll_data, sizeof(usbtll_data),
 				omap_uhhtll_latency,
 				ARRAY_SIZE(omap_uhhtll_latency), false);
 	if (IS_ERR(pdev)) {
-		pr_err("Could not build hwmod devices %s,%s\n",
-			USBHS_UHH_HWMODNAME, USBHS_TLL_HWMODNAME);
+		pr_err("Could not build hwmod device %s\n",
+		       USBHS_TLL_HWMODNAME);
+		return;
+	}
+
+	pdev = omap_device_build(OMAP_USBHS_DEVICE, bus_id, uhh_hwm,
+				&usbhs_data, sizeof(usbhs_data),
+				omap_uhhtll_latency,
+				ARRAY_SIZE(omap_uhhtll_latency), false);
+	if (IS_ERR(pdev)) {
+		pr_err("Could not build hwmod devices %s\n",
+		       USBHS_UHH_HWMODNAME);
 		return;
 	}
 }
-- 
1.7.9.5

