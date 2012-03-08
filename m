From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/12] ARM: OMAP2+: hwmod: add support for link registration
Date: Wed, 07 Mar 2012 19:38:33 -0700
Message-ID: <20120308023825.8205.87940.stgit@dusk>
References: <20120308023614.8205.78768.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45785 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab2CHCmK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 21:42:10 -0500
In-Reply-To: <20120308023614.8205.78768.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Add support for direct IP block interconnect ("link") registration to
the hwmod code via a new function, omap_hwmod_register_links().  This
will replace direct registration of hwmods, and a subsequent patch
will remove omap_hwmod_register().

This change will allow a subsequent patch to remove the hwmod data
link arrays.  This will reduce the size of the hwmod static data and
also make it easier to generate the data files.  It will also make it
possible to share some of the struct omap_hwmod records across
multiple SoCs, since the link array pointers will be removed from the
struct omap_hwmod.

The downside is that boot time will increase.  Minimizing boot time
was the reason why the link arrays were originally introduced.
Removing them will require extra computation during boot to allocate
memory and associate IP blocks with their interconnects.  However,
since the current kernel development focus is on reducing the number
of lines in arch/arm/mach-omap2/, boot time impact is now seemingly
considered a lower priority.

This patch contains additional complexity to reduce the number of
memory allocations required for this change.  This reduces the boot
time impact: total hwmod link registration time was ~ 2655
microseconds with a simple allocation strategy, but is now ~ 549
microseconds[1] with the approach taken by this patch.

1. Measured on a BeagleBoard 35xx @ 500MHz MPU/333 MHz CORE, average
   of 7 samples.  Total uncertainty is +/- 61 microseconds.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |  297 ++++++++++++++++++=
+++++++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   24 ++
 2 files changed, 305 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 3c733a8..edbeefa 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -137,6 +137,7 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
+#include <linux/bootmem.h>
=20
 #include "common.h"
 #include <plat/cpu.h>
@@ -159,25 +160,54 @@
 /* Name of the OMAP hwmod for the MPU */
 #define MPU_INITIATOR_NAME		"mpu"
=20
+/*
+ * Number of struct omap_hwmod_link records per struct
+ * omap_hwmod_ocp_if record (master->slave and slave->master)
+ */
+#define LINKS_PER_OCP_IF		2
+
 /* omap_hwmod_list contains all registered struct omap_hwmods */
 static LIST_HEAD(omap_hwmod_list);
=20
 /* mpu_oh: used to add/remove MPU initiator from sleepdep list */
 static struct omap_hwmod *mpu_oh;
=20
+/*
+ * link_registration: set to true if hwmod interfaces are being regist=
ered
+ * directly; set to false if hwmods are being registered directly
+ */
+static bool link_registration;
+
+/*
+ * linkspace: ptr to a buffer that struct omap_hwmod_link records are
+ * allocated from - used to reduce the number of small memory
+ * allocations, which has a significant impact on performance
+ */
+static struct omap_hwmod_link *linkspace;
+
+/*
+ * free_ls, max_ls: array indexes into linkspace; representing the
+ * next free struct omap_hwmod_link index, and the maximum number of
+ * struct omap_hwmod_link records allocated (respectively)
+ */
+static unsigned short free_ls, max_ls, ls_supp;
=20
 /* Private functions */
