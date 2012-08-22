From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: [PATCH 2/2] ARM: OMAP: hwmod: revise deassert sequence
Date: Wed, 22 Aug 2012 00:42:30 -0500
Message-ID: <1345614150-25723-3-git-send-email-omar.luna@linaro.org>
References: <1345614150-25723-1-git-send-email-omar.luna@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51181 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756460Ab2HVFmp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Aug 2012 01:42:45 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so909839obb.19
        for <linux-omap@vger.kernel.org>; Tue, 21 Aug 2012 22:42:45 -0700 (PDT)
In-Reply-To: <1345614150-25723-1-git-send-email-omar.luna@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Omar Ramirez Luna <omar.luna@linaro.org>

For a reset sequence to complete cleanly, a module needs its
associated clocks to be enabled, otherwise the timeout check
in prcm code can print a false failure (failed to hardreset)
that occurs because the clocks aren't powered ON and the status
bit checked can't transition without them.

Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
---
 arch/arm/mach-omap2/omap_hwmod.c |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index eaedc33..b65e021 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1509,6 +1509,7 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 {
 	struct omap_hwmod_rst_info ohri;
 	int ret = -EINVAL;
+	int hwsup = 0;
 
 	if (!oh)
 		return -EINVAL;
@@ -1520,10 +1521,46 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 	if (IS_ERR_VALUE(ret))
 		return ret;
 
+	if (oh->clkdm) {
+		/*
+		 * A clockdomain must be in SW_SUP otherwise reset
+		 * might not be completed. The clockdomain can be set
+		 * in HW_AUTO only when the module become ready.
+		 */
+		hwsup = clkdm_in_hwsup(oh->clkdm);
+		ret = clkdm_hwmod_enable(oh->clkdm, oh);
+		if (ret) {
+			WARN(1, "omap_hwmod: %s: could not enable clockdomain %s: %d\n",
+			     oh->name, oh->clkdm->name, ret);
+			return ret;
+		}
+	}
+
+	_enable_clocks(oh);
+	if (soc_ops.enable_module)
+		soc_ops.enable_module(oh);
+
 	ret = soc_ops.deassert_hardreset(oh, &ohri);
+
+	if (soc_ops.disable_module)
+		soc_ops.disable_module(oh);
+	_disable_clocks(oh);
+
 	if (ret == -EBUSY)
 		pr_warning("omap_hwmod: %s: failed to hardreset\n", oh->name);
 
+	if (!ret) {
+		/*
+		 * Set the clockdomain to HW_AUTO, assuming that the
+		 * previous state was HW_AUTO.
+		 */
+		if (oh->clkdm && hwsup)
+			clkdm_allow_idle(oh->clkdm);
+	} else {
+		if (oh->clkdm)
+			clkdm_hwmod_disable(oh->clkdm, oh);
+	}
+
 	return ret;
 }
 
-- 
1.7.9.5

