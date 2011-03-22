From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] Input: tca6416-keypad: Change to module_init()
Date: Wed, 23 Mar 2011 00:16:04 +0900
Message-ID: <AANLkTimBkGCxzV8czXimkc5X_+SX8qRUrUiJRiS_UeV1@mail.gmail.com>
References: <20110322142619.1109.89105.sendpatchset@t400s>
	<20110322142855.GB2202@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110322142855.GB2202@sirena.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: dmitry.torokhov@gmail.com, srk@ti.com, khilman@ti.com, chinyeow.sim.xt@renesas.com, linux-sh@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 22, 2011 at 11:28 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Mar 22, 2011 at 11:26:19PM +0900, Magnus Damm wrote:
>
>> The tca6416 driver makes use of the I2C bus for chatting
>> with the actual hardware device. Without this patch both
>> the I2C bus driver and the tca6416 driver are initialized
>> at the subsys_initcall() level. This may lead to problems
>> with the tca6416 driver being initialized before the I2C
>> bus driver.
>
> While this change seems reasonable I'm curious what the problems caused
> by out of order registration are?

The boot up time is delayed with 5 seconds or so due to a delay that
only happens if subsys_initcall() level is used for both tca6416 and
the I2C driver. By disabling the tca6416 driver in the kernel
configuration the delay goes away. I have not tracked it down further
than using module_init() instead of subsys_initcall() in the tca6416
driver. This because tca6416-keypad.c is the only keyboard driver that
uses subsys_initcall().

If I enable initcall_debug then I get this output:

calling  input_init+0x0/0x114 @ 1
initcall input_init+0x0/0x114 returned 0 after 0 usecs
calling  tca6416_keypad_init+0x0/0x10 @ 1
initcall tca6416_keypad_init+0x0/0x10 returned 0 after 0 usecs
calling  sh_mobile_i2c_adap_init+0x0/0xc @ 1
i2c-sh_mobile i2c-sh_mobile.0: clocks managed by runtime pm
input: tca6408-keys as
/devices/platform/i2c-sh_mobile.0/i2c-0/0-0020/input/input0
[delay]

If my interpretation of the log above is correct then
tca6416_keypad_init() is executed before sh_mobile_i2c_adap_init().

As for link order, i2c is located after input in driver/Makefile. I
believe that matches well with the log above.

Thanks,

/ magnus
