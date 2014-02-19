From: Paul Walmsley <paul@pwsan.com>
Subject: [RFC PATCH] ARM: OMAP2+: clockdomain: Reintroduce SW_SLEEP Support
 (fwd)
Date: Wed, 19 Feb 2014 18:25:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402191824260.8777@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42397 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583AbaBSSZH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Feb 2014 13:25:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, d-gerlach@ti.com


Just FYI.  Queued for v3.15 unless someone complains.

- Paul

---------- Forwarded message ----------
Date: Fri, 7 Feb 2014 16:20:59 -0600
From: Dave Gerlach <d-gerlach@ti.com>
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>,
    Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>,
    Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC PATCH] ARM: OMAP2+: clockdomain: Reintroduce SW_SLEEP Support

Since commit 65aa94b204d (ARM: OMAP4: clockdomain/CM code: Update supported
transition modes), on OMAP4, all CLKDMs support HW_AUTO so this is used
instead of SW_SLEEP for the idling of clockdomains. However, additional
SoCs now leverage the OMAP4 clockdomain code so update it to use SW_SLEEP
if the clockdomain data specifies that the CLKDM has the
CLKDM_CAN_FORCE_SLEEP flag set rather than using HW_AUTO for both cases.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 731ca13..f5c4731 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -254,6 +254,11 @@ void omap4_cminst_clkdm_force_wakeup(u8 part, u16 inst, u16 cdoffs)
  *
  */
 
+void omap4_cminst_clkdm_force_sleep(u8 part, u16 inst, u16 cdoffs)
+{
+	_clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_SLEEP, part, inst, cdoffs);
+}
+
 /**
  * omap4_cminst_wait_module_ready - wait for a module to be in 'func' state
  * @part: PRCM partition ID that the CM_CLKCTRL register exists in
@@ -404,8 +409,17 @@ static int omap4_clkdm_clear_all_wkup_sleep_deps(struct clockdomain *clkdm)
 
 static int omap4_clkdm_sleep(struct clockdomain *clkdm)
 {
-	omap4_cminst_clkdm_enable_hwsup(clkdm->prcm_partition,
-					clkdm->cm_inst, clkdm->clkdm_offs);
+	if (clkdm->flags & CLKDM_CAN_HWSUP)
+		omap4_cminst_clkdm_enable_hwsup(clkdm->prcm_partition,
+						clkdm->cm_inst,
+						clkdm->clkdm_offs);
+	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP)
+		omap4_cminst_clkdm_force_sleep(clkdm->prcm_partition,
+					       clkdm->cm_inst,
+					       clkdm->clkdm_offs);
+	else
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
1.7.9.5
