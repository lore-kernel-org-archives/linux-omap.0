From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 00/20] OMAP2+: UART: Runtime adaptation + cleanup
Date: Tue, 13 Dec 2011 11:26:40 -0800
Message-ID: <87fwgow9vz.fsf@ti.com>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
	<CAAL8m4wGN5ykm3-+xrGPe-WJUDBdterxAyZ=C3kH862+n1DprQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:37399 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754160Ab1LMT0u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 14:26:50 -0500
In-Reply-To: <CAAL8m4wGN5ykm3-+xrGPe-WJUDBdterxAyZ=C3kH862+n1DprQ@mail.gmail.com>
	(Govindraj's message of "Tue, 13 Dec 2011 18:31:13 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

Govindraj <govindraj.ti@gmail.com> writes:

[...]

> I have re-based this patch series against LO master
> commit id: deee6d5359969a0ce4e2760cfd7b9f379bd5698a
>
> Same is available here [1]
>
> I have tested this patch series along with:
>
> 1.) Tero's V11 irq chaining series
>      http://www.spinics.net/lists/linux-omap/msg61445.html
>     (This patch series is used for uart wakeup handling using
>       prcm_irq chaining)
>
> 2.) Rajendra's hwmod change
>      http://www.spinics.net/lists/arm-kernel/msg148632.html
>      (This patch handles init_no_idle flag setting
>       without this patch there will be boot warning however
>       all pm features will work after boot up.)
>
> 3.) Vishwa's io daisy chain changes.
>      http://permalink.gmane.org/gmane.linux.ports.arm.omap/65500
>      (tested with and without this patch series pm features works).
>
> Same combination of patches based on above commit id
> used for testing is available here [2].

Please have a closer look at your branch.

The second commit[1] commits the .rej file from a failed patch apply,
so obviously doesn't do what was intended.

Kevin

[1]
>From ae5d13382a5784f35f5bfe05413fbec4632e58f0 Mon Sep 17 00:00:00 2001
From: "Govindraj.R" <govindraj.raja@ti.com>
Date: Tue, 13 Sep 2011 13:32:32 +0530
Subject: [PATCH] OMAP2+: UART: cleanup 8250 console driver support

We had been using traditional 8250 driver as uart console driver
prior to omap-serial driver. Since we have omap-serial driver
in mainline kernel for some time now it has been used as default
uart console driver on omap2+ platforms. Remove 8250 support for
omap-uarts.

Serial_in and serial_out override for 8250 serial driver is also
removed. Empty fifo read fix is already taken care with omap-serial
driver with data ready bit check from LSR reg before reading RX fifo.
Also waiting for THRE(transmit hold reg empty) is done with wait_for_xmitr
in omap-serial driver.

Serial_in/out overrides are not neceesary for omap-serial driver
and things that are taken with omap-serial driver are removed here.

Remove headers that were necessary to support 8250 support
and remove all config bindings done to keep 8250 backward compatibility
while adding omap-serial driver. Remove omap_uart_reset needed for
8250 autoconf.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c.rej |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/serial.c.rej

diff --git a/arch/arm/mach-omap2/serial.c.rej b/arch/arm/mach-omap2/serial.c.rej
new file mode 100644
index 0000000..2325897
--- /dev/null
+++ b/arch/arm/mach-omap2/serial.c.rej
@@ -0,0 +1,26 @@
+--- arch/arm/mach-omap2/serial.c
++++ arch/arm/mach-omap2/serial.c
+@@ -19,23 +19,17 @@
+  */
+ #include <linux/kernel.h>
+ #include <linux/init.h>
+-#include <linux/serial_reg.h>
+ #include <linux/clk.h>
+ #include <linux/io.h>
+ #include <linux/delay.h>
+ #include <linux/platform_device.h>
+ #include <linux/slab.h>
+-#include <linux/serial_8250.h>
+ #include <linux/pm_runtime.h>
+ #include <linux/console.h>
+ 
+-#ifdef CONFIG_SERIAL_OMAP
+ #include <plat/omap-serial.h>
+-#endif
+-
+ #include <plat/common.h>
+ #include <plat/board.h>
+-#include <plat/clock.h>
+ #include <plat/dma.h>
+ #include <plat/omap_hwmod.h>
+ #include <plat/omap_device.h>
-- 
1.7.6

