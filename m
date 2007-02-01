From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] gpio-switch.c: use right flags for interrupts
Date: Thu, 01 Feb 2007 11:03:43 +0100
Message-ID: <85wt32nqio.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
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

--=-=-=


Hi,


The recent switch from SA_ to IRQF_ constants for interrupt flags
introduced a typo in the gpio_switch driver (IRQF_SHIRQ doesn't exist
but IRQF_SHARED does).


Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=irq_changes.patch

---
 arch/arm/plat-omap/gpio-switch.c |    2 	1 +	1 -	0 !
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-omap-2.6/arch/arm/plat-omap/gpio-switch.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/gpio-switch.c	2007-02-01 09:40:39.000000000 +0100
+++ linux-omap-2.6/arch/arm/plat-omap/gpio-switch.c	2007-02-01 09:42:02.000000000 +0100
@@ -310,7 +310,7 @@ static int __init new_switch(struct gpio
 			trigger = IRQF_TRIGGER_RISING;
 	}
 	r = request_irq(OMAP_GPIO_IRQ(sw->gpio), gpio_sw_irq_handler,
-			IRQF_SHIRQ | trigger, sw->name, sw);
+			IRQF_SHARED | trigger, sw->name, sw);
 	if (r < 0) {
 		printk(KERN_ERR "gpio-switch: request_irq() failed "
 		       "for GPIO %d\n", sw->gpio);

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=--
