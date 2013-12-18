From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 4/6] net: cpsw: Use cpsw-ctrl-macid driver
Date: Wed, 18 Dec 2013 17:47:20 +0100
Message-ID: <1387385242-1161-5-git-send-email-mpa@pengutronix.de>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387385242-1161-1-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Use ctrl-macid driver to obtain the macids stored in the processor. This
is only done when defined in DT.

Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 Documentation/devicetree/bindings/net/cpsw.txt |  5 +++++
 drivers/net/ethernet/ti/cpsw.c                 | 18 ++++++++++++++----
 drivers/net/ethernet/ti/cpsw.h                 |  2 ++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documentation/devicetree/bindings/net/cpsw.txt
index c39f077..b95c38b 100644
--- a/Documentation/devicetree/bindings/net/cpsw.txt
+++ b/Documentation/devicetree/bindings/net/cpsw.txt
@@ -34,6 +34,11 @@ Required properties:
 Optional properties:
 - dual_emac_res_vlan	: Specifies VID to be used to segregate the ports
 - mac-address		: Specifies slave MAC address
+- ti,mac-address-ctrl	: When cpsw-ctrl-macid support is compiledin, this can
+			  be set to a phandle with one argument, see
+			  cpsw-ctrl-macid.txt. If this method fails, cpsw falls
+			  back to mac-address or random mac-address.
+
 
 Note: "ti,hwmods" field is used to fetch the base address and irq
 resources from TI, omap hwmod data base during device registration.
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 5120d9c..382d793 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1804,9 +1804,16 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 		snprintf(slave_data->phy_id, sizeof(slave_data->phy_id),
 			 PHY_ID_FMT, mdio->name, phyid);
 
-		mac_addr = of_get_mac_address(slave_node);
-		if (mac_addr)
-			memcpy(slave_data->mac_addr, mac_addr, ETH_ALEN);
+		ret = cpsw_ctrl_macid_read(slave_node, slave_data->mac_addr);
+		if (ret) {
+			if (ret == -EPROBE_DEFER)
+				return ret;
+
+			mac_addr = of_get_mac_address(slave_node);
+			if (mac_addr)
+				memcpy(slave_data->mac_addr, mac_addr,
+						ETH_ALEN);
+		}
 
 		slave_data->phy_if = of_get_phy_mode(slave_node);
 
@@ -1946,10 +1953,13 @@ static int cpsw_probe(struct platform_device *pdev)
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
1.8.5.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
