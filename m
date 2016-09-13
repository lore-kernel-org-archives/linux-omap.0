From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 5/5] wlcore: wl18xx: Use chip specific configuration firmware
Date: Tue, 13 Sep 2016 14:50:43 -0700
Message-ID: <20160913215043.29454-6-tony@atomide.com>
References: <20160913215043.29454-1-tony@atomide.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160913215043.29454-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Use the wl18xx specific config firmware we now have available.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/net/wireless/ti/wl18xx/main.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ti/wl18xx/main.c b/drivers/net/wireless/ti/wl18xx/main.c
index 00a04df..06d6943 100644
--- a/drivers/net/wireless/ti/wl18xx/main.c
+++ b/drivers/net/wireless/ti/wl18xx/main.c
@@ -1397,25 +1397,24 @@ static int wl18xx_get_pg_ver(struct wl1271 *wl, s8 *ver)
 	return ret;
 }
 
-#define WL18XX_CONF_FILE_NAME "ti-connectivity/wl18xx-conf.bin"
-
 static int wl18xx_load_conf_file(struct device *dev, struct wlcore_conf *conf,
-				 struct wl18xx_priv_conf *priv_conf)
+				 struct wl18xx_priv_conf *priv_conf,
+				 const char *file)
 {
 	struct wlcore_conf_file *conf_file;
 	const struct firmware *fw;
 	int ret;
 
-	ret = request_firmware(&fw, WL18XX_CONF_FILE_NAME, dev);
+	ret = request_firmware(&fw, file, dev);
 	if (ret < 0) {
 		wl1271_error("could not get configuration binary %s: %d",
-			     WL18XX_CONF_FILE_NAME, ret);
+			     file, ret);
 		return ret;
 	}
 
 	if (fw->size != WL18XX_CONF_SIZE) {
-		wl1271_error("configuration binary file size is wrong, expected %zu got %zu",
-			     WL18XX_CONF_SIZE, fw->size);
+		wl1271_error("%s configuration binary size is wrong, expected %zu got %zu",
+			     file, WL18XX_CONF_SIZE, fw->size);
 		ret = -EINVAL;
 		goto out_release;
 	}
@@ -1448,9 +1447,12 @@ static int wl18xx_load_conf_file(struct device *dev, struct wlcore_conf *conf,
 
 static int wl18xx_conf_init(struct wl1271 *wl, struct device *dev)
 {
+	struct platform_device *pdev = wl->pdev;
+	struct wlcore_platdev_data *pdata = dev_get_platdata(&pdev->dev);
 	struct wl18xx_priv *priv = wl->priv;
 
-	if (wl18xx_load_conf_file(dev, &wl->conf, &priv->conf) < 0) {
+	if (wl18xx_load_conf_file(dev, &wl->conf, &priv->conf,
+				  pdata->family->cfg_name) < 0) {
 		wl1271_warning("falling back to default config");
 
 		/* apply driver default configuration */
@@ -2141,4 +2143,3 @@ MODULE_PARM_DESC(num_rx_desc_param,
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>");
 MODULE_FIRMWARE(WL18XX_FW_NAME);
-MODULE_FIRMWARE(WL18XX_CONF_FILE_NAME);
-- 
2.9.3
