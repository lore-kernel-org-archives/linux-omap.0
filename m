From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH] ARM: AMx3xx: Allow low level debugging on all UARTs
Date: Tue, 21 Jun 2016 17:37:58 +0530
Message-ID: <20160621120758.28732-1-lokeshvutla@ti.com>
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
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, nm@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

AM33xx/AM43xx Soc has 6 UART interfaces. Any of these 6 UARTs can be used as
serial console as defined by the specific board design and passing a proper
console bootarg. Given this, we should be able to use any UART(that is
used as serial console) for low level debugging. Currently only UART1 can
be used for low level debugging. So, adding support for all other UARTs
instead of waiting for new board with a different UART console.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
- Debugll support is enabled on all UARTs as per the earlier feedback
 received here: http://www.spinics.net/lists/linux-omap/msg123160.html
- Need to patch to use earlyprintk on am335x-icev2 board.

 arch/arm/Kconfig.debug                             | 40 ++++++++++++++++++++++
 arch/arm/include/debug/omap2plus.S                 | 28 +++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.h                   | 20 +++++++++++
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 10 +++---
 4 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 19a3dcf..c147e21 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -701,6 +701,46 @@ choice
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_OMAP2PLUS_UART
 
+	config DEBUG_AM33XXUART2
+		bool "Kernel low-level debugging messages via AM33XX/AM43XX UART2"
+		depends on ARCH_OMAP2PLUS
+		select DEBUG_OMAP2PLUS_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on AM33xx and AM43xx based platforms on the UART2.
+
+	config DEBUG_AM33XXUART3
+		bool "Kernel low-level debugging messages via AM33XX/AM43XX UART3"
+		depends on ARCH_OMAP2PLUS
+		select DEBUG_OMAP2PLUS_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on AM33xx and AM43xx based platforms on the UART3.
+
+	config DEBUG_AM33XXUART4
+		bool "Kernel low-level debugging messages via AM33XX/AM43XX UART4"
+		depends on ARCH_OMAP2PLUS
+		select DEBUG_OMAP2PLUS_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on AM33xx and AM43xx based platforms on the UART4.
+
+	config DEBUG_AM33XXUART5
+		bool "Kernel low-level debugging messages via AM33XX/AM43XX UART5"
+		depends on ARCH_OMAP2PLUS
+		select DEBUG_OMAP2PLUS_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on AM33xx and AM43xx based platforms on the UART5.
+
+	config DEBUG_AM33XXUART6
+		bool "Kernel low-level debugging messages via AM33XX/AM43XX UART6"
+		depends on ARCH_OMAP2PLUS
+		select DEBUG_OMAP2PLUS_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on AM33xx and AM43xx based platforms on the UART6.
+
 	config DEBUG_ZOOM_UART
 		bool "Kernel low-level debugging messages via Zoom2/3 UART"
 		depends on ARCH_OMAP2PLUS
diff --git a/arch/arm/include/debug/omap2plus.S b/arch/arm/include/debug/omap2plus.S
index 6d867ae..7e99184 100644
--- a/arch/arm/include/debug/omap2plus.S
+++ b/arch/arm/include/debug/omap2plus.S
@@ -40,6 +40,11 @@
 
 /* AM33XX serial port */
 #define AM33XX_UART1_BASE	0x44E09000
+#define AM33XX_UART2_BASE	0x48022000
+#define AM33XX_UART3_BASE	0x48024000
+#define AM33XX_UART4_BASE	0x481a6000
+#define AM33XX_UART5_BASE	0x481a8000
+#define AM33XX_UART6_BASE	0x481aa000
 
 /* OMAP5 serial ports */
 #define OMAP5_UART1_BASE	OMAP2_UART1_BASE
@@ -128,6 +133,29 @@ omap_uart_lsr:	.word	0
 		and	\rp, \rp, #0x00ffffff
 		b	97f
 #endif
