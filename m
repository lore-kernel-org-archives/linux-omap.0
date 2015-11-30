From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARM: OMAP2+: Change core_initcall levels to
 postcore_initcall
Date: Mon, 30 Nov 2015 08:26:29 -0800
Message-ID: <1448900789-4034-3-git-send-email-tony@atomide.com>
References: <1448900789-4034-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1448900789-4034-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We want to be able to probe a few selected device drivers before hwmod
code populates the clocks in omap_hwmod_setup_all(). This allows us to
convert most of the clock drivers into regular device drivers.

We only need a few minimal clock drivers early for the system timers to
select between the 32KiHz clock and the high frequency oscillator.

With these changes, initializing the clock drivers can be just done at
core_initcall time with something like:

np = of_find_node_by_name(NULL, "plls");
if (np)
	of_platform_populate(np, NULL, NULL, NULL);

And then these clocks will be available for the interconnect code to use.

Having most of the clock drivers being regular device drivers allows
us to use the nice things like devm_* functions and dev_err and dev_dbg.
As an extra bonus, this also allows us to develop the clock drivers for
new SoCs as loadable modules initially for cases where we can boot up
the system based on the bootloader configured clocks.

To do this, let's change the core_initcalls to postcore_initcall under
mach-omap2.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap2-restart.c | 2 +-
 arch/arm/mach-omap2/omap_device.c   | 2 +-
 arch/arm/mach-omap2/omap_hwmod.c    | 2 +-
 arch/arm/mach-omap2/serial.c        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2-restart.c b/arch/arm/mach-omap2/omap2-restart.c
index d937b2e..497269d 100644
--- a/arch/arm/mach-omap2/omap2-restart.c
+++ b/arch/arm/mach-omap2/omap2-restart.c
@@ -62,4 +62,4 @@ static int __init omap2xxx_common_look_up_clks_for_reset(void)
 
 	return 0;
 }
-omap_core_initcall(omap2xxx_common_look_up_clks_for_reset);
+omap_postcore_initcall(omap2xxx_common_look_up_clks_for_reset);
diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 72ebc4c..3750ed1 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -869,7 +869,7 @@ static int __init omap_device_init(void)
 	bus_register_notifier(&platform_bus_type, &platform_nb);
 	return 0;
 }
-omap_core_initcall(omap_device_init);
+omap_postcore_initcall(omap_device_init);
 
 /**
  * omap_device_late_idle - idle devices without drivers
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cc8a987..49d5376 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3307,7 +3307,7 @@ static int __init omap_hwmod_setup_all(void)
 
 	return 0;
 }
-omap_core_initcall(omap_hwmod_setup_all);
+omap_postcore_initcall(omap_hwmod_setup_all);
 
 /**
  * omap_hwmod_enable - enable an omap_hwmod
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 5fb50fe..f164c6b 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -213,7 +213,7 @@ static int __init omap_serial_early_init(void)
 
 	return 0;
 }
-omap_core_initcall(omap_serial_early_init);
+omap_postcore_initcall(omap_serial_early_init);
 
 /**
  * omap_serial_init_port() - initialize single serial port
-- 
2.6.2
