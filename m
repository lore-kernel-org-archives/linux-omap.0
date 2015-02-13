From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/9] ARM: OMAP: display: change compat names to array
Date: Fri, 13 Feb 2015 17:11:21 +0200
Message-ID: <1423840286-18377-5-git-send-email-tomi.valkeinen@ti.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43936 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963AbbBMPMi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 10:12:38 -0500
In-Reply-To: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Simplify the DSS detection logic by creating a list of the omapdss
compat strings, instead of checking each separately with an 'if'.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 7a050f9c37ff..156d022b1e09 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -562,25 +562,24 @@ void __init omapdss_early_init_of(void)
 
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
2.3.0

