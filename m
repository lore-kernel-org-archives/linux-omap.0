From: Thomas Weber <weber@corscience.de>
Subject: [PATCH] OMAP2: powerdomain: Add break in switch statement
Date: Fri,  9 Jul 2010 09:40:53 +0200
Message-ID: <1278661253-22185-1-git-send-email-weber@corscience.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add a missing break at end of switch statement. At the moment it is a
fall through to WARN_ON(1) and return -EEXIST.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/powerdomain.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index a2904aa..6527ec3 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -875,6 +875,7 @@ int pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
 		break;
 	case 4:
 		m = OMAP_MEM4_RETSTATE_MASK;
+		break;
 	default:
 		WARN_ON(1); /* should never happen */
 		return -EEXIST;
-- 
1.7.1
