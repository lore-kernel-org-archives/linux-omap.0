From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] OMAP1: IrDA cleanup
Date: Thu, 13 Apr 2006 08:10:12 -0700 (PDT)
Message-ID: <20060413151012.93539.qmail@web32909.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1986576439-1144941012=:92939"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--0-1986576439-1144941012=:92939
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

 
 

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1986576439-1144941012=:92939
Content-Type: text/x-patch;
	name="0001-Remove-the-last-references-to-omap1610-IrDA-code.patch"
Content-Description: 109089295-0001-Remove-the-last-references-to-omap1610-IrDA-code.patch
Content-Disposition: inline;
	filename="0001-Remove-the-last-references-to-omap1610-IrDA-code.patch"

>From nobody Mon Sep 17 00:00:00 2001
From: Komal Shah <komal_shah802003@yahoo.com>
Date: Thu Apr 13 18:06:46 2006 +0300
Subject: [PATCH] Remove the last references to omap1610 IrDA code.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 arch/arm/mach-omap1/board-h2.c |    4 ++++
 arch/arm/mach-omap1/board-h3.c |    3 +++
 arch/arm/mach-omap1/devices.c  |   30 ------------------------------
 3 files changed, 7 insertions(+), 30 deletions(-)

c6009e49e49089e75a22fdfd67c87233cf7201f2
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 7eded8e..50c39ba 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -271,11 +271,15 @@
 		.flags	= IORESOURCE_IRQ,
 	},
 };
+
+static u64 irda_dmamask = 0xffffffff;
+
 static struct platform_device h2_irda_device = {
 	.name		= "omapirda",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &h2_irda_data,
+		.dma_mask	= &irda_dmamask,
 	},
 	.num_resources	= ARRAY_SIZE(h2_irda_resources),
 	.resource	= h2_irda_resources,
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 4b8d0ec..ef7315e 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -346,11 +346,14 @@
 	},
 };
 
+static u64 irda_dmamask = 0xffffffff;
+
 static struct platform_device h3_irda_device = {
 	.name		= "omapirda",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &h3_irda_data,
+		.dma_mask	= &irda_dmamask,
 	},
 	.num_resources	= ARRAY_SIZE(h3_irda_resources),
 	.resource	= h3_irda_resources,
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 847329c..f9f076f 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -25,35 +25,6 @@
 #include <asm/arch/mux.h>
 #include <asm/arch/gpio.h>
 
-#if	defined(CONFIG_OMAP1610_IR) || defined(CONFIG_OMAP161O_IR_MODULE)
-
-static u64 irda_dmamask = 0xffffffff;
-
-static struct platform_device omap1610ir_device = {
-	.name = "omap1610-ir",
-	.id = -1,
-	.dev = {
-		.dma_mask	= &irda_dmamask,
-	},
-};
-
-static void omap_init_irda(void)
-{
-	/* FIXME define and use a boot tag, members something like:
-	 *  u8		uart;		// uart1, or uart3
-	 * ... but driver only handles uart3 for now
-	 *  s16		fir_sel;	// gpio for SIR vs FIR
-	 * ... may prefer a callback for SIR/MIR/FIR mode select;
-	 * while h2 uses a GPIO, H3 uses a gpio expander
-	 */
-	if (machine_is_omap_h2()
-			|| machine_is_omap_h3())
-		(void) platform_device_register(&omap1610ir_device);
-}
-#else
-static inline void omap_init_irda(void) {}
-#endif
-
 /*-------------------------------------------------------------------------*/
 
 #if	defined(CONFIG_OMAP_RTC) || defined(CONFIG_OMAP_RTC)
@@ -155,7 +126,6 @@
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
-	omap_init_irda();
 	omap_init_rtc();
 	omap_init_sti();
 
-- 
1.3-rc1.GIT


--0-1986576439-1144941012=:92939
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1986576439-1144941012=:92939--
