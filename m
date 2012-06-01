From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 3/4] ARM: OMAP3+: PM: VP: check to ensure VP is idle before forceupdate
Date: Thu, 31 May 2012 20:41:38 -0500
Message-ID: <1338514899-3560-4-git-send-email-nm@ti.com>
References: <1338514899-3560-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:35404 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753943Ab2FABl4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 21:41:56 -0400
Received: by obhx4 with SMTP id x4so2371765obh.6
        for <linux-omap@vger.kernel.org>; Thu, 31 May 2012 18:41:55 -0700 (PDT)
In-Reply-To: <1338514899-3560-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Vinay Amancha <vinaykumar@ti.com>

Ideally in the flow of DVFS programming, VP should be in idle state
(since we disabled it) before entering forceupdate. Ensure that
this is the case. Not doing this could cause VP statemachine
to enter invalid states. Use ratelimited warnings to prevent spam
if VP state machine is stuck.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>

Signed-off-by: Vinay Amancha <vinaykumar@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/vp.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 4723879..2a8a085 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -163,6 +163,13 @@ int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 	u8 target_vsel, current_vsel;
 	int ret, timeout = 0;
 
+	ret = _vp_wait_for_idle(voltdm, vp);
+	if (ret) {
+		pr_warn_ratelimited("%s: vdd_%s idle timedout (v=%ld)\n",
+				    __func__, voltdm->name, target_volt);
+		return ret;
+	}
+
 	ret = omap_vc_pre_scale(voltdm, target_volt, &target_vsel, &current_vsel);
 	if (ret)
 		return ret;
-- 
1.7.9.5

