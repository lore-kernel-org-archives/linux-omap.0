From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v2] arm: omap2: timer: don't disable our timers
Date: Mon, 5 Oct 2015 19:45:32 -0500
Message-ID: <1444092332-9011-1-git-send-email-balbi@ti.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Arnd Bergmann <arnd@arndb.de>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

We actually want these devices to be created because
we will be moving timers to drivers/clocksource and
this will prevent them from probing.

The only situation where we want secure timers to be
actually disabled is when we *know* we're running on
non-GP (read: HS or EMU) chips, because the secure
timer will NOT be available for the public world.

This patch is just moving the call to of_add_property
to its rightful place.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Okay, seems like this is a saner approach.

changes since v1:
	- don't completely remove the status disabled trick, just limit it to
          non-GP chips

 arch/arm/mach-omap2/timer.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 0ff676273b4b..0bd3ee4552de 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -161,9 +161,7 @@ static const struct of_device_id omap_timer_match[] __initconst = {
  *
  * Helper function to get a timer during early boot using device-tree for use
  * as kernel system timer. Optionally, the property argument can be used to
- * select a timer with a specific property. Once a timer is found then mark
- * the timer node in device-tree as disabled, to prevent the kernel from
- * registering this timer as a platform device and so no one else can use it.
+ * select a timer with a specific property.
  */
 static struct device_node * __init omap_get_timer_dt(const struct of_device_id *match,
 						     const char *property)
@@ -182,8 +180,6 @@ static struct device_node * __init omap_get_timer_dt(const struct of_device_id *
 				  of_get_property(np, "ti,timer-pwm", NULL) ||
 				  of_get_property(np, "ti,timer-secure", NULL)))
 			continue;
-
-		of_add_property(np, &device_disabled);
 		return np;
 	}
 
@@ -208,7 +204,10 @@ static void __init omap_dmtimer_init(void)
 	/* If we are a secure device, remove any secure timer nodes */
 	if ((omap_type() != OMAP2_DEVICE_TYPE_GP)) {
 		np = omap_get_timer_dt(omap_timer_match, "ti,timer-secure");
-		of_node_put(np);
+		if (np) {
+			of_add_property(np, &device_disabled);
+			of_node_put(np);
+		}
 	}
 }
 
-- 
2.5.3
