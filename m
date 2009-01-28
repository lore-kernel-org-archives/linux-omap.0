From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/9] ARM: OMAP: Fix omap34xx revision detection for ES3.1
Date: Wed, 28 Jan 2009 10:28:16 -0800
Message-ID: <20090128182816.21007.94947.stgit@localhost>
References: <20090128181931.21007.73744.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58639 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbZA1S2V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 13:28:21 -0500
In-Reply-To: <20090128181931.21007.73744.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Fix omap34xx revision detection for ES3.1

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c              |    6 +++++-
 arch/arm/plat-omap/include/mach/cpu.h |    1 +
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index b0f8e7d..b52a02f 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -172,9 +172,13 @@ void __init omap34xx_check_revision(void)
 			omap_revision = OMAP3430_REV_ES3_0;
 			rev_name = "ES3.0";
 			break;
+		case 4:
+			omap_revision = OMAP3430_REV_ES3_1;
+			rev_name = "ES3.1";
+			break;
 		default:
 			/* Use the latest known revision as default */
-			omap_revision = OMAP3430_REV_ES3_0;
+			omap_revision = OMAP3430_REV_ES3_1;
 			rev_name = "Unknown revision\n";
 		}
 	}
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index b2062f1..a8e1178 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -339,6 +339,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define OMAP3430_REV_ES2_0	0x34301034
 #define OMAP3430_REV_ES2_1	0x34302034
 #define OMAP3430_REV_ES3_0	0x34303034
+#define OMAP3430_REV_ES3_1	0x34304034
 
 /*
  * omap_chip bits

