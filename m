From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] Input: tca6416-keypad: Change to module_init()
Date: Tue, 29 Mar 2011 16:11:12 +0900
Message-ID: <AANLkTimX+SQHaFjc=zARjuvdzX8OisQMHCBUgcR4V7sa@mail.gmail.com>
References: <20110322142619.1109.89105.sendpatchset@t400s>
	<20110322142855.GB2202@sirena.org.uk>
	<20110322143307.GB24004@linux-sh.org>
	<AANLkTimRV9vzOE7+VPX48y3KebLJSvBOkqxoM--9gqGb@mail.gmail.com>
	<20110322153226.GC30303@linux-sh.org>
	<AANLkTimyxdcJ-eEke9x7X1zdiJNbFtncfv0=NzKjtAme@mail.gmail.com>
	<20110322155730.GD30303@linux-sh.org>
	<AANLkTi=Fjc2f837ifH152Rh8W0PfiZvViYaLe=8XZo4Z@mail.gmail.com>
	<20110322163144.GC2202@sirena.org.uk>
	<AANLkTiniBVWhSiNZMRYbO857D_Vj03KxH4qYqkVo-11J@mail.gmail.com>
	<20110322165907.GG22583@opensource.wolfsonmicro.com>
	<AANLkTin1jG36-EsvAk9o-KxdxaBBhx=5Rf+JMidjYqsT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47981 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab1C2HLO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Mar 2011 03:11:14 -0400
In-Reply-To: <AANLkTin1jG36-EsvAk9o-KxdxaBBhx=5Rf+JMidjYqsT@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Mundt <lethal@linux-sh.org>, dmitry.torokhov@gmail.com, srk@ti.com, khilman@ti.com, chinyeow.sim.xt@renesas.com, linux-sh@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Mar 24, 2011 at 1:04 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Wed, Mar 23, 2011 at 1:59 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Wed, Mar 23, 2011 at 01:51:02AM +0900, Magnus Damm wrote:
>>
>>> I'm not sure if this is i2c specific though - in general you probably
>>> need to register the parent bus driver first.
>>
>> This was my original question - I'm not aware of any reason why you
>> should need to register the driver for the specific bus first, it seems
>> odd.
>
> Can't see why it wouldn't work - in theory at least. I'll have a look tomorrow.

Ok, it seems like the I2C bus registration is working as expected.
After digging into this a bit more I've discovered that the root cause
seems to be related to clocks. On sh7372 the I2C controller and the
serial console share the parent clock, and the setup order is
affecting the serial console.

Without this patch, if subsys_init() is used for tca6416-keypad then
the I2C controller will be used at probe() time from the function
tca6416_setup_registers() - this before the serial console driver has
been initialized properly. The I2C controller used by tca6416 will
stop the parent clock when the I2C bus access is finished. The serial
console driver is driven early using earlyprintk at this time, and the
clock is assumed to be enabled until the real driver is installed at
module_init() time. So with subsys_init() in tca6416 the I2C
controller stops the clock while the earlyprintk code assumes it to be
on. This is causing delays.

If the tca6416 driver is changed to module_init() then the serial
console driver will be initialized before the tca6416 driver due to
the linking order and all is working fine.

As we already knew, the clock framework code in drivers/sh/clk should
be updated to turn off unused clocks. To fix the issue in this mail
thread we should also update the code to force the console clock to be
enabled early on to make sure the serial console clock isn't turned
off by accident.

I propose that we convert the tca6416 driver to module_init() as a
short term fix _and_ at the same time work on improving the clock
framework code.

Can anyone think of a reason why the tca6416 driver shouldn't be
changed to module_init()?

Thanks,

/ magnus
