From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 03/23] mfd: omap-usb-tll: Fix channel count detection
Date: Tue, 4 Dec 2012 16:12:56 +0200
Message-ID: <1354630396-24545-4-git-send-email-rogerq@ti.com>
References: <1354630396-24545-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354630396-24545-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org, bjorn-yOkvZcmFvRU@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Fix channel count detecion for REV2. Also, don't give up
if we don't recognize the IP Revision. We assume the default
number of channels (i.e. 3) for unrecognized IPs.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/omap-usb-tll.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 18fefdb..e67cafc 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -98,6 +98,7 @@
 struct usbtll_omap {
 	struct clk				*usbtll_p1_fck;
 	struct clk				*usbtll_p2_fck;
+	int					nch;	/* num. of channels */
 	struct usbtll_omap_platform_data	*pdata;
 	/* secure the register updates */
 	spinlock_t				lock;
@@ -210,7 +211,7 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 	unsigned				reg;
 	unsigned long				flags;
 	int					ret = 0;
-	int					i, ver, count;
+	int					i, ver;
 
 	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
 
@@ -262,16 +263,18 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 	ver =  usbtll_read(base, OMAP_USBTLL_REVISION);
 	switch (ver) {
 	case OMAP_USBTLL_REV1:
-	case OMAP_USBTLL_REV2:
-		count = OMAP_TLL_CHANNEL_COUNT;
+		tll->nch = OMAP_TLL_CHANNEL_COUNT;
 		break;
+	case OMAP_USBTLL_REV2:
 	case OMAP_USBTLL_REV3:
-		count = OMAP_REV2_TLL_CHANNEL_COUNT;
+		tll->nch = OMAP_REV2_TLL_CHANNEL_COUNT;
 		break;
 	default:
-		dev_err(dev, "TLL version failed\n");
-		ret = -ENODEV;
-		goto err_ioremap;
+		tll->nch = OMAP_TLL_CHANNEL_COUNT;
+		dev_dbg(dev,
+		 "USB TLL Rev : 0x%x not recognized, assuming %d channels\n",
+			ver, tll->nch);
+		break;
 	}
 
 	if (is_ehci_tll_mode(pdata->port_mode[0]) ||
@@ -291,7 +294,7 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 		usbtll_write(base, OMAP_TLL_SHARED_CONF, reg);
 
 		/* Enable channels now */
-		for (i = 0; i < count; i++) {
+		for (i = 0; i < tll->nch; i++) {
 			reg = usbtll_read(base,	OMAP_TLL_CHANNEL_CONF(i));
 
 			if (is_ohci_port(pdata->port_mode[i])) {
@@ -319,7 +322,6 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 		}
 	}
 
-err_ioremap:
 	spin_unlock_irqrestore(&tll->lock, flags);
 	iounmap(base);
 	pm_runtime_put_sync(dev);
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
