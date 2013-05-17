From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: reset handling in am335x hwmod data
Date: Fri, 17 May 2013 15:53:49 +0200
Message-ID: <87zjvtlnki.fsf@dell.be.48ers.dk>
References: <87ehij8lpb.fsf@dell.be.48ers.dk>
	<alpine.DEB.2.00.1212232033030.8937@utopia.booyaka.com>
	<20130517135022.GH14133@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:51930 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028Ab3EQNxy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 09:53:54 -0400
Received: by mail-wi0-f181.google.com with SMTP id hi5so479956wib.2
        for <linux-omap@vger.kernel.org>; Fri, 17 May 2013 06:53:53 -0700 (PDT)
In-Reply-To: <20130517135022.GH14133@arwen.pp.htv.fi> (Felipe Balbi's message
	of "Fri, 17 May 2013 16:50:22 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

>>>>> "Felipe" == Felipe Balbi <balbi@ti.com> writes:

Hi,

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

 Felipe> there is one "issue" with this. At least on AM335x starter kit,
 Felipe> GPIO0_7 is used as DDR power pin. If we reset that GPIO bank,
 Felipe> DDR looses power and "for obscure reasons" (:-)) the board
 Felipe> doesn't boot.

Heh!

 Felipe> In this case, we cannot reset that bank, otherwise Starter Kit
 Felipe> will never boot in mainline. Bad PCB design, I know, but it's
 Felipe> not something we can change now :-)

Indeed. So that's two examples of people designing boards with the
assumption that gpios will not toggle between bootloader and running
system. Chances are that there will be others.

-- 
Bye, Peter Korsgaard
