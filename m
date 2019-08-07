From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 3/3] bus: ti-sysc: allow reset sharing across devices
Date: Wed, 7 Aug 2019 15:46:05 +0300
Message-ID: <1565181965-21039-4-git-send-email-t-kristo@ti.com>
References: <1565181965-21039-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565181965-21039-1-git-send-email-t-kristo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com
Cc: linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Some devices need to share their reset signals, like DSP MMUs, thus drop
the exclusive notation from reset request. Also, balance the init time
reset count, otherwise the resets will never be applied post boot.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/bus/ti-sysc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index e08125a..b30eb05 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -502,7 +502,7 @@ static void sysc_clkdm_allow_idle(struct sysc *ddata)
 static int sysc_init_resets(struct sysc *ddata)
 {
 	ddata->rsts =
-		devm_reset_control_get_optional(ddata->dev, "rstctrl");
+		devm_reset_control_get_optional_shared(ddata->dev, "rstctrl");
 	if (IS_ERR(ddata->rsts))
 		return PTR_ERR(ddata->rsts);
 
@@ -1527,7 +1527,7 @@ static int sysc_legacy_init(struct sysc *ddata)
  */
 static int sysc_rstctrl_reset_deassert(struct sysc *ddata, bool reset)
 {
-	int error, val;
+	int error;
 
 	if (!ddata->rsts)
 		return 0;
@@ -1538,7 +1538,9 @@ static int sysc_rstctrl_reset_deassert(struct sysc *ddata, bool reset)
 			return error;
 	}
 
-	return reset_control_deassert(ddata->rsts);
+	reset_control_deassert(ddata->rsts);
+
+	return 0;
 }
 
 /*
@@ -2418,6 +2420,10 @@ static int sysc_probe(struct platform_device *pdev)
 		goto unprepare;
 	}
 
+	/* Balance reset counts */
+	if (ddata->rsts)
+		reset_control_assert(ddata->rsts);
+
 	sysc_show_registers(ddata);
 
 	ddata->dev->type = &sysc_device_type;
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
