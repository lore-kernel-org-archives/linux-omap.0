From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 05/16] mfd: omap-usb-tll: Add OMAP5 revision and HSIC support
Date: Thu, 15 Nov 2012 16:34:03 +0200
Message-ID: <1352990054-14680-6-git-send-email-rogerq@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352990054-14680-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The TLL module on OMAP5 has 3 channels.
HSIC mode requires the TLL channel to be in Transparent UTMI mode.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/omap-usb-tll.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 31ac7db..c48d545 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -54,10 +54,13 @@
 
 #define	OMAP_TLL_CHANNEL_CONF(num)			(0x040 + 0x004 * num)
 #define OMAP_TLL_CHANNEL_CONF_FSLSMODE_SHIFT		24
+#define OMAP_TLL_CHANNEL_CONF_DRVVBUS			(1 << 16)
+#define OMAP_TLL_CHANNEL_CONF_CHRGVBUS			(1 << 15)
 #define	OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF		(1 << 11)
 #define	OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE		(1 << 10)
 #define	OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE		(1 << 9)
 #define	OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE		(1 << 8)
+#define OMAP_TLL_CHANNEL_CONF_MODE_TRANSPARENT_UTMI	(2 << 1)
 #define OMAP_TLL_CHANNEL_CONF_CHANMODE_FSLS		(1 << 1)
 #define	OMAP_TLL_CHANNEL_CONF_CHANEN			(1 << 0)
 
@@ -96,6 +99,7 @@
 #define OMAP_USBTLL_REV1		0x00000015	/* OMAP3 */
 #define OMAP_USBTLL_REV2		0x00000018	/* OMAP 3630 */
 #define OMAP_USBTLL_REV3		0x00000004	/* OMAP4 */
+#define OMAP_USBTLL_REV4		0x6		/* OMAP5 */
 
 #define is_ehci_tll_mode(x)	(x == OMAP_EHCI_PORT_MODE_TLL)
 
@@ -260,6 +264,7 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 	ver =  usbtll_read(base, OMAP_USBTLL_REVISION);
 	switch (ver) {
 	case OMAP_USBTLL_REV1:
+	case OMAP_USBTLL_REV4:
 		tll->nch = DEFAULT_TLL_CHANNEL_COUNT;
 		break;
 	case OMAP_USBTLL_REV2:
@@ -321,6 +326,15 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 				reg &= ~(OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE
 					| OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF
 					| OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE);
+			} else if (pdata->port_mode[i] ==
+					OMAP_EHCI_PORT_MODE_HSIC) {
+				/*
+				 * HSIC Mode requires UTMI port configurations
+				 */
+				reg |= OMAP_TLL_CHANNEL_CONF_DRVVBUS
+				 | OMAP_TLL_CHANNEL_CONF_CHRGVBUS
+				 | OMAP_TLL_CHANNEL_CONF_MODE_TRANSPARENT_UTMI
+				 | OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF;
 			} else {
 				continue;
 			}
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
