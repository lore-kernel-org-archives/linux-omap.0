From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] ARM: OMAP: Use the correct CONFIG_ARCH_OMAP24XX
Date: Thu, 6 Dec 2007 10:46:51 +0900
Message-ID: <20071206014651.GA15983@party>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Use the correct CONFIG_ARCH_OMAP24XX.
It boots on locked SRAM board.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index afe8181..6305dc9 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -91,7 +91,7 @@ static int is_sram_locked(void)
 {
 	int type = 0;
 
-#if defined(CONFIG_ARCH_OMAP242X)
+#if defined(CONFIG_ARCH_OMAP24XX)
 	if (cpu_is_omap242x())
 		type = (ctrl_read_reg(OMAP24XX_CONTROL_STATUS) &
 			OMAP2_DEVICETYPE_MASK);
