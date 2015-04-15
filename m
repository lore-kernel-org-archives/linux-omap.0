From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 08/35] ARM: OMAP2+: hwmod: move APIs out of __init section
Date: Wed, 15 Apr 2015 15:52:55 +0300
Message-ID: <1429102402-5276-9-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42504 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755354AbbDOMwr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:52:47 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

With hwmod init being split into an early and a late module init parts,
certain hwmod APIs can't reside under __init section anymore. Thus,
remove the __init declaration from the required APIs to make them
accessible at the module probe phase also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   37 +++++++++++++++++++------------------
 arch/arm/mach-omap2/omap_hwmod.h |    2 +-
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 4fc42c9..6e7b541 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1232,7 +1232,7 @@ static int _get_addr_space_by_name(struct omap_hwmod *oh, const char *name,
  * Intended to be called during hwmod registration only. No return
  * value.
  */
-static void __init _save_mpu_port_index(struct omap_hwmod *oh)
+static void _save_mpu_port_index(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os = NULL;
 	struct list_head *p;
@@ -1285,7 +1285,8 @@ static struct omap_hwmod_ocp_if *_find_mpu_rt_port(struct omap_hwmod *oh)
  * Returns a pointer to the struct omap_hwmod_addr_space record representing
  * the register target MPU address space; or returns NULL upon error.
  */
-static struct omap_hwmod_addr_space * __init _find_mpu_rt_addr_space(struct omap_hwmod *oh)
+static struct omap_hwmod_addr_space
+*_find_mpu_rt_addr_space(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
 	struct omap_hwmod_addr_space *mem;
@@ -2371,8 +2372,8 @@ static int of_dev_hwmod_lookup(struct device_node *np,
  * Returns 0 on success, -EINVAL if an invalid hwmod is passed, and
  * -ENXIO on absent or invalid register target address space.
  */
-static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
-				    int index, struct device_node *np)
+static int _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
+			     int index, struct device_node *np)
 {
 	struct omap_hwmod_addr_space *mem;
 	void __iomem *va_start = NULL;
@@ -2428,7 +2429,7 @@ static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
  * upon success or if the hwmod isn't registered or if the hwmod's
  * address space is not defined, or -EINVAL upon failure.
  */
-static int __init _init(struct omap_hwmod *oh, void *data)
+static int _init(struct omap_hwmod *oh, void *data)
 {
 	int r, index;
 	struct device_node *np = NULL;
@@ -2486,7 +2487,7 @@ static int __init _init(struct omap_hwmod *oh, void *data)
  * a stub; implementing this properly requires iclk autoidle usecounting in
  * the clock code.   No return value.
  */
-static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
+static void _setup_iclk_autoidle(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
 	struct list_head *p;
@@ -2521,7 +2522,7 @@ static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
  * reset.  Returns 0 upon success or a negative error code upon
  * failure.
  */
-static int __init _setup_reset(struct omap_hwmod *oh)
+static int _setup_reset(struct omap_hwmod *oh)
 {
 	int r;
 
@@ -2582,7 +2583,7 @@ static int __init _setup_reset(struct omap_hwmod *oh)
  *
  * No return value.
  */
-static void __init _setup_postsetup(struct omap_hwmod *oh)
+static void _setup_postsetup(struct omap_hwmod *oh)
 {
 	u8 postsetup_state;
 
@@ -2630,7 +2631,7 @@ static void __init _setup_postsetup(struct omap_hwmod *oh)
  * affects the IP block hardware, or system integration hardware
  * associated with the IP block.  Returns 0.
  */
-static int __init _setup(struct omap_hwmod *oh, void *data)
+static int _setup(struct omap_hwmod *oh, void *data)
 {
 	if (oh->_state != _HWMOD_STATE_INITIALIZED)
 		return 0;
@@ -2682,7 +2683,7 @@ static int __init _setup(struct omap_hwmod *oh, void *data)
  * that the copy process would be relatively complex due to the large number
  * of substructures.
  */
-static int __init _register(struct omap_hwmod *oh)
+static int _register(struct omap_hwmod *oh)
 {
 	if (!oh || !oh->name || !oh->class || !oh->class->name ||
 	    (oh->_state != _HWMOD_STATE_UNKNOWN))
@@ -2725,8 +2726,8 @@ static int __init _register(struct omap_hwmod *oh)
  * 'supplemental' allocations will be logged when debugging is
  * enabled.  Returns 0.
  */
-static int __init _alloc_links(struct omap_hwmod_link **ml,
-			       struct omap_hwmod_link **sl)
+static int _alloc_links(struct omap_hwmod_link **ml,
+			struct omap_hwmod_link **sl)
 {
 	unsigned int sz;
 
@@ -2762,7 +2763,7 @@ static int __init _alloc_links(struct omap_hwmod_link **ml,
  * locking in this code.  Changes to this assumption will require
  * additional locking.  Returns 0.
  */
-static int __init _add_link(struct omap_hwmod_ocp_if *oi)
+static int _add_link(struct omap_hwmod_ocp_if *oi)
 {
 	struct omap_hwmod_link *ml, *sl;
 
@@ -2795,7 +2796,7 @@ static int __init _add_link(struct omap_hwmod_ocp_if *oi)
  * should be marked __initdata and freed after init.  This would allow
  * unneeded omap_hwmods to be freed on multi-OMAP configurations.
  */
-static int __init _register_link(struct omap_hwmod_ocp_if *oi)
+static int _register_link(struct omap_hwmod_ocp_if *oi)
 {
 	struct omap_hwmod *oh;
 
@@ -3244,7 +3245,7 @@ static void __init *memblock_alloc(int size)
  * -ENOMEM if the link memory area can't be allocated, or 0 upon
  * success.
  */
-int __init omap_hwmod_register_links(struct omap_hwmod_ocp_if **ois)
+int omap_hwmod_register_links(struct omap_hwmod_ocp_if **ois)
 {
 	int r, i;
 
@@ -3285,7 +3286,7 @@ int __init omap_hwmod_register_links(struct omap_hwmod_ocp_if **ois)
  * to the MPU.  Intended to be called only by omap_hwmod_setup*().  No
  * return value.
  */
-static void __init _ensure_mpu_hwmod_is_setup(struct omap_hwmod *oh)
+static void _ensure_mpu_hwmod_is_setup(struct omap_hwmod *oh)
 {
 	if (!mpu_oh || mpu_oh->_state == _HWMOD_STATE_UNKNOWN)
 		pr_err("omap_hwmod: %s: MPU initiator hwmod %s not yet registered\n",
@@ -3305,7 +3306,7 @@ static void __init _ensure_mpu_hwmod_is_setup(struct omap_hwmod *oh)
  * registered omap_hwmod.  Also calls _setup() on each hwmod.  Returns
  * -EINVAL upon error or 0 upon success.
  */
-int __init omap_hwmod_setup_one(const char *oh_name)
+int omap_hwmod_setup_one(const char *oh_name)
 {
 	struct omap_hwmod *oh;
 
@@ -3333,7 +3334,7 @@ int __init omap_hwmod_setup_one(const char *oh_name)
  * names to struct clk pointers for each registered omap_hwmod.  Also
  * calls _setup() on each hwmod.  Returns 0 upon success.
  */
-static int __init omap_hwmod_setup_all(void)
+int omap_hwmod_setup_all(void)
 {
 	_ensure_mpu_hwmod_is_setup(NULL);
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 9611c91..fe75d38 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -696,7 +696,7 @@ struct omap_hwmod *omap_hwmod_lookup(const char *name);
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data);
 
-int __init omap_hwmod_setup_one(const char *name);
+int omap_hwmod_setup_one(const char *name);
 
 int omap_hwmod_enable(struct omap_hwmod *oh);
 int omap_hwmod_idle(struct omap_hwmod *oh);
-- 
1.7.9.5

