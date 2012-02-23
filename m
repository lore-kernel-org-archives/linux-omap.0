From: Richard Watts <rrw@kynesim.co.uk>
Subject: Re: help: BeagleBoard xM RevC ethernet port
Date: Thu, 23 Feb 2012 10:23:51 +0000
Message-ID: <4F4613B7.8010601@kynesim.co.uk>
References: <4F3E0EB7.9060803@ti.com> <874nuizfyf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from anakin.london.02.net ([87.194.255.134]:54245 "EHLO
	anakin.london.02.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086Ab2BWKXy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 05:23:54 -0500
In-Reply-To: <874nuizfyf.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, balbi@ti.com

On 22/02/12 22:00, Kevin Hilman wrote:
> Peter Ujfalusi <peter.ujfalusi@ti.com> writes:
> 
>> Hi,
>>
>> I hoped that time will solve this, but so far no luck. I just can not
>> get the ethernet port (along with the USB host ports) working on my xM RevC.
>> What is the trick to get it working on 3.3-rc3?
>>
>> There seams to be some configuration issue:
>>
>> [    1.437530] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>> [    1.444671] ehci_hcd: block sizes: qh 64 qtd 96 itd 160 sitd 96
>> [    1.451354] ehci-omap ehci-omap.0: failed to get ehci port0 regulator
>> [    1.458282] ehci-omap ehci-omap.0: failed to get ehci port1 regulator
> 
> 
> The first thing I try when I see these regulator failures is to add
> CONFIG_REGULATOR_DUMMY=y to the .config to see if that helps.  If so,
> then the board file needs some help configuring the right regulators.
> 
> Kevin
> --

 Apologies for the malformed patch, but I don't have time to clean it up
this morning (or test it in its cleaned state); however, the following
fixes the problem for me.

 It used to be masked because u-boot turns the regulator on to activate
ethernet on Beagle xM and no-one ever turns it off again, but some versions
of u-boot don't identify xM rev C correctly, so never turn it on ..

 Anyway, it's neater for the kernel to know what it's doing. And removes
a whole two lines of kernel startup output :-)


Richard.
---
commit 39d26ad563023acdddd06e8aaaf154378c373187
Author: Richard Watts <rrw@kynesim.co.uk>
Date:   Fri Jan 20 12:27:59 2012 +0000

    Turn on the USB regulator on Beagle xM explicitly, when the USB
    subsystem asks for it, rather than relying on u-boot to do it.

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 4a71cb7..69ed6a0 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -362,11 +362,32 @@ static struct regulator_init_data beagle_vsim = {
 	.consumer_supplies	= beagle_vsim_supply,
 };

+static struct regulator_consumer_supply beagle_usb_supply[] = {
+    REGULATOR_SUPPLY("hsusb0", "ehci-omap.0"),
+    REGULATOR_SUPPLY("hsusb1", "ehci-omap.0")
+};
+
+static struct regulator_init_data usb_power = {
+    .constraints = {
+        .min_uV = 1800000,
+        .max_uV = 1800000,
+        .valid_modes_mask = REGULATOR_MODE_NORMAL,
+        .valid_ops_mask = REGULATOR_CHANGE_VOLTAGE
+        | REGULATOR_CHANGE_MODE
+        | REGULATOR_CHANGE_STATUS,
+    },
+    .num_consumer_supplies = ARRAY_SIZE(beagle_usb_supply),
+    .consumer_supplies = beagle_usb_supply
+};
+
+
+
 static struct twl4030_platform_data beagle_twldata = {
 	/* platform_data for children goes here */
 	.gpio		= &beagle_gpio_data,
 	.vmmc1		= &beagle_vmmc1,
 	.vsim		= &beagle_vsim,
+        .vaux2          = &usb_power,
 };

 static struct i2c_board_info __initdata beagle_i2c_eeprom[] =

