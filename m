From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 12/14] ARM: OMAP1: Timer32K: Fix timer32K for clockevents
 and clean it up
Date: Fri, 21 Mar 2008 12:38:24 +0100 (CET)
Message-ID: <alpine.LFD.1.00.0803211237500.3781@apollo.tec.linutronix.de>
References: <1205746958-11242-4-git-send-email-tony@atomide.com> <1205746958-11242-5-git-send-email-tony@atomide.com> <1205746958-11242-6-git-send-email-tony@atomide.com> <1205746958-11242-7-git-send-email-tony@atomide.com> <1205746958-11242-8-git-send-email-tony@atomide.com>
 <1205746958-11242-9-git-send-email-tony@atomide.com> <1205746958-11242-10-git-send-email-tony@atomide.com> <1205746958-11242-11-git-send-email-tony@atomide.com> <1205746958-11242-12-git-send-email-tony@atomide.com> <1205746958-11242-13-git-send-email-tony@atomide.com>
 <20080320165243.GD16166@flint.arm.linux.org.uk> <87y78dntfz.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:58690 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754928AbYCULkF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Mar 2008 07:40:05 -0400
In-Reply-To: <87y78dntfz.fsf@paris.hilman.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Thu, 20 Mar 2008, Kevin Hilman wrote:

> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > On Mon, Mar 17, 2008 at 11:42:36AM +0200, Tony Lindgren wrote:
> >> This patch fixes timer32k for clockevents and syncs it with
> >> linux-omap tree.
> >> 
> >> Signed-off-by: Tony Lindgren <tony@atomide.com>
> >> ---
> >>  arch/arm/mach-omap1/timer32k.c |   20 ++++++++++++++------
> >>  1 files changed, 14 insertions(+), 6 deletions(-)
> >> 
> >>...
> >> @@ -126,9 +131,9 @@ static void omap_32k_timer_set_mode(enum clock_event_mode mode,
> >>  
> >>  	switch (mode) {
> >>  	case CLOCK_EVT_MODE_PERIODIC:
> >> +	case CLOCK_EVT_MODE_ONESHOT:
> >>  		omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
> >>  		break;
> >> -	case CLOCK_EVT_MODE_ONESHOT:
> >
> > I didn't think an event was supposed to be programmed to fire when one
> > shot mode is selected - from the other implementations, it appears that
> > the timer should be disabled until set_next_event() has been called.
> 
> That is correct.  The 'start' should only be happening for the
> periodic mode.  This following change should be done.

Yup. Oneshot mode is programmed from the clockevents framework.

Thanks,
	tglx
 
> Kevin
> 
> 
> diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
> index 905e735..0d9b02e 100644
> --- a/arch/arm/mach-omap1/timer32k.c
> +++ b/arch/arm/mach-omap1/timer32k.c
> @@ -131,9 +131,8 @@ static void omap_32k_timer_set_mode(enum clock_event_mode mode,
>  
>  	switch (mode) {
>  	case CLOCK_EVT_MODE_PERIODIC:
> -	case CLOCK_EVT_MODE_ONESHOT:
>  		omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
> -		break;
> +	case CLOCK_EVT_MODE_ONESHOT:
>  	case CLOCK_EVT_MODE_UNUSED:
>  	case CLOCK_EVT_MODE_SHUTDOWN:
>  		break;
> 
