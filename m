From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] phy: cpcap-usb: Fix missing return statement
Date: Mon, 12 Jun 2017 01:12:23 -0700
Message-ID: <20170612081223.20743-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Commit 8ae904e3c236 ("phy: cpcap-usb: Add CPCAP PMIC USB support")
is missing return statement as noted by Colin Ian King
<colin.king@canonical.com>. If the optional pins are not configured,
we just want to return early and not attempt to configure the pins.

Fixes: 8ae904e3c236 ("phy: cpcap-usb: Add CPCAP PMIC USB support")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/phy/motorola/phy-cpcap-usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -468,6 +468,8 @@ static int cpcap_usb_init_optional_pins(struct cpcap_phy_ddata *ddata)
 		dev_info(ddata->dev, "default pins not configured: %ld\n",
 			 PTR_ERR(ddata->pins));
 		ddata->pins = NULL;
+
+		return 0;
 	}
 
 	ddata->pins_ulpi = pinctrl_lookup_state(ddata->pins, "ulpi");
-- 
2.13.0
