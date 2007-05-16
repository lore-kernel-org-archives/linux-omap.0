From: tony@atomide.com
Subject: Re: [PATCH] ARM: OMAP: Fix 32k clockevents for 2430
Date: Wed, 16 May 2007 08:56:50 -0700
Message-ID: <20070516155649.GD20297@atomide.com>
References: <20070512003654.258174663@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070512003654.258174663@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Kevin Hilman <khilman@mvista.com> [070511 17:39]:
> 32k timer driver was using wrong base addr for 32k sync timer.
> Also fix unsupported one-shot mode in set_mode hook.

Thanks, I've refreshed  omap-fixes and and applied it to omap-fixes.
Also updated the comments accordingly, see below.

Tony

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=apply

From: Kevin Hilman <khilman@mvista.com>
Subject: ARM: OMAP: Fix 32k timer unsupported one-shot mode

Fix unsupported one-shot mode in set_mode hook.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 arch/arm/plat-omap/common.c   |    6 ++----
 arch/arm/plat-omap/timer32k.c |   10 ++++------
 2 files changed, 6 insertions(+), 10 deletions(-)

Index: linux-omap-2.6/arch/arm/plat-omap/common.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/common.c	2007-05-16 07:53:23.000000000 -0700
+++ linux-omap-2.6/arch/arm/plat-omap/common.c	2007-05-16 08:48:35.000000000 -0700
@@ -172,7 +172,7 @@ console_initcall(omap_add_serial_console
 #if defined(CONFIG_ARCH_OMAP16XX)
 #define TIMER_32K_SYNCHRONIZED		0xfffbc410
 #elif defined(CONFIG_ARCH_OMAP24XX)
-#define TIMER_32K_SYNCHRONIZED		0x48004010
+#define TIMER_32K_SYNCHRONIZED		(OMAP24XX_32KSYNCT_BASE + 0x10)
 #endif
 
 #ifdef	TIMER_32K_SYNCHRONIZED
Index: linux-omap-2.6/arch/arm/plat-omap/timer32k.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/timer32k.c	2007-05-16 07:53:24.000000000 -0700
+++ linux-omap-2.6/arch/arm/plat-omap/timer32k.c	2007-05-16 08:22:05.000000000 -0700
@@ -71,7 +71,7 @@ struct sys_timer omap_timer;
 #if defined(CONFIG_ARCH_OMAP16XX)
 #define TIMER_32K_SYNCHRONIZED		0xfffbc410
 #elif defined(CONFIG_ARCH_OMAP24XX)
-#define TIMER_32K_SYNCHRONIZED		0x48004010
+#define TIMER_32K_SYNCHRONIZED		(OMAP24XX_32KSYNCT_BASE + 0x10)
 #else
 #error OMAP 32KHz timer does not currently work on 15XX!
 #endif
@@ -147,14 +147,15 @@ static inline void omap_32k_timer_ack_ir
 static void omap_32k_timer_set_mode(enum clock_event_mode mode,
 				    struct clock_event_device *evt)
 {
+	omap_32k_timer_stop();
+
 	switch (mode) {
-	case CLOCK_EVT_MODE_ONESHOT:
 	case CLOCK_EVT_MODE_PERIODIC:
 		omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
 		break;
+	case CLOCK_EVT_MODE_ONESHOT:
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
-		omap_32k_timer_stop();
 		break;
 	}
 }
@@ -192,8 +193,6 @@ omap_32k_ticks_to_nsecs(unsigned long ti
 	return (unsigned long long) ticks_32k * 1000 * 5*5*5*5*5*5 >> 9;
 }
 
-static unsigned long omap_32k_last_tick = 0;
-
 /*
  * Returns current time from boot in nsecs. It's OK for this to wrap
  * around for now, as it's just a relative time stamp.
@@ -223,7 +222,6 @@ static __init void omap_init_32k_timer(v
 {
 	if (cpu_class_is_omap1())
 		setup_irq(INT_OS_TIMER, &omap_32k_timer_irq);
-	omap_32k_last_tick = omap_32k_sync_timer_read();
 
 #ifdef CONFIG_ARCH_OMAP2
 	/* REVISIT: Check 24xx TIOCP_CFG settings after idle works */

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--y0ulUmNC+osPPQO6--
