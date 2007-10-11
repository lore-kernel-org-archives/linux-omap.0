From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] Make dyntick work again
Date: Thu, 11 Oct 2007 13:32:41 -0700
Message-ID: <20071011203240.GL503@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yEPQxsgoJgBvi8ip"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Here's a quick patch to make dyntick work on omap again
after the clocksource changes. It now uses the Linux 
common implementation instead of the ARM specific one.

I haven't tested this patch much yet, except:

# grep time /proc/interrupts; sleep 10; grep time /proc/interrupts

Drops the ticks to below 10.

Regards,

Tony

--yEPQxsgoJgBvi8ip
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap-32k-timer-oneshot.patch"

diff --git a/arch/arm/plat-omap/timer32k.c b/arch/arm/plat-omap/timer32k.c
index be7cb8e..1eaec1c 100644
--- a/arch/arm/plat-omap/timer32k.c
+++ b/arch/arm/plat-omap/timer32k.c
@@ -146,6 +146,14 @@ static inline void omap_32k_timer_ack_irq(void)
 
 #endif
 
+static int omap_32k_timer_set_next_event(unsigned long delta,
+					 struct clock_event_device *dev)
+{
+	omap_32k_timer_start(delta);
+
+	return 0;
+}
+
 static void omap_32k_timer_set_mode(enum clock_event_mode mode,
 				    struct clock_event_device *evt)
 {
@@ -153,9 +161,9 @@ static void omap_32k_timer_set_mode(enum clock_event_mode mode,
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
+	case CLOCK_EVT_MODE_ONESHOT:
 		omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
 		break;
-	case CLOCK_EVT_MODE_ONESHOT:
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
 		break;
@@ -166,8 +174,9 @@ static void omap_32k_timer_set_mode(enum clock_event_mode mode,
 
 static struct clock_event_device clockevent_32k_timer = {
 	.name		= "32k-timer",
-	.features       = CLOCK_EVT_FEAT_PERIODIC,
+	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.shift		= 32,
+	.set_next_event	= omap_32k_timer_set_next_event,
 	.set_mode	= omap_32k_timer_set_mode,
 };
 

--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--yEPQxsgoJgBvi8ip--
