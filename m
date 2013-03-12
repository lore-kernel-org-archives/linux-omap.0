From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: IS_ERR_VALUE()
Date: Tue, 12 Mar 2013 14:16:04 +0000
Message-ID: <20130312141604.GV4977@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33340 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204Ab3CLOVQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 10:21:16 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

I am removing almost all references to the above macro from arch/arm.
Many of them are wrong.  Some of them are buggy.

For instance:

int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
{
        int div;
        div = gpmc_calc_divider(t->sync_clk);
        if (div < 0)
                return div;
static int gpmc_set_async_mode(int cs, struct gpmc_timings *t)
{
...
        return gpmc_cs_set_timings(cs, t);

.....
        ret = gpmc_set_async_mode(gpmc_onenand_data->cs, &t);
        if (IS_ERR_VALUE(ret))
                return ret;

So, gpmc_cs_set_timings() thinks any negative return value is an error,
but where we check that in higher levels, only a limited range are
errors... seriously?  Come on guys, get with the program.  Get your
error checking in order.

There is only _one_ use of IS_ERR_VALUE() in arch/arm which is correct,
and that is in arch/arm/include/asm/syscall.h:

static inline long syscall_get_error(struct task_struct *task,
                                     struct pt_regs *regs)
{
        unsigned long error = regs->ARM_r0;
        return IS_ERR_VALUE(error) ? error : 0;
}

So, here's a patch to remove them all, except for the above.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
This patch will be going into my "cleanup" branch along with the removal
of many wrong IS_ERR_OR_NULL() uses - with any errors anyone spots fixed.

 arch/arm/mach-exynos/mach-nuri.c        |    2 +-
 arch/arm/mach-imx/devices/devices.c     |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
 arch/arm/mach-omap2/clock.c             |    2 +-
 arch/arm/mach-omap2/gpmc-onenand.c      |    4 ++--
 arch/arm/mach-omap2/gpmc.c              |    8 ++++----
 arch/arm/mach-omap2/omap_device.c       |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c        |    4 ++--
 arch/arm/mach-omap2/timer.c             |    2 +-
 arch/arm/plat-omap/dmtimer.c            |    2 +-
 10 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 1ea7973..688991a 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -1251,7 +1251,7 @@ static void __init nuri_camera_init(void)
 	}
 
 	m5mols_board_info.irq = s5p_register_gpio_interrupt(GPIO_CAM_8M_ISP_INT);
-	if (!IS_ERR_VALUE(m5mols_board_info.irq))
+	if (m5mols_board_info.irq >= 0)
 		s3c_gpio_cfgpin(GPIO_CAM_8M_ISP_INT, S3C_GPIO_SFN(0xF));
 	else
 		pr_err("%s: Failed to configure 8M_ISP_INT GPIO\n", __func__);
diff --git a/arch/arm/mach-imx/devices/devices.c b/arch/arm/mach-imx/devices/devices.c
index 1b37482..1b4366a 100644
--- a/arch/arm/mach-imx/devices/devices.c
+++ b/arch/arm/mach-imx/devices/devices.c
@@ -37,7 +37,7 @@ int __init mxc_device_init(void)
 	int ret;
 
 	ret = device_register(&mxc_aips_bus);
-	if (IS_ERR_VALUE(ret))
+	if (ret < 0)
 		goto done;
 
 	ret = device_register(&mxc_ahb_bus);
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index c3558f9..6c949bc 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -479,7 +479,7 @@ static int __init beagle_opp_init(void)
 
 	/* Initialize the omap3 opp table if not already created. */
 	r = omap3_opp_init();
-	if (IS_ERR_VALUE(r) && (r != -EEXIST)) {
+	if (r < 0 && (r != -EEXIST)) {
 		pr_err("%s: opp default init failed\n", __func__);
 		return r;
 	}
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index e4ec3a6..2191f25 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -596,7 +596,7 @@ int __init omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name)
 		return -ENOENT;
 
 	r = clk_set_rate(mpurate_ck, mpurate);
-	if (IS_ERR_VALUE(r)) {
+	if (r < 0) {
 		WARN(1, "clock: %s: unable to set MPU rate to %d: %d\n",
 		     mpurate_ck_name, mpurate, r);
 		clk_put(mpurate_ck);
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index fadd8743..0d75889 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -303,7 +303,7 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
 	t = omap2_onenand_calc_async_timings();
 
 	ret = gpmc_set_async_mode(gpmc_onenand_data->cs, &t);
-	if (IS_ERR_VALUE(ret))
+	if (ret < 0)
 		return ret;
 
 	omap2_onenand_set_async_mode(onenand_base);
@@ -325,7 +325,7 @@ static int omap2_onenand_setup_sync(void __iomem *onenand_base, int *freq_ptr)
 	t = omap2_onenand_calc_sync_timings(gpmc_onenand_data, freq);
 
 	ret = gpmc_set_sync_mode(gpmc_onenand_data->cs, &t);
-	if (IS_ERR_VALUE(ret))
+	if (ret < 0)
 		return ret;
 
 	set_onenand_cfg(onenand_base);
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index e4b16c8..0011116 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -716,7 +716,7 @@ static int gpmc_setup_irq(void)
 		return -EINVAL;
 
 	gpmc_irq_start = irq_alloc_descs(-1, 0, GPMC_NR_IRQ, 0);
-	if (IS_ERR_VALUE(gpmc_irq_start)) {
+	if (gpmc_irq_start < 0) {
 		pr_err("irq_alloc_descs failed\n");
 		return gpmc_irq_start;
 	}
@@ -801,7 +801,7 @@ static int gpmc_mem_init(void)
 			continue;
 		gpmc_cs_get_memconf(cs, &base, &size);
 		rc = gpmc_cs_insert_mem(cs, base, size);
-		if (IS_ERR_VALUE(rc)) {
+		if (rc < 0) {
 			while (--cs >= 0)
 				if (gpmc_cs_mem_enabled(cs))
 					gpmc_cs_delete_mem(cs);
@@ -1373,14 +1373,14 @@ static int gpmc_probe(struct platform_device *pdev)
 		 GPMC_REVISION_MINOR(l));
 
 	rc = gpmc_mem_init();
-	if (IS_ERR_VALUE(rc)) {
+	if (rc < 0) {
 		clk_disable_unprepare(gpmc_l3_clk);
 		clk_put(gpmc_l3_clk);
 		dev_err(gpmc_dev, "failed to reserve memory\n");
 		return rc;
 	}
 
-	if (IS_ERR_VALUE(gpmc_setup_irq()))
+	if (gpmc_setup_irq() < 0)
 		dev_warn(gpmc_dev, "gpmc_setup_irq failed\n");
 
 	rc = gpmc_probe_dt(pdev);
diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 381be7a..72b09e0 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -131,7 +131,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 	int oh_cnt, i, ret = 0;
 
 	oh_cnt = of_property_count_strings(node, "ti,hwmods");
-	if (!oh_cnt || IS_ERR_VALUE(oh_cnt)) {
+	if (oh_cnt <= 0) {
 		dev_dbg(&pdev->dev, "No 'hwmods' to build omap_device\n");
 		return -ENODEV;
 	}
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index c2c798c..a62213e 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1663,7 +1663,7 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 		return -ENOSYS;
 
 	ret = _lookup_hardreset(oh, name, &ohri);
-	if (IS_ERR_VALUE(ret))
+	if (ret < 0)
 		return ret;
 
 	if (oh->clkdm) {
@@ -2413,7 +2413,7 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 	_init_mpu_rt_base(oh, NULL);
 
 	r = _init_clocks(oh, NULL);
-	if (IS_ERR_VALUE(r)) {
+	if (r < 0) {
 		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh->name);
 		return -EINVAL;
 	}
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 2bdd4cf..5bde35b 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -287,7 +287,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 			r = -EINVAL;
 		} else {
 			r = clk_set_parent(timer->fclk, src);
-			if (IS_ERR_VALUE(r))
+			if (r < 0)
 				pr_warn("%s: %s cannot set source\n",
 					__func__, oh->name);
 			clk_put(src);
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index a0daa2f..17f21c2 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -506,7 +506,7 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	}
 
 	ret = clk_set_parent(timer->fclk, parent);
-	if (IS_ERR_VALUE(ret))
+	if (ret < 0)
 		pr_err("%s: failed to set %s as parent\n", __func__,
 			parent_name);
 

