From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/4] ARM: OMAP4+: PM: erratum is used by OMAP5 and DRA7 as well
Date: Wed, 9 Sep 2015 16:18:11 -0500
Message-ID: <1441833494-32450-2-git-send-email-nm@ti.com>
References: <1441833494-32450-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1441833494-32450-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

OMAP5 and DRA7 reuse the same pm44xx_erratum variable so, enable the
same, else PM features such as Suspend to ram is broken in a SoC only
build configuration.

Reported-by: Carlos Hernandez <ceh@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/pm.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 425bfcd67db6..f5bae699baac 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -103,7 +103,8 @@ static inline void enable_omap3630_toggle_l2_on_restore(void) { }
 #define PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD	(1 << 0)
 #define PM_OMAP4_CPU_OSWR_DISABLE		(1 << 1)
 
-#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_PM) && (defined(CONFIG_ARCH_OMAP4) ||\
+	   defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX))
 extern u16 pm44xx_errata;
 #define IS_PM44XX_ERRATUM(id)		(pm44xx_errata & (id))
 #else
-- 
1.7.9.5
