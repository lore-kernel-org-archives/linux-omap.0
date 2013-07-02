From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v3 0/2]: auto request GPIO as input if used as IRQ via DT
Date: Tue, 02 Jul 2013 09:33:20 -0700
Message-ID: <87ehbgncq7.fsf@linaro.org>
References: <1372276203-21755-1-git-send-email-javier.martinez@collabora.co.uk>
	<87li5pooee.fsf@linaro.org> <51D27165.1050800@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:39451 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811Ab3GBQdX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jul 2013 12:33:23 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so6500534pab.22
        for <linux-omap@vger.kernel.org>; Tue, 02 Jul 2013 09:33:23 -0700 (PDT)
In-Reply-To: <51D27165.1050800@collabora.co.uk> (Javier Martinez Canillas's
	message of "Tue, 02 Jul 2013 08:21:25 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Grant Likely <grant.likely@linaro.org>, jgchunter@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, eballetbo@gmail.com, thomas.petazzoni@free-electrons.com, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>, aaro.koskinen@iki.fi

Javier Martinez Canillas <javier.martinez@collabora.co.uk> writes:

> On 07/02/2013 01:23 AM, Kevin Hilman wrote:
>> Javier Martinez Canillas <javier.martinez@collabora.co.uk> writes:
>> 
>>> When an OMAP GPIO is used as an IRQ line, a call to gpio_request()
>>> has to be made to initialize the OMAP GPIO bank before a driver
>>> request the IRQ. Otherwise the call to request_irq() fails.
>>>
>>> Drivers should not be aware of this neither care wether an IRQ line
>>> is a GPIO or not. They should just request the IRQ and this has to
>>> be handled by the irq_chip driver.
>>>
>>> With the current OMAP GPIO DT binding, if we define:
>>>
>>>                 gpio6: gpio@49058000 {
>>>                         compatible = "ti,omap3-gpio";
>>>                         reg = <0x49058000 0x200>;
>>>                         interrupts = <34>;
>>>                         ti,hwmods = "gpio6";
>>>                         gpio-controller;
>>>                         #gpio-cells = <2>;
>>>                         interrupt-controller;
>>>                         #interrupt-cells = <2>;
>>>                 };
>>>
>>>                 interrupt-parent = <&gpio6>;
>>>                 interrupts = <16 8>;
>>>
>>> The GPIO is correctly mapped as an IRQ but a call to gpio_request()
>>> is never made. Ideally this has to be handled by the IRQ core and
>>> there are some work-in-progress to add this logic to the core but
>>> until this general solution gets into mainline we need to solve this
>>> on a per irq_chip driver basis.
>>>
>>> Some drivers solve this by calling gpio_request() using a custom
>>> .xlate function handler. But .xlate could get called many times
>>> while the irq domain .map function handler is called just once
>>> when a IRQ mapping is created with a call to irq_create_mapping().
>>>
>>> This patch-set adds a custom .map function handler for the gpio-omap
>>> irq_chip driver that automatically call gpio_request() when a IRQ
>>> mapping is created for the GPIO line used as interrupt when using DT.
>>> This is just a temporary solution (a.k.a a hack) until a kernel wide
>>> approach is implemented and added to mainline.
>>>
>>> This is a third version of a patch-set that addresses some issues pointed
>>> out by Grant Like, it is composed of the following patches:
>>>
>>> [PATCH v3 1/2] gpio/omap: don't create an IRQ mapping for every GPIO on DT
>>> [PATCH v3 2/2] gpio/omap: auto request GPIO as input if used as IRQ via DT
>>>
>>> This was tested on an OMAP3 DM3735 board (IGEPv2) and all the supported
>>> peripherals are working correctly with both legacy and DT booting. Further
>>> testing will be highly appreciated.
>> 
>> Was there any testing done to hit low-power modes?  suspend/resume?
>> CPUidle enabled? etc.  It is especially instructive to enable off
>> mode[1] on OMAP3 platforms and see if things still work as expected.
>> 
>> Kevin
>> 
>> [1] echo 1 > /sys/kerel/debug/pm_debug/enable_off_mode
>>
>
> Hi Kevin,
>
> Thanks a lot for your feedback.
>
> I tested enabling power domain transitions to off mode [1] and suspending to RAM
> [2] with both DT and legacy boot. With legacy booting everything works as expected.

Excellent, thanks.

> In the DT case suspending/resume (without enabling off mode) doesn't affect
> system operation. For example the Ethernet chip that uses a GPIO IRQ still is
> able to transmit frames after suspending to RAM and waking up the board hitting
> Ctrl+C in the serial console.
>
> Now, enabling off mode [2] with DT makes the board to never go out from suspend:
>
> root@igep00x0:~# echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode
> root@igep00x0:~# echo mem > /sys/power/state
> [  129.833343] PM: Syncing filesystems ... done.
> [  129.879211] Freezing user space processes ... (elapsed 0.01 seconds) done.
> [  129.905487] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
> [  129.935363] Suspending console(s) (use no_console_suspend to debug)
>
> The board just hangs/sleeps and I don't have a way to take it from suspend.
>
> I don't know if there something missing on my board DT file but I think this is
> orthogonal with these patches since since I got the same behavior without them.

Yes, you're right.  I forgot we don't have full wakeup capabilities from
low-power states yet (IO pad wakeups) with DT boots.  We have that
mostly working now, but not ready for v3.10.

Thanks for testing,

Once the OMAP1 build failure is fixed (omap1_defconfig build fails
because of this series), feel free to add

Tested-by: Kevin Hilman <khilman@linaro.org>  # OMAP3530: Beagle, Overo
Reviewed-by: Kevin Hilman <khilman@linaro.org>

Kevin
