From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/5] wlcore: Fix config firmware loading issues
Date: Sat, 17 Sep 2016 09:06:32 -0700
Message-ID: <20160917160633.8767-5-tony@atomide.com>
References: <20160917160633.8767-1-tony@atomide.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160917160633.8767-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Booting multiple wl12xx and wl18xx devices using the same rootfs is
a pain. You currently have to symlink the right nvs file depending
on the wl12xx type.

For example, with wl1271-nvs.bin being a symlink to wl127x-nvs.bin
by default and trying to bring up a wl128x based device:

wlcore: ERROR nvs size is not as expected: 1113 != 912
wlcore: ERROR NVS file is needed during boot
wlcore: ERROR NVS file is needed during boot
wlcore: ERROR firmware boot failed despite 3 retries

Note that wl18xx uses a separate config firmware wl18xx-conf.bin
that can be generated with tools using the following two git repos:

git.ti.com/wilink8-wlan/18xx-ti-utils
git.ti.com/wilink8-wlan/wl18xx_fw

So let's not configure the nvs file for wl18xx as it's not needed
AFAIK. If it turns out that we also need the nvs file for wl18xx,
we can just add it to the config firmware data for wl18xx.

Let's fix the issue by using the chip specific config firmware
data, and make sure we produce understandable warnings if something
is missing.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/net/wireless/ti/wlcore/boot.c     | 15 +++++++++----
 drivers/net/wireless/ti/wlcore/main.c     | 36 ++++++++++++++++++++-----------
 drivers/net/wireless/ti/wlcore/wlcore_i.h |  7 ------
 3 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/boot.c b/drivers/net/wireless/ti/wlcore/boot.c
--- a/drivers/net/wireless/ti/wlcore/boot.c
+++ b/drivers/net/wireless/ti/wlcore/boot.c
@@ -282,6 +282,9 @@ EXPORT_SYMBOL_GPL(wlcore_boot_upload_firmware);
 
 int wlcore_boot_upload_nvs(struct wl1271 *wl)
 {
+	struct platform_device *pdev = wl->pdev;
+	struct wlcore_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
+	const char *nvs_name = "unknown";
 	size_t nvs_len, burst_len;
 	int i;
 	u32 dest_addr, val;
@@ -293,6 +296,9 @@ int wlcore_boot_upload_nvs(struct wl1271 *wl)
 		return -ENODEV;
 	}
 
+	if (pdev_data && pdev_data->family)
+		nvs_name = pdev_data->family->nvs_name;
+
 	if (wl->quirks & WLCORE_QUIRK_LEGACY_NVS) {
 		struct wl1271_nvs_file *nvs =
 			(struct wl1271_nvs_file *)wl->nvs;
@@ -310,8 +316,9 @@ int wlcore_boot_upload_nvs(struct wl1271 *wl)
 		if (wl->nvs_len != sizeof(struct wl1271_nvs_file) &&
 		    (wl->nvs_len != WL1271_INI_LEGACY_NVS_FILE_SIZE ||
 		     wl->enable_11a)) {
-			wl1271_error("nvs size is not as expected: %zu != %zu",
-				wl->nvs_len, sizeof(struct wl1271_nvs_file));
+			wl1271_error("%s size is not as expected: %zu != %zu",
+				     nvs_name, wl->nvs_len,
+				     sizeof(struct wl1271_nvs_file));
 			kfree(wl->nvs);
 			wl->nvs = NULL;
 			wl->nvs_len = 0;
@@ -328,8 +335,8 @@ int wlcore_boot_upload_nvs(struct wl1271 *wl)
 			if (nvs->general_params.dual_mode_select)
 				wl->enable_11a = true;
 		} else {
-			wl1271_error("nvs size is not as expected: %zu != %zu",
-				     wl->nvs_len,
+			wl1271_error("%s size is not as expected: %zu != %zu",
+				     nvs_name, wl->nvs_len,
 				     sizeof(struct wl128x_nvs_file));
 			kfree(wl->nvs);
 			wl->nvs = NULL;
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -6413,9 +6413,12 @@ static void wlcore_nvs_cb(const struct firmware *fw, void *context)
 			goto out;
 		}
 		wl->nvs_len = fw->size;
-	} else {
+	} else if (pdev_data->family->nvs_name) {
 		wl1271_debug(DEBUG_BOOT, "Could not get nvs file %s",
-			     WL12XX_NVS_NAME);
+			     pdev_data->family->nvs_name);
+		wl->nvs = NULL;
+		wl->nvs_len = 0;
+	} else {
 		wl->nvs = NULL;
 		wl->nvs_len = 0;
 	}
@@ -6510,21 +6513,29 @@ static void wlcore_nvs_cb(const struct firmware *fw, void *context)
 
 int wlcore_probe(struct wl1271 *wl, struct platform_device *pdev)
 {
-	int ret;
+	struct wlcore_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
+	const char *nvs_name;
+	int ret = 0;
 
-	if (!wl->ops || !wl->ptable)
+	if (!wl->ops || !wl->ptable || !pdev_data)
 		return -EINVAL;
 
 	wl->dev = &pdev->dev;
 	wl->pdev = pdev;
 	platform_set_drvdata(pdev, wl);
 
-	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
-				      WL12XX_NVS_NAME, &pdev->dev, GFP_KERNEL,
-				      wl, wlcore_nvs_cb);
-	if (ret < 0) {
-		wl1271_error("request_firmware_nowait failed: %d", ret);
-		complete_all(&wl->nvs_loading_complete);
+	if (pdev_data->family && pdev_data->family->nvs_name) {
+		nvs_name = pdev_data->family->nvs_name;
+		ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
+					      nvs_name, &pdev->dev, GFP_KERNEL,
+					      wl, wlcore_nvs_cb);
+		if (ret < 0) {
+			wl1271_error("request_firmware_nowait failed for %s: %d",
+				     nvs_name, ret);
+			complete_all(&wl->nvs_loading_complete);
+		}
+	} else {
+		wlcore_nvs_cb(NULL, wl);
 	}
 
 	return ret;
@@ -6533,9 +6544,11 @@ EXPORT_SYMBOL_GPL(wlcore_probe);
 
 int wlcore_remove(struct platform_device *pdev)
 {
+	struct wlcore_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
 	struct wl1271 *wl = platform_get_drvdata(pdev);
 
-	wait_for_completion(&wl->nvs_loading_complete);
+	if (pdev_data->family && pdev_data->family->nvs_name)
+		wait_for_completion(&wl->nvs_loading_complete);
 	if (!wl->initialized)
 		return 0;
 
@@ -6572,4 +6585,3 @@ MODULE_PARM_DESC(no_recovery, "Prevent HW recovery. FW will remain stuck.");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>");
 MODULE_AUTHOR("Juuso Oikarinen <juuso.oikarinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>");
-MODULE_FIRMWARE(WL12XX_NVS_NAME);
diff --git a/drivers/net/wireless/ti/wlcore/wlcore_i.h b/drivers/net/wireless/ti/wlcore/wlcore_i.h
--- a/drivers/net/wireless/ti/wlcore/wlcore_i.h
+++ b/drivers/net/wireless/ti/wlcore/wlcore_i.h
@@ -35,13 +35,6 @@
 #include "conf.h"
 #include "ini.h"
 
-/*
- * wl127x and wl128x are using the same NVS file name. However, the
- * ini parameters between them are different.  The driver validates
- * the correct NVS size in wl1271_boot_upload_nvs().
- */
-#define WL12XX_NVS_NAME "ti-connectivity/wl1271-nvs.bin"
