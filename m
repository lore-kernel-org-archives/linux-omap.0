From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] phy: cpcap-usb: Drop extra write to usb2 register
Date: Sun, 22 Dec 2019 10:17:04 -0800
Message-ID: <20191222181704.61511-3-tony@atomide.com>
References: <20191222181704.61511-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191222181704.61511-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

We are currently writing the same register twice. Let's enable the USB
PHY only at the end of the function.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/phy/motorola/phy-cpcap-usb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -489,12 +489,6 @@ static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata)
 	if (error)
 		goto out_err;
 
-	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC2,
-				   CPCAP_BIT_USBXCVREN,
-				   CPCAP_BIT_USBXCVREN);
-	if (error)
-		goto out_err;
-
 	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC3,
 				   CPCAP_BIT_PU_SPI |
 				   CPCAP_BIT_DMPD_SPI |
-- 
2.24.1
