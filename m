From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH] ARM: OMAP4: PM: Keep static dep between MPUSS and ABE clockdomain
Date: Tue, 15 May 2012 17:12:36 +0530
Message-ID: <1337082156-30390-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

Commit 68523f4233de5f233478dde0a63047b4efb710b8 (ARM: OMAP4:
Workaround the OCP synchronisation issue with 32K synctimer)
does not include GP Timers in ABE domain. Since synchronization
issue is applicable to all GPTIMER[1-12], we also need to set
static dependency of MPUSS with abe_clkdm and l4_per_clkdm.
Dependency with l4_per_clkdm timers is already set in commit
12f27826bdaf56b01cbdfc8bdeb577ebc106dee3 (ARM: OMAP4: PM: Keep
static dep between MPUSS-EMIF and MPUSS-L3/L4 and DUCATI-L3).
Therefore, set static dependency of MPUSS with abe_clkdm.

Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 8856253..f788e98 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -146,6 +146,7 @@ static int __init omap4_pm_init(void)
 	int ret;
 	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm, *l4wkup;
 	struct clockdomain *ducati_clkdm, *l3_2_clkdm, *l4_per_clkdm;
+	struct clockdomain *abe_clkdm;
 
 	if (!cpu_is_omap44xx())
 		return -ENODEV;
@@ -180,8 +181,10 @@ static int __init omap4_pm_init(void)
 	l4_per_clkdm = clkdm_lookup("l4_per_clkdm");
 	l4wkup = clkdm_lookup("l4_wkup_clkdm");
 	ducati_clkdm = clkdm_lookup("ducati_clkdm");
+	abe_clkdm = clkdm_lookup("abe_clkdm");
 	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) || (!l4wkup) ||
-		(!l3_2_clkdm) || (!ducati_clkdm) || (!l4_per_clkdm))
+		(!l3_2_clkdm) || (!ducati_clkdm) || (!l4_per_clkdm) ||
+		(!abe_clkdm))
 		goto err2;
 
 	ret = clkdm_add_wkdep(mpuss_clkdm, emif_clkdm);
@@ -191,6 +194,7 @@ static int __init omap4_pm_init(void)
 	ret |= clkdm_add_wkdep(mpuss_clkdm, l4wkup);
 	ret |= clkdm_add_wkdep(ducati_clkdm, l3_1_clkdm);
 	ret |= clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);
+	ret |= clkdm_add_wkdep(mpuss_clkdm, abe_clkdm);
 	if (ret) {
 		pr_err("Failed to add MPUSS -> L3/EMIF/L4PER, DUCATI -> L3 "
 				"wakeup dependency\n");
-- 
1.7.0.4
