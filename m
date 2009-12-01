From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: Re: Preventing OMAP3 serial driver to take control of all UARTs
Date: Tue, 1 Dec 2009 13:02:56 +0200
Message-ID: <20091201110256.GB17675@esdhcp04058.research.nokia.com>
References: <20091130084651.GA17675@esdhcp04058.research.nokia.com> <1259599010.4649.51.camel@thunk> <fa686aa40911300901nd47259ar2e1beae7be447937@mail.gmail.com> <20091130194031.GV4348@atomide.com> <1259613066.4649.127.camel@thunk> <20091130210957.GY4348@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59455 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462AbZLALHt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 06:07:49 -0500
Content-Disposition: inline
In-Reply-To: <20091130210957.GY4348@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Peter Barada <peterb@logicpd.com>, Grant Likely <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Olof Johansson <olof@lixom.net>

On Mon, Nov 30, 2009 at 10:09:58PM +0100, ext Tony Lindgren wrote:
> * Peter Barada <peterb@logicpd.com> [091130 12:30]:
> > On Mon, 2009-11-30 at 11:40 -0800, Tony Lindgren wrote:
> > > * Grant Likely <grant.likely@secretlab.ca> [091130 09:01]:
> > > > On Mon, Nov 30, 2009 at 9:36 AM, Peter Barada <peterb@logicpd.com> wrote:
> > > > > On Mon, 2009-11-30 at 10:46 +0200, Mika Westerberg wrote:
> > > > >> Hi Tony,
> > > > >>
> > > > >> Current omap serial driver takes control of all 3 (4 on OMAP3640)
> > > > >> UARTS. However, we have such a setup where UART2 for example is used
> > > > >> by bluetooth driver. It uses the UART as non-standard way (there are
> > > > >> some Nokia extensions to H4 protocol) so we cannot use the standard
> > > > >> driver for driving the UART but have written special one for that
> > > > >> purpose.
> > > > >>
> > > > >> Question is: Is there any, upstreamable, way of preventing omap serial
> > > > >> driver to do this? Currently this is done with custom #ifdef hackery to
> > > > >> mach-omap2/serial.c. Alternative solution that comes into mind is to
> > > > >> specify UART configuration in board files and let serial driver to use
> > > > >> that instead of hard-coded one. Or do you have some nice alternatives?
> > > > >
> > > > > Previously (back around 2.6.28-rc8) in the board file, the
> > > > > omap_uart_config struct controlled which serial ports were enabled on
> > > > > startup.  It was used in omap_serial_init, and it looks like that code
> > > > > went away with the following commit:
> > > > > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blobdiff;f=arch/arm/mach-omap2/serial.c;h=2e17b57f5b23bb6703a2d621103585af1d8d729b;hp=555e735524381cbf8ef9f20d778ad81f9438e24e;hb=4355c41a635943d30e9396b95185314343dcb551;hpb=7e9ccf7776bb68b5367eb0bb35e519df62bea35c
> > > > >
> > > > > I'm kinda in the same boat as I want to use some of the unused serial
> > > > > port pins for GPIO, but they are setup as serial ports....
> > > 
> > > Sounds like we need something back to specify the ports to use
> > > from board-*.c files. Kevin, got any comments? 
> > >  
> > > > Not in mainlined yet, but I'm working on porting flattened device tree
> > > > support to OMAP to solve exactly this sort of problem.  Basically,
> > > > instead of hard coding or #ifdeffing things, a data blob gets handed
> > > > to the kernel at boot time telling it exactly what hardware is present
> > > > in a consistent, parsable format.  Device drivers then get probed
> > > > based on data in the device tree.  Here's some info on the approach:
> > > > 
> > > > http://www.elinux.org/Device_Trees
> > > > 
> > > > I expect to have my prototype ready for review mid-January, and most
> > > > of the common code should be either merged or queued up in linux-next
> > > > by that time.
> > > 
> > > While device tree is a nice solution to some of the problems, it still
> > > leaves all the issues we already have with buggy and and outdated
> > > bootloaders. So we still need to properly initialize the devices in
> > > the kernel.
> > > 
> > > Just for reference, most of the omap bootloader bugs seem to be
> > > related to not muxing the pins right or using wrong timings for GPMC.
> > > 
> > > And then things that mostly change during the board development are
> > > the GPIO pins, but those can be easily rewritten in the board-*.c
> > > files based on the omap_rev.
> > > 
> > > But at least the device tree is a standard model, while the earlier
> > > omap tag approach was non-standard.
> > > 
> > > Peter, maybe you've already thought through all this.. But would it be
> > > possible to do lightweight device tree that we just use to populate
> > > the platform data?
> > 
> > One possibility is to pass to omap_serial_init() the omap_uart_config
> > struct pointer to specify which parts are enabled.  If a NULL is passed
> > in, then enable all the ports available.  Since omap_serial_early_init()
> > was already called, the muxing would have to be cleaned up, but since
> > the kernel should mux all the pins it uses, that shouldn't be a problem.
> > omap_serial_init would now look something like(warning, coding on the
> > fly - don't know if it will work as is):
> > 
> > void __init omap_serial_init(struct omap_uart_config *confptr)
> > {
> > 	int i;
> > 
> > 	for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
> > 		struct omap_uart_state *uart = &omap_uart[i];
> > 		struct platform_device *pdev = &uart->pdev;
> > 		struct device *dev = &pdev->dev;
> > 
> > 		/* Only enable
> > 		if (!confptr || confptr->port_enabled & (1<<i)) {
> > 			omap_uart_reset(uart);
> > 			omap_uart_idle_init(uart);
> > 
> > 			if (WARN_ON(platform_device_register(pdev)))
> > 				continue;
> > 			if ((cpu_is_omap34xx() && uart->padconf) ||
> > 			    (uart->wk_en && uart->wk_mask)) {
> > 				device_init_wakeup(dev, true);
> > 				DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
> > 			}
> > 		}
> > 	}
> > }
> 
> Yeah, I guess something like that would be good. We may want to
> specify the optional other pins there too, typically it's just
> RX and TX pins.
> 
> It could also be directly struct plat_serial8250_port array we
> pass? Or does that make things more complicated to use the upcoming
> omap serial driver?

How about something like in the patch attached?

Then for example we would do in board-rx51.c:
	...
	omap_serial_init_port(2);

(we only use UART3 as serial port).

I quickly tested this with RX-51 and seems to work.

Thanks,
MW

---

From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Date: Tue, 1 Dec 2009 12:54:21 +0200
Subject: [PATCH] OMAP3: serial - allow platforms specify which UARTs to initialize

This patch adds new function: omap_serial_init_port(port) that can be
used to initialize only selected UARTs as serial ports. Platforms can
then in their board files call this function instead of omap_serial_init()
if they don't want to use all UARTs as serial ports.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/mach-omap2/serial.c             |   59 +++++++++++++++++++++++-------
 arch/arm/plat-omap/include/plat/serial.h |    1 +
 2 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 2e17b57..fe46560 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -631,24 +631,55 @@ void __init omap_serial_early_init(void)
 	}
 }
 
+/**
+ * omap_serial_init_port() - initialize single serial port
+ * @port: serial port number (0-3)
+ *
+ * This function initialies serial driver for given @port only.
+ * Platforms can call this function instead of omap_serial_init()
+ * if they don't plan to use all available UARTs as serial ports.
+ *
+ * Don't mix calls to omap_serial_init_port() and omap_serial_init(),
+ * use only one of the two.
+ */
+void __init omap_serial_init_port(int port)
+{
+	struct omap_uart_state *uart;
+	struct platform_device *pdev;
+	struct device *dev;
+
+	BUG_ON(port < 0);
+	BUG_ON(port >= ARRAY_SIZE(omap_uart));
+
+	uart = &omap_uart[port];
+	pdev = &uart->pdev;
+	dev = &pdev->dev;
+
+	omap_uart_reset(uart);
+	omap_uart_idle_init(uart);
+
+	if (WARN_ON(platform_device_register(pdev)))
+		return;
+
+	if ((cpu_is_omap34xx() && uart->padconf) ||
+	    (uart->wk_en && uart->wk_mask)) {
+		device_init_wakeup(dev, true);
+		DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
+	}
+}
+
+/**
+ * omap_serial_init() - intialize all supported serial ports
+ *
+ * Initializes all available UARTs as serial ports. Platforms
+ * can call this function when they want to have default behaviour
+ * for serial ports (e.g initialize them all as serial ports).
+ */
 void __init omap_serial_init(void)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
-		struct omap_uart_state *uart = &omap_uart[i];
-		struct platform_device *pdev = &uart->pdev;
-		struct device *dev = &pdev->dev;
-
-		omap_uart_reset(uart);
-		omap_uart_idle_init(uart);
-
-		if (WARN_ON(platform_device_register(pdev)))
-			continue;
-		if ((cpu_is_omap34xx() && uart->padconf) ||
-		    (uart->wk_en && uart->wk_mask)) {
-			device_init_wakeup(dev, true);
-			DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
-		}
+		omap_serial_init_port(i);
 	}
 }
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index 9951345..f5a4a92 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -53,6 +53,7 @@
 #ifndef __ASSEMBLER__
 extern void __init omap_serial_early_init(void);
 extern void omap_serial_init(void);
+extern void omap_serial_init_port(int port);
 extern int omap_uart_can_sleep(void);
 extern void omap_uart_check_wakeup(void);
 extern void omap_uart_prepare_suspend(void);
-- 
1.5.6.5

