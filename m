From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] ARM: OMAP2+: Remove mostly unused hwmod linkspace
Date: Tue, 14 Mar 2017 14:06:36 -0700
Message-ID: <20170314210639.2065-2-tony@atomide.com>
References: <20170314210639.2065-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170314210639.2065-1-tony@atomide.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We want to be able to dynamically allocate struct omap_hwmod_ocp_if and
struct omap_hwmod at device driver probe time based on .dts data.

Current setup with the linkspace using memblock_virt_alloc() makes
this tricky, so let's get rid of struct linkspace and directly set up
struct omap_hwmod_ocp_if as the master and slave lists.

As we are currently not using the master_ports either, let's remove it
too. And let's add the struct omap_hwmod_ocp_if node directly to the
slave_ports list.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 116 +--------------------------------------
 arch/arm/mach-omap2/omap_hwmod.h |  13 +----
 2 files changed, 4 insertions(+), 125 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -138,7 +138,6 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
-#include <linux/bootmem.h>
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -216,20 +215,6 @@ static LIST_HEAD(omap_hwmod_list);
 /* mpu_oh: used to add/remove MPU initiator from sleepdep list */
 static struct omap_hwmod *mpu_oh;
 
-/*
- * linkspace: ptr to a buffer that struct omap_hwmod_link records are
- * allocated from - used to reduce the number of small memory
- * allocations, which has a significant impact on performance
- */
-static struct omap_hwmod_link *linkspace;
-
-/*
- * free_ls, max_ls: array indexes into linkspace; representing the
- * next free struct omap_hwmod_link index, and the maximum number of
- * struct omap_hwmod_link records allocated (respectively)
- */
-static unsigned short free_ls, max_ls, ls_supp;
-
 /* inited: set to true once the hwmod code is initialized */
 static bool inited;
 
