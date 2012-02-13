From: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: [PATCH] OMAP2 PM: do RCU locking for opp_get_voltage()
Date: Mon, 13 Feb 2012 09:44:04 +0100
Message-ID: <1329122644-7121-1-git-send-email-arnout@mind.be>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:53707
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238Ab2BMIoR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Feb 2012 03:44:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Thara Gopinath <thara@ti.com>, Russell King <linux@arm.linux.org.uk>, Philip Oberstaller <philip.oberstaller@septentrio.com>, "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>

From: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>

According to the documentation of opp_get_voltage(), it must be called
with rcu_read_lock() held.  The OMAP2 power manager doesn't do this.
The locking error is caught by PROVE_RCU.

Signed-off-by: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
---
Please CC me, I'm not on the list.

I was very surprised by this error, because this is the only user of
opp_get_voltage().

Regards,
Arnout
---
 arch/arm/mach-omap2/pm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 00bff46..bce2bdc 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -174,14 +174,17 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
 	freq = clk->rate;
 	clk_put(clk);
 
+	rcu_read_lock();
 	opp = opp_find_freq_ceil(dev, &freq);
 	if (IS_ERR(opp)) {
 		pr_err("%s: unable to find boot up OPP for vdd_%s\n",
 			__func__, vdd_name);
+		rcu_read_unlock();
 		goto exit;
 	}
 
 	bootup_volt = opp_get_voltage(opp);
+	rcu_read_unlock();
 	if (!bootup_volt) {
 		pr_err("%s: unable to find voltage corresponding "
 			"to the bootup OPP for vdd_%s\n", __func__, vdd_name);
-- 
1.7.8.3

