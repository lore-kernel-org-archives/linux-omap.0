From: Peter Barada <peterb@logicpd.com>
Subject: smsc911x IRQ on MMC1_DAT7 pin problem with ES3.1 35x
Date: Tue, 11 Aug 2009 13:28:17 -0400
Message-ID: <1250011697.18517.86.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:30382 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752986AbZHKRYO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Aug 2009 13:24:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

I have a board that has the smsx911x driver IRQ hooked up to
R25_MMC1_DAT7, and I've setup the pin (mux offset 0x156) as "
OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT", and a gpio input.

The smsc911x platform data is:

static struct smsc911x_platform_config ldp_smsc911x_platform_data = {
	.irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
	.irq_type = SMSC911X_IRQ_TYPE_OPEN_DRAIN,
	.flags = SMSC911X_USE_16BIT,
	.phy_interface = PHY_INTERFACE_MODE_MII,
};

and the IRQ pin from the LAN9211 is hooked up to SD1_MMC7 and pulled to
1.8V via a 4.75Kohm resistor.

Unfortunately with ES3.1 silicon I'm getting:

OMAP-Torpedo# modprobe smsc911x
smsc911x: Driver version 2008-10-21.
irq 289: nobody cared (try booting with the "irqpoll" option)
[<c0036e40>] (dump_stack+0x0/0x14) from [<c008500c>] (__report_bad_irq
+0x3c/0x94)
[<c0084fd0>] (__report_bad_irq+0x0/0x94) from [<c00851b8>]
(note_interrupt+0x154/0x1cc)
 r4:c0406f14
[<c0085064>] (note_interrupt+0x0/0x1cc) from [<c0085f4c>]
(handle_level_irq+0xb4/0xec)
[<c0085e98>] (handle_level_irq+0x0/0xec) from [<c0048f74>]
(gpio_irq_handler+0x13c/0x180)
 r5:c0406f14 r4:00000121
[<c0048e38>] (gpio_irq_handler+0x0/0x180) from [<c0032068>]
(__exception_text_start+0x68/0x8c)
[<c0032000>] (__exception_text_start+0x0/0x8c) from [<c00329d0>]
(__irq_svc+0x30/0x80)
Exception stack(0xc7817c60 to 0xc7817ca8)
7c60: 00000000 0000033d 00000001 00000000 c0406f14 40000013 c7a26720
00000121
7c80: c0406f2c c78a8800 00000088 c7817ccc d9056000 c7817ca8 00000002
c0084974
7ca0: 40000013 ffffffff
 r5:d8200000 r4:ffffffff
[<c0084800>] (__setup_irq+0x0/0x1e0) from [<c0084a8c>] (request_irq
+0xac/0xd8)
 r8:c01e7a60 r7:c0406f14 r6:00000000 r5:00000121 r4:c7a26720
[<c00849e0>] (request_irq+0x0/0xd8) from [<c030719c>]
(smsc911x_drv_probe+0x5bc/0x12f8)
[<c0306be0>] (smsc911x_drv_probe+0x0/0x12f8) from [<c01db38c>]
(platform_drv_probe+0x20/0x24)
[<c01db36c>] (platform_drv_probe+0x0/0x24) from [<c01da540>]
(driver_probe_device+0xec/0x198)
[<c01da454>] (driver_probe_device+0x0/0x198) from [<c01da658>]
(__driver_attach+0x6c/0x90)
 r6:c03ff6dc r5:c04183b4 r4:c03ff630
[<c01da5ec>] (__driver_attach+0x0/0x90) from [<c01d9a7c>]
(bus_for_each_dev+0x4c/0x84)
 r6:c01da5ec r5:c7817db0 r4:00000000
[<c01d9a30>] (bus_for_each_dev+0x0/0x84) from [<c01da368>]
(driver_attach+0x20/0x28)
 r7:00000000 r6:c78c8b40 r5:c04183b4 r4:00000000
[<c01da348>] (driver_attach+0x0/0x28) from [<c01d9f18>] (bus_add_driver
+0xa8/0x218)
[<c01d9e70>] (bus_add_driver+0x0/0x218) from [<c01da85c>]
(driver_register+0x98/0x11c)
[<c01da7c4>] (driver_register+0x0/0x11c) from [<c01db728>]
(platform_driver_register+0x78/0x94)
[<c01db6b0>] (platform_driver_register+0x0/0x94) from [<c001ebb0>]
(smsc911x_init_module+0x14/0x1c)
[<c001eb9c>] (smsc911x_init_module+0x0/0x1c) from [<c00322d8>]
(__exception_text_end+0x60/0x190)
[<c0032278>] (__exception_text_end+0x0/0x190) from [<c0008730>]
(kernel_init+0x6c/0xd8)
[<c00086c4>] (kernel_init+0x0/0xd8) from [<c0060d90>] (do_exit
+0x0/0x6e0)
 r5:00000000 r4:00000000
handlers:
[<c01e7a60>] (smsc911x_irqhandler+0x0/0x558)
Disabling IRQ #289


0) Looking at the IRQ pin with a scope while modprobing the driver shows
it steady at 1.8V.

1) Do I need (and how?) to setup PBIAS and/or VMMC1 to make the
MMC1_DAT4 through MMC1_DAT7 usable as GPIO pins at 1.8V while allowing
MMC1_DAT0 through MMC1_DAT3 to be used for an SD/MMC port?

2) Will the code in twl_mmc1_set_power() affect the voltage/bias on pins
MMC1_dat4 through MMC1_DAT7?

-- 
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
