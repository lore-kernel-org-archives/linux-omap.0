From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 5/7] drivers/usb/dwc3: don't check resource with devm_ioremap_resource
Date: Tue, 14 Jan 2014 12:58:56 +0100
Message-ID: <1389700739-3696-5-git-send-email-wsa@the-dreams.de>
References: <1389700739-3696-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389700739-3696-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Should go via subsystem tree

 drivers/usb/dwc3/dwc3-omap.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 7f7ea62..cbcd972 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -432,11 +432,6 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "missing memory base resource\n");
-		return -EINVAL;
-	}
-
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
-- 
1.8.5.1
