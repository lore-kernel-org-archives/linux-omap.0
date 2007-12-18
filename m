From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] ARM: OMAP: Remove undefined CONFIG_ARCH_OMAP242X
Date: Tue, 18 Dec 2007 10:33:01 +0900
Message-ID: <20071218013301.GA19671@party>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Remove undefined CONFIG_ARCH_OMAP242X.
It boots on locked SRAM board.

Comment from Tony.
Additionally the #if defined(CONFIG_ARCH_OMAP242X) should not be
needed here. If not selected, the cpu_is_omapxxxx() functions
are if (0) {} functions and get optimized out.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index afe8181..c377cb0 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -91,11 +91,9 @@ static int is_sram_locked(void)
 {
 	int type = 0;
 
-#if defined(CONFIG_ARCH_OMAP242X)
 	if (cpu_is_omap242x())
 		type = (ctrl_read_reg(OMAP24XX_CONTROL_STATUS) &
 			OMAP2_DEVICETYPE_MASK);
-#endif
 
 	if (type == GP_DEVICE) {
 		/* RAMFW: R/W access to all initiators for all qualifier sets */
