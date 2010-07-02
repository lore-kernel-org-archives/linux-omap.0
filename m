From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/20] OMAP: hwmod: allow omap_hwmod_late_init() caller to
	skip module idle in _setup()
Date: Fri, 02 Jul 2010 09:29:25 -0600
Message-ID: <20100702152923.6221.8507.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>
List-Id: linux-omap@vger.kernel.org

On kernels that don't use the omap_device_enable() calls to enable
devices, leave all on-chip devices enabled in hwmod _setup().
Otherwise, accesses to those devices are likely to fail, crashing the
system.  It's expected that kernels built without CONFIG_PM_RUNTIME
will be the primary use-case for this.  This functionality is
controlled by adding an extra parameter to omap_hwmod_late_init().

This patch is based on the patch "OMAP: hwmod: don't auto-disable
hwmod when !CONFIG_PM_RUNTIME" by Kevin Hilman
<khilman@deeprootsystems.com>.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/io.c                     |    9 ++++++
 arch/arm/mach-omap2/omap_hwmod.c             |   37 ++++++++++++++++++--------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    5 ++--
 3 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4e1f53d..05c9cdb 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -313,6 +313,8 @@ static int __init _omap2_init_reprogram_sdrc(void)
 void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 				 struct omap_sdrc_params *sdrc_cs1)
 {
+	u8 skip_setup_idle = 0;
+
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_autodeps);
 	if (cpu_is_omap242x())
@@ -337,8 +339,13 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 		pr_err("Could not init clock framework - unknown CPU\n");
 
 	omap_serial_early_init();
+
+#ifndef CONFIG_PM_RUNTIME
+	skip_setup_idle = 1;
+#endif
 	if (cpu_is_omap24xx() || cpu_is_omap34xx())   /* FIXME: OMAP4 */
-		omap_hwmod_late_init();
+		omap_hwmod_late_init(skip_setup_idle);
+
 	omap_pm_if_init();
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 47943ec..d9e96fa 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -761,6 +761,7 @@ static struct omap_hwmod *_lookup(const char *name)
 /**
  * _init_clocks - clk_get() all clocks associated with this hwmod
  * @oh: struct omap_hwmod *
+ * @data: not used; pass NULL
  *
  * Called by omap_hwmod_late_init() (after omap2_clk_init()).
  * Resolves all clock names embedded in the hwmod.  Must be called
@@ -768,7 +769,7 @@ static struct omap_hwmod *_lookup(const char *name)
  * has not yet been registered or if the clocks have already been
  * initialized, 0 on success, or a non-zero error on failure.
  */
-static int _init_clocks(struct omap_hwmod *oh)
+static int _init_clocks(struct omap_hwmod *oh, void *data)
 {
 	int ret = 0;
 
@@ -993,19 +994,25 @@ static int _shutdown(struct omap_hwmod *oh)
 /**
  * _setup - do initial configuration of omap_hwmod
  * @oh: struct omap_hwmod *
+ * @skip_setup_idle_p: do not idle hwmods at the end of the fn if 1
  *
  * Writes the CLOCKACTIVITY bits @clockact to the hwmod @oh
- * OCP_SYSCONFIG register.  Must be called with omap_hwmod_mutex
- * held.  Returns -EINVAL if the hwmod is in the wrong state or returns
- * 0.
+ * OCP_SYSCONFIG register.  Must be called with omap_hwmod_mutex held.
+ * @skip_setup_idle is intended to be used on a system that will not
+ * call omap_hwmod_enable() to enable devices (e.g., a system without
+ * PM runtime).  Returns -EINVAL if the hwmod is in the wrong state or
+ * returns 0.
  */
-static int _setup(struct omap_hwmod *oh)
+static int _setup(struct omap_hwmod *oh, void *data)
 {
 	int i, r;
+	u8 skip_setup_idle;
 
-	if (!oh)
+	if (!oh || !data)
 		return -EINVAL;
 
+	skip_setup_idle = *(u8 *)data;
+
 	/* Set iclk autoidle mode */
 	if (oh->slaves_cnt > 0) {
 		for (i = 0; i < oh->slaves_cnt; i++) {
@@ -1047,7 +1054,7 @@ static int _setup(struct omap_hwmod *oh)
 		}
 	}
 
-	if (!(oh->flags & HWMOD_INIT_NO_IDLE))
+	if (!(oh->flags & HWMOD_INIT_NO_IDLE) && !skip_setup_idle)
 		_omap_hwmod_idle(oh);
 
 	return 0;
@@ -1161,6 +1168,7 @@ struct omap_hwmod *omap_hwmod_lookup(const char *name)
 /**
  * omap_hwmod_for_each - call function for each registered omap_hwmod
  * @fn: pointer to a callback function
+ * @data: void * data to pass to callback function
  *
  * Call @fn for each registered omap_hwmod, passing @data to each
  * function.  @fn must return 0 for success or any other value for
@@ -1169,7 +1177,8 @@ struct omap_hwmod *omap_hwmod_lookup(const char *name)
  * caller of omap_hwmod_for_each().  @fn is called with
  * omap_hwmod_for_each() held.
  */
-int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh))
+int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
+			void *data)
 {
 	struct omap_hwmod *temp_oh;
 	int ret;
@@ -1179,7 +1188,7 @@ int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh))
 
 	mutex_lock(&omap_hwmod_mutex);
 	list_for_each_entry(temp_oh, &omap_hwmod_list, node) {
-		ret = (*fn)(temp_oh);
+		ret = (*fn)(temp_oh, data);
 		if (ret)
 			break;
 	}
@@ -1226,24 +1235,28 @@ int omap_hwmod_init(struct omap_hwmod **ohs)
 
 /**
  * omap_hwmod_late_init - do some post-clock framework initialization
+ * @skip_setup_idle: if 1, do not idle hwmods in _setup()
  *
  * Must be called after omap2_clk_init().  Resolves the struct clk names
  * to struct clk pointers for each registered omap_hwmod.  Also calls
  * _setup() on each hwmod.  Returns 0.
  */
-int omap_hwmod_late_init(void)
+int omap_hwmod_late_init(u8 skip_setup_idle)
 {
 	int r;
 
 	/* XXX check return value */
-	r = omap_hwmod_for_each(_init_clocks);
+	r = omap_hwmod_for_each(_init_clocks, NULL);
 	WARN(r, "omap_hwmod: omap_hwmod_late_init(): _init_clocks failed\n");
 
 	mpu_oh = omap_hwmod_lookup(MPU_INITIATOR_NAME);
 	WARN(!mpu_oh, "omap_hwmod: could not find MPU initiator hwmod %s\n",
 	     MPU_INITIATOR_NAME);
 
-	omap_hwmod_for_each(_setup);
+	if (skip_setup_idle)
+		pr_debug("omap_hwmod: will leave hwmods enabled during setup\n");
+
+	omap_hwmod_for_each(_setup, &skip_setup_idle);
 
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 253f6e5..aebfacb 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -482,8 +482,9 @@ int omap_hwmod_init(struct omap_hwmod **ohs);
 int omap_hwmod_register(struct omap_hwmod *oh);
 int omap_hwmod_unregister(struct omap_hwmod *oh);
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
-int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh));
-int omap_hwmod_late_init(void);
+int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
+			void *data);
+int omap_hwmod_late_init(u8 skip_setup_idle);
 
 int omap_hwmod_enable(struct omap_hwmod *oh);
 int _omap_hwmod_enable(struct omap_hwmod *oh);
