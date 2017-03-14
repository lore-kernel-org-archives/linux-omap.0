From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] ARM: OMAP2+: Use list_for_each_entry for hwmod slave_ports
Date: Tue, 14 Mar 2017 14:06:37 -0700
Message-ID: <20170314210639.2065-3-tony@atomide.com>
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

We are just iterating over the slave_ports lists, so we can
use list_for_each_entry() no problem.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 83 +++++-----------------------------------
 1 file changed, 10 insertions(+), 73 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -221,29 +221,6 @@ static bool inited;
 /* Private functions */
 
 /**
- * _fetch_next_ocp_if - return the next OCP interface in a list
- * @p: ptr to a ptr to the list_head inside the ocp_if to return
- * @i: pointer to the index of the element pointed to by @p in the list
- *
- * Return a pointer to the struct omap_hwmod_ocp_if record
- * containing the struct list_head pointed to by @p, and increment
- * @p such that a future call to this routine will return the next
- * record.
- */
-static struct omap_hwmod_ocp_if *_fetch_next_ocp_if(struct list_head **p,
-						    int *i)
-{
-	struct omap_hwmod_ocp_if *oi;
-
-	oi = list_entry(*p, struct omap_hwmod_ocp_if, node);
-	*p = (*p)->next;
-
-	*i = *i + 1;
-
-	return oi;
-}
-
-/**
  * _update_sysc_cache - return the module OCP_SYSCONFIG register, keep copy
  * @oh: struct omap_hwmod *
  *
@@ -779,15 +756,10 @@ static int _init_main_clk(struct omap_hwmod *oh)
 static int _init_interface_clks(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
-	struct list_head *p;
 	struct clk *c;
-	int i = 0;
 	int ret = 0;
 
-	p = oh->slave_ports.next;
-
-	while (i < oh->slaves_cnt) {
-		os = _fetch_next_ocp_if(&p, &i);
+	list_for_each_entry(os, &oh->slave_ports, node) {
 		if (!os->clk)
 			continue;
 
@@ -890,19 +862,13 @@ static void _disable_optional_clocks(struct omap_hwmod *oh)
 static int _enable_clocks(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
-	struct list_head *p;
-	int i = 0;
 
 	pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
 
 	if (oh->_clk)
 		clk_enable(oh->_clk);
 
-	p = oh->slave_ports.next;
-
-	while (i < oh->slaves_cnt) {
-		os = _fetch_next_ocp_if(&p, &i);
-
+	list_for_each_entry(os, &oh->slave_ports, node) {
 		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
 			clk_enable(os->_clk);
 	}
@@ -924,19 +890,13 @@ static int _enable_clocks(struct omap_hwmod *oh)
 static int _disable_clocks(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
-	struct list_head *p;
-	int i = 0;
 
 	pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);
 
 	if (oh->_clk)
 		clk_disable(oh->_clk);
 
-	p = oh->slave_ports.next;
-
-	while (i < oh->slaves_cnt) {
-		os = _fetch_next_ocp_if(&p, &i);
-
+	list_for_each_entry(os, &oh->slave_ports, node) {
 		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
 			clk_disable(os->_clk);
 	}
@@ -1175,16 +1135,11 @@ static int _get_sdma_req_by_name(struct omap_hwmod *oh, const char *name,
 static int _get_addr_space_by_name(struct omap_hwmod *oh, const char *name,
 				   u32 *pa_start, u32 *pa_end)
 {
-	int i, j;
+	int j;
 	struct omap_hwmod_ocp_if *os;
-	struct list_head *p = NULL;
 	bool found = false;
 
-	p = oh->slave_ports.next;
-
-	i = 0;
-	while (i < oh->slaves_cnt) {
-		os = _fetch_next_ocp_if(&p, &i);
+	list_for_each_entry(os, &oh->slave_ports, node) {
 
 		if (!os->addr)
 			return -ENOENT;
@@ -1224,18 +1179,13 @@ static int _get_addr_space_by_name(struct omap_hwmod *oh, const char *name,
 static void __init _save_mpu_port_index(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os = NULL;
-	struct list_head *p;
-	int i = 0;
 
 	if (!oh)
 		return;
 
 	oh->_int_flags |= _HWMOD_NO_MPU_PORT;
 
-	p = oh->slave_ports.next;
-
-	while (i < oh->slaves_cnt) {
-		os = _fetch_next_ocp_if(&p, &i);
+	list_for_each_entry(os, &oh->slave_ports, node) {
 		if (os->user & OCP_USER_MPU) {
 			oh->_mpu_port = os;
 			oh->_int_flags &= ~_HWMOD_NO_MPU_PORT;
@@ -2436,15 +2386,11 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
-	struct list_head *p;
-	int i = 0;
+
 	if (oh->_state != _HWMOD_STATE_INITIALIZED)
 		return;
 
-	p = oh->slave_ports.next;
-
-	while (i < oh->slaves_cnt) {
-		os = _fetch_next_ocp_if(&p, &i);
+	list_for_each_entry(os, &oh->slave_ports, node) {
 		if (!os->_clk)
 			continue;
 
@@ -3288,14 +3234,10 @@ int omap_hwmod_count_resources(struct omap_hwmod *oh, unsigned long flags)
 		ret += _count_sdma_reqs(oh);
 
 	if (flags & IORESOURCE_MEM) {
-		int i = 0;
 		struct omap_hwmod_ocp_if *os;
-		struct list_head *p = oh->slave_ports.next;
 
-		while (i < oh->slaves_cnt) {
-			os = _fetch_next_ocp_if(&p, &i);
+		list_for_each_entry(os, &oh->slave_ports, node)
 			ret += _count_ocp_if_addr_spaces(os);
-		}
 	}
 
 	return ret;
@@ -3314,7 +3256,6 @@ int omap_hwmod_count_resources(struct omap_hwmod *oh, unsigned long flags)
 int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
 {
 	struct omap_hwmod_ocp_if *os;
-	struct list_head *p;
 	int i, j, mpu_irqs_cnt, sdma_reqs_cnt, addr_cnt;
 	int r = 0;
 
@@ -3344,11 +3285,7 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
 		r++;
 	}
 
-	p = oh->slave_ports.next;
-
-	i = 0;
-	while (i < oh->slaves_cnt) {
-		os = _fetch_next_ocp_if(&p, &i);
+	list_for_each_entry(os, &oh->slave_ports, node) {
 		addr_cnt = _count_ocp_if_addr_spaces(os);
 
 		for (j = 0; j < addr_cnt; j++) {
-- 
2.11.1
