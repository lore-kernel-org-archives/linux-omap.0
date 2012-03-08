From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/12] ARM: OMAP: hwmod: remove code support for direct hwmod
 registration
Date: Wed, 07 Mar 2012 19:38:36 -0700
Message-ID: <20120308023834.8205.55023.stgit@dusk>
References: <20120308023614.8205.78768.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45789 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab2CHCmK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 21:42:10 -0500
In-Reply-To: <20120308023614.8205.78768.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Now that the data has been converted to use interface registration, we
can remove the (now unused) direct hwmod registration code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |  124 +++++++-----------=
--------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    7 -
 2 files changed, 33 insertions(+), 98 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index edbeefa..f3d264a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -173,12 +173,6 @@ static LIST_HEAD(omap_hwmod_list);
 static struct omap_hwmod *mpu_oh;
=20
 /*
- * link_registration: set to true if hwmod interfaces are being regist=
ered
- * directly; set to false if hwmods are being registered directly
- */
-static bool link_registration;
-
-/*
  * linkspace: ptr to a buffer that struct omap_hwmod_link records are
  * allocated from - used to reduce the number of small memory
  * allocations, which has a significant impact on performance
@@ -195,32 +189,22 @@ static unsigned short free_ls, max_ls, ls_supp;
 /* Private functions */
