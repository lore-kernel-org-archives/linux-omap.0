From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 01/21] usb: phy: nop: Add some parameters to platform data
Date: Wed, 20 Mar 2013 17:44:40 +0200
Message-ID: <1363794300-31526-2-git-send-email-rogerq@ti.com>
References: <1363794300-31526-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54141 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910Ab3CTPpM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Mar 2013 11:45:12 -0400
In-Reply-To: <1363794300-31526-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: balbi@ti.com, rogerq@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Add clk_rate parameter to platform data. If supplied, the
NOP phy driver will program the clock to that rate during probe.

Also add 2 flags, needs_vcc and needs_reset.
If the flag is set and the regulator couldn't be found
then the driver will bail out with -EPROBE_DEFER.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 include/linux/usb/nop-usb-xceiv.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/usb/nop-usb-xceiv.h b/include/linux/usb/nop-usb-xceiv.h
index 28884c7..148d351 100644
--- a/include/linux/usb/nop-usb-xceiv.h
+++ b/include/linux/usb/nop-usb-xceiv.h
@@ -5,6 +5,11 @@
 
 struct nop_usb_xceiv_platform_data {
 	enum usb_phy_type type;
+	unsigned long clk_rate;
+
+	/* if set fails with -EPROBE_DEFER if can't get regulator */
+	unsigned int needs_vcc:1;
+	unsigned int needs_reset:1;
 };
 
 #if defined(CONFIG_NOP_USB_XCEIV) || (defined(CONFIG_NOP_USB_XCEIV_MODULE) && defined(MODULE))
-- 
1.7.4.1

