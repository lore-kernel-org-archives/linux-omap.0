From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] omap3: id: fix 3630 rev detection
Date: Thu,  5 Aug 2010 07:17:16 -0500
Message-ID: <1281010636-24796-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53221 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759179Ab0HEMR3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Aug 2010 08:17:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Sanjeev Premi <premi@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Manjunath K <manjugk@ti.com>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

Wrong placement of break causes all revisions of 3630 to be
detected as 3630 es1.2, we need to break main loop if we have
an identified chip, default falls through as in the rest of the
switches in this function.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Manjunath K <manjugk@ti.com>
Cc: Anand Gadiyar <gadiyar@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/id.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index e8256a2..9a879f9 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -284,8 +284,8 @@ static void __init omap3_check_revision(void)
 		default:
 			omap_revision =  OMAP3630_REV_ES1_2;
 			omap_chip.oc |= CHIP_IS_OMAP3630ES1_2;
-			break;
 		}
+		break;
 	default:
 		/* Unknown default to latest silicon rev as default*/
 		omap_revision =  OMAP3630_REV_ES1_2;
-- 
1.6.3.3

