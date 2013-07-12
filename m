From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] Revert "ARM: OMAP2+: Fix serial init for device
 tree based booting"
Date: Fri, 12 Jul 2013 01:03:05 -0700
Message-ID: <20130712080305.GD7656@atomide.com>
References: <1373539986-27272-1-git-send-email-rnayak@ti.com>
 <1373539986-27272-2-git-send-email-rnayak@ti.com>
 <20130712072051.GA7656@atomide.com>
 <51DFB0E4.6040007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30321 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757236Ab3GLIDL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jul 2013 04:03:11 -0400
Content-Disposition: inline
In-Reply-To: <51DFB0E4.6040007@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, mpfj-list@newflow.co.uk, sourav.poddar@ti.com, paul@pwsan.com, balbi@ti.com

* Rajendra Nayak <rnayak@ti.com> [130712 00:38]:
> On Friday 12 July 2013 12:50 PM, Tony Lindgren wrote:
> > * Rajendra Nayak <rnayak@ti.com> [130711 03:59]:
> >> This reverts commit 82702ea11ddfe0e43382e1fa5b66d807d8114916.
> >>
> >> The above commit stubbed out omap_serial_early_init() in case of
> >> DT build thinking it was doing the serial port initializations.
> > 
> > Well not really. It was done to cut dependency between device
> > tree initialized drivers and pdata initialized drivers.
> >  
> >> omap_serial_early_init() however does not do the serial port
> >> inits (its instead done by omap_serial_init_port()) instead
> >> it sets the HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET flags
> >> for the console uart which causes hwmod to avoid doing a reset
> >> followed by the idling of the console uart.
> >>
> >> This is still needed even in the DT case.
> > 
> > This fix is going the wrong way.
> > 
> > The console is working fine with DT based booting for me,
> > except for the earlyprintk fix needed.
> 
> It works on omap4 and omap5. It won't work on any
> am33xx devices.

OK. I assume the regular serial onsole works just fine, what does
not work is the earlyprintk for am33xx?

> > And there should not be any need to parse cmdline for console
> > as omap-serial.c sets it up and already knows about it.
> > 
> > Care to state what exactly this attempts to fix and for which
> > omaps? If this is only needed for am33xx, then why?
> 
> Yes, this is needed only for am33xx because am33xx hwmod rightly
> had the hwmod flags for NO_IDLE and NO_RESET removed and omap4
> and omap5 wrongly still carry them around.

OK.
 
> Just try applying PATCH 2/2 of this series and it won't work on the
> omap4 sdp anymore.

OK, so that's only for earlyprintk then?

If so, it seems the right fix is to set the NO_IDLE and NO_RESET
flags based on ifdef CONFIG_DEBUG_OMAP4UART3 etc as that is selected
in the Kconfig now.

The current code in mach-omap2/serial.c is wrong, and is a hack
needed for the pdata based booting. What's broken is that
omap_serial_early_init() parses the cmdline for console, which
itself is pretty nasty, and it won't work the right way as
there's nothing stopping from having the earlycon in a different
UART from the serial console. So we just want to get rid of the
whole mach-omap2/serial.c once we're all DT.

So to summarize, we have two bugs:

1. Omap hwmod code can reset UART while earlycon may be using
   it. The fix to this is to use NO_IDLE and NO_RESET flags in
   the hwmod code if CONFIG_DEBUG_OMAPxUARTy is specified.

2. A bug in drivers/tty/serial/omap-serial.c where the
   missing context loss count can cause NULL context to be
   initialized during driver probe causing port to hang for
   earlycon. The fix for that is what Felipe has suggested or
   fix it in the driver by removing the context loss count usage
   and detect the need for context restore based on the UART
   state.

Or am I still missing something?

Regards,

Tony
