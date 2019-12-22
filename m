From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] phy: cpcap-usb: Prevent USB line glitches from waking up modem
Date: Sun, 22 Dec 2019 10:17:02 -0800
Message-ID: <20191222181704.61511-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

The micro-USB connector on Motorola Mapphone devices can be muxed between
the SoC and the mdm6600 modem. But even when used for the SoC, configuring
the PHY with ID pin grounded will wake up the modem from idle state. Looks
like the issue is probably caused by line glitches.

We can prevent the glitches by using a previously unknown mode of the
GPIO mux to prevent the USB lines from being connected to the moden while
configuring the USB PHY, and enable the USB lines after configuring the
PHY.

Note that this only prevents waking up mdm6600 as regular USB A-host mode,
and does not help when connected to a lapdock. The lapdock specific issue
still needs to be debugged separately.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/phy/motorola/phy-cpcap-usb.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -115,7 +115,7 @@ struct cpcap_usb_ints_state {
 enum cpcap_gpio_mode {
 	CPCAP_DM_DP,
 	CPCAP_MDM_RX_TX,
-	CPCAP_UNKNOWN,
+	CPCAP_UNKNOWN_DISABLED,	/* Seems to disable USB lines */
 	CPCAP_OTG_DM_DP,
 };
 
@@ -381,7 +381,8 @@ static int cpcap_usb_set_uart_mode(struct cpcap_phy_ddata *ddata)
 {
 	int error;
 
-	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_DM_DP);
+	/* Disable lines to prevent glitches from waking up mdm6600 */
+	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_UNKNOWN_DISABLED);
 	if (error)
 		goto out_err;
 
@@ -408,6 +409,11 @@ static int cpcap_usb_set_uart_mode(struct cpcap_phy_ddata *ddata)
 	if (error)
 		goto out_err;
 
+	/* Enable UART mode */
+	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_DM_DP);
+	if (error)
+		goto out_err;
+
 	return 0;
 
 out_err:
@@ -420,7 +426,8 @@ static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata)
 {
 	int error;
 
-	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_OTG_DM_DP);
+	/* Disable lines to prevent glitches from waking up mdm6600 */
+	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_UNKNOWN_DISABLED);
 	if (error)
 		return error;
 
@@ -460,6 +467,11 @@ static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata)
 	if (error)
 		goto out_err;
 
+	/* Enable USB mode */
+	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_OTG_DM_DP);
+	if (error)
+		goto out_err;
+
 	return 0;
 
 out_err:
-- 
2.24.1
