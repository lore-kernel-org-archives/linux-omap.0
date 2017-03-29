From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 3/8] ARM: OMAP2+: pm: Remove __init from omap_pm_clkdms_setup
Date: Tue, 28 Mar 2017 20:57:56 -0500
Message-ID: <20170329015801.22240-4-d-gerlach@ti.com>
References: <20170329015801.22240-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170329015801.22240-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

omap_pm_clkdms_setup gets called from pm init functions and now that
pm33xx and pm43xx can be loaded as modules this must be kept to be
called at any point during runtime.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 0598630c1778..486d3179af07 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -71,7 +71,7 @@ void omap_pm_get_oscillator(u32 *tstart, u32 *tshut)
 }
 #endif
 
-int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
+int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
 	clkdm_allow_idle(clkdm);
 	return 0;
-- 
2.11.0
