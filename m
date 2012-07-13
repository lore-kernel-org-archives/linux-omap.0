From: Jon Hunter <jon-hunter@ti.com>
Subject: [RFC RESEND 2/4] ARM: OMAP3: Dynamically disable secure timer nodes for secure devices
Date: Fri, 13 Jul 2012 17:26:51 -0500
Message-ID: <1342218413-30116-3-git-send-email-jon-hunter@ti.com>
References: <1342218413-30116-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44177 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765Ab2GMW2N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jul 2012 18:28:13 -0400
In-Reply-To: <1342218413-30116-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Jon Hunter <jon-hunter@ti.com>

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

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
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

