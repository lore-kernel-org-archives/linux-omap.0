From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [patch-v2.6.39 10/19] arm: omap: usb: host: add names to resources
Date: Tue,  1 Mar 2011 17:15:31 +0200
Message-ID: <1298992540-5984-11-git-send-email-balbi@ti.com>
References: <1298992540-5984-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298992540-5984-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

add names to EHCI and OHCI resources. That will help us
identify the resource correctly when moving to a setup
where OHCI and EHCI play well together.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/usb-ehci.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index 25eeada..2c74fa1 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -350,6 +350,11 @@ void __init usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata)
 		setup_4430ehci_io_mux(pdata->port_mode);
 	}
 
+	ehci_resources[0].name	= "ehci";
+	ehci_resources[1].name	= "uhh";
+	ehci_resources[2].name	= "tll";
+	ehci_resources[3].name	= "irq";
+
 	if (platform_device_register(&ehci_device) < 0) {
 		printk(KERN_ERR "Unable to register HS-USB (EHCI) device\n");
 		return;
@@ -369,21 +374,25 @@ void __init usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata)
 
 static struct resource ohci_resources[] = {
 	{
+		.name	= "ohci",
 		.start	= OMAP34XX_OHCI_BASE,
 		.end	= OMAP34XX_OHCI_BASE + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
+		.name	= "uhh",
 		.start	= OMAP34XX_UHH_CONFIG_BASE,
 		.end	= OMAP34XX_UHH_CONFIG_BASE + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
+		.name	= "tll",
 		.start	= OMAP34XX_USBTLL_BASE,
 		.end	= OMAP34XX_USBTLL_BASE + SZ_4K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{	/* general IRQ */
+		.name	= "irq",
 		.start	= INT_34XX_OHCI_IRQ,
 		.flags	= IORESOURCE_IRQ,
 	}
-- 
1.7.4.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
