From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH 1/4] omap_udc: fix compilation with debug enabled
Date: Sun, 6 Jul 2008 14:25:53 +0400
Message-ID: <20080706102553.GA29914__23413.4086560973$1215345089$gmane$org@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:63709 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbYGFLuZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Jul 2008 07:50:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so678890fgg.17
        for <linux-omap@vger.kernel.org>; Sun, 06 Jul 2008 04:50:24 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 drivers/usb/gadget/omap_udc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index 881d74c..b3cee6f 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -54,6 +54,7 @@
 
 #include <asm/arch/dma.h>
 #include <asm/arch/usb.h>
+#include <asm/arch/control.h>
 
 #include "omap_udc.h"
 
@@ -2289,7 +2290,7 @@ static int proc_otg_show(struct seq_file *s)
 	tmp = OTG_REV_REG;
 	if (cpu_is_omap24xx()) {
 		ctrl_name = "control_devconf";
-		trans = CONTROL_DEVCONF_REG;
+		trans = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
 	} else {
 		ctrl_name = "tranceiver_ctrl";
 		trans = USB_TRANSCEIVER_CTRL_REG;
-- 
1.5.6


-- 
With best wishes
Dmitry

