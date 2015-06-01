From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv4 07/10] ARM: OMAP2+: display: detect DRA7 DSS
Date: Mon, 1 Jun 2015 09:23:15 +0300
Message-ID: <1433139798-23450-8-git-send-email-tomi.valkeinen@ti.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57675 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753155AbbFAGYI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 02:24:08 -0400
In-Reply-To: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add platform code to detect DRA7 DSS.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 9868d0bc7805..6ab13d18c636 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -287,6 +287,8 @@ static enum omapdss_version __init omap_display_get_version(void)
 		return OMAPDSS_VER_OMAP5;
 	else if (soc_is_am43xx())
 		return OMAPDSS_VER_AM43xx;
+	else if (soc_is_dra7xx())
+		return OMAPDSS_VER_DRA7xx;
 	else
 		return OMAPDSS_VER_UNKNOWN;
 }
@@ -573,6 +575,7 @@ static const char * const omapdss_compat_names[] __initconst = {
 	"ti,omap3-dss",
 	"ti,omap4-dss",
 	"ti,omap5-dss",
+	"ti,dra7-dss",
 };
 
 struct device_node * __init omapdss_find_dss_of_node(void)
-- 
2.1.4

