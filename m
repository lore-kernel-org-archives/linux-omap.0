From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/12] ARM: OMAP2+: hwmod: add function to iterate over struct
 omap_hwmod_ocp_if
Date: Wed, 07 Mar 2012 19:38:24 -0700
Message-ID: <20120308023823.8205.84120.stgit@dusk>
References: <20120308023614.8205.78768.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45781 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab2CHCmJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 21:42:09 -0500
In-Reply-To: <20120308023614.8205.78768.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

To reduce the number of lines of data in the OMAP portion of the Linux
code base, subsequent patches will remove the lists of hwmod
interconnect links from the static hwmod data.  These lists will be
built dynamically during boot.  To ease this transition, this patch
centralizes the way that interconnect links are iterated into a single
function, _fetch_next_ocp_if().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |  115 ++++++++++++++++++++++--------=
--------
 1 files changed, 67 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 503047a..96a03d7 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -169,6 +169,29 @@ static struct omap_hwmod *mpu_oh;
 /* Private functions */
=20
 /**
+ * _fetch_next_ocp_if - return @i'th OCP interface in an array
+ * @p: ptr to a ptr to the list_head inside the ocp_if to return (not =
yet used)
+ * @old: ptr to an array of struct omap_hwmod_ocp_if records
+ * @i: pointer to the index into the @old array
+ *
+ * Return a pointer to the next struct omap_hwmod_ocp_if record in a
+ * sequence.  Currently returns a struct omap_hwmod_ocp_if record
+ * corresponding to the element index pointed to by @i in the @old
+ * array, and increments the index pointed to by @i.
+ */
+static struct omap_hwmod_ocp_if *_fetch_next_ocp_if(struct list_head *=
*p,
+						    struct omap_hwmod_ocp_if **old,
+						    int *i)
+{
+	struct omap_hwmod_ocp_if *oi;
+
+	oi =3D old[*i];
+	*i =3D *i + 1;
+
+	return oi;
+}
+
+/**
  * _update_sysc_cache - return the module OCP_SYSCONFIG register, keep=
 copy
  * @oh: struct omap_hwmod *
  *
@@ -582,16 +605,13 @@ static int _init_main_clk(struct omap_hwmod *oh)
  */
 static int _init_interface_clks(struct omap_hwmod *oh)
 {
+	struct omap_hwmod_ocp_if *os;
 	struct clk *c;
-	int i;
+	int i =3D 0;
 	int ret =3D 0;
=20
-	if (oh->slaves_cnt =3D=3D 0)
-		return 0;
-
-	for (i =3D 0; i < oh->slaves_cnt; i++) {
-		struct omap_hwmod_ocp_if *os =3D oh->slaves[i];
-
+	while (i < oh->slaves_cnt) {
+		os =3D _fetch_next_ocp_if(NULL, oh->slaves, &i);
 		if (!os->clk)
 			continue;
=20
@@ -643,21 +663,19 @@ static int _init_opt_clks(struct omap_hwmod *oh)
  */
 static int _enable_clocks(struct omap_hwmod *oh)
 {
-	int i;
+	struct omap_hwmod_ocp_if *os;
+	int i =3D 0;
=20
 	pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
=20
 	if (oh->_clk)
 		clk_enable(oh->_clk);
=20
-	if (oh->slaves_cnt > 0) {
-		for (i =3D 0; i < oh->slaves_cnt; i++) {
-			struct omap_hwmod_ocp_if *os =3D oh->slaves[i];
-			struct clk *c =3D os->_clk;
+	while (i < oh->slaves_cnt) {
+		os =3D _fetch_next_ocp_if(NULL, oh->slaves, &i);
=20
-			if (c && (os->flags & OCPIF_SWSUP_IDLE))
-				clk_enable(c);
-		}
+		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
+			clk_enable(os->_clk);
 	}
=20
 	/* The opt clocks are controlled by the device driver. */
@@ -673,21 +691,19 @@ static int _enable_clocks(struct omap_hwmod *oh)
  */
 static int _disable_clocks(struct omap_hwmod *oh)
 {
-	int i;
+	struct omap_hwmod_ocp_if *os;
+	int i =3D 0;
=20
 	pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);
=20
 	if (oh->_clk)
 		clk_disable(oh->_clk);
=20
-	if (oh->slaves_cnt > 0) {
-		for (i =3D 0; i < oh->slaves_cnt; i++) {
-			struct omap_hwmod_ocp_if *os =3D oh->slaves[i];
-			struct clk *c =3D os->_clk;
+	while (i < oh->slaves_cnt) {
+		os =3D _fetch_next_ocp_if(NULL, oh->slaves, &i);
=20
-			if (c && (os->flags & OCPIF_SWSUP_IDLE))
-				clk_disable(c);
-		}
+		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
+			clk_disable(os->_clk);
 	}
=20
 	/* The opt clocks are controlled by the device driver. */
@@ -997,8 +1013,9 @@ static int _get_addr_space_by_name(struct omap_hwm=
od *oh, const char *name,
 	struct omap_hwmod_ocp_if *os;
 	bool found =3D false;
=20
-	for (i =3D 0; i < oh->slaves_cnt; i++) {
-		os =3D oh->slaves[i];
+	i =3D 0;
+	while (i < oh->slaves_cnt) {
+		os =3D _fetch_next_ocp_if(NULL, oh->slaves, &i);
=20
 		if (!os->addr)
 			return -ENOENT;
@@ -1035,15 +1052,15 @@ static int _get_addr_space_by_name(struct omap_=
hwmod *oh, const char *name,
  */
 static int __init _find_mpu_port_index(struct omap_hwmod *oh)
 {
-	int i;
+	struct omap_hwmod_ocp_if *os;
+	int i =3D 0;
 	int found =3D 0;
=20
-	if (!oh || oh->slaves_cnt =3D=3D 0)
+	if (!oh)
 		return -EINVAL;
=20
-	for (i =3D 0; i < oh->slaves_cnt; i++) {
-		struct omap_hwmod_ocp_if *os =3D oh->slaves[i];
-
+	while (i < oh->slaves_cnt) {
+		os =3D _fetch_next_ocp_if(NULL, oh->slaves, &i);
 		if (os->user & OCP_USER_MPU) {
 			found =3D 1;
 			break;
@@ -1052,12 +1069,12 @@ static int __init _find_mpu_port_index(struct o=
map_hwmod *oh)
=20
 	if (found)
 		pr_debug("omap_hwmod: %s: MPU OCP slave port ID  %d\n",
-			 oh->name, i);
+			 oh->name, i - 1);
 	else
 		pr_debug("omap_hwmod: %s: no MPU OCP slave port found\n",
 			 oh->name);
=20
-	return (found) ? i : -EINVAL;
+	return (found) ? (i - 1) : -EINVAL;
 }
=20
 /**
@@ -1956,23 +1973,22 @@ static void __init _init_mpu_rt_base(struct oma=
p_hwmod *oh, void *data)
  */
 static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
 {
-	int i;
-
+	struct omap_hwmod_ocp_if *os;
+	int i =3D 0;
 	if (oh->_state !=3D _HWMOD_STATE_INITIALIZED)
 		return;
=20
-	for (i =3D 0; i < oh->slaves_cnt; i++) {
-		struct omap_hwmod_ocp_if *os =3D oh->slaves[i];
-		struct clk *c =3D os->_clk;
=20
-		if (!c)
+	while (i < oh->slaves_cnt) {
+		os =3D _fetch_next_ocp_if(NULL, oh->slaves, &i);
+		if (!os->_clk)
 			continue;
=20
 		if (os->flags & OCPIF_SWSUP_IDLE) {
 			/* XXX omap_iclk_deny_idle(c); */
 		} else {
 			/* XXX omap_iclk_allow_idle(c); */
-			clk_enable(c);
+			clk_enable(os->_clk);
 		}
 	}
=20
@@ -2585,12 +2601,16 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
  */
 int omap_hwmod_count_resources(struct omap_hwmod *oh)
 {
-	int ret, i;
+	struct omap_hwmod_ocp_if *os;
+	int ret;
+	int i =3D 0;
=20
 	ret =3D _count_mpu_irqs(oh) + _count_sdma_reqs(oh);
=20
-	for (i =3D 0; i < oh->slaves_cnt; i++)
-		ret +=3D _count_ocp_if_addr_spaces(oh->slaves[i]);
+	while (i < oh->slaves_cnt) {
+		os =3D _fetch_next_ocp_if(NULL, oh->slaves, &i);
+		ret +=3D _count_ocp_if_addr_spaces(os);
+	}
=20
 	return ret;
 }
@@ -2607,7 +2627,8 @@ int omap_hwmod_count_resources(struct omap_hwmod =
*oh)
  */
 int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *=
res)
 {
-	int i, j, mpu_irqs_cnt, sdma_reqs_cnt;
+	struct omap_hwmod_ocp_if *os;
+	int i, j, mpu_irqs_cnt, sdma_reqs_cnt, addr_cnt;
 	int r =3D 0;
=20
 	/* For each IRQ, DMA, memory area, fill in array.*/
@@ -2630,11 +2651,9 @@ int omap_hwmod_fill_resources(struct omap_hwmod =
*oh, struct resource *res)
 		r++;
 	}
=20
-	for (i =3D 0; i < oh->slaves_cnt; i++) {
-		struct omap_hwmod_ocp_if *os;
-		int addr_cnt;
-
-		os =3D oh->slaves[i];
+	i =3D 0;
+	while (i < oh->slaves_cnt) {
+		os =3D _fetch_next_ocp_if(NULL, oh->slaves, &i);
 		addr_cnt =3D _count_ocp_if_addr_spaces(os);
=20
 		for (j =3D 0; j < addr_cnt; j++) {


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
