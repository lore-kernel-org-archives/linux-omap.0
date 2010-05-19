From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 05/22] OMAP: hwmod: Fix wrong pointer iteration in oh->slaves
Date: Tue, 18 May 2010 20:18:43 -0600
Message-ID: <20100519021842.19716.89475.stgit@localhost.localdomain>
References: <20100519021800.19716.8938.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39782 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755032Ab0ESCU7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 22:20:59 -0400
In-Reply-To: <20100519021800.19716.8938.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Benoit Cousson <b-cousson@ti.com>

From: Benoit Cousson <b-cousson@ti.com>

The iteration is currently done on the omap_hwmod_ocp_if pointer
and not on the table pointer that reference them.
It worked most of the time because the structure are contiguous in
memory.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6459d07..a280ccc 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -432,7 +432,6 @@ static int _init_main_clk(struct omap_hwmod *oh)
  */
 static int _init_interface_clks(struct omap_hwmod *oh)
 {
-	struct omap_hwmod_ocp_if *os;
 	struct clk *c;
 	int i;
 	int ret = 0;
@@ -440,7 +439,9 @@ static int _init_interface_clks(struct omap_hwmod *oh)
 	if (oh->slaves_cnt == 0)
 		return 0;
 
-	for (i = 0, os = *oh->slaves; i < oh->slaves_cnt; i++, os++) {
+	for (i = 0; i < oh->slaves_cnt; i++) {
+		struct omap_hwmod_ocp_if *os = oh->slaves[i];
+
 		if (!os->clk)
 			continue;
 
@@ -490,7 +491,6 @@ static int _init_opt_clks(struct omap_hwmod *oh)
  */
 static int _enable_clocks(struct omap_hwmod *oh)
 {
-	struct omap_hwmod_ocp_if *os;
 	int i;
 
 	pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
@@ -499,7 +499,8 @@ static int _enable_clocks(struct omap_hwmod *oh)
 		clk_enable(oh->_clk);
 
 	if (oh->slaves_cnt > 0) {
-		for (i = 0, os = *oh->slaves; i < oh->slaves_cnt; i++, os++) {
+		for (i = 0; i < oh->slaves_cnt; i++) {
+			struct omap_hwmod_ocp_if *os = oh->slaves[i];
 			struct clk *c = os->_clk;
 
 			if (c && !IS_ERR(c) && (os->flags & OCPIF_SWSUP_IDLE))
@@ -520,7 +521,6 @@ static int _enable_clocks(struct omap_hwmod *oh)
  */
 static int _disable_clocks(struct omap_hwmod *oh)
 {
-	struct omap_hwmod_ocp_if *os;
 	int i;
 
 	pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);
@@ -529,7 +529,8 @@ static int _disable_clocks(struct omap_hwmod *oh)
 		clk_disable(oh->_clk);
 
 	if (oh->slaves_cnt > 0) {
-		for (i = 0, os = *oh->slaves; i < oh->slaves_cnt; i++, os++) {
+		for (i = 0; i < oh->slaves_cnt; i++) {
+			struct omap_hwmod_ocp_if *os = oh->slaves[i];
 			struct clk *c = os->_clk;
 
 			if (c && !IS_ERR(c) && (os->flags & OCPIF_SWSUP_IDLE))
@@ -551,14 +552,15 @@ static int _disable_clocks(struct omap_hwmod *oh)
  */
 static int _find_mpu_port_index(struct omap_hwmod *oh)
 {
-	struct omap_hwmod_ocp_if *os;
 	int i;
 	int found = 0;
 
 	if (!oh || oh->slaves_cnt == 0)
 		return -EINVAL;
 
-	for (i = 0, os = *oh->slaves; i < oh->slaves_cnt; i++, os++) {
+	for (i = 0; i < oh->slaves_cnt; i++) {
+		struct omap_hwmod_ocp_if *os = oh->slaves[i];
+
 		if (os->user & OCP_USER_MPU) {
 			found = 1;
 			break;
@@ -593,7 +595,7 @@ static void __iomem *_find_mpu_rt_base(struct omap_hwmod *oh, u8 index)
 	if (!oh || oh->slaves_cnt == 0)
 		return NULL;
 
-	os = *oh->slaves + index;
+	os = oh->slaves[index];
 
 	for (i = 0, mem = os->addr; i < os->addr_cnt; i++, mem++) {
 		if (mem->flags & ADDR_TYPE_RT) {
@@ -806,7 +808,7 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
 		return 0;
 
-	os = *oh->slaves + oh->_mpu_port_index;
+	os = oh->slaves[oh->_mpu_port_index];
 
 	if (oh->flags & HWMOD_NO_IDLEST)
 		return 0;
@@ -1000,7 +1002,6 @@ static int _shutdown(struct omap_hwmod *oh)
  */
 static int _setup(struct omap_hwmod *oh)
 {
-	struct omap_hwmod_ocp_if *os;
 	int i, r;
 
 	if (!oh)
@@ -1008,7 +1009,8 @@ static int _setup(struct omap_hwmod *oh)
 
 	/* Set iclk autoidle mode */
 	if (oh->slaves_cnt > 0) {
-		for (i = 0, os = *oh->slaves; i < oh->slaves_cnt; i++, os++) {
+		for (i = 0; i < oh->slaves_cnt; i++) {
+			struct omap_hwmod_ocp_if *os = oh->slaves[i];
 			struct clk *c = os->_clk;
 
 			if (!c || IS_ERR(c))
@@ -1438,7 +1440,7 @@ int omap_hwmod_count_resources(struct omap_hwmod *oh)
 	ret = oh->mpu_irqs_cnt + oh->sdma_chs_cnt;
 
 	for (i = 0; i < oh->slaves_cnt; i++)
-		ret += (*oh->slaves + i)->addr_cnt;
+		ret += oh->slaves[i]->addr_cnt;
 
 	return ret;
 }
@@ -1479,7 +1481,7 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
 	for (i = 0; i < oh->slaves_cnt; i++) {
 		struct omap_hwmod_ocp_if *os;
 
-		os = *oh->slaves + i;
+		os = oh->slaves[i];
 
 		for (j = 0; j < os->addr_cnt; j++) {
 			(res + r)->start = (os->addr + j)->pa_start;


