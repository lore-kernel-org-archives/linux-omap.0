From: Shuah Khan <shuahkh-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: [PATCH 4/7] usb: dwc3: exynos: change goto labels in this file to meaningful names
Date: Fri, 24 Mar 2017 18:05:02 -0600
Message-ID: <a81ad4534b4b9d451d0a2310469aa64b3c236f6e.1490387086.git.shuahkh@osg.samsung.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1490387086.git.shuahkh-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
In-Reply-To: <cover.1490387086.git.shuahkh-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
References: <cover.1490387086.git.shuahkh-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org
Cc: Shuah Khan <shuahkh-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Change goto labels in this file to meaningful names

Signed-off-by: Shuah Khan <shuahkh-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
---
 drivers/usb/dwc3/dwc3-exynos.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 98f74ff..11f31f4 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -58,12 +58,12 @@ static int dwc3_exynos_register_phys(struct dwc3_exynos *exynos)
 
 	ret = platform_device_add_data(exynos->usb2_phy, &pdata, sizeof(pdata));
 	if (ret)
-		goto err1;
+		goto usb2_phy_device_put;
 
 	pdev = platform_device_alloc("usb_phy_generic", PLATFORM_DEVID_AUTO);
 	if (!pdev) {
 		ret = -ENOMEM;
-		goto err1;
+		goto usb2_phy_device_put;
 	}
 
 	exynos->usb3_phy = pdev;
@@ -71,25 +71,25 @@ static int dwc3_exynos_register_phys(struct dwc3_exynos *exynos)
 
 	ret = platform_device_add_data(exynos->usb3_phy, &pdata, sizeof(pdata));
 	if (ret)
-		goto err2;
+		goto usb3_phy_device_put;
 
 	ret = platform_device_add(exynos->usb2_phy);
 	if (ret)
-		goto err2;
+		goto usb3_phy_device_put;
 
 	ret = platform_device_add(exynos->usb3_phy);
 	if (ret)
-		goto err3;
+		goto usb2_phy_device_del;
 
 	return 0;
 
-err3:
+usb2_phy_device_del:
 	platform_device_del(exynos->usb2_phy);
 
-err2:
+usb3_phy_device_put:
 	platform_device_put(exynos->usb3_phy);
 
-err1:
+usb2_phy_device_put:
 	platform_device_put(exynos->usb2_phy);
 
 	return ret;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
