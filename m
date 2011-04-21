From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] omap:usb: fixing ehci phy gpio values for omap3
Date: Thu, 21 Apr 2011 19:52:42 +0530
Message-ID: <1303395763-8702-2-git-send-email-keshava_mgowda@ti.com>
References: <1303395763-8702-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1303395763-8702-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, p-basak2-l0cyMroinI0@public.gmane.org, axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, mpfj-list-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org, Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>

The gpio of EHCI phy should be 0 instead of 1;
This fixes the hub enumeration issue in beagle xm board.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/omap-usb-host.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index b3bb3ac..a12202e 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -718,14 +718,14 @@ static int usbhs_enable(struct device *dev)
 			gpio_request(pdata->ehci_data->reset_gpio_port[0],
 						"USB1 PHY reset");
 			gpio_direction_output
-				(pdata->ehci_data->reset_gpio_port[0], 1);
+				(pdata->ehci_data->reset_gpio_port[0], 0);
 		}
 
 		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[1])) {
 			gpio_request(pdata->ehci_data->reset_gpio_port[1],
 						"USB2 PHY reset");
 			gpio_direction_output
-				(pdata->ehci_data->reset_gpio_port[1], 1);
+				(pdata->ehci_data->reset_gpio_port[1], 0);
 		}
 
 		/* Hold the PHY in RESET for enough time till DIR is high */
@@ -905,11 +905,11 @@ static int usbhs_enable(struct device *dev)
 
 		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[0]))
 			gpio_set_value
-				(pdata->ehci_data->reset_gpio_port[0], 0);
+				(pdata->ehci_data->reset_gpio_port[0], 1);
 
 		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[1]))
 			gpio_set_value
-				(pdata->ehci_data->reset_gpio_port[1], 0);
+				(pdata->ehci_data->reset_gpio_port[1], 1);
 	}
 
 end_count:
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