=20
 /**
- * _fetch_next_ocp_if - return @i'th OCP interface in an array
- * @p: ptr to a ptr to the list_head inside the ocp_if to return (not =
yet used)
+ * _fetch_next_ocp_if - return next OCP interface in an array or list
+ * @p: ptr to a ptr to the list_head inside the ocp_if to return
  * @old: ptr to an array of struct omap_hwmod_ocp_if records
  * @i: pointer to the index into the @old array
  *
  * Return a pointer to the next struct omap_hwmod_ocp_if record in a
- * sequence.  Currently returns a struct omap_hwmod_ocp_if record
- * corresponding to the element index pointed to by @i in the @old
- * array, and increments the index pointed to by @i.
+ * sequence.  If hwmods are being registered directly, then return a
+ * struct omap_hwmod_ocp_if record corresponding to the element index
+ * pointed to by @i in the
+ * @old array.  Otherwise, return a pointer to the struct
+ * omap_hwmod_ocp_if record containing the struct list_head record poi=
nted
+ * to by @p, and set the pointer pointed to by @p to point to the next
+ * struct list_head record in the list.
  */
 static struct omap_hwmod_ocp_if *_fetch_next_ocp_if(struct list_head *=
*p,
 						    struct omap_hwmod_ocp_if **old,
@@ -185,7 +215,13 @@ static struct omap_hwmod_ocp_if *_fetch_next_ocp_i=
f(struct list_head **p,
 {
 	struct omap_hwmod_ocp_if *oi;
=20
-	oi =3D old[*i];
+	if (!link_registration) {
+		oi =3D old[*i];
+	} else {
+		oi =3D list_entry(*p, struct omap_hwmod_link, node)->ocp_if;
+		*p =3D (*p)->next;
+	}
+
 	*i =3D *i + 1;
=20
 	return oi;
@@ -606,12 +642,16 @@ static int _init_main_clk(struct omap_hwmod *oh)
 static int _init_interface_clks(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
+	struct list_head *p =3D NULL;
 	struct clk *c;
 	int i =3D 0;
 	int ret =3D 0;
=20
+	if (link_registration)
+		p =3D oh->slave_ports.next;
+
 	while (i < oh->slaves_cnt) {
-		os =3D _fetch_next_ocp_if(NULL, oh->slaves, &i);
+		os =3D _fetch_next_ocp_if(&p, oh->slaves, &i);
 		if (!os->clk)
 			continue;
=20
@@ -664,6 +704,7 @@ static int _init_opt_clks(struct omap_hwmod *oh)
 static int _enable_clocks(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
+	struct list_head *p =3D NULL;
 	int i =3D 0;
=20
 	pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
@@ -671,8 +712,11 @@ static int _enable_clocks(struct omap_hwmod *oh)
 	if (oh->_clk)
 		clk_enable(oh->_clk);
=20
+	if (link_registration)
+		p =3D oh->slave_ports.next;
+
 	while (i < oh->slaves_cnt) {
-		os =3D _fetch_next_ocp_if(NULL, oh->slaves, &i);
+		os =3D _fetch_next_ocp_if(&p, oh->slaves, &i);
=20
 		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
 			clk_enable(os->_clk);
@@ -692,6 +736,7 @@ static int _enable_clocks(struct omap_hwmod *oh)
 static int _disable_clocks(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
+	struct list_head *p =3D NULL;
 	int i =3D 0;
=20
 	pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);
@@ -699,8 +744,11 @@ static int _disable_clocks(struct omap_hwmod *oh)
 	if (oh->_clk)
 		clk_disable(oh->_clk);
=20
+	if (link_registration)
+		p =3D oh->slave_ports.next;
+
 	while (i < oh->slaves_cnt) {
-		os =3D _fetch_next_ocp_if(NULL, oh->slaves, &i);
+		os =3D _fetch_next_ocp_if(&p, oh->slaves, &i);
=20
 		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
 			clk_disable(os->_clk);
@@ -1011,8 +1059,12 @@ static int _get_addr_space_by_name(struct omap_h=
wmod *oh, const char *name,
 {
 	int i, j;
 	struct omap_hwmod_ocp_if *os;
+	struct list_head *p =3D NULL;
 	bool found =3D false;
=20
+	if (link_registration)
+		p =3D oh->slave_ports.next;
+
 	i =3D 0;
 	while (i < oh->slaves_cnt) {
 		os =3D _fetch_next_ocp_if(NULL, oh->slaves, &i);
@@ -1055,6 +1107,7 @@ static int _get_addr_space_by_name(struct omap_hw=
mod *oh, const char *name,
 static void __init _save_mpu_port_index(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os =3D NULL;
+	struct list_head *p =3D NULL;
 	int i =3D 0;
=20
 	if (!oh)
@@ -1062,9 +1115,13 @@ static void __init _save_mpu_port_index(struct o=
map_hwmod *oh)
=20
 	oh->_int_flags |=3D _HWMOD_NO_MPU_PORT;
=20
+	if (link_registration)
+		p =3D oh->slave_ports.next;
+
 	while (i < oh->slaves_cnt) {
-		os =3D _fetch_next_ocp_if(NULL, oh->slaves, &i);
+		os =3D _fetch_next_ocp_if(&p, oh->slaves, &i);
 		if (os->user & OCP_USER_MPU) {
+			oh->_mpu_port =3D os;
 			oh->_mpu_port_index =3D i - 1;
 			oh->_int_flags &=3D ~_HWMOD_NO_MPU_PORT;
 			break;
@@ -1092,7 +1149,10 @@ static struct omap_hwmod_ocp_if *_find_mpu_rt_po=
rt(struct omap_hwmod *oh)
 	if (!oh || oh->_int_flags & _HWMOD_NO_MPU_PORT || oh->slaves_cnt =3D=3D=
 0)
 		return NULL;
=20
-	return oh->slaves[oh->_mpu_port_index];
+	if (!link_registration)
+		return oh->slaves[oh->_mpu_port_index];
+	else
+		return oh->_mpu_port;
 };
=20
 /**
@@ -1938,6 +1998,8 @@ static void __init _init_mpu_rt_base(struct omap_=
hwmod *oh, void *data)
 	if (!oh)
 		return;
=20
+	_save_mpu_port_index(oh);
+
 	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
 		return;
=20
@@ -1971,13 +2033,16 @@ static void __init _init_mpu_rt_base(struct oma=
p_hwmod *oh, void *data)
 static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
+	struct list_head *p =3D NULL;
 	int i =3D 0;
 	if (oh->_state !=3D _HWMOD_STATE_INITIALIZED)
 		return;
=20
+	if (link_registration)
+		p =3D oh->slave_ports.next;
=20
 	while (i < oh->slaves_cnt) {
-		os =3D _fetch_next_ocp_if(NULL, oh->slaves, &i);
+		os =3D _fetch_next_ocp_if(&p, oh->slaves, &i);
 		if (!os->_clk)
 			continue;
=20
@@ -2181,10 +2246,10 @@ static int __init _register(struct omap_hwmod *=
oh)
 	if (_lookup(oh->name))
 		return -EEXIST;
=20
-	_save_mpu_port_index(oh);
-
 	list_add_tail(&oh->node, &omap_hwmod_list);
=20
+	INIT_LIST_HEAD(&oh->master_ports);
+	INIT_LIST_HEAD(&oh->slave_ports);
 	spin_lock_init(&oh->_lock);
=20
 	oh->_state =3D _HWMOD_STATE_REGISTERED;
@@ -2199,6 +2264,160 @@ static int __init _register(struct omap_hwmod *=
oh)
 	return 0;
 }
=20
+/**
+ * _alloc_links - return allocated memory for hwmod links
+ * @ml: pointer to a struct omap_hwmod_link * for the master link
+ * @sl: pointer to a struct omap_hwmod_link * for the slave link
+ *
+ * Return pointers to two struct omap_hwmod_link records, via the
+ * addresses pointed to by @ml and @sl.  Will first attempt to return
+ * memory allocated as part of a large initial block, but if that has
+ * been exhausted, will allocate memory itself.  Since ideally this
+ * second allocation path will never occur, the number of these
+ * 'supplemental' allocations will be logged when debugging is
+ * enabled.  Returns 0.
+ */
+static int __init _alloc_links(struct omap_hwmod_link **ml,
+			       struct omap_hwmod_link **sl)
+{
+	unsigned int sz;
+
+	if ((free_ls + LINKS_PER_OCP_IF) <=3D max_ls) {
+		*ml =3D &linkspace[free_ls++];
+		*sl =3D &linkspace[free_ls++];
+		return 0;
+	}
+
+	sz =3D sizeof(struct omap_hwmod_link) * LINKS_PER_OCP_IF;
+
+	*sl =3D NULL;
+	*ml =3D alloc_bootmem(sz);
+
+	memset(*ml, 0, sz);
+
+	*sl =3D (void *)(*ml) + sizeof(struct omap_hwmod_link);
+
+	ls_supp++;
+	pr_debug("omap_hwmod: supplemental link allocations needed: %d\n",
+		 ls_supp * LINKS_PER_OCP_IF);
+
+	return 0;
+};
+
+/**
+ * _add_link - add an interconnect between two IP blocks
+ * @oi: pointer to a struct omap_hwmod_ocp_if record
+ *
+ * Add struct omap_hwmod_link records connecting the master IP block
+ * specified in @oi->master to @oi, and connecting the slave IP block
+ * specified in @oi->slave to @oi.  This code is assumed to run before
+ * preemption or SMP has been enabled, thus avoiding the need for
+ * locking in this code.  Changes to this assumption will require
+ * additional locking.  Returns 0.
+ */
+static int __init _add_link(struct omap_hwmod_ocp_if *oi)
+{
+	struct omap_hwmod_link *ml, *sl;
+
+	pr_debug("omap_hwmod: %s -> %s: adding link\n", oi->master->name,
+		 oi->slave->name);
+
+	_alloc_links(&ml, &sl);
+
+	ml->ocp_if =3D oi;
+	INIT_LIST_HEAD(&ml->node);
+	list_add(&ml->node, &oi->master->master_ports);
+	oi->master->masters_cnt++;
+
+	sl->ocp_if =3D oi;
+	INIT_LIST_HEAD(&sl->node);
+	list_add(&sl->node, &oi->slave->slave_ports);
+	oi->slave->slaves_cnt++;
+
+	return 0;
+}
+
+/**
+ * _register_link - register a struct omap_hwmod_ocp_if
+ * @oi: struct omap_hwmod_ocp_if *
+ *
+ * Registers the omap_hwmod_ocp_if record @oi.  Returns -EEXIST if it
+ * has already been registered; -EINVAL if @oi is NULL or if the
+ * record pointed to by @oi is missing required fields; or 0 upon
+ * success.
+ *
+ * XXX The data should be copied into bootmem, so the original data
+ * should be marked __initdata and freed after init.  This would allow
+ * unneeded omap_hwmods to be freed on multi-OMAP configurations.
+ */
+static int __init _register_link(struct omap_hwmod_ocp_if *oi)
+{
+	if (!oi || !oi->master || !oi->slave || !oi->user)
+		return -EINVAL;
+
+	if (oi->_int_flags & _OCPIF_INT_FLAGS_REGISTERED)
+		return -EEXIST;
+
+	pr_debug("omap_hwmod: registering link from %s to %s\n",
+		 oi->master->name, oi->slave->name);
+
+	/*
+	 * Register the connected hwmods, if they haven't been
+	 * registered already
+	 */
+	if (oi->master->_state !=3D _HWMOD_STATE_REGISTERED)
+		_register(oi->master);
+
+	if (oi->slave->_state !=3D _HWMOD_STATE_REGISTERED)
+		_register(oi->slave);
+
+	_add_link(oi);
+
+	oi->_int_flags |=3D _OCPIF_INT_FLAGS_REGISTERED;
+
+	return 0;
+}
+
+/**
+ * _alloc_linkspace - allocate large block of hwmod links
+ * @ois: pointer to an array of struct omap_hwmod_ocp_if records to co=
unt
+ *
+ * Allocate a large block of struct omap_hwmod_link records.  This
+ * improves boot time significantly by avoiding the need to allocate
+ * individual records one by one.  If the number of records to
+ * allocate in the block hasn't been manually specified, this function
+ * will count the number of struct omap_hwmod_ocp_if records in @ois
+ * and use that to determine the allocation size.  For SoC families
+ * that require multiple list registrations, such as OMAP3xxx, this
+ * estimation process isn't optimal, so manual estimation is advised
+ * in those cases.  Returns -EEXIST if the allocation has already occu=
rred
+ * or 0 upon success.
+ */
+static int __init _alloc_linkspace(struct omap_hwmod_ocp_if **ois)
+{
+	unsigned int i =3D 0;
+	unsigned int sz;
+
+	if (linkspace) {
+		WARN(1, "linkspace already allocated\n");
+		return -EEXIST;
+	}
+
+	if (max_ls =3D=3D 0)
+		while (ois[i++])
+			max_ls +=3D LINKS_PER_OCP_IF;
+
+	sz =3D sizeof(struct omap_hwmod_link) * max_ls;
+
+	pr_debug("omap_hwmod: %s: allocating %d byte linkspace (%d links)\n",
+		 __func__, sz, max_ls);
+
+	linkspace =3D alloc_bootmem(sz);
+
+	memset(linkspace, 0, sz);
+
+	return 0;
+}
=20
 /* Public functions */
=20
@@ -2338,6 +2557,9 @@ int __init omap_hwmod_register(struct omap_hwmod =
**ohs)
 {
 	int r, i;
=20
+	if (link_registration)
+		return -EINVAL;
+
 	if (!ohs)
 		return 0;
=20
@@ -2352,6 +2574,41 @@ int __init omap_hwmod_register(struct omap_hwmod=
 **ohs)
 }
=20
 /**
+ * omap_hwmod_register_links - register an array of hwmod links
+ * @ois: pointer to an array of omap_hwmod_ocp_if to register
+ *
+ * Intended to be called early in boot before the clock framework is
+ * initialized.  If @ois is not null, will register all omap_hwmods
+ * listed in @ois that are valid for this chip.  Returns 0.
+ */
+int __init omap_hwmod_register_links(struct omap_hwmod_ocp_if **ois)
+{
+	int r, i;
+
+	if (!ois)
+		return 0;
+
+	link_registration =3D true;
+
+	if (!linkspace) {
+		if (_alloc_linkspace(ois)) {
+			pr_err("omap_hwmod: could not allocate link space\n");
+			return -ENOMEM;
+		}
+	}
+
+	i =3D 0;
+	do {
+		r =3D _register_link(ois[i]);
+		WARN(r && r !=3D -EEXIST,
+		     "omap_hwmod: _register_link(%s -> %s) returned %d\n",
+		     ois[i]->master->name, ois[i]->slave->name, r);
+	} while (ois[++i]);
+
+	return 0;
+}
+
+/**
  * _ensure_mpu_hwmod_is_setup - ensure the MPU SS hwmod is init'ed and=
 set up
  * @oh: pointer to the hwmod currently being set up (usually not the M=
PU)
  *
@@ -2593,13 +2850,17 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
 int omap_hwmod_count_resources(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
+	struct list_head *p =3D NULL;
 	int ret;
 	int i =3D 0;
=20
 	ret =3D _count_mpu_irqs(oh) + _count_sdma_reqs(oh);
=20
+	if (link_registration)
+		p =3D oh->slave_ports.next;
+
 	while (i < oh->slaves_cnt) {
-		os =3D _fetch_next_ocp_if(NULL, oh->slaves, &i);
+		os =3D _fetch_next_ocp_if(&p, oh->slaves, &i);
 		ret +=3D _count_ocp_if_addr_spaces(os);
 	}
=20
@@ -2619,6 +2880,7 @@ int omap_hwmod_count_resources(struct omap_hwmod =
*oh)
 int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *=
res)
 {
 	struct omap_hwmod_ocp_if *os;
+	struct list_head *p =3D NULL;
 	int i, j, mpu_irqs_cnt, sdma_reqs_cnt, addr_cnt;
 	int r =3D 0;
=20
@@ -2642,9 +2904,12 @@ int omap_hwmod_fill_resources(struct omap_hwmod =
*oh, struct resource *res)
 		r++;
 	}
=20
+	if (link_registration)
+		p =3D oh->slave_ports.next;
+
 	i =3D 0;
 	while (i < oh->slaves_cnt) {
-		os =3D _fetch_next_ocp_if(NULL, oh->slaves, &i);
+		os =3D _fetch_next_ocp_if(&p, oh->slaves, &i);
 		addr_cnt =3D _count_ocp_if_addr_spaces(os);
=20
 		for (j =3D 0; j < addr_cnt; j++) {
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index 083b6da..66c4a30 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -219,6 +219,10 @@ struct omap_hwmod_addr_space {
 #define OCPIF_SWSUP_IDLE		(1 << 0)
 #define OCPIF_CAN_BURST			(1 << 1)
=20
+/* omap_hwmod_ocp_if._int_flags possibilities */
+#define _OCPIF_INT_FLAGS_REGISTERED	(1 << 0)
+
+
 /**
  * struct omap_hwmod_ocp_if - OCP interface data
  * @master: struct omap_hwmod that initiates OCP transactions on this =
link
@@ -230,6 +234,7 @@ struct omap_hwmod_addr_space {
  * @width: OCP data width
  * @user: initiators using this interface (see OCP_USER_* macros above=
)
  * @flags: OCP interface flags (see OCPIF_* macros above)
+ * @_int_flags: internal flags (see _OCPIF_INT_FLAGS* macros above)
  *
  * It may also be useful to add a tag_cnt field for OCP2.x devices.
  *
@@ -248,6 +253,7 @@ struct omap_hwmod_ocp_if {
 	u8				width;
 	u8				user;
 	u8				flags;
+	u8				_int_flags;
 };
=20
=20
@@ -477,6 +483,16 @@ struct omap_hwmod_class {
 };
=20
 /**
+ * struct omap_hwmod_link - internal structure linking hwmods with ocp=
_ifs
+ * @ocp_if: OCP interface structure record pointer
+ * @node: list_head pointing to next struct omap_hwmod_link in a list
+ */
+struct omap_hwmod_link {
+	struct omap_hwmod_ocp_if	*ocp_if;
+	struct list_head		node;
+};
+
+/**
  * struct omap_hwmod - integration data for OMAP hardware "modules" (I=
P blocks)
  * @name: name of the hwmod
  * @class: struct omap_hwmod_class * to the class of this hwmod
@@ -495,6 +511,7 @@ struct omap_hwmod_class {
  * @_sysc_cache: internal-use hwmod flags
  * @_mpu_rt_va: cached register target start address (internal use)
  * @_mpu_port_index: cached MPU register target slave ID (internal use=
)
+ * @_mpu_port: cached MPU register target slave (internal use)
  * @opt_clks_cnt: number of @opt_clks
  * @master_cnt: number of @master entries
  * @slaves_cnt: number of @slave entries
@@ -513,6 +530,8 @@ struct omap_hwmod_class {
  *
  * Parameter names beginning with an underscore are managed internally=
 by
  * the omap_hwmod code and should not be set during initialization.
+ *
+ * @masters and @slaves are now deprecated.
  */
 struct omap_hwmod {
 	const char			*name;
@@ -534,11 +553,14 @@ struct omap_hwmod {
 	char				*vdd_name;
 	struct omap_hwmod_ocp_if	**masters; /* connect to *_IA */
 	struct omap_hwmod_ocp_if	**slaves;  /* connect to *_TA */
+	struct list_head		master_ports; /* connect to *_IA */
+	struct list_head		slave_ports; /* connect to *_TA */
 	void				*dev_attr;
 	u32				_sysc_cache;
 	void __iomem			*_mpu_rt_va;
 	spinlock_t			_lock;
 	struct list_head		node;
+	struct omap_hwmod_ocp_if	*_mpu_port;
 	u16				flags;
 	u8				_mpu_port_index;
 	u8				response_lat;
@@ -624,4 +646,6 @@ extern int omap2430_hwmod_init(void);
 extern int omap3xxx_hwmod_init(void);
 extern int omap44xx_hwmod_init(void);
=20
+extern int __init omap_hwmod_register_links(struct omap_hwmod_ocp_if *=
*ois);
+
 #endif


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