+#ifdef CONFIG_DEBUG_AM33XXUART2
+		mov	\rp, #UART_OFFSET(AM33XX_UART2_BASE)
+		b	98f
+#endif
+#ifdef CONFIG_DEBUG_AM33XXUART3
+		mov	\rp, #UART_OFFSET(AM33XX_UART3_BASE)
+		b	98f
+#endif
+#ifdef CONFIG_DEBUG_AM33XXUART4
+		ldr	\rp, =AM33XX_UART4_BASE
+		and	\rp, \rp, #0x00ffffff
+		b	98f
+#endif
+#ifdef CONFIG_DEBUG_AM33XXUART5
+		ldr	\rp, =AM33XX_UART5_BASE
+		and	\rp, \rp, #0x00ffffff
+		b	98f
+#endif
+#ifdef CONFIG_DEBUG_AM33XXUART6
+		ldr	\rp, =AM33XX_UART6_BASE
+		and	\rp, \rp, #0x00ffffff
+		b	98f
+#endif
 #ifdef CONFIG_DEBUG_ZOOM_UART
 		ldr	\rp, =ZOOM_UART_BASE
 		str	\rp, [\tmp, #0]		@ omap_uart_phys
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 4041bad..354fee1 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -106,6 +106,11 @@ extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type3;
 #define DEBUG_TI81XXUART2_FLAGS	0
 #define DEBUG_TI81XXUART3_FLAGS	0
 #define DEBUG_AM33XXUART1_FLAGS	0
+#define DEBUG_AM33XXUART2_FLAGS	0
+#define DEBUG_AM33XXUART3_FLAGS	0
+#define DEBUG_AM33XXUART4_FLAGS	0
+#define DEBUG_AM33XXUART5_FLAGS	0
+#define DEBUG_AM33XXUART6_FLAGS	0
 
 #define DEBUG_OMAPUART_FLAGS	(HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET)
 
@@ -148,6 +153,21 @@ extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type3;
 #elif defined(CONFIG_DEBUG_AM33XXUART1)
 #undef DEBUG_AM33XXUART1_FLAGS
 #define DEBUG_AM33XXUART1_FLAGS DEBUG_OMAPUART_FLAGS
+#elif defined(CONFIG_DEBUG_AM33XXUART2)
+#undef DEBUG_AM33XXUART2_FLAGS
+#define DEBUG_AM33XXUART2_FLAGS DEBUG_OMAPUART_FLAGS
+#elif defined(CONFIG_DEBUG_AM33XXUART3)
+#undef DEBUG_AM33XXUART3_FLAGS
+#define DEBUG_AM33XXUART3_FLAGS DEBUG_OMAPUART_FLAGS
+#elif defined(CONFIG_DEBUG_AM33XXUART4)
+#undef DEBUG_AM33XXUART4_FLAGS
+#define DEBUG_AM33XXUART4_FLAGS DEBUG_OMAPUART_FLAGS
+#elif defined(CONFIG_DEBUG_AM33XXUART5)
+#undef DEBUG_AM33XXUART5_FLAGS
+#define DEBUG_AM33XXUART5_FLAGS DEBUG_OMAPUART_FLAGS
+#elif defined(CONFIG_DEBUG_AM33XXUART6)
+#undef DEBUG_AM33XXUART6_FLAGS
+#define DEBUG_AM33XXUART6_FLAGS DEBUG_OMAPUART_FLAGS
 #endif
 
 /**
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index aed3362..666eca6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -1242,7 +1242,7 @@ struct omap_hwmod am33xx_uart2_hwmod = {
 	.name		= "uart2",
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
+	.flags		= DEBUG_AM33XXUART2_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
@@ -1256,7 +1256,7 @@ struct omap_hwmod am33xx_uart3_hwmod = {
 	.name		= "uart3",
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
+	.flags		= DEBUG_AM33XXUART3_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
@@ -1269,7 +1269,7 @@ struct omap_hwmod am33xx_uart4_hwmod = {
 	.name		= "uart4",
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
+	.flags		= DEBUG_AM33XXUART4_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
@@ -1282,7 +1282,7 @@ struct omap_hwmod am33xx_uart5_hwmod = {
 	.name		= "uart5",
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
+	.flags		= DEBUG_AM33XXUART5_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
@@ -1295,7 +1295,7 @@ struct omap_hwmod am33xx_uart6_hwmod = {
 	.name		= "uart6",
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
+	.flags		= DEBUG_AM33XXUART6_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-- 
2.9.0
