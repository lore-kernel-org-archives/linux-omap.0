From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 3/4] [OMAP] omap_udc: Add clocking and disable vbus sense for
	omap7xx
Date: Mon, 5 Oct 2009 07:51:03 -0700
Message-ID: <6cb013310910050751n3dfad278r1b6fee6720271dd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f173.google.com ([209.85.210.173]:43177 "EHLO
	mail-yx0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbZJEOv7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Oct 2009 10:51:59 -0400
Received: by yxe3 with SMTP id 3so2902968yxe.4
        for <linux-omap@vger.kernel.org>; Mon, 05 Oct 2009 07:51:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I added a provision for the usb_dc_ck and l3_ocpi_ck clocks as
dc_clk and hhc_clk, respectively, for omap7xx CPUs.  Additionally,
I added a check in machine_without_vbus_sense for all omap7xx
devices, as presently I know of no omap7xx-based devices that
have vbus sense, and it made more sense to me to use a cpu check
here than to spell out each machine one at a time.  Finally, DMA
is disabled for omap7xx, as it causes problems with these chips.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 drivers/usb/gadget/omap_udc.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index a2db0e1..1762bd8 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -2098,6 +2098,7 @@ static inline int machine_without_vbus_sense(void)
 		|| machine_is_omap_h4()
 #endif
 		|| machine_is_sx1()
+		|| cpu_is_omap7xx() /* No known omap7xx boards with vbus sense */
 		);
 }

@@ -2838,6 +2839,16 @@ static int __init omap_udc_probe(struct
platform_device *pdev)
 		udelay(100);
 	}

+	if (cpu_is_omap7xx()) {
+		dc_clk = clk_get(&pdev->dev, "usb_dc_ck");
+		hhc_clk = clk_get(&pdev->dev, "l3_ocpi_ck");
+		BUG_ON(IS_ERR(dc_clk) || IS_ERR(hhc_clk));
+		/* can't use omap_udc_enable_clock yet */
+		clk_enable(dc_clk);
+		clk_enable(hhc_clk);
+		udelay(100);
+	}
+
 	INFO("OMAP UDC rev %d.%d%s\n",
 		omap_readw(UDC_REV) >> 4, omap_readw(UDC_REV) & 0xf,
 		config->otg ? ", Mini-AB" : "");
@@ -2970,7 +2981,7 @@ known:
 		goto cleanup3;
 	}
 #endif
-	if (cpu_is_omap16xx()) {
+	if (cpu_is_omap16xx() || cpu_is_omap7xx()) {
 		udc->dc_clk = dc_clk;
 		udc->hhc_clk = hhc_clk;
 		clk_disable(hhc_clk);
@@ -3008,7 +3019,7 @@ cleanup0:
 	if (xceiv)
 		otg_put_transceiver(xceiv);

-	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
+	if (cpu_is_omap16xx() || cpu_is_omap24xx() || cpu_is_omap7xx()) {
 		clk_disable(hhc_clk);
 		clk_disable(dc_clk);
 		clk_put(hhc_clk);
@@ -3115,6 +3126,10 @@ static struct platform_driver udc_driver = {

 static int __init udc_init(void)
 {
+	/* Disable DMA for omap7xx -- it doesn't work right. */
+	if (cpu_is_omap7xx())
+		use_dma = 0;
+
 	INFO("%s, version: " DRIVER_VERSION
 #ifdef	USE_ISO
 		" (iso)"
-- 
1.5.6.3
