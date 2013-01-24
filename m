From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 31/32] usb: chipidea: let udc-core manage gadget->dev
Date: Thu, 24 Jan 2013 17:46:09 +0200
Message-ID: <1359042370-4358-32-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org, dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, leoli@freescale.com, eric.y.miao@gmail.com, linux@arm.linux.org.uk, haojian.zhuang@gmail.com, ben-linux@fluff.org, kgene.kim@samsung.com, kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-geode@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/chipidea/udc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index f64fbea..e95e8bb 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1717,11 +1717,11 @@ static int udc_start(struct ci13xxx *ci)
 
 	INIT_LIST_HEAD(&ci->gadget.ep_list);
 
-	dev_set_name(&ci->gadget.dev, "gadget");
 	ci->gadget.dev.dma_mask = dev->dma_mask;
 	ci->gadget.dev.coherent_dma_mask = dev->coherent_dma_mask;
 	ci->gadget.dev.parent   = dev;
 	ci->gadget.dev.release  = udc_release;
+	ci->gadget.register_my_device = true;
 
 	/* alloc resources */
 	ci->qh_pool = dma_pool_create("ci13xxx_qh", dev,
@@ -1761,15 +1761,9 @@ static int udc_start(struct ci13xxx *ci)
 		hw_enable_vbus_intr(ci);
 	}
 
-	retval = device_register(&ci->gadget.dev);
-	if (retval) {
-		put_device(&ci->gadget.dev);
-		goto put_transceiver;
-	}
-
 	retval = dbg_create_files(ci->dev);
 	if (retval)
-		goto unreg_device;
+		goto put_transceiver;
 
 	if (!IS_ERR_OR_NULL(ci->transceiver)) {
 		retval = otg_set_peripheral(ci->transceiver->otg,
@@ -1797,8 +1791,6 @@ remove_trans:
 	dev_err(dev, "error = %i\n", retval);
 remove_dbg:
 	dbg_remove_files(ci->dev);
-unreg_device:
-	device_unregister(&ci->gadget.dev);
 put_transceiver:
 	if (!IS_ERR_OR_NULL(ci->transceiver) && ci->global_phy)
 		usb_put_phy(ci->transceiver);
@@ -1837,7 +1829,6 @@ static void udc_stop(struct ci13xxx *ci)
 			usb_put_phy(ci->transceiver);
 	}
 	dbg_remove_files(ci->dev);
-	device_unregister(&ci->gadget.dev);
 	/* my kobject is dynamic, I swear! */
 	memset(&ci->gadget, 0, sizeof(ci->gadget));
 }
-- 
1.8.1.rc1.5.g7e0651a
