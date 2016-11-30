From: Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] mach-omap2: fixing wrong strcat for Non-NULL terminated
 string
Date: Wed, 30 Nov 2016 16:10:28 +0530
Message-ID: <1480502428-19509-1-git-send-email-maninder1.s@samsung.com>
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
 arch/arm/mach-omap2/omap_hwmod.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 759e1d4..8adf272 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -742,12 +742,15 @@ static int _init_main_clk(struct omap_hwmod *oh)
 	char name[MOD_CLK_MAX_NAME_LEN];
 	struct clk *clk;
 
-	/* +7 magic comes from '_mod_ck' suffix */
-	if (strlen(oh->name) + 7 > MOD_CLK_MAX_NAME_LEN)
+	/* +8 magic comes from strlen("_mod_ck") added as suffix */
+	if (strlen(oh->name) + 8 > MOD_CLK_MAX_NAME_LEN) {
 		pr_warn("%s: warning: cropping name for %s\n", __func__,
 			oh->name);
+		strncpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - 8);
+		name[MOD_CLK_MAX_NAME_LEN - 8] = '\0';
+	} else
+		strcpy(name, oh->name);
 
-	strncpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - 7);
 	strcat(name, "_mod_ck");
 
 	clk = clk_get(NULL, name);
-- 
1.9.1
