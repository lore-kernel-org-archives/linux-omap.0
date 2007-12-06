From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] ARM: OMAP: Remove redundant gpio request at apollon
Date: Thu, 6 Dec 2007 10:46:26 +0900
Message-ID: <20071206014626.GA15974@party>
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

The gpio request is done by gpio-keys

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-omap2/board-apollon-keys.c b/arch/arm/mach-omap2/board-apollon-keys.c
index 6b2e551..b6fa4ea 100644
--- a/arch/arm/mach-omap2/board-apollon-keys.c
+++ b/arch/arm/mach-omap2/board-apollon-keys.c
@@ -77,29 +77,17 @@ static void __init apollon_sw_init(void)
 {
 	/* Enter SW - Y11 */
 	omap_cfg_reg(Y11_242X_GPIO16);
-	omap_request_gpio(SW_ENTER_GPIO16);
-	omap_set_gpio_direction(SW_ENTER_GPIO16, 1);
 	/* Up SW - AA12 */
 	omap_cfg_reg(AA12_242X_GPIO17);
-	omap_request_gpio(SW_UP_GPIO17);
-	omap_set_gpio_direction(SW_UP_GPIO17, 1);
 	/* Down SW - AA8 */
 	omap_cfg_reg(AA8_242X_GPIO58);
-	omap_request_gpio(SW_DOWN_GPIO58);
-	omap_set_gpio_direction(SW_DOWN_GPIO58, 1);
 #ifdef CONFIG_MACH_OMAP_APOLLON_PLUS
 	/* Left SW - P18 */
 	omap_cfg_reg(P18_24XX_GPIO95);
-	omap_request_gpio(SW_LEFT_GPIO95);
-	omap_set_gpio_direction(SW_LEFT_GPIO95, 1);
 	/* Right SW - M18 */
 	omap_cfg_reg(M18_24XX_GPIO96);
-	omap_request_gpio(SW_RIGHT_GPIO96);
-	omap_set_gpio_direction(SW_RIGHT_GPIO96, 1);
 	/* Esc SW - L14 */
 	omap_cfg_reg(L14_24XX_GPIO97);
-	omap_request_gpio(SW_ESC_GPIO97);
-	omap_set_gpio_direction(SW_ESC_GPIO97, 1);
 #endif
 }
 
