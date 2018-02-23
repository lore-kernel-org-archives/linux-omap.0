From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/12] ARM: OMAP2+: Enable ti-sysc to use device tree data for
 smartreflex
Date: Fri, 23 Feb 2018 13:01:00 -0800
Message-ID: <20180223210100.86732-13-tony@atomide.com>
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

Let's enable ti-sysc probing of child devices. So far we have only used
ti-sysc to probe interconnect target modules to idle them for cases where
the SoC does not have any child devices configured for the module, such
as smartreflex on dra7.

As we have smartreflex driver configured in the device tree for some SoCs,
we need to flip things on with a single patch to prevent both omap_device
and ti-sysc to probe smartreflex. So let's stop probing smartreflex with
omap_device and probe it with ti-sysc by enabling passing the auxdata.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_device.c  |  5 +++++
 arch/arm/mach-omap2/pdata-quirks.c |  1 +
 arch/arm/mach-omap2/sr_device.c    | 25 ++++++++++++++-----------
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -140,6 +140,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 	struct omap_device *od;
 	struct omap_hwmod *oh;
 	struct device_node *node = pdev->dev.of_node;
+	struct resource res;
 	const char *oh_name;
 	int oh_cnt, i, ret = 0;
 	bool device_active = false;
@@ -150,6 +151,10 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/* Use ti-sysc driver instead of omap_device? */
+	if (!omap_hwmod_parse_module_range(NULL, node, &res))
+		return -ENODEV;
+
 	hwmods = kzalloc(sizeof(struct omap_hwmod *) * oh_cnt, GFP_KERNEL);
 	if (!hwmods) {
 		ret = -ENOMEM;
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -487,6 +487,7 @@ static struct of_dev_auxdata omap_auxdata_lookup[];
 
 static struct ti_sysc_platform_data ti_sysc_pdata = {
 	.auxdata = omap_auxdata_lookup,
+	.init_module = omap_hwmod_init_module,
 	.enable_module = ti_sysc_enable_module,
 	.idle_module = ti_sysc_idle_module,
 	.shutdown_module = ti_sysc_shutdown_module,
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -93,16 +93,23 @@ extern struct omap_sr_data omap_sr_pdata[];
 
 static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
 {
-	struct omap_sr_data *sr_data;
-	struct platform_device *pdev;
+	struct omap_sr_data *sr_data = NULL;
 	struct omap_volt_data *volt_data;
 	struct omap_smartreflex_dev_attr *sr_dev_attr;
-	char *name = "smartreflex";
 	static int i;
 
-	sr_data = kzalloc(sizeof(*sr_data), GFP_KERNEL);
-	if (!sr_data)
-		return -ENOMEM;
+	if (!strncmp(oh->name, "smartreflex_mpu_iva", 20) ||
+	    !strncmp(oh->name, "smartreflex_mpu", 16))
+		sr_data = &omap_sr_pdata[OMAP_SR_MPU];
+	else if (!strncmp(oh->name, "smartreflex_core", 17))
+		sr_data = &omap_sr_pdata[OMAP_SR_CORE];
+	else if (!strncmp(oh->name, "smartreflex_iva", 16))
+		sr_data = &omap_sr_pdata[OMAP_SR_IVA];
+
+	if (!sr_data) {
+		pr_err("%s: Unknown instance %s\n", __func__, oh->name);
+		return -EINVAL;
+	}
 
 	sr_dev_attr = (struct omap_smartreflex_dev_attr *)oh->dev_attr;
 	if (!sr_dev_attr || !sr_dev_attr->sensor_voltdm_name) {
@@ -147,13 +154,9 @@ static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
 
 	sr_data->enable_on_init = sr_enable_on_init;
 
-	pdev = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data));
-	if (IS_ERR(pdev))
-		pr_warn("%s: Could not build omap_device for %s: %s\n",
-			__func__, name, oh->name);
 exit:
 	i++;
-	kfree(sr_data);
+
 	return 0;
 }
 
-- 
2.16.2
