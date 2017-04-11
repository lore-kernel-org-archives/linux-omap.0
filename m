From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] mfd: omap-usb-tll: Fix inverted bit use for USB TLL mode
Date: Mon, 10 Apr 2017 17:15:43 -0700
Message-ID: <20170411001543.1338-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>, Keshava Munegowda <keshava_mgowda@ti.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Roger Quadros <rogerq@ti.com>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Commit 16fa3dc75c22 ("mfd: omap-usb-tll: HOST TLL platform driver")
added support for USB TLL, but uses OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF
bit the wrong way. The comments in the code are mostly correct, but the
inverted use of OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF causes the register
to be enabled instead of disabled like the comments say. And the
idle mode should be only disabled for UTMIAUTOIDLE while ULPIAUTOIDLE
can be enabled.

This matches the TLL_CHANNEL_CONF_i register configuration for ehci-tll
in the Motorola Linux kernel tree for Wrigley 3G LTE modem on droid 4.
Without this patch the modem can only be pinged few times before it
stops responding. Also lsub -v output shows errors without this patch.

Fixes: 16fa3dc75c22 ("mfd: omap-usb-tll: HOST TLL platform driver")
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/omap-usb-tll.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -373,12 +373,13 @@ int omap_tll_init(struct usbhs_omap_platform_data *pdata)
 			} else if (pdata->port_mode[i] ==
 					OMAP_EHCI_PORT_MODE_TLL) {
 				/*
-				 * Disable AutoIdle, BitStuffing
-				 * and use SDR Mode
+				 * Disable UTMI AutoIdle, BitStuffing
+				 * and use SDR Mode. Enable ULPI AutoIdle.
 				 */
-				reg &= ~(OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE
-					| OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF
-					| OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE);
+				reg &= ~(OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE |
+					 OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE);
+				reg |= OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF;
+				reg |= OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE;
 			} else if (pdata->port_mode[i] ==
 					OMAP_EHCI_PORT_MODE_HSIC) {
 				/*
-- 
2.12.2
