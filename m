From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 1/2] Revert "ARM: OMAP2+: Fix serial init for device tree
 based booting"
Date: Fri, 12 Jul 2013 14:29:56 +0530
Message-ID: <51DFC58C.7030105@ti.com>
References: <1373539986-27272-1-git-send-email-rnayak@ti.com> <1373539986-27272-2-git-send-email-rnayak@ti.com> <20130712072051.GA7656@atomide.com> <51DFB0E4.6040007@ti.com> <20130712080305.GD7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47583 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757361Ab3GLJA1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Jul 2013 05:00:27 -0400
In-Reply-To: <20130712080305.GD7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, mpfj-list@newflow.co.uk, sourav.poddar@ti.com, paul@pwsan.com, balbi@ti.com

On Friday 12 July 2013 01:33 PM, Tony Lindgren wrote:
> * Rajendra Nayak <rnayak@ti.com> [130712 00:38]:
>> On Friday 12 July 2013 12:50 PM, Tony Lindgren wrote:
>>> * Rajendra Nayak <rnayak@ti.com> [130711 03:59]:
>>>> This reverts commit 82702ea11ddfe0e43382e1fa5b66d807d8114916.
>>>>
>>>> The above commit stubbed out omap_serial_early_init() in case of
>>>> DT build thinking it was doing the serial port initializations.
>>>
>>> Well not really. It was done to cut dependency between device
>>> tree initialized drivers and pdata initialized drivers.
>>>  
>>>> omap_serial_early_init() however does not do the serial port
>>>> inits (its instead done by omap_serial_init_port()) instead
>>>> it sets the HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET flags
>>>> for the console uart which causes hwmod to avoid doing a reset
>>>> followed by the idling of the console uart.
>>>>
>>>> This is still needed even in the DT case.
>>>
>>> This fix is going the wrong way.
>>>
>>> The console is working fine with DT based booting for me,
>>> except for the earlyprintk fix needed.
>>
>> It works on omap4 and omap5. It won't work on any
>> am33xx devices.
> 
> OK. I assume the regular serial onsole works just fine, what does
> not work is the earlyprintk for am33xx?

Yes, thats right.

> 
>>> And there should not be any need to parse cmdline for console
>>> as omap-serial.c sets it up and already knows about it.
>>>
>>> Care to state what exactly this attempts to fix and for which
>>> omaps? If this is only needed for am33xx, then why?
>>
>> Yes, this is needed only for am33xx because am33xx hwmod rightly
>> had the hwmod flags for NO_IDLE and NO_RESET removed and omap4
>> and omap5 wrongly still carry them around.
> 
> OK.
>  
>> Just try applying PATCH 2/2 of this series and it won't work on the
>> omap4 sdp anymore.
> 
> OK, so that's only for earlyprintk then?

yes,

> 
> If so, it seems the right fix is to set the NO_IDLE and NO_RESET
> flags based on ifdef CONFIG_DEBUG_OMAP4UART3 etc as that is selected
> in the Kconfig now.

ok makes sense. It seems like the static data in hwmod can be populated
based on these defines? something like

/* uart3 */
static struct omap_hwmod omap44xx_uart3_hwmod = {
        .name           = "uart3",
        .class          = &omap44xx_uart_hwmod_class,
        .clkdm_name     = "l4_per_clkdm",
#ifdef CONFIG_DEBUG_OMAP4UART3
        .flags          = HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET |
                                HWMOD_SWSUP_SIDLE_ACT,
#else
        .flags          = HWMOD_SWSUP_SIDLE_ACT,
#endif
        .main_clk       = "func_48m_fclk",
        .prcm = {
                .omap4 = {
                        .clkctrl_offs = OMAP4_CM_L4PER_UART3_CLKCTRL_OFFSET,
                        .context_offs = OMAP4_RM_L4PER_UART3_CONTEXT_OFFSET,
                        .modulemode   = MODULEMODE_SWCTRL,
                },
        },
};

And same way for others? That way the cmdline parsing can be done away
with even for the non-DT case.

> 
> The current code in mach-omap2/serial.c is wrong, and is a hack
> needed for the pdata based booting. What's broken is that
> omap_serial_early_init() parses the cmdline for console, which
> itself is pretty nasty, and it won't work the right way as
> there's nothing stopping from having the earlycon in a different
> UART from the serial console. So we just want to get rid of the
> whole mach-omap2/serial.c once we're all DT.
> 
> So to summarize, we have two bugs:
> 
> 1. Omap hwmod code can reset UART while earlycon may be using
>    it. The fix to this is to use NO_IDLE and NO_RESET flags in
>    the hwmod code if CONFIG_DEBUG_OMAPxUARTy is specified.
> 
> 2. A bug in drivers/tty/serial/omap-serial.c where the
>    missing context loss count can cause NULL context to be
>    initialized during driver probe causing port to hang for
>    earlycon. The fix for that is what Felipe has suggested or
>    fix it in the driver by removing the context loss count usage
>    and detect the need for context restore based on the UART
>    state.
> 
> Or am I still missing something?

No, thats pretty much the 2 issues we have.

regards,
Rajendra
> 
> Regards,
> 
> Tony
> 

