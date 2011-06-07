From: Nishanth Menon <nm@ti.com>
Subject: [pm-wip/cpufreq][PATCH 3/3] OMAP2+: cpufreq: do lateinit
Date: Mon,  6 Jun 2011 21:05:30 -0500
Message-ID: <1307412330-25798-4-git-send-email-nm@ti.com>
References: <1307412330-25798-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:57191 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756383Ab1FGCGM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 22:06:12 -0400
Received: by gwb20 with SMTP id 20so2198394gwb.31
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 19:06:05 -0700 (PDT)
In-Reply-To: <1307412330-25798-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Since we do module_init, cpufreq initializes before power late_init
where many of the required data structures are registered. Move
cpufreq init to late_initcall instead. Further CONFIG_CPU_FREQ
on which the build depends is bool and does'nt support modules yet.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 2177381..07c2ab9 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -273,5 +273,5 @@ static void __exit omap_cpufreq_exit(void)
 
 MODULE_DESCRIPTION("cpufreq driver for OMAP2PLUS SOCs");
 MODULE_LICENSE("GPL");
-module_init(omap_cpufreq_init);
+late_initcall(omap_cpufreq_init);
 module_exit(omap_cpufreq_exit);
-- 
1.7.1

