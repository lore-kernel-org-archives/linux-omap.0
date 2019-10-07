From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 3/3] bus: ti-sysc: avoid toggling power state of module during
 probe
Date: Mon, 7 Oct 2019 15:29:31 +0300
Message-ID: <20191007122931.18668-4-t-kristo@ti.com>
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

Current implementation for ti-sysc powers down the module once module
init is complete. However, right after power is disabled, it is enabled
via runtime PM. This is unnecessary so avoid it by re-ordering the
events a bit; move powering down of the module post runtime PM enable
which makes sure the use counts are maintained properly and there is
no extra power down/up sequence for the module.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/bus/ti-sysc.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 6f392469d5b0..5b69457fa857 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1580,11 +1580,6 @@ static int sysc_reset(struct sysc *ddata)
 static int sysc_init_module(struct sysc *ddata)
 {
 	int error = 0;
-	bool manage_clocks = true;
-
-	if (ddata->cfg.quirks &
-	    (SYSC_QUIRK_NO_IDLE | SYSC_QUIRK_NO_IDLE_ON_INIT))
-		manage_clocks = false;
 
 	error = sysc_clockdomain_init(ddata);
 	if (error)
@@ -1617,28 +1612,32 @@ static int sysc_init_module(struct sysc *ddata)
 	if (ddata->legacy_mode) {
 		error = sysc_legacy_init(ddata);
 		if (error)
-			goto err_main_clocks;
+			goto err_reset;
 	}
 
 	if (!ddata->legacy_mode) {
 		error = sysc_enable_module(ddata->dev);
 		if (error)
-			goto err_main_clocks;
+			goto err_reset;
 	}
 
 	error = sysc_reset(ddata);
 	if (error)
 		dev_err(ddata->dev, "Reset failed with %d\n", error);
 
-	if (!ddata->legacy_mode && manage_clocks)
+	if (error && !ddata->legacy_mode)
 		sysc_disable_module(ddata->dev);
 
+err_reset:
+	if (error && !(ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT))
+		reset_control_assert(ddata->rsts);
+
 err_main_clocks:
-	if (manage_clocks)
+	if (error)
 		sysc_disable_main_clocks(ddata);
 err_opt_clocks:
 	/* No re-enable of clockdomain autoidle to prevent module autoidle */
-	if (manage_clocks) {
+	if (error) {
 		sysc_disable_opt_clocks(ddata);
 		sysc_clkdm_allow_idle(ddata);
 	}
@@ -2411,9 +2410,16 @@ static int sysc_probe(struct platform_device *pdev)
 		goto unprepare;
 	}
 
-	/* Balance reset counts */
-	if (ddata->rsts)
-		reset_control_assert(ddata->rsts);
+	/* Balance use counts as PM runtime should have enabled these all */
+	if (!(ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT))
+		reset_control_assert(ddata->rsts);
+
+	if (!(ddata->cfg.quirks &
+	      (SYSC_QUIRK_NO_IDLE | SYSC_QUIRK_NO_IDLE_ON_INIT))) {
+		sysc_disable_main_clocks(ddata);
+		sysc_disable_opt_clocks(ddata);
+		sysc_clkdm_allow_idle(ddata);
+	}
 
 	sysc_show_registers(ddata);
 
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
