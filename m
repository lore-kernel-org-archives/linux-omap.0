From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 5/5] ARM: OMAP2+: pm33xx-core: Do not Turn OFF CEFUSE as PPA may be using it
Date: Fri, 29 Mar 2019 12:53:36 -0500
Message-ID: <20190329175336.19824-5-afd@ti.com>
References: <20190329175336.19824-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329175336.19824-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Kabir Sahane <x0153567@ti.com>

This area is used to store keys by HSPPA in case of AM438x SOC. Leave it
active.

Signed-off-by: Kabir Sahane <x0153567@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/mach-omap2/pm33xx-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index 724cf5774a6c..c93b6efd565f 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -51,10 +51,12 @@ static int amx3_common_init(void)
 
 	/* CEFUSE domain can be turned off post bootup */
 	cefuse_pwrdm = pwrdm_lookup("cefuse_pwrdm");
-	if (cefuse_pwrdm)
-		omap_set_pwrdm_state(cefuse_pwrdm, PWRDM_POWER_OFF);
-	else
+	if (!cefuse_pwrdm)
 		pr_err("PM: Failed to get cefuse_pwrdm\n");
+	else if (omap_type() != OMAP2_DEVICE_TYPE_GP)
+		pr_info("PM: Leaving EFUSE power domain active\n");
+	else
+		omap_set_pwrdm_state(cefuse_pwrdm, PWRDM_POWER_OFF);
 
 	return 0;
 }
-- 
2.21.0
