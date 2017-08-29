From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/5] ARM: OMAP2+: Drop unused omap_init_hdq
Date: Tue, 29 Aug 2017 10:03:34 -0700
Message-ID: <20170829170335.11536-5-tony@atomide.com>
References: <20170829170335.11536-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170829170335.11536-1-tony@atomide.com>
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
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We now boot all of mach-omap2 in device tree only mode and
this is now dead code.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/hdq1w.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm/mach-omap2/hdq1w.c b/arch/arm/mach-omap2/hdq1w.c
--- a/arch/arm/mach-omap2/hdq1w.c
+++ b/arch/arm/mach-omap2/hdq1w.c
@@ -75,25 +75,3 @@ int omap_hdq1w_reset(struct omap_hwmod *oh)
 
 	return 0;
 }
-
-#ifndef CONFIG_OF
-static int __init omap_init_hdq(void)
-{
-	int id = -1;
-	struct platform_device *pdev;
-	struct omap_hwmod *oh;
-	char *oh_name = "hdq1w";
-	char *devname = "omap_hdq";
-
-	oh = omap_hwmod_lookup(oh_name);
-	if (!oh)
-		return 0;
-
-	pdev = omap_device_build(devname, id, oh, NULL, 0);
-	WARN(IS_ERR(pdev), "Can't build omap_device for %s:%s.\n",
-	     devname, oh->name);
-
-	return 0;
-}
-omap_arch_initcall(omap_init_hdq);
-#endif
-- 
2.14.1
