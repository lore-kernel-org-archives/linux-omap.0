From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 1/7] usb: dwc3: core: fix dwc3_probe() to not do put_sync when get_sync fails
Date: Fri, 24 Mar 2017 18:04:59 -0600
Message-ID: <2238ea52423a83118ab724a96e8f0691ec4ada0b.1490387086.git.shuahkh@osg.samsung.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <cover.1490387086.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1490387086.git.shuahkh@osg.samsung.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, kgene@kernel.org, krzk@kernel.org, javier@osg.samsung.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

dwc3_probe() does pm_runtime_put_sync() in its err1 handling when
pm_runtime_get_sync() fails.  Move the pm_runtime_put_sync() under
err2 instead as it is used in error paths after pm_runtime_get_sync()
succeeds.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/usb/dwc3/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 56f1367..0fc7bef 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1162,9 +1162,9 @@ static int dwc3_probe(struct platform_device *pdev)
 
 err2:
 	pm_runtime_allow(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 
 err1:
-	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 err0:
-- 
2.7.4
