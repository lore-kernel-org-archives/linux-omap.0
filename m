From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv4 06/10] ARM: OMAP: display: change compat names to array
Date: Mon, 1 Jun 2015 09:23:14 +0300
Message-ID: <1433139798-23450-7-git-send-email-tomi.valkeinen@ti.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57670 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758769AbbFAGYE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 02:24:04 -0400
In-Reply-To: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Simplify the DSS detection logic by creating a list of the omapdss
compat strings, instead of checking each separately with an 'if'.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index f492ae147c6a..9868d0bc7805 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -568,25 +568,24 @@ void __init omapdss_early_init_of(void)
 
 }
 
+static const char * const omapdss_compat_names[] __initconst = {
+	"ti,omap2-dss",
+	"ti,omap3-dss",
+	"ti,omap4-dss",
+	"ti,omap5-dss",
+};
+
 struct device_node * __init omapdss_find_dss_of_node(void)
 {
 	struct device_node *node;
+	int i;
 
-	node = of_find_compatible_node(NULL, NULL, "ti,omap2-dss");
-	if (node)
-		return node;
-
-	node = of_find_compatible_node(NULL, NULL, "ti,omap3-dss");
-	if (node)
-		return node;
-
-	node = of_find_compatible_node(NULL, NULL, "ti,omap4-dss");
-	if (node)
-		return node;
-
-	node = of_find_compatible_node(NULL, NULL, "ti,omap5-dss");
-	if (node)
-		return node;
+	for (i = 0; i < ARRAY_SIZE(omapdss_compat_names); ++i) {
+		node = of_find_compatible_node(NULL, NULL,
+			omapdss_compat_names[i]);
+		if (node)
+			return node;
+	}
 
 	return NULL;
 }
-- 
2.1.4

