From: Qi Hou <qi.hou@windriver.com>
Subject: [PATCH,
 v2] arm: omap2: timer: fix a kmemleak caused in omap_get_timer_dt
Date: Tue, 9 Jan 2018 17:24:21 +0800
Message-ID: <1515489861-1474-1-git-send-email-qi.hou@windriver.com>
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
To: tony@atomide.com, linux@armlinux.org.uk
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

When more than one GP timers are used as kernel system timers and the
corresponding nodes in device-tree are marked with the same "disabled"
property, then the "attr" field of the property will be initialized
more than once as the property being added to sys file system via
__of_add_property_sysfs().

In __of_add_property_sysfs(), the "name" field of pp->attr.attr is set
directly to the return value of safe_name(), without taking care of
whether it's already a valid pointer to a memory block. If it is, its
old value will always be overwritten by the new one and the memory block
allocated before will a "ghost", then a kmemleak happened.

That the same "disabled" property being added to different nodes of device
tree would cause that kind of kmemleak overhead, at leat once.

To fix it, allocate the property dynamically, and delete static one.

Signed-off-by: Qi Hou <qi.hou@windriver.com>
---
 arch/arm/mach-omap2/timer.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index ece09c9..206ae8d 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -156,12 +156,6 @@ static struct clock_event_device clockevent_gpt = {
 	.tick_resume		= omap2_gp_timer_shutdown,
 };
 
-static struct property device_disabled = {
-	.name = "status",
-	.length = sizeof("disabled"),
-	.value = "disabled",
-};
-
 static const struct of_device_id omap_timer_match[] __initconst = {
 	{ .compatible = "ti,omap2420-timer", },
 	{ .compatible = "ti,omap3430-timer", },
@@ -203,8 +197,17 @@ static struct device_node * __init omap_get_timer_dt(const struct of_device_id *
 				  of_get_property(np, "ti,timer-secure", NULL)))
 			continue;
 
-		if (!of_device_is_compatible(np, "ti,omap-counter32k"))
-			of_add_property(np, &device_disabled);
+		if (!of_device_is_compatible(np, "ti,omap-counter32k")) {
+			struct property *prop;
+
+			prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+			if (!prop)
+				return NULL;
+			prop->name = "status";
+			prop->length = sizeof("disabled");
+			prop->value = "disabled";
+			of_add_property(np, prop);
+		}
 		return np;
 	}
 
-- 
2.7.4
