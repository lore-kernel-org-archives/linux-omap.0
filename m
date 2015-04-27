From: <grygorii.strashko@linaro.org>
Subject: [PATCH 2/3] bus: omap_l3_noc: add missed callbacks for suspend-to-disk
Date: Mon, 27 Apr 2015 21:24:31 +0300
Message-ID: <1430159072-31440-3-git-send-email-grygorii.strashko@linaro.org>
References: <1430159072-31440-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430159072-31440-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Cc: ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <Grygorii.Strashko@linaro.org>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <Grygorii.Strashko@linaro.org>

Add missed callbacks needed for proper supporting of suspend-to-disk
by using recently introduced macro SET_NOIRQ_SYSTEM_SLEEP_PM_OPS.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
---
 drivers/bus/omap_l3_noc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index 11f7982..6ae3884 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -300,7 +300,7 @@ static int omap_l3_probe(struct platform_device *pdev)
 	return ret;
 }
 
-#ifdef	CONFIG_PM
+#ifdef	CONFIG_PM_SLEEP
 
 /**
  * l3_resume_noirq() - resume function for l3_noc
@@ -346,7 +346,7 @@ static int l3_resume_noirq(struct device *dev)
 }
 
 static const struct dev_pm_ops l3_dev_pm_ops = {
-	.resume_noirq		= l3_resume_noirq,
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, l3_resume_noirq)
 };
 
 #define L3_DEV_PM_OPS (&l3_dev_pm_ops)
-- 
1.9.1
