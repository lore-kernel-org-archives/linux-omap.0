From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/3] ARM: OMAP3+: PM: VP: check to ensure VP is idle before forceupdate
Date: Fri, 18 May 2012 14:33:20 -0500
Message-ID: <1337369601-14915-3-git-send-email-nm@ti.com>
References: <[PATCH] ARM: OMAP3+: PM: VP: ensure VP is idle before disable>
 <1337369601-14915-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:51923 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967006Ab2ERTdg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 15:33:36 -0400
Received: by obbun3 with SMTP id un3so4140978obb.25
        for <linux-omap@vger.kernel.org>; Fri, 18 May 2012 12:33:35 -0700 (PDT)
In-Reply-To: <1337369601-14915-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vinay Amancha <vinaykumar@ti.com>

Ideally in the flow of DVFS programming, VP should be in idle state
(since we disabled it) before entering forceupdate. Ensure that
this is the case. Not doing this could cause VP statemachine
to enter invalid states.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Signed-off-by: Vinay Amancha <vinaykumar@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/vp.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 925d869..985091b 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -123,6 +123,18 @@ int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 	u8 target_vsel, current_vsel;
 	int ret, timeout = 0;
 
+/*
+	 * Wait for VP idle Typical latency is <2us. Maximum latency is ~100us
+	 * This is an additional allowance to ensure we are in proper state
+	 * to enter into forceupdate state transition.
+	 */
+	omap_test_timeout((voltdm->read(vp->vstatus)),
+			  VP_IDLE_TIMEOUT, timeout);
+
+	if (timeout >= VP_IDLE_TIMEOUT)
+		pr_warning("%s: vdd_%s idle timedout forceupdate(v=%ld)\n",
+			   __func__, voltdm->name, target_volt);
+
 	ret = omap_vc_pre_scale(voltdm, target_volt, &target_vsel, &current_vsel);
 	if (ret)
 		return ret;
-- 
1.7.9.5

