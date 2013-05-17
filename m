From: Kevin Hilman <khilman@linaro.org>
Subject: Re: reset handling in am335x hwmod data
Date: Fri, 17 May 2013 10:08:40 -0700
Message-ID: <877gixsfdz.fsf@linaro.org>
References: <87ehij8lpb.fsf@dell.be.48ers.dk>
	<alpine.DEB.2.00.1212232033030.8937@utopia.booyaka.com>
	<20130517135022.GH14133@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:47789 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755588Ab3EQRIn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 13:08:43 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so77942pbc.32
        for <linux-omap@vger.kernel.org>; Fri, 17 May 2013 10:08:43 -0700 (PDT)
In-Reply-To: <20130517135022.GH14133@arwen.pp.htv.fi> (Felipe Balbi's message
	of "Fri, 17 May 2013 16:50:22 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Paul Walmsley <paul@pwsan.com>, Peter Korsgaard <jacmet@sunsite.dk>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Felipe Balbi <balbi@ti.com> writes:

> Hi,
>
> On Sun, Dec 23, 2012 at 08:58:13PM +0000, Paul Walmsley wrote:
>> > In this specific case the pin is connected to nCONFIG of a FPGA. The
>> > FPGA is commanded to start configuration from a SPI flash in the
>> > bootloader, so it can happen in parallel with kernel
>> > load/uncompress/startup, but as the kernel resets the gpio during
>> > initialization this doesn't work.
>> > 
>> > Digging a bit into it, I see the hwmod of the gpio controller is
>> > configured to reset at startup, and it works correctly (E.G. the pin is
>> > left asserted) if I change it to HWMOD_INIT_NO_RESET:
>> > 
>> > --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
>> > +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
>> > @@ -992,7 +992,7 @@ static struct omap_hwmod am33xx_gpio1_hwmod = {
>> >         .name           = "gpio2",
>> >         .class          = &am33xx_gpio_hwmod_class,
>> >         .clkdm_name     = "l4ls_clkdm",
>> > -       .flags          = HWMOD_CONTROL_OPT_CLKS_IN_RESET,
>> > +       .flags          = (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
>> >         .mpu_irqs       = am33xx_gpio1_irqs,
>> >         .main_clk       = "l4ls_gclk",
>> >         .prcm           = {
>> > 
>> > Now the question is why is this configured like this?
>> 
>> This behavior is intended to decouple the kernel from the bootloader, or 
>> previously-booted operating system (e.g., the kexec case).  The original 
>> goal was to place the system in an known safe state as soon as possible 
>> after the kernel starts.  This is to prevent misconfigured or 
>
> there is one "issue" with this. At least on AM335x starter kit, GPIO0_7
> is used as DDR power pin. If we reset that GPIO bank, DDR looses power
> and "for obscure reasons" (:-)) the board doesn't boot.
>
> In this case, we cannot reset that bank, otherwise Starter Kit will
> never boot in mainline. Bad PCB design, I know, but it's not something
> we can change now :-)

FWIW, we've seen this before (GPIO connected to PMIC reset is a fun
one), and this is why we have omap_hwmod_no_setup_reset().

Kevin