=20
 /**
- * _fetch_next_ocp_if - return next OCP interface in an array or list
+ * _fetch_next_ocp_if - return the next OCP interface in a list
  * @p: ptr to a ptr to the list_head inside the ocp_if to return
- * @old: ptr to an array of struct omap_hwmod_ocp_if records
- * @i: pointer to the index into the @old array
- *
- * Return a pointer to the next struct omap_hwmod_ocp_if record in a
- * sequence.  If hwmods are being registered directly, then return a
- * struct omap_hwmod_ocp_if record corresponding to the element index
- * pointed to by @i in the
- * @old array.  Otherwise, return a pointer to the struct
- * omap_hwmod_ocp_if record containing the struct list_head record poi=
nted
- * to by @p, and set the pointer pointed to by @p to point to the next
- * struct list_head record in the list.
+ * @i: pointer to the index of the element pointed to by @p in the lis=
t
+ *
+ * Return a pointer to the struct omap_hwmod_ocp_if record
+ * containing the struct list_head pointed to by @p, and increment
+ * @p such that a future call to this routine will return the next
+ * record.
  */
 static struct omap_hwmod_ocp_if *_fetch_next_ocp_if(struct list_head *=
*p,
-						    struct omap_hwmod_ocp_if **old,
 						    int *i)
 {
 	struct omap_hwmod_ocp_if *oi;
=20
-	if (!link_registration) {
-		oi =3D old[*i];
-	} else {
-		oi =3D list_entry(*p, struct omap_hwmod_link, node)->ocp_if;
-		*p =3D (*p)->next;
-	}
+	oi =3D list_entry(*p, struct omap_hwmod_link, node)->ocp_if;
+	*p =3D (*p)->next;
=20
 	*i =3D *i + 1;
=20
@@ -642,16 +626,15 @@ static int _init_main_clk(struct omap_hwmod *oh)
 static int _init_interface_clks(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
-	struct list_head *p =3D NULL;
+	struct list_head *p;
 	struct clk *c;
 	int i =3D 0;
 	int ret =3D 0;
=20
-	if (link_registration)
-		p =3D oh->slave_ports.next;
+	p =3D oh->slave_ports.next;
=20
 	while (i < oh->slaves_cnt) {
-		os =3D _fetch_next_ocp_if(&p, oh->slaves, &i);
+		os =3D _fetch_next_ocp_if(&p, &i);
 		if (!os->clk)
 			continue;
=20
@@ -704,7 +687,7 @@ static int _init_opt_clks(struct omap_hwmod *oh)
 static int _enable_clocks(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
-	struct list_head *p =3D NULL;
+	struct list_head *p;
 	int i =3D 0;
=20
 	pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
@@ -712,11 +695,10 @@ static int _enable_clocks(struct omap_hwmod *oh)
 	if (oh->_clk)
 		clk_enable(oh->_clk);
=20
-	if (link_registration)
-		p =3D oh->slave_ports.next;
+	p =3D oh->slave_ports.next;
=20
 	while (i < oh->slaves_cnt) {
-		os =3D _fetch_next_ocp_if(&p, oh->slaves, &i);
+		os =3D _fetch_next_ocp_if(&p, &i);
=20
 		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
 			clk_enable(os->_clk);
@@ -736,7 +718,7 @@ static int _enable_clocks(struct omap_hwmod *oh)
 static int _disable_clocks(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
-	struct list_head *p =3D NULL;
+	struct list_head *p;
 	int i =3D 0;
=20
 	pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);
@@ -744,11 +726,10 @@ static int _disable_clocks(struct omap_hwmod *oh)
 	if (oh->_clk)
 		clk_disable(oh->_clk);
=20
-	if (link_registration)
-		p =3D oh->slave_ports.next;
+	p =3D oh->slave_ports.next;
=20
 	while (i < oh->slaves_cnt) {
-		os =3D _fetch_next_ocp_if(&p, oh->slaves, &i);
+		os =3D _fetch_next_ocp_if(&p, &i);
=20
 		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
 			clk_disable(os->_clk);
@@ -1062,12 +1043,11 @@ static int _get_addr_space_by_name(struct omap_=
hwmod *oh, const char *name,
 	struct list_head *p =3D NULL;
 	bool found =3D false;
=20
-	if (link_registration)
-		p =3D oh->slave_ports.next;
+	p =3D oh->slave_ports.next;
=20
 	i =3D 0;
 	while (i < oh->slaves_cnt) {
-		os =3D _fetch_next_ocp_if(NULL, oh->slaves, &i);
+		os =3D _fetch_next_ocp_if(&p, &i);
=20
 		if (!os->addr)
 			return -ENOENT;
@@ -1107,7 +1087,7 @@ static int _get_addr_space_by_name(struct omap_hw=
mod *oh, const char *name,
 static void __init _save_mpu_port_index(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os =3D NULL;
-	struct list_head *p =3D NULL;
+	struct list_head *p;
 	int i =3D 0;
=20
 	if (!oh)
@@ -1115,14 +1095,12 @@ static void __init _save_mpu_port_index(struct =
omap_hwmod *oh)
=20
 	oh->_int_flags |=3D _HWMOD_NO_MPU_PORT;
=20
-	if (link_registration)
-		p =3D oh->slave_ports.next;
+	p =3D oh->slave_ports.next;
=20
 	while (i < oh->slaves_cnt) {
-		os =3D _fetch_next_ocp_if(&p, oh->slaves, &i);
+		os =3D _fetch_next_ocp_if(&p, &i);
 		if (os->user & OCP_USER_MPU) {
 			oh->_mpu_port =3D os;
-			oh->_mpu_port_index =3D i - 1;
 			oh->_int_flags &=3D ~_HWMOD_NO_MPU_PORT;
 			break;
 		}
@@ -1149,10 +1127,7 @@ static struct omap_hwmod_ocp_if *_find_mpu_rt_po=
rt(struct omap_hwmod *oh)
 	if (!oh || oh->_int_flags & _HWMOD_NO_MPU_PORT || oh->slaves_cnt =3D=3D=
 0)
 		return NULL;
=20
-	if (!link_registration)
-		return oh->slaves[oh->_mpu_port_index];
-	else
-		return oh->_mpu_port;
+	return oh->_mpu_port;
 };
=20
 /**
@@ -2033,16 +2008,15 @@ static void __init _init_mpu_rt_base(struct oma=
p_hwmod *oh, void *data)
 static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
-	struct list_head *p =3D NULL;
+	struct list_head *p;
 	int i =3D 0;
 	if (oh->_state !=3D _HWMOD_STATE_INITIALIZED)
 		return;
=20
-	if (link_registration)
-		p =3D oh->slave_ports.next;
+	p =3D oh->slave_ports.next;
=20
 	while (i < oh->slaves_cnt) {
-		os =3D _fetch_next_ocp_if(&p, oh->slaves, &i);
+		os =3D _fetch_next_ocp_if(&p, &i);
 		if (!os->_clk)
 			continue;
=20
@@ -2546,34 +2520,6 @@ int omap_hwmod_for_each(int (*fn)(struct omap_hw=
mod *oh, void *data),
 }
=20
 /**
- * omap_hwmod_register - register an array of hwmods
- * @ohs: pointer to an array of omap_hwmods to register
- *
- * Intended to be called early in boot before the clock framework is
- * initialized.  If @ohs is not null, will register all omap_hwmods
- * listed in @ohs that are valid for this chip.  Returns 0.
- */
-int __init omap_hwmod_register(struct omap_hwmod **ohs)
-{
-	int r, i;
-
-	if (link_registration)
-		return -EINVAL;
-
-	if (!ohs)
-		return 0;
-
-	i =3D 0;
-	do {
-		r =3D _register(ohs[i]);
-		WARN(r, "omap_hwmod: %s: _register returned %d\n", ohs[i]->name,
-		     r);
-	} while (ohs[++i]);
-
-	return 0;
-}
-
-/**
  * omap_hwmod_register_links - register an array of hwmod links
  * @ois: pointer to an array of omap_hwmod_ocp_if to register
  *
@@ -2588,8 +2534,6 @@ int __init omap_hwmod_register_links(struct omap_=
hwmod_ocp_if **ois)
 	if (!ois)
 		return 0;
=20
-	link_registration =3D true;
-
 	if (!linkspace) {
 		if (_alloc_linkspace(ois)) {
 			pr_err("omap_hwmod: could not allocate link space\n");
@@ -2850,17 +2794,16 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
 int omap_hwmod_count_resources(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
-	struct list_head *p =3D NULL;
+	struct list_head *p;
 	int ret;
 	int i =3D 0;
=20
 	ret =3D _count_mpu_irqs(oh) + _count_sdma_reqs(oh);
=20
-	if (link_registration)
-		p =3D oh->slave_ports.next;
+	p =3D oh->slave_ports.next;
=20
 	while (i < oh->slaves_cnt) {
-		os =3D _fetch_next_ocp_if(&p, oh->slaves, &i);
+		os =3D _fetch_next_ocp_if(&p, &i);
 		ret +=3D _count_ocp_if_addr_spaces(os);
 	}
=20
@@ -2880,7 +2823,7 @@ int omap_hwmod_count_resources(struct omap_hwmod =
*oh)
 int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *=
res)
 {
 	struct omap_hwmod_ocp_if *os;
-	struct list_head *p =3D NULL;
+	struct list_head *p;
 	int i, j, mpu_irqs_cnt, sdma_reqs_cnt, addr_cnt;
 	int r =3D 0;
=20
@@ -2904,12 +2847,11 @@ int omap_hwmod_fill_resources(struct omap_hwmod=
 *oh, struct resource *res)
 		r++;
 	}
=20
-	if (link_registration)
-		p =3D oh->slave_ports.next;
+	p =3D oh->slave_ports.next;
=20
 	i =3D 0;
 	while (i < oh->slaves_cnt) {
-		os =3D _fetch_next_ocp_if(&p, oh->slaves, &i);
+		os =3D _fetch_next_ocp_if(&p, &i);
 		addr_cnt =3D _count_ocp_if_addr_spaces(os);
=20
 		for (j =3D 0; j < addr_cnt; j++) {
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index 66c4a30..8c39f70 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -505,12 +505,9 @@ struct omap_hwmod_link {
  * @opt_clks: other device clocks that drivers can request (0..*)
  * @vdd_name: voltage domain name
  * @voltdm: pointer to voltage domain (filled in at runtime)
- * @masters: ptr to array of OCP ifs that this hwmod can initiate on
- * @slaves: ptr to array of OCP ifs that this hwmod can respond on
  * @dev_attr: arbitrary device attributes that can be passed to the dr=
iver
  * @_sysc_cache: internal-use hwmod flags
  * @_mpu_rt_va: cached register target start address (internal use)
- * @_mpu_port_index: cached MPU register target slave ID (internal use=
)
  * @_mpu_port: cached MPU register target slave (internal use)
  * @opt_clks_cnt: number of @opt_clks
  * @master_cnt: number of @master entries
@@ -551,8 +548,6 @@ struct omap_hwmod {
 	char				*clkdm_name;
 	struct clockdomain		*clkdm;
 	char				*vdd_name;
-	struct omap_hwmod_ocp_if	**masters; /* connect to *_IA */
-	struct omap_hwmod_ocp_if	**slaves;  /* connect to *_TA */
 	struct list_head		master_ports; /* connect to *_IA */
 	struct list_head		slave_ports; /* connect to *_TA */
 	void				*dev_attr;
@@ -562,7 +557,6 @@ struct omap_hwmod {
 	struct list_head		node;
 	struct omap_hwmod_ocp_if	*_mpu_port;
 	u16				flags;
-	u8				_mpu_port_index;
 	u8				response_lat;
 	u8				rst_lines_cnt;
 	u8				opt_clks_cnt;
@@ -574,7 +568,6 @@ struct omap_hwmod {
 	u8				_postsetup_state;
 };
=20
-int omap_hwmod_register(struct omap_hwmod **ohs);
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data);


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
