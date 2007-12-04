From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/4] 3430 clock: Add missing ICR clock
Date: Tue, 04 Dec 2007 02:26:08 -0700
Message-ID: <20071204092737.064644136@pwsan.com>
References: <20071204092605.831497615@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=3430_add_icr_clock.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Add the 3430 clock for the ICR.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock34xx.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: linux-omap/arch/arm/mach-omap2/clock34xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock34xx.h	2007-12-04 01:55:14.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/clock34xx.h	2007-12-04 01:55:58.000000000 -0700
@@ -1125,6 +1125,16 @@
 	.recalc		= &followparent_recalc,
 };
 
+/* Intersystem Communication Registers - chassis mode only */
+static struct clk icr_ick = {
+	.name		= "icr_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_ICR_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk aes2_ick = {
 	.name		= "aes2_ick",
 	.parent		= &core_l4_ick,
@@ -2265,6 +2275,7 @@
 	&security_l3_ick,
 	&pka_ick,
 	&core_l4_ick,
+	&icr_ick,
 	&aes2_ick,
 	&sha12_ick,
 	&des2_ick,

-- 
