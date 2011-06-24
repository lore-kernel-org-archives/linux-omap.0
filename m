From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 02/14] OMAP2+: hwmod: Init clkdm field at boot time
Date: Fri, 24 Jun 2011 13:05:48 +0200
Message-ID: <1308913560-333-3-git-send-email-b-cousson@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35155 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753197Ab1FXLGS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 07:06:18 -0400
In-Reply-To: <y>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

At boot time, lookup the clkdm_name to get the clkdm
structure pointer for further usage.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   34 +++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 2 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 55ad6a5..bb63e2d 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -919,9 +919,40 @@ static struct omap_hwmod *_lookup(const char *name)
 
 	return oh;
 }
+/**
+ * _init_clkdm - look up a clockdomain name, store pointer in omap_hwmod
+ * @oh: struct omap_hwmod *
+ *
+ * Convert a clockdomain name stored in a struct omap_hwmod into a
+ * clockdomain pointer, and save it into the struct omap_hwmod.
+ * return -EINVAL if clkdm_name does not exist or if the lookup failed.
+ */
+static int _init_clkdm(struct omap_hwmod *oh)
+{
+	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+		return 0;
+
+	if (!oh->clkdm_name) {
+		pr_warning("omap_hwmod: %s: no clkdm_name\n", oh->name);
+		return -EINVAL;
+	}
+
+	oh->clkdm = clkdm_lookup(oh->clkdm_name);
+	if (!oh->clkdm) {
+		pr_warning("omap_hwmod: %s: could not associate to clkdm %s\n",
+			oh->name, oh->clkdm_name);
+		return -EINVAL;
+	}
+
+	pr_debug("omap_hwmod: %s: associated to clkdm %s\n",
+		oh->name, oh->clkdm_name);
+
+	return 0;
+}
 
 /**
- * _init_clocks - clk_get() all clocks associated with this hwmod
+ * _init_clocks - clk_get() all clocks associated with this hwmod. Retrieve as
+ * well the clockdomain.
  * @oh: struct omap_hwmod *
  * @data: not used; pass NULL
  *
@@ -941,6 +972,7 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
 	ret |= _init_main_clk(oh);
 	ret |= _init_interface_clks(oh);
 	ret |= _init_opt_clks(oh);
+	ret |= _init_clkdm(oh);
 
 	if (!ret)
 		oh->_state = _HWMOD_STATE_CLKS_INITED;
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 5d77c5b..28ea1c8 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -520,6 +520,7 @@ struct omap_hwmod {
 	struct clk			*_clk;
 	struct omap_hwmod_opt_clk	*opt_clks;
 	char				*clkdm_name;
+	struct clockdomain		*clkdm;
 	char				*vdd_name;
 	struct voltagedomain		*voltdm;
 	struct omap_hwmod_ocp_if	**masters; /* connect to *_IA */
-- 
1.7.0.4

