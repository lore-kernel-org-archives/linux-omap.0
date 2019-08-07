From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 1/3] bus: ti-sysc: re-order the clkdm control around reset handling
Date: Wed, 7 Aug 2019 15:46:03 +0300
Message-ID: <1565181965-21039-2-git-send-email-t-kristo@ti.com>
References: <1565181965-21039-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565181965-21039-1-git-send-email-t-kristo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com
Cc: linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Parenting clockdomain for the IP should be enabled during the reset
handling logic, otherwise the reset may not finish properly. Re-order
the clockdomain control logic to avoid this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/bus/ti-sysc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index e6deabd..ad9c6d3 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1091,11 +1091,11 @@ static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 	ddata->enabled = false;
 
 err_allow_idle:
-	sysc_clkdm_allow_idle(ddata);
-
 	if (ddata->disable_on_idle)
 		reset_control_assert(ddata->rsts);
 
+	sysc_clkdm_allow_idle(ddata);
+
 	return error;
 }
 
@@ -1109,11 +1109,12 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 	if (ddata->enabled)
 		return 0;
 
-	if (ddata->disable_on_idle)
-		reset_control_deassert(ddata->rsts);
 
 	sysc_clkdm_deny_idle(ddata);
 
+	if (ddata->disable_on_idle)
+		reset_control_deassert(ddata->rsts);
+
 	if (sysc_opt_clks_needed(ddata)) {
 		error = sysc_enable_opt_clocks(ddata);
 		if (error)
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
