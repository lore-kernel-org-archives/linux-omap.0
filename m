From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v4 04/12] ARM: OMAP1: OHCI: use platform_data fn ptr to enable
 OCPI bus
Date: Tue, 10 Apr 2012 18:35:38 -0600
Message-ID: <20120411003528.27059.8836.stgit@dusk>
References: <20120411003454.27059.37500.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43922 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759903Ab2DKAiU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 20:38:20 -0400
In-Reply-To: <20120411003454.27059.37500.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Roland Stigge <stigge@antcom.de>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Anand Gadiyar <gadiyar@ti.com>

The OMAP1 OHCI driver needs to enable the OCPI IP block before it can
work.  Previously, the driver was simply calling a symbol defined in
the OMAP platform code, but this is incorrect: drivers should be fully
decoupled from platform and architecture code.

So instead, modify the driver to call through a platform_data function
pointer instead.  We skip any DT aspect, since OMAP1 is not scheduled
to be converted to DT in the near future.

This resolves the following sparse warning:

It also gets rid of a cpu_is_omap16xx() call in a driver.

In the long term, it probably makes sense to move the OCPI bus code to
somewhere under drivers/.  This should avoid the whole platform_data/DT
issue with this function.

Also interesting is that drivers/usb/host/ohci-nxp.c contains a stub
for ocpi_enable() - perhaps the NXP chips use a similar OCPI IP block?

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Roland Stigge <stigge@antcom.de>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap1/usb.c               |    3 +++
 arch/arm/plat-omap/include/plat/board.h |    2 ++
 drivers/usb/host/ohci-omap.c            |    5 +++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
index 19de03b..e61afd9 100644
--- a/arch/arm/mach-omap1/usb.c
+++ b/arch/arm/mach-omap1/usb.c
@@ -29,6 +29,8 @@
 #include <plat/mux.h>
 #include <plat/usb.h>
 
+#include "common.h"
+
 /* These routines should handle the standard chip-specific modes
  * for usb0/1/2 ports, covering basic mux and transceiver setup.
  *
@@ -138,6 +140,7 @@ static inline void ohci_device_init(struct omap_usb_config *pdata)
 	if (cpu_is_omap7xx())
 		ohci_resources[1].start = INT_7XX_USB_HHC_1;
 	pdata->ohci_device = &ohci_device;
+	pdata->ocpi_enable = &ocpi_enable;
 }
 
 #else
diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap/include/plat/board.h
index d5eb4c8..4814c5b 100644
--- a/arch/arm/plat-omap/include/plat/board.h
+++ b/arch/arm/plat-omap/include/plat/board.h
@@ -91,6 +91,8 @@ struct omap_usb_config {
 	u32 (*usb0_init)(unsigned nwires, unsigned is_device);
 	u32 (*usb1_init)(unsigned nwires);
 	u32 (*usb2_init)(unsigned nwires, unsigned alt_pingroup);
+
+	int (*ocpi_enable)(void);
 };
 
 struct omap_lcd_config {
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 96451e4..71229cb 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -205,8 +205,9 @@ static int ohci_omap_init(struct usb_hcd *hcd)
 	need_transceiver = need_transceiver
 			|| machine_is_omap_h2() || machine_is_omap_h3();
 
-	if (cpu_is_omap16xx())
-		ocpi_enable();
+	/* XXX OMAP16xx only */
+	if (config->ocpi_enable)
+		config->ocpi_enable();
 
 #ifdef	CONFIG_USB_OTG
 	if (need_transceiver) {


