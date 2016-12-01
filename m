From: Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH v2] mach-omap2: fixing wrong strcat for Non-NULL terminated
 string
Date: Thu, 01 Dec 2016 16:28:33 +0530
Message-ID: <1480589913-8839-1-git-send-email-maninder1.s@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com, linux@armlinux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, ajeet.y@samsung.com, pankaj.m@samsung.com, Maninder Singh <maninder1.s@samsung.com>, Vaneet Narang <v.narang@samsung.com>
List-Id: linux-omap@vger.kernel.org

variable name can have Non NULL terminated string after cropping
which may result strcat to fail, and cropping is not
required if (strlen(oh->name) + 8 < MOD_CLK_MAX_NAME_LEN).

Issue caught with static analysis tool:
"Dangerous usage of 'name' (strncpy doesn't always 0-terminate it)"

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
v1 -> v2: changed strncpy to strlcpy
 arch/arm/mach-omap2/omap_hwmod.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 759e1d4..582b95a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -742,12 +742,14 @@ static int _init_main_clk(struct omap_hwmod *oh)
 	char name[MOD_CLK_MAX_NAME_LEN];
 	struct clk *clk;
 
-	/* +7 magic comes from '_mod_ck' suffix */
-	if (strlen(oh->name) + 7 > MOD_CLK_MAX_NAME_LEN)
+	/* +8 magic comes from strlen("_mod_ck") added as suffix */
+	if (strlen(oh->name) + 8 > MOD_CLK_MAX_NAME_LEN) {
 		pr_warn("%s: warning: cropping name for %s\n", __func__,
 			oh->name);
+		strlcpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - 7);
+	} else
+		strcpy(name, oh->name);
 
-	strncpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - 7);
 	strcat(name, "_mod_ck");
 
 	clk = clk_get(NULL, name);
-- 
1.9.1
