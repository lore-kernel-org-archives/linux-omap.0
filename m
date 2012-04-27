From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 4/6] ARM: OMAP2+: hwmod: use init-time function pointer for
 wait_target_ready
Date: Fri, 27 Apr 2012 13:05:38 -0700
Message-ID: <1335557140-10854-5-git-send-email-khilman@ti.com>
References: <1335557140-10854-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1335557140-10854-1-git-send-email-khilman@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Rather than using cpu_is* checking at runtime, initialize an SoC specific
function pointer for wait_target_ready().

While here, downgrade the BUG() to a WARN_ON() so it gives a noisy
warning instead of causing a kernel panic.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   43 ++++++++++++++++----------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 3641b0a..6dd454d 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1341,6 +1341,24 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
 	return ret;
 }
 
+static int omap2_wait_module_ready(struct omap_hwmod *oh)
+{
+	return omap2_cm_wait_module_ready(oh->prcm.omap2.module_offs,
+					  oh->prcm.omap2.idlest_reg_id,
+					  oh->prcm.omap2.idlest_idle_bit);
+}
+
+static int omap4_wait_module_ready(struct omap_hwmod *oh)
+{
+	if (!oh->clkdm)
+		return -EINVAL;
+
+	return omap4_cminst_wait_module_ready(oh->clkdm->prcm_partition,
+					      oh->clkdm->cm_inst,
+					      oh->clkdm->clkdm_offs,
+					      oh->prcm.omap4.clkctrl_offs);
+}
+
 /**
  * _wait_target_ready - wait for a module to leave slave idle
  * @oh: struct omap_hwmod *
@@ -1353,7 +1371,7 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
 static int _wait_target_ready(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
-	int ret;
+	int ret = -EINVAL;
 
 	if (!oh)
 		return -EINVAL;
@@ -1369,21 +1387,9 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 
 	/* XXX check clock enable states */
 
-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		ret = omap2_cm_wait_module_ready(oh->prcm.omap2.module_offs,
-						 oh->prcm.omap2.idlest_reg_id,
-						 oh->prcm.omap2.idlest_idle_bit);
-	} else if (cpu_is_omap44xx()) {
-		if (!oh->clkdm)
-			return -EINVAL;
-
-		ret = omap4_cminst_wait_module_ready(oh->clkdm->prcm_partition,
-						     oh->clkdm->cm_inst,
-						     oh->clkdm->clkdm_offs,
-						     oh->prcm.omap4.clkctrl_offs);
-	} else {
-		BUG();
-	};
+	WARN_ON(!oh->wait_module_ready);
+	if (oh->wait_module_ready)
+		ret = oh->wait_module_ready(oh);
 
 	return ret;
 }
@@ -2055,9 +2061,12 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 		return -EINVAL;
 	}
 
-	if (cpu_is_omap44xx()) {
+	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+		oh->wait_module_ready = omap2_wait_module_ready;
+	} else if (cpu_is_omap44xx()) {
 		oh->enable_module = _omap4_enable_module;
 		oh->disable_module = _omap4_disable_module;
+		oh->wait_module_ready = omap4_wait_module_ready;
 	}
 
 	oh->_state = _HWMOD_STATE_INITIALIZED;
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 0dbe8cf..329ede5 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -567,6 +567,7 @@ struct omap_hwmod {
 
 	void (*enable_module)(struct omap_hwmod *oh);
 	int (*disable_module)(struct omap_hwmod *oh);
+	int (*wait_module_ready)(struct omap_hwmod *oh);
 };
 
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
-- 
1.7.9.2
