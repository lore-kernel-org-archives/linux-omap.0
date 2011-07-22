From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH] mfd: omap-usb-host: fix clock API usage on usbhs_disable()
Date: Fri, 22 Jul 2011 18:39:30 +0530
Message-ID: <1311340170-28773-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, kishon@ti.com, Keshava Munegowda <Keshava_mgowda@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Keshava Munegowda <Keshava_mgowda@ti.com>

usbhs_disable function was invoking clk_enable() instead of
clk_disable(), thus only increasing the clock usage counter and
preventing this particular clock from being ever turned off.
Because of this, the power domain of omap4 the USB Host subsystem
would never reach lower power states.This patch calls clk_disable()
in usbhs_disable function

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
---
 drivers/mfd/omap-usb-host.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 1717144..29601e7 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -998,9 +998,9 @@ static void usbhs_disable(struct device *dev)
 
 	if (is_omap_usbhs_rev2(omap)) {
 		if (is_ehci_tll_mode(pdata->port_mode[0]))
-			clk_enable(omap->usbtll_p1_fck);
+			clk_disable(omap->usbtll_p1_fck);
 		if (is_ehci_tll_mode(pdata->port_mode[1]))
-			clk_enable(omap->usbtll_p2_fck);
+			clk_disable(omap->usbtll_p2_fck);
 		clk_disable(omap->utmi_p2_fck);
 		clk_disable(omap->utmi_p1_fck);
 	}
-- 
1.6.0.4
