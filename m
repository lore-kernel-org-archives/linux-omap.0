From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/9] ARM: OMAP2+: display: detect DRA7 DSS
Date: Fri, 13 Feb 2015 17:11:22 +0200
Message-ID: <1423840286-18377-6-git-send-email-tomi.valkeinen@ti.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41987 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753033AbbBMPMm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 10:12:42 -0500
In-Reply-To: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add platform code to detect DRA7 DSS.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 156d022b1e09..7f596fe2bfeb 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -281,6 +281,8 @@ static enum omapdss_version __init omap_display_get_version(void)
 		return OMAPDSS_VER_OMAP5;
 	else if (soc_is_am43xx())
 		return OMAPDSS_VER_AM43xx;
+	else if (soc_is_dra7xx())
+		return OMAPDSS_VER_DRA7xx;
 	else
 		return OMAPDSS_VER_UNKNOWN;
 }
@@ -567,6 +569,7 @@ static const char * const omapdss_compat_names[] __initconst = {
 	"ti,omap3-dss",
 	"ti,omap4-dss",
 	"ti,omap5-dss",
+	"ti,dra7-dss",
 };
 
 struct device_node * __init omapdss_find_dss_of_node(void)
-- 
2.3.0

