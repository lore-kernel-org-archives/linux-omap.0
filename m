From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 8/8] ARM: OMAP2+: Create dummy platform_device for pm33xx
Date: Tue, 28 Mar 2017 20:58:01 -0500
Message-ID: <20170329015801.22240-9-d-gerlach@ti.com>
References: <20170329015801.22240-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170329015801.22240-1-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Keerthy J <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Add amx3_common_pm_init to create a dummy platform_device for
pm33xx so that our pm33xx module can probe and am335x and am437x
platforms to enable basic suspend to mem and standby support.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/common.h      |  7 +++++++
 arch/arm/mach-omap2/io.c          |  2 ++
 arch/arm/mach-omap2/pm33xx-core.c | 12 ++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index c4f2ace91ea2..21fe3e44b125 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -77,6 +77,13 @@ static inline int omap4_pm_init_early(void)
 }
 #endif
 
+#if defined(CONFIG_PM) && (defined(CONFIG_SOC_AM33XX) || \
+	defined(CONFIG_SOC_AM43XX))
+void amx3_common_pm_init(void);
+#else
+static inline void amx3_common_pm_init(void) { }
+#endif
+
 extern void omap2_init_common_infrastructure(void);
 
 extern void omap_init_time(void);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 5aafb8449c40..1bbbf19c93ea 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -652,6 +652,7 @@ void __init am33xx_init_early(void)
 void __init am33xx_init_late(void)
 {
 	omap_common_late_init();
+	amx3_common_pm_init();
 }
 #endif
 
@@ -676,6 +677,7 @@ void __init am43xx_init_late(void)
 {
 	omap_common_late_init();
 	omap2_clk_enable_autoidle_all();
+	amx3_common_pm_init();
 }
 #endif
 
diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index c84ffc4de2e9..b5d90841c27a 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -179,3 +179,15 @@ struct am33xx_pm_platform_data *am33xx_pm_get_pdata(void)
 	else
 		return NULL;
 }
+
+void __init amx3_common_pm_init(void)
+{
+	struct platform_device_info devinfo = { };
+	struct am33xx_pm_platform_data *pdata;
+
+	pdata = am33xx_pm_get_pdata();
+	devinfo.name = "pm33xx";
+	devinfo.data = pdata;
+	devinfo.size_data = sizeof(*pdata);
+	platform_device_register_full(&devinfo);
+}
-- 
2.11.0
