From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 12/14] ARM: OMAP1: Timer32K: Fix timer32K for clockevents and clean it up
Date: Thu, 20 Mar 2008 16:52:43 +0000
Message-ID: <20080320165243.GD16166@flint.arm.linux.org.uk>
References: <1205746958-11242-4-git-send-email-tony@atomide.com> <1205746958-11242-5-git-send-email-tony@atomide.com> <1205746958-11242-6-git-send-email-tony@atomide.com> <1205746958-11242-7-git-send-email-tony@atomide.com> <1205746958-11242-8-git-send-email-tony@atomide.com> <1205746958-11242-9-git-send-email-tony@atomide.com> <1205746958-11242-10-git-send-email-tony@atomide.com> <1205746958-11242-11-git-send-email-tony@atomide.com> <1205746958-11242-12-git-send-email-tony@atomide.com> <1205746958-11242-13-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56237 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336AbYCTQxM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 12:53:12 -0400
Content-Disposition: inline
In-Reply-To: <1205746958-11242-13-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Mon, Mar 17, 2008 at 11:42:36AM +0200, Tony Lindgren wrote:
> This patch fixes timer32k for clockevents and syncs it with
> linux-omap tree.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap1/timer32k.c |   20 ++++++++++++++------
>  1 files changed, 14 insertions(+), 6 deletions(-)
> 
>...
> @@ -126,9 +131,9 @@ static void omap_32k_timer_set_mode(enum clock_event_mode mode,
>  
>  	switch (mode) {
>  	case CLOCK_EVT_MODE_PERIODIC:
> +	case CLOCK_EVT_MODE_ONESHOT:
>  		omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
>  		break;
> -	case CLOCK_EVT_MODE_ONESHOT:

I didn't think an event was supposed to be programmed to fire when one
shot mode is selected - from the other implementations, it appears that
the timer should be disabled until set_next_event() has been called.
However, this isn't documented anywhere.

Thomas?
