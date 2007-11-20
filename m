From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: Enable OMAP3 SDRC clock on init.
Date: Tue, 20 Nov 2007 14:16:54 -0800
Message-ID: <1195597014-14054-1-git-send-email-khilman@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Enable sdrc_ick on init so it doesn't get disabled when
CONFIG_OMAP_RESET_CLOCKS=y

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/mach-omap2/clock34xx.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index b8132a1..a5321bb 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1101,7 +1101,7 @@ static struct clk sdrc_ick = {
 	.parent		= &core_l3_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_SDRC_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP343X | ENABLE_ON_INIT,
 	.recalc		= &followparent_recalc,
 };
 
-- 
1.5.3.5
