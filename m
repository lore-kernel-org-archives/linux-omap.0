From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/12] bus: ti-sysc: Improve handling for no-reset-on-init and
 no-idle-on-init
Date: Fri, 23 Feb 2018 13:00:52 -0800
Message-ID: <20180223210100.86732-5-tony@atomide.com>
References: <20180223210100.86732-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180223210100.86732-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

At least earlycon needs a delayed idle before the 8250 driver probes
to avoid glitches in the console output. Let's handle the delayed idle
for devices tagged with ti,no-reset-on-init and ti,no-idle-on-init with
delayed_work. Others don't need it, and there should be no need to use
runtime PM autosuspend for the interconnect target driver as it's the
child device drivers that should configure it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -74,6 +74,7 @@ struct sysc {
 	u32 revision;
 	bool enabled;
 	bool needs_resume;
+	struct delayed_work idle_work;
 };
 
 static u32 sysc_read(struct sysc *ddata, int offset)
@@ -1028,6 +1029,16 @@ static int sysc_init_match(struct sysc *ddata)
 	return 0;
 }
 
+static void ti_sysc_idle(struct work_struct *work)
+{
+	struct sysc *ddata;
+
+	ddata = container_of(work, struct sysc, idle_work.work);
+
+	if (pm_runtime_active(ddata->dev))
+		pm_runtime_put_sync(ddata->dev);
+}
+
 static int sysc_probe(struct platform_device *pdev)
 {
 	struct sysc *ddata;
@@ -1081,8 +1092,6 @@ static int sysc_probe(struct platform_device *pdev)
 		goto unprepare;
 	}
 
-	pm_runtime_use_autosuspend(ddata->dev);
-
 	sysc_show_registers(ddata);
 
 	ddata->dev->type = &sysc_device_type;
@@ -1091,13 +1100,19 @@ static int sysc_probe(struct platform_device *pdev)
 	if (error)
 		goto err;
 
-	pm_runtime_mark_last_busy(ddata->dev);
-	pm_runtime_put_autosuspend(ddata->dev);
+	INIT_DELAYED_WORK(&ddata->idle_work, ti_sysc_idle);
+
+	/* At least earlycon won't survive without deferred idle */
+	if (ddata->cfg.quirks & (SYSC_QUIRK_NO_IDLE_ON_INIT |
+				 SYSC_QUIRK_NO_RESET_ON_INIT)) {
+		schedule_delayed_work(&ddata->idle_work, 3000);
+	} else {
+		pm_runtime_put(&pdev->dev);
+	}
 
 	return 0;
 
 err:
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 unprepare:
@@ -1111,6 +1126,8 @@ static int sysc_remove(struct platform_device *pdev)
 	struct sysc *ddata = platform_get_drvdata(pdev);
 	int error;
 
+	cancel_delayed_work_sync(&ddata->idle_work);
+
 	error = pm_runtime_get_sync(ddata->dev);
 	if (error < 0) {
 		pm_runtime_put_noidle(ddata->dev);
@@ -1120,7 +1137,6 @@ static int sysc_remove(struct platform_device *pdev)
 
 	of_platform_depopulate(&pdev->dev);
 
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.16.2