@@ -250,7 +235,7 @@ static struct omap_hwmod_ocp_if *_fetch_next_ocp_if(struct list_head **p,
 {
 	struct omap_hwmod_ocp_if *oi;
 
-	oi = list_entry(*p, struct omap_hwmod_link, node)->ocp_if;
+	oi = list_entry(*p, struct omap_hwmod_ocp_if, node);
 	*p = (*p)->next;
 
 	*i = *i + 1;
@@ -2657,7 +2642,6 @@ static int __init _register(struct omap_hwmod *oh)
 
 	list_add_tail(&oh->node, &omap_hwmod_list);
 
-	INIT_LIST_HEAD(&oh->master_ports);
 	INIT_LIST_HEAD(&oh->slave_ports);
 	spin_lock_init(&oh->_lock);
 	lockdep_set_class(&oh->_lock, &oh->hwmod_key);
@@ -2675,49 +2659,10 @@ static int __init _register(struct omap_hwmod *oh)
 }
 
 /**
- * _alloc_links - return allocated memory for hwmod links
- * @ml: pointer to a struct omap_hwmod_link * for the master link
- * @sl: pointer to a struct omap_hwmod_link * for the slave link
- *
- * Return pointers to two struct omap_hwmod_link records, via the
- * addresses pointed to by @ml and @sl.  Will first attempt to return
- * memory allocated as part of a large initial block, but if that has
- * been exhausted, will allocate memory itself.  Since ideally this
- * second allocation path will never occur, the number of these
- * 'supplemental' allocations will be logged when debugging is
- * enabled.  Returns 0.
- */
-static int __init _alloc_links(struct omap_hwmod_link **ml,
-			       struct omap_hwmod_link **sl)
-{
-	unsigned int sz;
-
-	if ((free_ls + LINKS_PER_OCP_IF) <= max_ls) {
-		*ml = &linkspace[free_ls++];
-		*sl = &linkspace[free_ls++];
-		return 0;
-	}
-
-	sz = sizeof(struct omap_hwmod_link) * LINKS_PER_OCP_IF;
-
-	*sl = NULL;
-	*ml = memblock_virt_alloc(sz, 0);
-
-	*sl = (void *)(*ml) + sizeof(struct omap_hwmod_link);
-
-	ls_supp++;
-	pr_debug("omap_hwmod: supplemental link allocations needed: %d\n",
-		 ls_supp * LINKS_PER_OCP_IF);
-
-	return 0;
-};
-
-/**
  * _add_link - add an interconnect between two IP blocks
  * @oi: pointer to a struct omap_hwmod_ocp_if record
  *
- * Add struct omap_hwmod_link records connecting the master IP block
- * specified in @oi->master to @oi, and connecting the slave IP block
+ * Add struct omap_hwmod_link records connecting the slave IP block
  * specified in @oi->slave to @oi.  This code is assumed to run before
  * preemption or SMP has been enabled, thus avoiding the need for
  * locking in this code.  Changes to this assumption will require
@@ -2725,19 +2670,10 @@ static int __init _alloc_links(struct omap_hwmod_link **ml,
  */
 static int __init _add_link(struct omap_hwmod_ocp_if *oi)
 {
-	struct omap_hwmod_link *ml, *sl;
-
 	pr_debug("omap_hwmod: %s -> %s: adding link\n", oi->master->name,
 		 oi->slave->name);
 
-	_alloc_links(&ml, &sl);
-
-	ml->ocp_if = oi;
-	list_add(&ml->node, &oi->master->master_ports);
-	oi->master->masters_cnt++;
-
-	sl->ocp_if = oi;
-	list_add(&sl->node, &oi->slave->slave_ports);
+	list_add(&oi->node, &oi->slave->slave_ports);
 	oi->slave->slaves_cnt++;
 
 	return 0;
@@ -2784,45 +2720,6 @@ static int __init _register_link(struct omap_hwmod_ocp_if *oi)
 	return 0;
 }
 
-/**
- * _alloc_linkspace - allocate large block of hwmod links
- * @ois: pointer to an array of struct omap_hwmod_ocp_if records to count
- *
- * Allocate a large block of struct omap_hwmod_link records.  This
- * improves boot time significantly by avoiding the need to allocate
- * individual records one by one.  If the number of records to
- * allocate in the block hasn't been manually specified, this function
- * will count the number of struct omap_hwmod_ocp_if records in @ois
- * and use that to determine the allocation size.  For SoC families
- * that require multiple list registrations, such as OMAP3xxx, this
- * estimation process isn't optimal, so manual estimation is advised
- * in those cases.  Returns -EEXIST if the allocation has already occurred
- * or 0 upon success.
- */
-static int __init _alloc_linkspace(struct omap_hwmod_ocp_if **ois)
-{
-	unsigned int i = 0;
-	unsigned int sz;
-
-	if (linkspace) {
-		WARN(1, "linkspace already allocated\n");
-		return -EEXIST;
-	}
-
-	if (max_ls == 0)
-		while (ois[i++])
-			max_ls += LINKS_PER_OCP_IF;
-
-	sz = sizeof(struct omap_hwmod_link) * max_ls;
-
-	pr_debug("omap_hwmod: %s: allocating %d byte linkspace (%d links)\n",
-		 __func__, sz, max_ls);
-
-	linkspace = memblock_virt_alloc(sz, 0);
-
-	return 0;
-}
-
 /* Static functions intended only for use in soc_ops field function pointers */
 
 /**
@@ -3180,13 +3077,6 @@ int __init omap_hwmod_register_links(struct omap_hwmod_ocp_if **ois)
 	if (ois[0] == NULL) /* Empty list */
 		return 0;
 
-	if (!linkspace) {
-		if (_alloc_linkspace(ois)) {
-			pr_err("omap_hwmod: could not allocate link space\n");
-			return -ENOMEM;
-		}
-	}
-
 	i = 0;
 	do {
 		r = _register_link(ois[i]);
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -313,6 +313,7 @@ struct omap_hwmod_ocp_if {
 	struct omap_hwmod_addr_space	*addr;
 	const char			*clk;
 	struct clk			*_clk;
+	struct list_head		node;
 	union {
 		struct omap_hwmod_omap2_firewall omap2;
 	}				fw;
@@ -617,16 +618,6 @@ struct omap_hwmod_class {
 };
 
 /**
- * struct omap_hwmod_link - internal structure linking hwmods with ocp_ifs
- * @ocp_if: OCP interface structure record pointer
- * @node: list_head pointing to next struct omap_hwmod_link in a list
- */
-struct omap_hwmod_link {
-	struct omap_hwmod_ocp_if	*ocp_if;
-	struct list_head		node;
-};
-
-/**
  * struct omap_hwmod - integration data for OMAP hardware "modules" (IP blocks)
  * @name: name of the hwmod
  * @class: struct omap_hwmod_class * to the class of this hwmod
@@ -688,7 +679,6 @@ struct omap_hwmod {
 	struct omap_hwmod_opt_clk	*opt_clks;
 	char				*clkdm_name;
 	struct clockdomain		*clkdm;
-	struct list_head		master_ports; /* connect to *_IA */
 	struct list_head		slave_ports; /* connect to *_TA */
 	void				*dev_attr;
 	u32				_sysc_cache;
@@ -703,7 +693,6 @@ struct omap_hwmod {
 	u8				response_lat;
 	u8				rst_lines_cnt;
 	u8				opt_clks_cnt;
-	u8				masters_cnt;
 	u8				slaves_cnt;
 	u8				hwmods_cnt;
 	u8				_int_flags;
-- 
2.11.1
