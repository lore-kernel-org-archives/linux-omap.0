From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 1/2] Revert "ARM: OMAP2+: Fix serial init for device tree
 based booting"
Date: Fri, 12 Jul 2013 14:52:59 +0530
Message-ID: <51DFCAF3.7040503@ti.com>
References: <1373539986-27272-1-git-send-email-rnayak@ti.com> <1373539986-27272-2-git-send-email-rnayak@ti.com> <20130712072051.GA7656@atomide.com> <51DFB0E4.6040007@ti.com> <20130712080305.GD7656@atomide.com> <51DFC58C.7030105@ti.com> <20130712091827.GH7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48561 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757373Ab3GLJXb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Jul 2013 05:23:31 -0400
In-Reply-To: <20130712091827.GH7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, mpfj-list@newflow.co.uk, sourav.poddar@ti.com, paul@pwsan.com, balbi@ti.com

On Friday 12 July 2013 02:48 PM, Tony Lindgren wrote:
> * Rajendra Nayak <rnayak@ti.com> [130712 02:06]:
>> On Friday 12 July 2013 01:33 PM, Tony Lindgren wrote:
>>>
>>> OK, so that's only for earlyprintk then?
>>
>> yes,
>>
>>>
>>> If so, it seems the right fix is to set the NO_IDLE and NO_RESET
>>> flags based on ifdef CONFIG_DEBUG_OMAP4UART3 etc as that is selected
>>> in the Kconfig now.
>>
>> ok makes sense. It seems like the static data in hwmod can be populated
>> based on these defines? something like
>>
>> /* uart3 */
>> static struct omap_hwmod omap44xx_uart3_hwmod = {
>>         .name           = "uart3",
>>         .class          = &omap44xx_uart_hwmod_class,
>>         .clkdm_name     = "l4_per_clkdm",
>> #ifdef CONFIG_DEBUG_OMAP4UART3
>>         .flags          = HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET |
>>                                 HWMOD_SWSUP_SIDLE_ACT,
>> #else
>>         .flags          = HWMOD_SWSUP_SIDLE_ACT,
>> #endif
>>         .main_clk       = "func_48m_fclk",
>>         .prcm = {
>>                 .omap4 = {
>>                         .clkctrl_offs = OMAP4_CM_L4PER_UART3_CLKCTRL_OFFSET,
>>                         .context_offs = OMAP4_RM_L4PER_UART3_CONTEXT_OFFSET,
>>                         .modulemode   = MODULEMODE_SWCTRL,
>>                 },
>>         },
>> };
>>
>> And same way for others? That way the cmdline parsing can be done away
>> with even for the non-DT case.
> 
> Yes we can do it that way. How about add a common macro for it if
> it's always the same? Then the .flags line would be just:
> 
> #define HWMOD_OMAP_UART_FLAGS(soc, port)
> ...
> 
> 	.flags		= HWMOD_OMAP_UART_FLAGS(4, 3),

Right, that seems much cleaner. I will send a patch out for it and get rid
of all the cmdline parsing in serial.c

regards
Rajendra
> 
>>> The current code in mach-omap2/serial.c is wrong, and is a hack
>>> needed for the pdata based booting. What's broken is that
>>> omap_serial_early_init() parses the cmdline for console, which
>>> itself is pretty nasty, and it won't work the right way as
>>> there's nothing stopping from having the earlycon in a different
>>> UART from the serial console. So we just want to get rid of the
>>> whole mach-omap2/serial.c once we're all DT.
>>>
>>> So to summarize, we have two bugs:
>>>
>>> 1. Omap hwmod code can reset UART while earlycon may be using
>>>    it. The fix to this is to use NO_IDLE and NO_RESET flags in
>>>    the hwmod code if CONFIG_DEBUG_OMAPxUARTy is specified.
>>>
>>> 2. A bug in drivers/tty/serial/omap-serial.c where the
>>>    missing context loss count can cause NULL context to be
>>>    initialized during driver probe causing port to hang for
>>>    earlycon. The fix for that is what Felipe has suggested or
>>>    fix it in the driver by removing the context loss count usage
>>>    and detect the need for context restore based on the UART
>>>    state.
>>>
>>> Or am I still missing something?
>>
>> No, thats pretty much the 2 issues we have.
> 
> OK thanks good to hear it's limited to earlycon issues.
> 
> Regards,
> 
> Tony
> 

