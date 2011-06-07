From: Nishanth Menon <nm@ti.com>
Subject: [pm-wip/voltdm_nm][PATCH 09/10] OMAP2+: PM: secure OPP access using rcu locks
Date: Mon,  6 Jun 2011 21:16:12 -0500
Message-ID: <1307412972-25854-10-git-send-email-nm@ti.com>
References: <1307412972-25854-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:51904 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756861Ab1FGCQs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 22:16:48 -0400
Received: by gwaa12 with SMTP id a12so2043069gwa.14
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 19:16:47 -0700 (PDT)
In-Reply-To: <1307412972-25854-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

OPP functions as described in Documentation/power/opp.txt
should be accessed under rcu_locks.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/pm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index d085f29..7355347 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -198,14 +198,17 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
 	freq = clk->rate;
 	clk_put(clk);
 
+	rcu_read_lock();
 	opp = opp_find_freq_ceil(dev, &freq);
 	if (IS_ERR(opp)) {
+		rcu_read_unlock();
 		printk(KERN_ERR "%s: unable to find boot up OPP for vdd_%s\n",
 			__func__, vdd_name);
 		goto exit;
 	}
 
 	bootup_volt = opp_get_voltage(opp);
+	rcu_read_unlock();
 	if (!bootup_volt) {
 		printk(KERN_ERR "%s: unable to find voltage corresponding"
 			"to the bootup OPP for vdd_%s\n", __func__, vdd_name);
-- 
1.7.1

