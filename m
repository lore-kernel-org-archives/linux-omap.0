From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 7/8] cpufreq: ti-cpufreq: Add support for AM3517
Date: Wed, 11 Sep 2019 19:47:13 +0200
Message-ID: <beda9274922c0fdc293a974a707426fac7c77921.1568224033.git.hns@goldelico.com>
References: <cover.1568224032.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1568224032.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?UTF-8?q?Andr=C3=A9=20Roth?= <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Roger Quadros <rogerq@ti.com>, Teresa Remmet <t.remmet@phytec.de>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

The AM3517 only lists 600MHz @ 1.2V, but the register values for
0x4830A204 = 1b86 802f, it seems like am3517 might be a derivative
of the omap36 which OPPs would be OPP50 (300 MHz) and OPP100
(600 MHz).

This patch simply adds the am3517 to the compatible table
similar to a mix of the omap3430 and omap3430 structure.

Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Adam Ford <aford173@gmail.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/cpufreq/ti-cpufreq.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index f4704f9033e0..cd2f6b87ea3e 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -177,6 +177,21 @@ static struct ti_cpufreq_soc_data omap36xx_soc_data = {
 	.multi_regulator = true,
 };
 
+/*
+ * AM3517 is quite similar to AM/DM37x except that it has no
+ * high speed grade eFuse and no abb ldo
+ */
+
+static struct ti_cpufreq_soc_data am3517_soc_data = {
+	.efuse_xlate = omap3_efuse_xlate,
+	.efuse_offset = OMAP3_CONTROL_DEVICE_STATUS - OMAP3_SYSCON_BASE,
+	.efuse_shift = 0,
+	.efuse_mask = 0,
+	.rev_offset = OMAP3_CONTROL_IDCODE - OMAP3_SYSCON_BASE,
+	.multi_regulator = false,
+};
+
+
 /**
  * ti_cpufreq_get_efuse() - Parse and return efuse value present on SoC
  * @opp_data: pointer to ti_cpufreq_data context
@@ -274,6 +289,7 @@ static int ti_cpufreq_setup_syscon_register(struct ti_cpufreq_data *opp_data)
 
 static const struct of_device_id ti_cpufreq_of_match[] = {
 	{ .compatible = "ti,am33xx", .data = &am3x_soc_data, },
+	{ .compatible = "ti,am3517", .data = &am3517_soc_data, },
 	{ .compatible = "ti,am43", .data = &am4x_soc_data, },
 	{ .compatible = "ti,dra7", .data = &dra7_soc_data },
 	{ .compatible = "ti,omap34xx", .data = &omap34xx_soc_data, },
-- 
2.19.1
