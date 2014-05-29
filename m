From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: DRA722: add detection of SoC information.
Date: Thu, 29 May 2014 14:05:50 -0500
Message-ID: <1401390350-10048-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33794 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753531AbaE2TG0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 May 2014 15:06:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>

Add support for DRA72x device DIEID. Currently these devices are
reported as DRA75/74 family of processors.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 (test using linux-next next-20140529 tag):
 before: http://slexy.org/raw/s21Yb8sOhy
 after:  http://slexy.org/raw/s20Nx96NrY

 Applies on:
 git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git 
 branch: omap-for-v3.16/soc

 arch/arm/mach-omap2/id.c  |   12 ++++++++++++
 arch/arm/mach-omap2/soc.h |    1 +
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 71bf216..801244a 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -649,6 +649,18 @@ void __init dra7xxx_check_revision(void)
 		}
 		break;
 
+	case 0xb9bc:
+		switch (rev) {
+		case 0:
+			omap_revision = DRA722_REV_ES1_0;
+			break;
+		default:
+			/* If we have no new revisions */
+			omap_revision = DRA722_REV_ES1_0;
+			break;
+		}
+		break;
+
 	default:
 		/* Unknown default to latest silicon rev as default*/
 		pr_warn("%s: unknown idcode=0x%08x (hawkeye=0x%08x,rev=0x%d)\n",
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index de2a34c..01ca808 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -462,6 +462,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define DRA7XX_CLASS		0x07000000
 #define DRA752_REV_ES1_0	(DRA7XX_CLASS | (0x52 << 16) | (0x10 << 8))
 #define DRA752_REV_ES1_1	(DRA7XX_CLASS | (0x52 << 16) | (0x11 << 8))
+#define DRA722_REV_ES1_0	(DRA7XX_CLASS | (0x22 << 16) | (0x10 << 8))
 
 void omap2xxx_check_revision(void);
 void omap3xxx_check_revision(void);
-- 
1.7.9.5

