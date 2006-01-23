From: Paul Mundt <paul.mundt@nokia.com>
Subject: [PATCH] ARM: OMAP: gpio-switch and retu-rtc kobject_uevent() fixes.
Date: Mon, 23 Jan 2006 16:13:24 +0200
Message-ID: <20060123141324.GA25124@nokia.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This updates gpio-switch and retu-rtc for the kobject_uevent() API
changes.

Signed-off-by: Paul Mundt <paul.mundt@nokia.com>

---

 arch/arm/plat-omap/gpio-switch.c |    6 ++----
 drivers/cbus/retu-rtc.c          |    3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

b0f545efd87d78689e3ea5c4d95ed40c1f8e3df0
diff --git a/arch/arm/plat-omap/gpio-switch.c b/arch/arm/plat-omap/gpio-switch.c
index 1e9025d..cbb1efb 100644
--- a/arch/arm/plat-omap/gpio-switch.c
+++ b/arch/arm/plat-omap/gpio-switch.c
@@ -129,11 +129,9 @@ static void gpio_sw_handler(void *data)
 		return;
 
 	if (sw->type == OMAP_GPIO_SWITCH_TYPE_CONNECTION)
-		kobject_uevent(&sw->pdev.dev.kobj, KOBJ_CHANGE,
-			       &dev_attr_connection_switch.attr);
+		kobject_uevent(&sw->pdev.dev.kobj, KOBJ_CHANGE);
 	else
-		kobject_uevent(&sw->pdev.dev.kobj, KOBJ_CHANGE,
-			       &dev_attr_cover_switch.attr);
+		kobject_uevent(&sw->pdev.dev.kobj, KOBJ_CHANGE);
 	sw->state = state;
 	if (omap_get_gpio_datain(sw->gpio))
 		set_irq_type(OMAP_GPIO_IRQ(sw->gpio), IRQT_FALLING);
diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index e823d7e..6471e7e 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -315,8 +315,7 @@ static void retu_rtca_disable(void)
 static void retu_rtca_expired(void *data)
 {
 	retu_rtca_disable();
-	kobject_uevent(&retu_rtc_driver.kobj, KOBJ_CHANGE,
-		       &dev_attr_alarm_expired.attr);
+	kobject_uevent(&retu_rtc_driver.kobj, KOBJ_CHANGE);
 }
 
 DECLARE_WORK(retu_rtca_work, retu_rtca_expired, NULL);
