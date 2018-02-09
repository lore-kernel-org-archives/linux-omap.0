From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Use v7_invalidate_l1 in omap4_finish_suspend
Date: Fri,  9 Feb 2018 09:40:19 -0800
Message-ID: <20180209174019.30069-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

We can use just v7_invalidate_l1 here instead of v7_flush_dcache_all
like the comments say.

Cc: Tero Kristo <t-kristo@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/sleep44xx.S | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
--- a/arch/arm/mach-omap2/sleep44xx.S
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -90,12 +90,7 @@ skip_secure_l1_clean:
 	mcr	p15, 0, r0, c1, c0, 0
 	isb
 
-	/*
-	 * Invalidate L1 data cache. Even though only invalidate is
-	 * necessary exported flush API is used here. Doing clean
-	 * on already clean cache would be almost NOP.
-	 */
-	bl	v7_flush_dcache_all
+	bl	v7_invalidate_l1
 
 	/*
 	 * Switch the CPU from Symmetric Multiprocessing (SMP) mode
-- 
2.16.1
