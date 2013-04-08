From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 7/8] staging: ti-soc-thermal: defer probe if cpufreq is not
 ready
Date: Mon, 8 Apr 2013 08:19:13 -0400
Message-ID: <1365423555-2669-8-git-send-email-eduardo.valentin@ti.com>
References: <1365423555-2669-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1365423555-2669-1-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, Eduardo Valentin <eduardo.valentin@ti.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When builtin compiled, there is a chance for this driver
be probed before cpufreq driver is up and running. In this
case, the cpucooling device can be wrong initialized.

Thus, this patch makes sure this driver is probed only
when cpufreq driver is ready. Whenever there is no
cpufreq driver registered, the probe will return -EPROBE_DEFER.

Tested-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/ti-soc-thermal/ti-bandgap.c        |   27 ++++++++++++++++---
 drivers/staging/ti-soc-thermal/ti-thermal-common.c |    5 +++
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/ti-bandgap.c b/drivers/staging/ti-soc-thermal/ti-bandgap.c
index 5b06b12..37fdba6 100644
--- a/drivers/staging/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/staging/ti-soc-thermal/ti-bandgap.c
@@ -1305,12 +1305,18 @@ int ti_bandgap_probe(struct platform_device *pdev)
 	for (i = 0; i < bgp->conf->sensor_count; i++) {
 		char *domain;
 
-		if (bgp->conf->sensors[i].register_cooling)
-			bgp->conf->sensors[i].register_cooling(bgp, i);
+		if (bgp->conf->sensors[i].register_cooling) {
+			ret = bgp->conf->sensors[i].register_cooling(bgp, i);
+			if (ret)
+				goto remove_sensors;
+		}
 
-		domain = bgp->conf->sensors[i].domain;
-		if (bgp->conf->expose_sensor)
-			bgp->conf->expose_sensor(bgp, i, domain);
+		if (bgp->conf->expose_sensor) {
+			domain = bgp->conf->sensors[i].domain;
+			ret = bgp->conf->expose_sensor(bgp, i, domain);
+			if (ret)
+				goto remove_last_cooling;
+		}
 	}
 
 	/*
@@ -1329,6 +1335,17 @@ int ti_bandgap_probe(struct platform_device *pdev)
 
 	return 0;
 
+remove_last_cooling:
+	if (bgp->conf->sensors[i].unregister_cooling)
+		bgp->conf->sensors[i].unregister_cooling(bgp, i);
+remove_sensors:
+	for (i--; i >= 0; i--) {
+		if (bgp->conf->sensors[i].unregister_cooling)
+			bgp->conf->sensors[i].unregister_cooling(bgp, i);
+		if (bgp->conf->remove_sensor)
+			bgp->conf->remove_sensor(bgp, i);
+	}
+	ti_bandgap_power(bgp, false);
 disable_clk:
 	if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
 		clk_disable_unprepare(bgp->fclock);
diff --git a/drivers/staging/ti-soc-thermal/ti-thermal-common.c b/drivers/staging/ti-soc-thermal/ti-thermal-common.c
index 58e19bc..e3c5e67 100644
--- a/drivers/staging/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/staging/ti-soc-thermal/ti-thermal-common.c
@@ -339,6 +339,11 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
 	if (!data)
 		return -EINVAL;
 
+	if (!cpufreq_get_current_driver()) {
+		dev_dbg(bgp->dev, "no cpufreq driver yet\n");
+		return -EPROBE_DEFER;
+	}
+
 	/* Register cooling device */
 	data->cool_dev = cpufreq_cooling_register(cpu_present_mask);
 	if (IS_ERR_OR_NULL(data->cool_dev)) {
-- 
1.7.7.1.488.ge8e1c
