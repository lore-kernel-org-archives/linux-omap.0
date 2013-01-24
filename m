From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 30/32] usb: chipidea: register debugging syfs on our device
Date: Thu, 24 Jan 2013 17:46:08 +0200
Message-ID: <1359042370-4358-31-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37676 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab3AXPrv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jan 2013 10:47:51 -0500
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org, dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, leoli@freescale.com, eric.y.miao@gmail.com, linux@arm.linux.org.uk, haojian.zhuang@gmail.com, ben-linux@fluff.org, kgene.kim@samsung.com, kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-geode@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Don't register anything non-generic under
the gadget's device as we don't really *own*
it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/chipidea/udc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 2f45bba..f64fbea 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1767,7 +1767,7 @@ static int udc_start(struct ci13xxx *ci)
 		goto put_transceiver;
 	}
 
-	retval = dbg_create_files(&ci->gadget.dev);
+	retval = dbg_create_files(ci->dev);
 	if (retval)
 		goto unreg_device;
 
@@ -1796,7 +1796,7 @@ remove_trans:
 
 	dev_err(dev, "error = %i\n", retval);
 remove_dbg:
-	dbg_remove_files(&ci->gadget.dev);
+	dbg_remove_files(ci->dev);
 unreg_device:
 	device_unregister(&ci->gadget.dev);
 put_transceiver:
@@ -1836,7 +1836,7 @@ static void udc_stop(struct ci13xxx *ci)
 		if (ci->global_phy)
 			usb_put_phy(ci->transceiver);
 	}
-	dbg_remove_files(&ci->gadget.dev);
+	dbg_remove_files(ci->dev);
 	device_unregister(&ci->gadget.dev);
 	/* my kobject is dynamic, I swear! */
 	memset(&ci->gadget, 0, sizeof(ci->gadget));
-- 
1.8.1.rc1.5.g7e0651a

