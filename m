From: Anand Gadiyar <gadiyar@ti.com>
Subject: Linux-next as of 20110222 broken on OMAP4
Date: Tue, 22 Feb 2011 15:19:48 +0530
Message-ID: <b858222d69a83460e469b80ee13cfbe8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:46459 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753480Ab1BVJtw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Feb 2011 04:49:52 -0500
Received: by fxm20 with SMTP id 20so2495777fxm.26
        for <linux-omap@vger.kernel.org>; Tue, 22 Feb 2011 01:49:49 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Looks like linux-next as of today is broken on at least OMAP4.

Turning on earlyprintk, I get a crash in omap_init_mcspi. Disabling
CONFIG_SPI_OMAP24XX gets me as far as the following lines from my
bootup log, but I haven't attempted to debug further.

If there are any patches out there to fix this, let me know.
Else I will debug this sometime tomorrow.

- Anand


[    0.622802] print_constraints: dummy:
[    0.627655] NET: Registered protocol family 16
[    0.632537] GPMC revision 6.0
[    0.635681] Trying to install interrupt handler for IRQ402
[    0.641418] Trying to install interrupt handler for IRQ403
[    0.647125] Trying to install interrupt handler for IRQ404
[    0.652862] Trying to install interrupt handler for IRQ405
[    0.658599] Trying to install interrupt handler for IRQ406
[    0.664306] Trying to install interrupt handler for IRQ407
[    0.670043] Trying to install interrupt handler for IRQ408
[    0.675781] Trying to install type control for IRQ409
[    0.681060] Trying to set irq flags for IRQ409
[    0.685699] gpmc: irq-20 could not claim: err -22
[    0.695556] omap_device: omap_gpio.0: new worst case activate latency
0: 91552
[    0.703552] OMAP GPIO hardware version 0.1
[    0.708221] OMAP GPIO hardware version 0.1
[    0.712890] OMAP GPIO hardware version 0.1
[    0.717498] OMAP GPIO hardware version 0.1
[    0.722137] OMAP GPIO hardware version 0.1
[    0.726776] OMAP GPIO hardware version 0.1[    0.738403] omap_mux_init:
Add partition: #1: core, flags: 2
[    0.746276] omap_mux_init: Add partition: #2: wkup, flags: 2
[    0.752349] error setting wl12xx data
[    0.759674] omap_device: omap_uart.0: new worst case deactivate latency
0: 30517
[    0.769805] Failed omap4_twl6030_hsmmc_set_late_init
[    0.777587] hw-breakpoint: found 6 breakpoint and 1 watchpoint
registers.
[    0.784667] hw-breakpoint: 1 breakpoint(s) reserved for watchpoint
single-step.
[    0.792266] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.803466] pm_dbg_init: only OMAP3 supported
[    0.808441] OMAP DMA hardware revision 0.0
[    0.849426] bio: create slab <bio-0> at 0
[    0.856201] print_constraints: vwl1271: 1800 mV
[    0.864959] SCSI subsystem initialized
[    0.870605] usbcore: registered new interface driver usbfs
[    0.876739] usbcore: registered new interface driver hub
[    0.882751] usbcore: registered new device driver usb
[    0.889221] omap_device: omap_i2c.1: new worst case activate latency 0:
30517
