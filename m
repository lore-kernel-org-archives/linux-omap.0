From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.21-rc5-omap1-git] OSK led fixes
Date: Mon, 2 Apr 2007 12:48:10 -0700
Message-ID: <200704021248.10783.david-b@pacbell.net>
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

Bugfixes for the OSK led support:

 - Fix Kconfig merge glitches:  Mistral handles idle and timer leds just fine
 - Fix pm_suspend() runtime botch:  can't sleep, so can't touch tps65010 leds 

Improvements:
 - Switch sense of Mistral idle led, so idle == off

Probably the TPS65010 leds should be handled only by the "new led" API.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- osk2.orig/arch/arm/Kconfig	2007-04-01 09:49:26.000000000 -0700
+++ osk2/arch/arm/Kconfig	2007-04-01 22:50:04.000000000 -0700
@@ -668,7 +668,8 @@ config LEDS
 
 config LEDS_TIMER
 	bool "Timer LED" if (!ARCH_CDB89712 && !ARCH_OMAP) || \
-			    MACH_OMAP_H2 || MACH_OMAP_PERSEUS2
+			    OMAP_OSK_MISTRAL || MACH_OMAP_H2 \
+			    || MACH_OMAP_PERSEUS2
 	depends on LEDS
 	default y if ARCH_EBSA110
 	help
@@ -684,7 +685,9 @@ config LEDS_TIMER
 
 config LEDS_CPU
 	bool "CPU usage LED" if (!ARCH_CDB89712 && !ARCH_EBSA110 && \
-			!ARCH_OMAP) || MACH_OMAP_H2 || MACH_OMAP_PERSEUS2
+			!ARCH_OMAP) \
+			|| OMAP_OSK_MISTRAL || MACH_OMAP_H2 \
+			|| MACH_OMAP_PERSEUS2
 	depends on LEDS
 	help
 	  If you say Y here, the red LED will be used to give a good real
--- osk2.orig/arch/arm/mach-omap1/pm.c	2007-04-01 22:42:34.000000000 -0700
+++ osk2/arch/arm/mach-omap1/pm.c	2007-04-01 22:42:43.000000000 -0700
@@ -58,7 +58,6 @@
 #include <asm/arch/tc.h>
 #include <asm/arch/pm.h>
 #include <asm/arch/mux.h>
-#include <asm/arch/tps65010.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/dsp_common.h>
 #include <asm/arch/dmtimer.h>
@@ -248,11 +247,6 @@ void omap_pm_suspend(void)
 
 	omap_serial_wake_trigger(1);
 
-	if (machine_is_omap_osk()) {
-		/* Stop LED1 (D9) blink */
-		tps65010_set_led(LED1, OFF);
-	}
-
 	if (!cpu_is_omap15xx())
 		omap_writew(0xffff, ULPD_SOFT_DISABLE_REQ_REG);
 
@@ -445,11 +439,6 @@ void omap_pm_suspend(void)
 	omap_serial_wake_trigger(0);
 
 	printk("PM: OMAP%x is re-starting from deep sleep...\n", system_rev);
-
-	if (machine_is_omap_osk()) {
-		/* Let LED1 (D9) blink again */
-		tps65010_set_led(LED1, BLINK);
-	}
 }
 
 #if defined(DEBUG) && defined(CONFIG_PROC_FS)
--- osk2.orig/arch/arm/mach-omap1/leds-osk.c	2007-04-01 09:47:03.000000000 -0700
+++ osk2/arch/arm/mach-omap1/leds-osk.c	2007-04-01 22:45:50.000000000 -0700
@@ -133,13 +133,13 @@ void osk_leds_event(led_event_t evt)
 		mistral_setled();
 		break;
 
-	case led_idle_start:
-		hw_led_state |= IDLE_LED;
+	case led_idle_start:	/* idle == off */
+		hw_led_state &= ~IDLE_LED;
 		mistral_setled();
 		break;
 
 	case led_idle_end:
-		hw_led_state &= ~IDLE_LED;
+		hw_led_state |= IDLE_LED;
 		mistral_setled();
 		break;
 
