From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 12/22] omap2 clock: vlynq_fck is missing clksel divider code
Date: Thu, 02 Aug 2007 12:10:14 -0600
Message-ID: <20070802181142.674723905@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=fix-up-vlynq-core-clock.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

vlynq_fck is a clksel clock.  But omap2_clk_set_parent() is missing
the code to divide its parent's rate down appropriately when vlynq_fck
is set to use a core_ck parent.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -823,7 +823,7 @@ static u32 omap2_get_src_field(u32 *type
 			if (src_clk == &func_96m_ck)
 				val = 0;
 			else if (src_clk == &core_ck)
-				val = 0x10;
+				val = 0x10;             /* rate needs fixing */
 		}
 		break;
 	case CM_CORE_SEL2:
@@ -934,7 +934,8 @@ static int omap2_clk_set_parent(struct c
 		clk->parent = new_parent;
 
 		/* SRC_RATE_SEL_MASK clocks follow their parents rates.*/
-		if ((new_parent == &core_ck) && (clk == &dss1_fck))
+		if ((new_parent == &core_ck) &&
+		    (clk == &dss1_fck || clk == &vlynq_fck))
 			clk->rate = new_parent->rate / 0x10;
 		else
 			clk->rate = new_parent->rate;

-- 
