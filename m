From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/16] bus: ti-sysc: Improve suspend and resume handling
Date: Mon, 23 Apr 2018 10:45:44 -0700
Message-ID: <20180423174549.57412-12-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Based on testing with more devices I noticed that some devices
don't suspend or resume properly. We need to PM runtime suspend
and resume devices if we have ddata->needs_resume set.

Let's also improve the error handling and add few debug statements
to make it easier to notice suspend and resume related issues if
DEBUG is set.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 54 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -662,6 +662,7 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 static int sysc_suspend(struct device *dev)
 {
 	struct sysc *ddata;
+	int error;
 
 	ddata = dev_get_drvdata(dev);
 
@@ -672,14 +673,27 @@ static int sysc_suspend(struct device *dev)
 	if (!ddata->enabled)
 		return 0;
 
+	dev_dbg(ddata->dev, "%s %s\n", __func__,
+		ddata->name ? ddata->name : "");
+
+	error = pm_runtime_put_sync_suspend(dev);
+	if (error < 0) {
+		dev_warn(ddata->dev, "%s not idle %i %s\n",
+			 __func__, error,
+			 ddata->name ? ddata->name : "");
+
+		return 0;
+	}
+
 	ddata->needs_resume = true;
 
-	return sysc_runtime_suspend(dev);
+	return 0;
 }
 
 static int sysc_resume(struct device *dev)
 {
 	struct sysc *ddata;
+	int error;
 
 	ddata = dev_get_drvdata(dev);
 
@@ -691,9 +705,16 @@ static int sysc_resume(struct device *dev)
 		dev_dbg(ddata->dev, "%s %s\n", __func__,
 			ddata->name ? ddata->name : "");
 
-		ddata->needs_resume = false;
+		error = pm_runtime_get_sync(dev);
+		if (error < 0) {
+			dev_err(ddata->dev, "%s  error %i %s\n",
+				__func__, error,
+				 ddata->name ? ddata->name : "");
 
-		return sysc_runtime_resume(dev);
+			return error;
+		}
+
+		ddata->needs_resume = false;
 	}
 
 	return 0;
@@ -735,6 +756,9 @@ static int sysc_noirq_resume(struct device *dev)
 		return 0;
 
 	if (ddata->needs_resume) {
+		dev_dbg(ddata->dev, "%s %s\n", __func__,
+			ddata->name ? ddata->name : "");
+
 		ddata->needs_resume = false;
 
 		return sysc_runtime_resume(dev);
@@ -1069,18 +1093,33 @@ static int sysc_child_suspend_noirq(struct device *dev)
 
 	ddata = sysc_child_to_parent(dev);
 
+	dev_dbg(ddata->dev, "%s %s\n", __func__,
+		ddata->name ? ddata->name : "");
+
 	error = pm_generic_suspend_noirq(dev);
-	if (error)
+	if (error) {
+		dev_err(dev, "%s error at %i: %i\n",
+			__func__, __LINE__, error);
+
 		return error;
+	}
 
 	if (!pm_runtime_status_suspended(dev)) {
 		error = pm_generic_runtime_suspend(dev);
-		if (error)
+		if (error) {
+			dev_err(dev, "%s error at %i: %i\n",
+				__func__, __LINE__, error);
+
 			return error;
+		}
 
 		error = sysc_runtime_suspend(ddata->dev);
-		if (error)
+		if (error) {
+			dev_err(dev, "%s error at %i: %i\n",
+				__func__, __LINE__, error);
+
 			return error;
+		}
 
 		ddata->child_needs_resume = true;
 	}
@@ -1095,6 +1134,9 @@ static int sysc_child_resume_noirq(struct device *dev)
 
 	ddata = sysc_child_to_parent(dev);
 
+	dev_dbg(ddata->dev, "%s %s\n", __func__,
+		ddata->name ? ddata->name : "");
+
 	if (ddata->child_needs_resume) {
 		ddata->child_needs_resume = false;
 
-- 
2.17.0
