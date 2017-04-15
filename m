From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] mfd: omap-usb-tll: Fix inverted bit use for USB TLL mode
Date: Sat, 15 Apr 2017 10:05:08 -0700
Message-ID: <20170415170509.17364-2-tony@atomide.com>
References: <20170415170509.17364-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170415170509.17364-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>, Keshava Munegowda <keshava_mgowda@ti.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Roger Quadros <rogerq@ti.com>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Commit 16fa3dc75c22 ("mfd: omap-usb-tll: HOST TLL platform driver")
added support for USB TLL, but uses OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF
bit the wrong way. The comments in the code are correct, but the inverted
use of OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF causes the register to be
enabled instead of disabled unlike what the comments say.

Without this change the Wrigley 3G LTE modem on droid 4 EHCI bus can
be only pinged few times before it stops responding.

Fixes: 16fa3dc75c22 ("mfd: omap-usb-tll: HOST TLL platform driver")
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/omap-usb-tll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -377,8 +377,8 @@ int omap_tll_init(struct usbhs_omap_platform_data *pdata)
 				 * and use SDR Mode
 				 */
 				reg &= ~(OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE
-					| OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF
 					| OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE);
+				reg |= OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF;
 			} else if (pdata->port_mode[i] ==
 					OMAP_EHCI_PORT_MODE_HSIC) {
 				/*
-- 
2.12.2
