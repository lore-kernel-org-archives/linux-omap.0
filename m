From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 03/23] mfd: omap-usb-tll: Fix channel count detection
Date: Mon, 10 Dec 2012 12:20:13 +0200
Message-ID: <1355134833-5199-4-git-send-email-rogerq@ti.com>
References: <1355134833-5199-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1355134833-5199-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com, sameo@linux.intel.com, tony@atomide.com
Cc: paul@pwsan.com, sshtylyov@mvista.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, keshava_mgowda@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bjorn@mork.no, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Fix channel count detecion for REV2. Also, don't give up
if we don't recognize the IP Revision. We assume the default
number of channels (i.e. 3) for unrecognized IPs.

Signed-off-by: Roger Quadros <rogerq@ti.com>
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
