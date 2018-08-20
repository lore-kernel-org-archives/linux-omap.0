From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 3/3] ARM: OMAP1: ams-delta: register MODEM device earlier
Date: Mon, 20 Aug 2018 20:13:33 +0200
Message-ID: <20180820181333.2527-4-jmkrzyszt@gmail.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820181333.2527-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Amstrad Delta MODEM device used to be initialized at arch_initcall
before it was once moved to late_initcall by commit f7519d8c8290 ("ARM:
OMAP1: ams-delta: register latch dependent devices later"). The purpose
of that change was to postpone initialization of devices which depended
on latch2 pins until latch2 converted to GPIO device was ready.

After recent fixes to GPIO handling, it was possible to moove
registration of most of those device back to where they were before.
The same can be safely done with the MODEM device as initialization
of GPIO pins it depends on was moved to machine_init by preceding
patch.

Move registration of the MODEM device to arch_initcall_sync, not to
arch_initcall, so it is never exposed to potential conflictinh
registration order hazard against OMAP serial ports.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index c865c6921af8..a98783f98f3a 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -896,11 +896,28 @@ static int __init modem_nreset_init(void)
 /*
  * This function expects MODEM IRQ number already assigned to the port
  * and fails if it's not.
+ * The MODEM device requires its RESET# pin kept high during probe.
+ * That requirement can be fulfilled in several ways:
+ * - with a descriptor of already functional modem_nreset regulator
+ *   assigned to the MODEM private data,
+ * - with the regulator not yet controlled by modem_pm function but
+ *   already enabled by default on probe,
+ * - before the modem_nreset regulator is probed, with the pin already
+ *   set high explicitly.
+ * The last one is already guaranteed by ams_delta_latch2_init() called
+ * from machine_init.
+ * In order to avoid taking over ttyS0 device slot, the MODEM device
+ * should be registered after OMAP serial ports.  Since those ports
+ * are registered at arch_initcall, this function can be called safely
+ * at arch_initcall_sync earliest.
  */
 static int __init ams_delta_modem_init(void)
 {
 	int err;
 
+	if (!machine_is_ams_delta())
+		return -ENODEV;
+
 	if (ams_delta_modem_ports[0].irq < 0)
 		return ams_delta_modem_ports[0].irq;
 
@@ -913,6 +930,7 @@ static int __init ams_delta_modem_init(void)
 
 	return err;
 }
+arch_initcall_sync(ams_delta_modem_init);
 
 static int __init late_init(void)
 {
@@ -922,10 +940,6 @@ static int __init late_init(void)
 	if (err)
 		return err;
 
-	err = ams_delta_modem_init();
-	if (err)
-		return err;
-
 	/*
 	 * Once the modem device is registered, the modem_nreset
 	 * regulator can be requested on behalf of that device.
-- 
2.16.4
