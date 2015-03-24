From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 04/10] ARM: OMAP: display: change compat names to array
Date: Tue, 24 Mar 2015 16:55:04 +0200
Message-ID: <1427208910-17678-5-git-send-email-tomi.valkeinen@ti.com>
References: <1427208910-17678-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42389 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbbCXO4E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2015 10:56:04 -0400
In-Reply-To: <1427208910-17678-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

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
2.3.3

