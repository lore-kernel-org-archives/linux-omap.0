From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 3/6] OMAP3: id: use explicit omap_revision codes for
	3505/3517 ES levels
Date: Wed, 14 Sep 2011 06:39:31 -0600
Message-ID: <20110914123928.25282.21878.stgit@dusk>
References: <20110914123708.25282.78122.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37241 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932412Ab1INMmZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 08:42:25 -0400
In-Reply-To: <20110914123708.25282.78122.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sanjeev Premi <premi@ti.com>

Use explicit revision codes for OMAP/AM 3505/3517 ES levels, as the rest
of the OMAP2+ SoCs do in mach-omap2/cpu.c.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/id.c              |   10 +++++++++-
 arch/arm/plat-omap/include/plat/cpu.h |    3 ++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 46bc2f9..6810c52 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -312,7 +312,15 @@ static void __init omap3_check_revision(void)
 		 *
 		 * REVISIT: AM3505/AM3517 should have their own CHIP_IS
 		 */
-		omap_revision = OMAP3517_REV(rev);
+		switch (rev) {
+		case 0:
+			omap_revision = OMAP3517_REV_ES1_0;
+			break;
+		case 1:
+		/* FALLTHROUGH */
+		default:
+			omap_revision = OMAP3517_REV_ES1_1;
+		}
 		omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
 		break;
 	case 0xb891:
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 34df171..1debee9 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -399,7 +399,8 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP3630_REV_ES1_2	(OMAP363X_CLASS | (OMAP_REVBITS_02 << 8))
 
 #define OMAP3517_CLASS		0x35170034
-#define OMAP3517_REV(v)		(OMAP3517_CLASS | (v << 8))
+#define OMAP3517_REV_ES1_0	OMAP3517_CLASS
+#define OMAP3517_REV_ES1_1	(OMAP3517_CLASS | (OMAP_REVBITS_01 << 8))
 
 #define TI816X_CLASS		0x81600034
 #define TI8168_REV_ES1_0	TI816X_CLASS


