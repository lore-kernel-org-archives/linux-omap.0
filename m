From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 2/3] bus: ti-sysc: drop the extra hardreset during init
Date: Mon, 7 Oct 2019 15:29:30 +0300
Message-ID: <20191007122931.18668-3-t-kristo@ti.com>
References: <20191007122931.18668-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191007122931.18668-1-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

There seems to be unnecessary extra hardreset line toggling applied
during module init. This is unnecessary, as the reset lines are already
asserted during boot, and it can cause certain modules to hang (iommus,
remoteprocs.) Remove the extra hardreset toggle, and remove the now
redundant function to handle this also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/bus/ti-sysc.c | 37 +------------------------------------
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index c9d01e2d3a64..6f392469d5b0 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1518,37 +1518,6 @@ static int sysc_legacy_init(struct sysc *ddata)
 	return error;
 }
 
-/**
- * sysc_rstctrl_reset_deassert - deassert rstctrl reset
- * @ddata: device driver data
- * @reset: reset before deassert
- *
- * A module can have both OCP softreset control and external rstctrl.
- * If more complicated rstctrl resets are needed, please handle these
- * directly from the child device driver and map only the module reset
- * for the parent interconnect target module device.
- *
- * Automatic reset of the module on init can be skipped with the
- * "ti,no-reset-on-init" device tree property.
- */
-static int sysc_rstctrl_reset_deassert(struct sysc *ddata, bool reset)
-{
-	int error;
-
-	if (!ddata->rsts)
-		return 0;
-
-	if (reset) {
-		error = reset_control_assert(ddata->rsts);
-		if (error)
-			return error;
-	}
-
-	reset_control_deassert(ddata->rsts);
-
-	return 0;
-}
-
 /*
  * Note that the caller must ensure the interconnect target module is enabled
  * before calling reset. Otherwise reset will not complete.
@@ -1613,10 +1582,6 @@ static int sysc_init_module(struct sysc *ddata)
 	int error = 0;
 	bool manage_clocks = true;
 
-	error = sysc_rstctrl_reset_deassert(ddata, false);
-	if (error)
-		return error;
-
 	if (ddata->cfg.quirks &
 	    (SYSC_QUIRK_NO_IDLE | SYSC_QUIRK_NO_IDLE_ON_INIT))
 		manage_clocks = false;
@@ -1640,7 +1605,7 @@ static int sysc_init_module(struct sysc *ddata)
 		goto err_opt_clocks;
 
 	if (!(ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT)) {
-		error = sysc_rstctrl_reset_deassert(ddata, true);
+		error = reset_control_deassert(ddata->rsts);
 		if (error)
 			goto err_main_clocks;
 	}
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
