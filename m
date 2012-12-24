From: Omar Ramirez Luna <omar.ramirez@copitl.com>
Subject: [PATCH 2/2] staging: tidspbridge: use prepare/unprepare on dsp clocks
Date: Mon, 24 Dec 2012 08:10:25 -0600
Message-ID: <1356358225-25557-2-git-send-email-omar.ramirez@copitl.com>
References: <1356358225-25557-1-git-send-email-omar.ramirez@copitl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1356358225-25557-1-git-send-email-omar.ramirez@copitl.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Lindgren <tony@atomide.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This solves runtime failures while trying to enable WDT3 related
functionality on firmware load, however it does affect other clocks
controlled by the driver. Seen on 3.8-rc1.

CCF provides clk_prepare and clk_unprepare for enable and disable
operations respectively, this needs to be called in the correct
order while handling clocks.

Code path to enable/disable dsp clocks can still be reached from an
atomic context, hence we can't use clk_prepare_enable and
clk_disable_unprepare yet.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@copitl.com>
---
 drivers/staging/tidspbridge/core/dsp-clock.c |   13 ++++++++++++-
 drivers/staging/tidspbridge/core/wdt.c       |   12 ++++++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/dsp-clock.c b/drivers/staging/tidspbridge/core/dsp-clock.c
index b647207..2f084e18 100644
--- a/drivers/staging/tidspbridge/core/dsp-clock.c
+++ b/drivers/staging/tidspbridge/core/dsp-clock.c
@@ -121,9 +121,13 @@ void dsp_clk_exit(void)
 	for (i = 0; i < DM_TIMER_CLOCKS; i++)
 		omap_dm_timer_free(timer[i]);
 
+	clk_unprepare(iva2_clk);
 	clk_put(iva2_clk);
+	clk_unprepare(ssi.sst_fck);
 	clk_put(ssi.sst_fck);
+	clk_unprepare(ssi.ssr_fck);
 	clk_put(ssi.ssr_fck);
+	clk_unprepare(ssi.ick);
 	clk_put(ssi.ick);
 }
 
@@ -145,14 +149,21 @@ void dsp_clk_init(void)
 	iva2_clk = clk_get(&dspbridge_device.dev, "iva2_ck");
 	if (IS_ERR(iva2_clk))
 		dev_err(bridge, "failed to get iva2 clock %p\n", iva2_clk);
+	else
+		clk_prepare(iva2_clk);
 
 	ssi.sst_fck = clk_get(&dspbridge_device.dev, "ssi_sst_fck");
 	ssi.ssr_fck = clk_get(&dspbridge_device.dev, "ssi_ssr_fck");
 	ssi.ick = clk_get(&dspbridge_device.dev, "ssi_ick");
 
-	if (IS_ERR(ssi.sst_fck) || IS_ERR(ssi.ssr_fck) || IS_ERR(ssi.ick))
+	if (IS_ERR(ssi.sst_fck) || IS_ERR(ssi.ssr_fck) || IS_ERR(ssi.ick)) {
 		dev_err(bridge, "failed to get ssi: sst %p, ssr %p, ick %p\n",
 					ssi.sst_fck, ssi.ssr_fck, ssi.ick);
+	} else {
+		clk_prepare(ssi.sst_fck);
+		clk_prepare(ssi.ssr_fck);
+		clk_prepare(ssi.ick);
+	}
 }
 
 /**
diff --git a/drivers/staging/tidspbridge/core/wdt.c b/drivers/staging/tidspbridge/core/wdt.c
index 1dce36f..7ff0e6c 100644
--- a/drivers/staging/tidspbridge/core/wdt.c
+++ b/drivers/staging/tidspbridge/core/wdt.c
@@ -63,11 +63,15 @@ int dsp_wdt_init(void)
 	dsp_wdt.fclk = clk_get(NULL, "wdt3_fck");
 
 	if (!IS_ERR(dsp_wdt.fclk)) {
+		clk_prepare(dsp_wdt.fclk);
+
 		dsp_wdt.iclk = clk_get(NULL, "wdt3_ick");
 		if (IS_ERR(dsp_wdt.iclk)) {
 			clk_put(dsp_wdt.fclk);
 			dsp_wdt.fclk = NULL;
 			ret = -EFAULT;
+		} else {
+			clk_prepare(dsp_wdt.iclk);
 		}
 	} else
 		ret = -EFAULT;
@@ -95,10 +99,14 @@ void dsp_wdt_exit(void)
 	free_irq(INT_34XX_WDT3_IRQ, &dsp_wdt);
 	tasklet_kill(&dsp_wdt.wdt3_tasklet);
 
-	if (dsp_wdt.fclk)
+	if (dsp_wdt.fclk) {
+		clk_unprepare(dsp_wdt.fclk);
 		clk_put(dsp_wdt.fclk);
-	if (dsp_wdt.iclk)
+	}
+	if (dsp_wdt.iclk) {
+		clk_unprepare(dsp_wdt.iclk);
 		clk_put(dsp_wdt.iclk);
+	}
 
 	dsp_wdt.fclk = NULL;
 	dsp_wdt.iclk = NULL;
-- 
1.7.4.4
