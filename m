From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.21-rc4-omap1] partial LED fixes
Date: Wed, 28 Mar 2007 13:09:36 -0700
Message-ID: <200703281309.36356.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Partial fix for CONFIG_LEDS breakage ... at least allow platforms
using the debug-leds support (H4 for now) to build with the generic
LED support, and default the LED that would be the timer LED to
trigger using the "heartbeat" (timer driven, rate depends on load).

Right now only H2 and P2 seem to have working LED support; this
at least makes H4 less broken.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -39,12 +39,6 @@ static struct h2p2_dbg_fpga __iomem	*fpg
 static u16				led_state, hw_led_state;
 
 
-#ifdef	CONFIG_LEDS
-#define old_led_api()	1
-#else
-#define old_led_api()	0
-#endif
-
 #ifdef	CONFIG_LEDS_OMAP_DEBUG
 #define new_led_api()	1
 #else
@@ -202,7 +196,8 @@ struct dbg_led {
 static struct dbg_led dbg_leds[] = {
 	/* REVISIT at least H2 uses different timer & cpu leds... */
 #ifndef CONFIG_LEDS_TIMER
-	{ .mask = 1 << 0,  .cdev.name =  "d4:green", },		/* timer */
+	{ .mask = 1 << 0,  .cdev.name =  "d4:green",
+		.cdev.default_trigger = "heartbeat", },
 #endif
 #ifndef CONFIG_LEDS_CPU
 	{ .mask = 1 << 1,  .cdev.name =  "d5:green", },		/* !idle */
@@ -274,10 +269,10 @@ static int /* __init */ fpga_probe(struc
 	fpga = ioremap(iomem->start, H2P2_DBG_FPGA_SIZE);
 	__raw_writew(~0, &fpga->leds);
 
-	if (old_led_api()) {
-		leds_event = h2p2_dbg_leds_event;
-		leds_event(led_start);
-	}
+#ifdef	CONFIG_LEDS
+	leds_event = h2p2_dbg_leds_event;
+	leds_event(led_start);
+#endif
 
 	if (new_led_api()) {
 		newled_init(&pdev->dev);
