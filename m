From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 06/22] mfd: omap-usb-tll: Check for missing platform data in probe
Date: Wed, 28 Nov 2012 16:48:54 +0200
Message-ID: <1354114150-11941-7-git-send-email-rogerq@ti.com>
References: <1354114150-11941-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354114150-11941-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

No need to check for missing platform data in runtime_suspend/resume
as it makes more sense to do it in the probe function.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/omap-usb-tll.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 99a3087..a6a44de 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -225,6 +225,11 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	if (!pdata) {
+		dev_err(dev, "Platform data missing\n");
+		return -ENODEV;
+	}
+
 	spin_lock_init(&tll->lock);
 
 	tll->pdata = pdata;
@@ -367,11 +372,6 @@ static int usbtll_runtime_resume(struct device *dev)
 
 	dev_dbg(dev, "usbtll_runtime_resume\n");
 
-	if (!pdata) {
-		dev_dbg(dev, "missing platform_data\n");
-		return  -ENODEV;
-	}
-
 	spin_lock_irqsave(&tll->lock, flags);
 
 	for (i = 0; i < tll->nch; i++) {
@@ -403,11 +403,6 @@ static int usbtll_runtime_suspend(struct device *dev)
 
 	dev_dbg(dev, "usbtll_runtime_suspend\n");
 
-	if (!pdata) {
-		dev_dbg(dev, "missing platform_data\n");
-		return  -ENODEV;
-	}
