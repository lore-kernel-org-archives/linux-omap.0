From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH v2] arm: omap3: am35x: Don't mark missing features as present
Date: Mon, 30 Apr 2012 16:57:09 -0700
Message-ID: <1335830229-4700-1-git-send-email-mgreer@animalcreek.com>
References: <1334861927-1741-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:42490 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932076Ab2D3X5d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 19:57:33 -0400
In-Reply-To: <1334861927-1741-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, paul@pwsan.com, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

The Chip Identification register on the am35x family of SoCs
has bits 12, 7:5, and 3:2 marked as reserved and are read as
zeroes.  Unfortunately, on other omap SoCs, a 0 bit means a
feature is "Full Use" so the OMAP3_CHECK_FEATURE() macro
called by omap3_check_features() will incorrectly interpret
those zeroes to mean that a feature is present even though it
isn't.  To fix that, the feature bits that are incorrectly
set (namely, OMAP3_HAS_IVA and OMAP3_HAS_ISP) need to be
cleared after all of the calls to OMAP3_CHECK_FEATURE() in
omap3_check_features() are made.

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/id.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index d2913e2..20c95b4 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -247,6 +247,17 @@ void __init omap3xxx_check_features(void)
 	omap_features |= OMAP3_HAS_SDRC;
 
 	/*
+	 * am35x fixups:
+	 * - The am35x Chip ID register has bits 12, 7:5, and 3:2 marked as
+	 *   reserved and therefore return 0 when read.  Unfortunately,
+	 *   OMAP3_CHECK_FEATURE() will interpret some of those zeroes to
+	 *   mean that a feature is present even though it isn't so clear
+	 *   the incorrectly set feature bits.
+	 */
+	if (cpu_is_am35xx())
+		omap_features &= ~(OMAP3_HAS_IVA | OMAP3_HAS_ISP);
+
+	/*
 	 * TODO: Get additional info (where applicable)
 	 *       e.g. Size of L2 cache.
 	 */
-- 
1.7.9.4

