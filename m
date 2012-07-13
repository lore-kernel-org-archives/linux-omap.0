From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: [RFC 2/4] ARM: OMAP3: Dynamically disable secure timer nodes for
 secure devices
Date: Fri, 13 Jul 2012 17:19:33 -0500
Message-ID: <1342217976-29802-4-git-send-email-jon-hunter@ti.com>
References: <1342217976-29802-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1342217976-29802-1-git-send-email-jon-hunter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Tarun Kanti DebBarma <tarun.kanti-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

OMAP3 devices may or may not have security features enabled. Security enabled
devices are known as high-secure (HS) and devices without security are known as
general purpose (GP).

For OMAP3 devices there are 12 general purpose timers available. On secure
devices the 12th timer is reserved for secure usage and so cannot be used by
the kernel, where as for a GP device it is available. We can detect the OMAP
device type, secure or GP, at runtime via an on-chip register. Today, when not
using DT, we do not register the 12th timer as a linux device if the device is
secure.

When using device tree, device tree is going to register all the timer devices
it finds in the device tree blob. To prevent device tree from registering 12th
timer on a secure OMAP3 device we can add a status property to the timer
binding with the value "disabled" at boot time. Note that timer 12 on a OMAP3
device has a property "ti,timer-secure" to indicate that it will not be
available on a secure device and so for secure OMAP3 devices, we search for
timers with this property and then disable them. Using the prom_add_property()
function to dynamically add a property was a recommended approach suggested by
Rob Herring [1].

I have tested this on an OMAP3 GP device and faking it to pretend to be a
secure device to ensure that any timers marked with "ti,timer-secure" are not
registered on boot. I have also made sure that all timers are registered as
expected on a GP device by default.

[1] http://comments.gmane.org/gmane.linux.ports.arm.omap/79203

Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/board-generic.c |    1 +
 arch/arm/mach-omap2/common.h        |    1 +
 arch/arm/mach-omap2/timer.c         |   36 +++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 6f93a20..20124d7 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -40,6 +40,7 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
 static void __init omap_generic_init(void)
 {
 	omap_sdrc_init(NULL, NULL);
+	omap_dmtimer_init();
 
 	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
 }
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 1f65b18..d6a4875 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -326,6 +326,7 @@ extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1);
 struct omap2_hsmmc_info;
 extern int omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers);
+extern void omap_dmtimer_init(void);
 
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 13d20c8..e3b9931 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -36,6 +36,7 @@
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #include <asm/mach/time.h>
 #include <plat/dmtimer.h>
@@ -482,6 +483,41 @@ static int __init omap2_dm_timer_init(void)
 }
 arch_initcall(omap2_dm_timer_init);
 
+static struct property timer_disabled = {
+	.name = "status",
+	.length = sizeof("disabled"),
+	.value = "disabled",
+};
+
+static struct of_device_id omap3_timer_match[] __initdata = {
+	{ .compatible = "ti,omap3-timer", },
+	{ }
+};
+
+/**
+ * omap_dmtimer_init - initialisation function when device tree is used
+ *
+ * For secure OMAP3 devices, timers with device type "timer-secure" cannot
+ * be used by the kernel as they are reserved. Therefore, to prevent the
+ * kernel registering these devices remove them dynamically from the device
+ * tree on boot.
+ */
+void __init omap_dmtimer_init(void)
+{
+	struct device_node *np;
+
+	if (!cpu_is_omap34xx())
+		return;
+
+	/* If we are a secure device, remove any secure timer nodes */
+	if ((omap_type() != OMAP2_DEVICE_TYPE_GP)) {
+		for_each_matching_node(np, omap3_timer_match) {
+			if (of_get_property(np, "ti,timer-secure", NULL))
+				prom_add_property(np, &timer_disabled);
+		}
+	}
+}
+
 /**
  * omap2_override_clocksource - clocksource override with user configuration
  *
-- 
1.7.9.5
