From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] Revert "ARM: OMAP2+: Fix serial init for device
 tree based booting"
Date: Fri, 12 Jul 2013 05:33:31 -0700
Message-ID: <20130712123331.GJ7656@atomide.com>
References: <1373539986-27272-1-git-send-email-rnayak@ti.com>
 <1373539986-27272-2-git-send-email-rnayak@ti.com>
 <20130712072051.GA7656@atomide.com>
 <51DFB0E4.6040007@ti.com>
 <20130712080305.GD7656@atomide.com>
 <51DFC58C.7030105@ti.com>
 <20130712091827.GH7656@atomide.com>
 <51DFF294.9080501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44933 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932193Ab3GLMdg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jul 2013 08:33:36 -0400
Content-Disposition: inline
In-Reply-To: <51DFF294.9080501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, mpfj-list@newflow.co.uk, sourav.poddar@ti.com, paul@pwsan.com, balbi@ti.com

* Rajendra Nayak <rnayak@ti.com> [130712 05:18]:
> On Friday 12 July 2013 02:48 PM, Tony Lindgren wrote:
> > * Rajendra Nayak <rnayak@ti.com> [130712 02:06]:
> >> On Friday 12 July 2013 01:33 PM, Tony Lindgren wrote:
> >>>
> >>> OK, so that's only for earlyprintk then?
> >>
> >> yes,
> >>
> >>>
> >>> If so, it seems the right fix is to set the NO_IDLE and NO_RESET
> >>> flags based on ifdef CONFIG_DEBUG_OMAP4UART3 etc as that is selected
> >>> in the Kconfig now.
> >>
> >> ok makes sense. It seems like the static data in hwmod can be populated
> >> based on these defines? something like
> >>
> >> /* uart3 */
> >> static struct omap_hwmod omap44xx_uart3_hwmod = {
> >>         .name           = "uart3",
> >>         .class          = &omap44xx_uart_hwmod_class,
> >>         .clkdm_name     = "l4_per_clkdm",
> >> #ifdef CONFIG_DEBUG_OMAP4UART3
> >>         .flags          = HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET |
> >>                                 HWMOD_SWSUP_SIDLE_ACT,
> >> #else
> >>         .flags          = HWMOD_SWSUP_SIDLE_ACT,
> >> #endif
> >>         .main_clk       = "func_48m_fclk",
> >>         .prcm = {
> >>                 .omap4 = {
> >>                         .clkctrl_offs = OMAP4_CM_L4PER_UART3_CLKCTRL_OFFSET,
> >>                         .context_offs = OMAP4_RM_L4PER_UART3_CONTEXT_OFFSET,
> >>                         .modulemode   = MODULEMODE_SWCTRL,
> >>                 },
> >>         },
> >> };
> >>
> >> And same way for others? That way the cmdline parsing can be done away
> >> with even for the non-DT case.
> > 
> > Yes we can do it that way. How about add a common macro for it if
> > it's always the same? Then the .flags line would be just:
> > 
> > #define HWMOD_OMAP_UART_FLAGS(soc, port)
> > ...
> > 
> > 	.flags		= HWMOD_OMAP_UART_FLAGS(4, 3),
> 
> I started doing this and ended up with equal number of #ifdefs in the
> header :( Was the intention of doing this to reduce the #ifdefs? in which
> case maybe I am doing something wrong.

Hmm can't you use ## for substition in the macro to reduce the ifdefs
and have just one macro instead one for every debug port?

Regards,

Tony
