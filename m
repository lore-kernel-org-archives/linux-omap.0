From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] mfd: omap: cleanup: use macros to check for TLL mode
Date: Wed, 14 Sep 2011 19:57:13 +0530
Message-ID: <1316010433-6024-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
Cc: p-basak2-l0cyMroinI0@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

In one particular place the old form of checking for TLL mode is used.
This patch fixes the same by using macros to check for TLL mode.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
patch is created on top of runtime patches from keshava hsoted at
git://gitorious.org/~kmg/mirrors/kmg-usbhs-pm.git
branch:kmg-pm-1
 drivers/mfd/omap-usb-host.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index e6f3b01..d43ca08 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -401,7 +401,7 @@ static void usbhs_omap_tll_init(struct device *dev, u8 tll_channel_count)
 			reg |= ohci_omap3_fslsmode(pdata->port_mode[i])
 				<< OMAP_TLL_CHANNEL_CONF_FSLSMODE_SHIFT;
 			reg |= OMAP_TLL_CHANNEL_CONF_CHANMODE_FSLS;
-		} else if (pdata->port_mode[i] == OMAP_EHCI_PORT_MODE_TLL) {
+		} else if (is_ehci_tll_mode(pdata->port_mode[i])) {
 
 			/* Disable AutoIdle, BitStuffing and use SDR Mode */
 			reg &= ~(OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
