From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 2/3] bus: ti-sysc: rework the reset handling
Date: Wed, 7 Aug 2019 15:46:04 +0300
Message-ID: <1565181965-21039-3-git-send-email-t-kristo@ti.com>
References: <1565181965-21039-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565181965-21039-1-git-send-email-t-kristo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com
Cc: linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

If reset controllers are assigned to the ti-sysc target-module, only
ti-sysc is going to be able to control these. Thus, remove all the
disable_on_idle flag usage, and assert/de-assert the reset always
in the idle path. Otherwise the reset signal will always just be
de-asserted.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/bus/ti-sysc.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index ad9c6d3..e08125a 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -95,7 +95,6 @@ struct sysc {
 	unsigned int enabled:1;
 	unsigned int needs_resume:1;
 	unsigned int child_needs_resume:1;
-	unsigned int disable_on_idle:1;
 	struct delayed_work idle_work;
 	void (*clk_enable_quirk)(struct sysc *sysc);
 	void (*clk_disable_quirk)(struct sysc *sysc);
@@ -1031,8 +1030,7 @@ static int __maybe_unused sysc_runtime_suspend_legacy(struct device *dev,
 		dev_err(dev, "%s: could not idle: %i\n",
 			__func__, error);
 
-	if (ddata->disable_on_idle)
-		reset_control_assert(ddata->rsts);
+	reset_control_assert(ddata->rsts);
 
 	return 0;
 }
@@ -1043,8 +1041,7 @@ static int __maybe_unused sysc_runtime_resume_legacy(struct device *dev,
 	struct ti_sysc_platform_data *pdata;
 	int error;
 
-	if (ddata->disable_on_idle)
-		reset_control_deassert(ddata->rsts);
+	reset_control_deassert(ddata->rsts);
 
 	pdata = dev_get_platdata(ddata->dev);
 	if (!pdata)
@@ -1091,8 +1088,7 @@ static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 	ddata->enabled = false;
 
 err_allow_idle:
-	if (ddata->disable_on_idle)
-		reset_control_assert(ddata->rsts);
+	reset_control_assert(ddata->rsts);
 
 	sysc_clkdm_allow_idle(ddata);
 
@@ -1112,8 +1108,7 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 
 	sysc_clkdm_deny_idle(ddata);
 
-	if (ddata->disable_on_idle)
-		reset_control_deassert(ddata->rsts);
+	reset_control_deassert(ddata->rsts);
 
 	if (sysc_opt_clks_needed(ddata)) {
 		error = sysc_enable_opt_clocks(ddata);
@@ -1543,14 +1538,7 @@ static int sysc_rstctrl_reset_deassert(struct sysc *ddata, bool reset)
 			return error;
 	}
 
-	error = reset_control_deassert(ddata->rsts);
-	if (error == -EEXIST)
-		return 0;
-
-	error = readx_poll_timeout(reset_control_status, ddata->rsts, val,
-				   val == 0, 100, MAX_MODULE_SOFTRESET_WAIT);
-
-	return error;
+	return reset_control_deassert(ddata->rsts);
 }
 
 /*
@@ -2449,9 +2437,6 @@ static int sysc_probe(struct platform_device *pdev)
 		pm_runtime_put(&pdev->dev);
 	}
 
-	if (!of_get_available_child_count(ddata->dev->of_node))
-		ddata->disable_on_idle = true;
-
 	return 0;
 
 err:
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
