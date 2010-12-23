From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 1/4] OMAP4: hwmod data: Fix missing SIDLE_SMART_WKUP in smartreflex sysc
Date: Thu, 23 Dec 2010 23:30:29 +0100
Message-ID: <1293143432-9891-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43579 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751468Ab0LWWan (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Dec 2010 17:30:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

Add the missing SIDLE_SMART_WKUP flag in idlemodes field of
the smartreflex sysconfig structure.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index e2ad1b6..3e9015a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1857,7 +1857,8 @@ static struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_smartreflex = {
 static struct omap_hwmod_class_sysconfig omap44xx_smartreflex_sysc = {
 	.sysc_offs	= 0x0038,
 	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
 	.sysc_fields	= &omap_hwmod_sysc_type_smartreflex,
 };
 
-- 
1.7.0.4

