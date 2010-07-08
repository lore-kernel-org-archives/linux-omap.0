From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/4] usb: ehci_omap: fix device detect issue with modules
Date: Thu,  8 Jul 2010 14:03:02 +0530
Message-ID: <1278577982-30046-5-git-send-email-ajay.gupta@ti.com>
References: <1278577982-30046-1-git-send-email-ajay.gupta@ti.com>
 <1278577982-30046-2-git-send-email-ajay.gupta@ti.com>
 <1278577982-30046-3-git-send-email-ajay.gupta@ti.com>
 <1278577982-30046-4-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1278577982-30046-4-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently devices don't get detected automatically if the ehci
module is inserted 2nd time onward. We need to disconnect and
reconnect the device for it to get detected and enumerated.

Resetting the USB PHY using PHY reset comamnd over ULPI fixes
this issue. Tested on OMAP3EVM.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Acked-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 5450e62..116ae28 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -38,6 +38,7 @@
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/usb/ulpi.h>
 #include <plat/usb.h>
 
 /*
@@ -236,6 +237,35 @@ static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
 
 /*-------------------------------------------------------------------------*/
 
+static void omap_ehci_soft_phy_reset(struct ehci_hcd_omap *omap, u8 port)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
+	unsigned reg = 0;
+
+	reg = ULPI_FUNC_CTRL_RESET
+		/* FUNCTION_CTRL_SET register */
+		| (ULPI_SET(ULPI_FUNC_CTRL) << EHCI_INSNREG05_ULPI_REGADD_SHIFT)
+		/* Write */
+		| (2 << EHCI_INSNREG05_ULPI_OPSEL_SHIFT)
+		/* PORTn */
+		| ((port + 1) << EHCI_INSNREG05_ULPI_PORTSEL_SHIFT)
+		/* start ULPI access*/
+		| (1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT);
+
+	ehci_omap_writel(omap->ehci_base, EHCI_INSNREG05_ULPI, reg);
+
+	/* Wait for ULPI access completion */
+	while ((ehci_omap_readl(omap->ehci_base, EHCI_INSNREG05_ULPI)
+			& (1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT))) {
+		cpu_relax();
+
+		if (time_after(jiffies, timeout)) {
+			dev_dbg(omap->dev, "phy reset operation timed out\n");
+			break;
+		}
+	}
+}
+
 /* omap_start_ehc
  *	- Start the TI USBHOST controller
  */
@@ -425,6 +455,12 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 			gpio_set_value(omap->reset_gpio_port[1], 1);
 	}
 
+	/* Soft reset the PHY using PHY reset command over ULPI */
+	if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY)
+		omap_ehci_soft_phy_reset(omap, 0);
+	if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY)
+		omap_ehci_soft_phy_reset(omap, 1);
+
 	return 0;
 
 err_sys_status:
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
