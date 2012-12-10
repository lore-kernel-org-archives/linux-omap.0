From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 07/23] mfd: omap-usb-tll: Check for missing platform data
 in probe
Date: Mon, 10 Dec 2012 12:20:17 +0200
Message-ID: <1355134833-5199-8-git-send-email-rogerq@ti.com>
References: <1355134833-5199-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1355134833-5199-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com, sameo@linux.intel.com, tony@atomide.com
Cc: paul@pwsan.com, sshtylyov@mvista.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, keshava_mgowda@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bjorn@mork.no, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

No need to check for missing platform data in runtime_suspend/resume
as it makes more sense to do it in the probe function.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-tll.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 07370a3..8b596e0 100644
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
-
 	spin_lock_irqsave(&tll->lock, flags);
 
 	for (i = 0; i < tll->nch; i++) {
-- 
1.7.4.1
