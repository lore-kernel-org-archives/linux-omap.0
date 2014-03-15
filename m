From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 4/5] net: cpsw: Use cpsw-ctrl-macid driver
Date: Sat, 15 Mar 2014 14:07:43 +0100
Message-ID: <1394888864-11007-5-git-send-email-mpa@pengutronix.de>
References: <1394888864-11007-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44290 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756562AbaCONJP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Mar 2014 09:09:15 -0400
In-Reply-To: <1394888864-11007-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

Use ctrl-macid driver to obtain the macids stored in the processor. This
is only done when defined in DT.

The internal macid is not used if mac-address is given explicitly. So it
does not change the behavior if the bootloader provides a mac address
through the mac-address property

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 Documentation/devicetree/bindings/net/cpsw.txt |  6 ++++++
 drivers/net/ethernet/ti/cpsw.c                 | 16 +++++++++++++---
 drivers/net/ethernet/ti/cpsw.h                 |  2 ++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documentation/devicetree/bindings/net/cpsw.txt
index c39f077..b997b96 100644
--- a/Documentation/devicetree/bindings/net/cpsw.txt
+++ b/Documentation/devicetree/bindings/net/cpsw.txt
@@ -34,6 +34,12 @@ Required properties:
 Optional properties:
 - dual_emac_res_vlan	: Specifies VID to be used to segregate the ports
 - mac-address		: Specifies slave MAC address
+- ti,mac-address-ctrl	: When cpsw-ctrl-macid support is compiled-in, this can
+			  be set to a phandle with one argument, see
+			  cpsw-ctrl-macid.txt. If this method fails, cpsw falls
+			  back to a random mac-address. An explicit mac-address
+			  property takes precedence.
+
 
 Note: "ti,hwmods" field is used to fetch the base address and irq
 resources from TI, omap hwmod data base during device registration.
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 651087b..05f4948 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1892,8 +1892,15 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 		}
 
 		mac_addr = of_get_mac_address(slave_node);
-		if (mac_addr)
-			memcpy(slave_data->mac_addr, mac_addr, ETH_ALEN);
+		if (mac_addr) {
+			memcpy(slave_data->mac_addr, mac_addr,
+					ETH_ALEN);
+		} else {
+			ret = cpsw_ctrl_macid_read(slave_node,
+					slave_data->mac_addr);
+			if (ret == -EPROBE_DEFER)
+				return ret;
+		}
 
 		slave_data->phy_if = of_get_phy_mode(slave_node);
 		if (slave_data->phy_if < 0) {
@@ -2038,10 +2045,13 @@ static int cpsw_probe(struct platform_device *pdev)
 	/* Select default pin state */
 	pinctrl_pm_select_default_state(&pdev->dev);
 
-	if (cpsw_probe_dt(&priv->data, pdev)) {
+	ret = cpsw_probe_dt(&priv->data, pdev);
+	if (ret == -EINVAL) {
 		pr_err("cpsw: platform data missing\n");
 		ret = -ENODEV;
 		goto clean_runtime_disable_ret;
+	} else if (ret) {
+		goto clean_runtime_disable_ret;
 	}
 	data = &priv->data;
 
diff --git a/drivers/net/ethernet/ti/cpsw.h b/drivers/net/ethernet/ti/cpsw.h
index 1b71067..222eebe 100644
--- a/drivers/net/ethernet/ti/cpsw.h
+++ b/drivers/net/ethernet/ti/cpsw.h
@@ -42,4 +42,6 @@ struct cpsw_platform_data {
 
 void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int slave);
 
+int cpsw_ctrl_macid_read(struct device_node *np, u8 *mac_addr);
+
 #endif /* __CPSW_H__ */
-- 
1.9.0

