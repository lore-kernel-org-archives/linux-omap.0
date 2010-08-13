From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/6] omap3: id: fix 3630 rev detection
Date: Fri, 13 Aug 2010 11:01:46 +0300
Message-ID: <20100813080146.18750.38591.stgit@baageli.muru.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52135 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773Ab0HMIBz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 04:01:55 -0400
In-Reply-To: <20100813080034.18750.15410.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Sanjeev Premi <premi@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Manjunath K <manjugk@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Anand Gadiyar <gadiyar@ti.com>

From: Nishanth Menon <nm@ti.com>

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
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

