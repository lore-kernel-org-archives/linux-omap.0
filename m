From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: 2430 PM: emul_ck is only available on 242x
Date: Tue,  5 Jun 2007 18:00:31 -0700
Message-ID: <1181091633807-git-send-email-khilman@mvista.com>
References: <11810916331121-git-send-email-khilman@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11810916331121-git-send-email-khilman@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

omap2_pm_init: on 2430,  don't fail if emul_ck is not available.  It
is only available on 2420

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/mach-omap2/pm.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index a1655c2..974fdc5 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -783,11 +783,13 @@ int __init omap2_pm_init(void)
 		return -ENODEV;
 	}
 
-	emul_ck = clk_get(NULL, "emul_ck");
-	if (IS_ERR(emul_ck)) {
-		printk(KERN_ERR "could not get emul_ck\n");
-		clk_put(osc_ck);
-		return -ENODEV;
+	if (cpu_is_omap242x()) {
+		emul_ck = clk_get(NULL, "emul_ck");
+		if (IS_ERR(emul_ck)) {
+			printk(KERN_ERR "could not get emul_ck\n");
+			clk_put(osc_ck);
+			return -ENODEV;
+		}
 	}
 
 	prcm_setup_regs();
-- 
1.5.2
