From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] mfd: omap-usb-tll: Configure ULPIAUTOIDLE
Date: Sat, 15 Apr 2017 10:05:09 -0700
Message-ID: <20170415170509.17364-3-tony@atomide.com>
References: <20170415170509.17364-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170415170509.17364-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>, Keshava Munegowda <keshava_mgowda@ti.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Roger Quadros <rogerq@ti.com>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

The idle mode needs to be only disabled for UTMIAUTOIDLE while
ULPIAUTOIDLE can be enabled.

This matches the TLL_CHANNEL_CONF_i register configuration for ehci-tll
in the Motorola Linux kernel tree for Wrigley 3G LTE modem on droid 4
and the modem still stays responsive.

Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/omap-usb-tll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

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
 				reg &= ~(OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE
 					| OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE);
 				reg |= OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF;
+				reg |= OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE;
 			} else if (pdata->port_mode[i] ==
 					OMAP_EHCI_PORT_MODE_HSIC) {
 				/*
-- 
2.12.2
