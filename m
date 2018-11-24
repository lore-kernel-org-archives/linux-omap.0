From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 2/5] USB: omap_udc: fix crashes on probe error and module removal
Date: Sun, 25 Nov 2018 00:17:05 +0200
Message-ID: <20181124221708.31003-3-aaro.koskinen@iki.fi>
References: <20181124221708.31003-1-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181124221708.31003-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

We currently crash if usb_add_gadget_udc_release() fails, since the
udc->done is not initialized until in the remove function.
Furthermore, on module removal the udc data is accessed although
the release function is already triggered by usb_del_gadget_udc()
early in the function.

Fix by rewriting the release and remove functions, basically moving
all the cleanup into the release function, and doing the completion
only in the module removal case.

The patch fixes omap_udc module probe with a failing gadged, and also
allows the removal of omap_udc. Tested by running "modprobe omap_udc;
modprobe -r omap_udc" in a loop.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/usb/gadget/udc/omap_udc.c | 50 ++++++++++++-------------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 1c77218c82af..240ccba44592 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2593,9 +2593,22 @@ omap_ep_setup(char *name, u8 addr, u8 type,
 
 static void omap_udc_release(struct device *dev)
 {
-	complete(udc->done);
+	pullup_disable(udc);
+	if (!IS_ERR_OR_NULL(udc->transceiver)) {
+		usb_put_phy(udc->transceiver);
+		udc->transceiver = NULL;
+	}
+	omap_writew(0, UDC_SYSCON1);
+	remove_proc_file();
+	if (udc->dc_clk) {
+		if (udc->clk_requested)
+			omap_udc_enable_clock(0);
+		clk_put(udc->hhc_clk);
+		clk_put(udc->dc_clk);
+	}
+	if (udc->done)
+		complete(udc->done);
 	kfree(udc);
-	udc = NULL;
 }
 
 static int
@@ -2900,12 +2913,8 @@ static int omap_udc_probe(struct platform_device *pdev)
 	}
 
 	create_proc_file();
-	status = usb_add_gadget_udc_release(&pdev->dev, &udc->gadget,
-			omap_udc_release);
-	if (!status)
-		return 0;
-
-	remove_proc_file();
+	return usb_add_gadget_udc_release(&pdev->dev, &udc->gadget,
+					  omap_udc_release);
 
 cleanup1:
 	kfree(udc);
@@ -2932,36 +2941,15 @@ static int omap_udc_remove(struct platform_device *pdev)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 
-	if (!udc)
-		return -ENODEV;
-
-	usb_del_gadget_udc(&udc->gadget);
-	if (udc->driver)
-		return -EBUSY;
-
 	udc->done = &done;
 
-	pullup_disable(udc);
-	if (!IS_ERR_OR_NULL(udc->transceiver)) {
-		usb_put_phy(udc->transceiver);
-		udc->transceiver = NULL;
-	}
-	omap_writew(0, UDC_SYSCON1);
-
-	remove_proc_file();
+	usb_del_gadget_udc(&udc->gadget);
 
-	if (udc->dc_clk) {
-		if (udc->clk_requested)
-			omap_udc_enable_clock(0);
-		clk_put(udc->hhc_clk);
-		clk_put(udc->dc_clk);
-	}
+	wait_for_completion(&done);
 
 	release_mem_region(pdev->resource[0].start,
 			pdev->resource[0].end - pdev->resource[0].start + 1);
 
-	wait_for_completion(&done);
-
 	return 0;
 }
 
-- 
2.17.0
