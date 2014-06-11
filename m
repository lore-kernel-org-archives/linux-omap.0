From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 27/36] ARM: OMAP2+: usb-tusb6010: Use omap_gpmc_retime()
Date: Wed, 11 Jun 2014 11:56:32 +0300
Message-ID: <1402477001-31132-28-git-send-email-rogerq@ti.com>
References: <1402477001-31132-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402477001-31132-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, dwmw2@infradead.org, computersforpeace@gmail.com
Cc: kyungmin.park@samsung.com, pekon@ti.com, ezequiel.garcia@free-electrons.com, javier@dowhile0.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

In order to change the GPMC settings/timings on the fly,
we must use omap_gpmc_retime(). The other gpmc_*() functions
will soon be made private and moved out of arch/mach-omap2/

CC: Felipe Balbi <balbi@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/usb-tusb6010.c | 94 ++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index e832bc7..71e6246 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -48,58 +48,48 @@ static struct gpmc_settings tusb_sync = {
 
 /* NOTE:  timings are from tusb 6010 datasheet Rev 1.8, 12-Sept 2006 */
 
-static int tusb_set_async_mode(unsigned sysclk_ps)
+static void tusb_get_async_timings(unsigned sysclk_ps,
+				   struct gpmc_device_timings *dev_t)
 {
-	struct gpmc_device_timings dev_t;
-	struct gpmc_timings	t;
-	unsigned		t_acsnh_advnh = sysclk_ps + 3000;
-
-	memset(&dev_t, 0, sizeof(dev_t));
-
-	dev_t.t_ceasu = 8 * 1000;
-	dev_t.t_avdasu = t_acsnh_advnh - 7000;
-	dev_t.t_ce_avd = 1000;
-	dev_t.t_avdp_r = t_acsnh_advnh;
-	dev_t.t_oeasu = t_acsnh_advnh + 1000;
-	dev_t.t_oe = 300;
-	dev_t.t_cez_r = 7000;
-	dev_t.t_cez_w = dev_t.t_cez_r;
-	dev_t.t_avdp_w = t_acsnh_advnh;
-	dev_t.t_weasu = t_acsnh_advnh + 1000;
-	dev_t.t_wpl = 300;
-	dev_t.cyc_aavdh_we = 1;
-
-	gpmc_calc_timings(&t, &tusb_async, &dev_t);
-
-	return gpmc_cs_set_timings(async_cs, &t);
+	unsigned t_acsnh_advnh = sysclk_ps + 3000;
+
+	memset(dev_t, 0, sizeof(*dev_t));
+
+	dev_t->t_ceasu = 8 * 1000;
+	dev_t->t_avdasu = t_acsnh_advnh - 7000;
+	dev_t->t_ce_avd = 1000;
+	dev_t->t_avdp_r = t_acsnh_advnh;
+	dev_t->t_oeasu = t_acsnh_advnh + 1000;
+	dev_t->t_oe = 300;
+	dev_t->t_cez_r = 7000;
+	dev_t->t_cez_w = dev_t->t_cez_r;
+	dev_t->t_avdp_w = t_acsnh_advnh;
+	dev_t->t_weasu = t_acsnh_advnh + 1000;
+	dev_t->t_wpl = 300;
+	dev_t->cyc_aavdh_we = 1;
 }
 
-static int tusb_set_sync_mode(unsigned sysclk_ps)
+static void tusb_get_sync_timings(unsigned sysclk_ps,
+				  struct gpmc_device_timings *dev_t)
 {
-	struct gpmc_device_timings dev_t;
-	struct gpmc_timings	t;
-	unsigned		t_scsnh_advnh = sysclk_ps + 3000;
-
-	memset(&dev_t, 0, sizeof(dev_t));
-
-	dev_t.clk = 11100;
-	dev_t.t_bacc = 1000;
-	dev_t.t_ces = 1000;
-	dev_t.t_ceasu = 8 * 1000;
-	dev_t.t_avdasu = t_scsnh_advnh - 7000;
-	dev_t.t_ce_avd = 1000;
-	dev_t.t_avdp_r = t_scsnh_advnh;
-	dev_t.cyc_aavdh_oe = 3;
-	dev_t.cyc_oe = 5;
-	dev_t.t_ce_rdyz = 7000;
-	dev_t.t_avdp_w = t_scsnh_advnh;
-	dev_t.cyc_aavdh_we = 3;
-	dev_t.cyc_wpl = 6;
-	dev_t.t_ce_rdyz = 7000;
-
-	gpmc_calc_timings(&t, &tusb_sync, &dev_t);
-
-	return gpmc_cs_set_timings(sync_cs, &t);
+	unsigned t_scsnh_advnh = sysclk_ps + 3000;
+
+	memset(dev_t, 0, sizeof(dev_t));
+
+	dev_t->clk = 11100;
+	dev_t->t_bacc = 1000;
+	dev_t->t_ces = 1000;
+	dev_t->t_ceasu = 8 * 1000;
+	dev_t->t_avdasu = t_scsnh_advnh - 7000;
+	dev_t->t_ce_avd = 1000;
+	dev_t->t_avdp_r = t_scsnh_advnh;
+	dev_t->cyc_aavdh_oe = 3;
+	dev_t->cyc_oe = 5;
+	dev_t->t_ce_rdyz = 7000;
+	dev_t->t_avdp_w = t_scsnh_advnh;
+	dev_t->cyc_aavdh_we = 3;
+	dev_t->cyc_wpl = 6;
+	dev_t->t_ce_rdyz = 7000;
 }
 
 /* tusb driver calls this when it changes the chip's clocking */
@@ -110,18 +100,22 @@ int tusb6010_platform_retime(unsigned is_refclk)
 
 	unsigned	sysclk_ps;
 	int		status;
+	struct gpmc_device_timings dev_t;
 
 	if (!refclk_psec)
 		return -ENODEV;
 
 	sysclk_ps = is_refclk ? refclk_psec : TUSB6010_OSCCLK_60;
 
-	status = tusb_set_async_mode(sysclk_ps);
+	tusb_get_async_timings(sysclk_ps, &dev_t);
+	status = omap_gpmc_retime(async_cs, &tusb_async, &dev_t);
 	if (status < 0) {
 		printk(error, "async", status);
 		goto done;
 	}
-	status = tusb_set_sync_mode(sysclk_ps);
+
+	tusb_get_sync_timings(sysclk_ps, &dev_t);
+	status = omap_gpmc_retime(sync_cs, &tusb_sync, &dev_t);
 	if (status < 0)
 		printk(error, "sync", status);
 done:
-- 
1.8.3.2
