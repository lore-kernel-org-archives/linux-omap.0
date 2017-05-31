From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/11] ARM: OMAP2+: Remove unused legacy code for watchdog
Date: Wed, 31 May 2017 15:51:38 -0700
Message-ID: <20170531225139.30723-11-tony@atomide.com>
References: <20170531225139.30723-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170531225139.30723-1-tony@atomide.com>
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
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We are now booting all mach-omap2 in device tree only mode.
Any code that is only called in legacy boot mode where
of_have_populated_dt() is not set is safe to remove now.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/wd_timer.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm/mach-omap2/wd_timer.c b/arch/arm/mach-omap2/wd_timer.c
--- a/arch/arm/mach-omap2/wd_timer.c
+++ b/arch/arm/mach-omap2/wd_timer.c
@@ -102,31 +102,3 @@ int omap2_wd_timer_reset(struct omap_hwmod *oh)
 	return (c == MAX_MODULE_SOFTRESET_WAIT) ? -ETIMEDOUT :
 		omap2_wd_timer_disable(oh);
 }
-
-static int __init omap_init_wdt(void)
-{
-	int id = -1;
-	struct platform_device *pdev;
-	struct omap_hwmod *oh;
-	char *oh_name = "wd_timer2";
-	char *dev_name = "omap_wdt";
-	struct omap_wd_timer_platform_data pdata;
-
-	if (!cpu_class_is_omap2() || of_have_populated_dt())
-		return 0;
-
-	oh = omap_hwmod_lookup(oh_name);
-	if (!oh) {
-		pr_err("Could not look up wd_timer%d hwmod\n", id);
-		return -EINVAL;
-	}
-
-	pdata.read_reset_sources = prm_read_reset_sources;
-
-	pdev = omap_device_build(dev_name, id, oh, &pdata,
-				 sizeof(struct omap_wd_timer_platform_data));
-	WARN(IS_ERR(pdev), "Can't build omap_device for %s:%s.\n",
-	     dev_name, oh->name);
-	return 0;
-}
-omap_subsys_initcall(omap_init_wdt);
-- 
2.13.0
