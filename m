From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] ARM: OMAP2+: Remove unneeded semicolons
Date: Thu, 17 Sep 2015 15:38:05 +0200
Message-ID: <1442497085-31476-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Remove the unneded semicolons since they are clearly a typo error.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/mach-omap2/pm44xx.c                | 2 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index d697cecf762b..178e22c146b7 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -210,7 +210,7 @@ static inline int omap4plus_init_static_deps(const struct static_dep_map *map)
 		}
 
 		map++;
-	};
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index d31c495175c1..2e00c7f1f471 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -582,7 +582,7 @@ void __init omap3xxx_powerdomains_init(void)
 
 	/* Only 81xx needs custom pwrdm_operations */
 	if (!cpu_is_ti81xx())
-		pwrdm_register_platform_funcs(&omap3_pwrdm_operations);;
+		pwrdm_register_platform_funcs(&omap3_pwrdm_operations);
 
 	rev = omap_rev();
 
-- 
2.4.3
