From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/4] 3430 clock: 3430 clock: enable SCM clock at boot
Date: Tue, 04 Dec 2007 02:26:06 -0700
Message-ID: <20071204092736.852326853@pwsan.com>
References: <20071204092605.831497615@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=3430_enable_omapctrl_on_init.patch
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

As we do with 24xx, enable the System Control Module iclk at boot.

Signed-off-by: Paul Walmsley <paul@pwsan.com>


---
 arch/arm/mach-omap2/clock34xx.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-omap/arch/arm/mach-omap2/clock34xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock34xx.h	2007-12-02 09:51:11.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/clock34xx.h	2007-12-02 09:51:40.000000000 -0700
@@ -1337,7 +1337,7 @@
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_OMAPCTRL_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP343X | ENABLE_ON_INIT,
 	.recalc		= &followparent_recalc,
 };
 

-- 
