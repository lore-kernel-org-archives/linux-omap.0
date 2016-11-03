From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv2] ARM: OMAP3: Fix formatting of features printed
Date: Thu,  3 Nov 2016 10:34:39 -0700
Message-ID: <20161103173439.20657-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With the printk cleanups merged into v4.9-rc1, we now get the omap
revision printed on multiple lines. Let's fix that and also remove the
extra empty space at the end of the features. And let's update things
to use scnprintf as suggested by Ivaylo Dimitrov
<ivo.g.dimitrov.75@gmail.com>.

Reported-by: Adam Ford <aford173@gmail.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -205,11 +205,15 @@ void __init omap2xxx_check_revision(void)
 
 #define OMAP3_SHOW_FEATURE(feat)		\
 	if (omap3_has_ ##feat())		\
-		printk(#feat" ");
+		n += scnprintf(buf + n, sizeof(buf) - n, #feat " ");
 
 static void __init omap3_cpuinfo(void)
 {
 	const char *cpu_name;
+	char buf[64];
+	int n = 0;
+
+	memset(buf, 0, sizeof(buf));
 
 	/*
 	 * OMAP3430 and OMAP3530 are assumed to be same.
@@ -241,10 +245,10 @@ static void __init omap3_cpuinfo(void)
 		cpu_name = "OMAP3503";
 	}
 
-	sprintf(soc_name, "%s", cpu_name);
+	scnprintf(soc_name, sizeof(soc_name), "%s", cpu_name);
 
 	/* Print verbose information */
-	pr_info("%s %s (", soc_name, soc_rev);
+	n += scnprintf(buf, sizeof(buf) - n, "%s %s (", soc_name, soc_rev);
 
 	OMAP3_SHOW_FEATURE(l2cache);
 	OMAP3_SHOW_FEATURE(iva);
@@ -252,8 +256,10 @@ static void __init omap3_cpuinfo(void)
 	OMAP3_SHOW_FEATURE(neon);
 	OMAP3_SHOW_FEATURE(isp);
 	OMAP3_SHOW_FEATURE(192mhz_clk);
-
-	printk(")\n");
+	if (*(buf + n - 1) == ' ')
+		n--;
+	n += scnprintf(buf + n, sizeof(buf) - n, ")\n");
+	pr_info("%s", buf);
 }
 
 #define OMAP3_CHECK_FEATURE(status,feat)				\
-- 
2.10.2
