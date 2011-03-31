From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 05/10] omap2+: Use dmtimer macros for clockevent
Date: Thu, 31 Mar 2011 14:35:26 -0700
Message-ID: <8762qz9dnl.fsf@ti.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
	<20110328222140.4046.91213.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:38459 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758915Ab1CaVfa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 17:35:30 -0400
Received: by mail-px0-f171.google.com with SMTP id 7so688298pxi.16
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 14:35:29 -0700 (PDT)
In-Reply-To: <20110328222140.4046.91213.stgit@baageli.muru.com> (Tony
	Lindgren's message of "Mon, 28 Mar 2011 15:21:40 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> This patch makes timer-gp.c to use only a subset of dmtimer
> functions without the need to initialize dmtimer code early.
>
> Note that omap_dmtimer_init_one can eventually be moved to
> omap2+ specific dmtimer.c.
>
> Also note that now with the inline functions, timer_set_next_event
> becomes more efficient in the lines of assembly code.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

In looking closer at this patch, I have a few questions.

[...]

> @@ -75,7 +97,8 @@ static struct irqaction omap2_gp_timer_irq = {
>  static int omap2_gp_timer_set_next_event(unsigned long cycles,
>  					 struct clock_event_device *evt)
>  {
> -	omap_dm_timer_set_load_start(gptimer, 0, 0xffffffff - cycles);
> +	__omap_dm_timer_load_start(clkev.io_base, OMAP_TIMER_CTRL_ST,
> +						0xffffffff - cycles, 1);
>  
>  	return 0;

The creation of macros is causing some readability concern, at least for
me...

In creating the macro versions of some of the functions, the macro
version actually has different behavior which makes reading the code a
little confusing.

I just noticed that the macro version of _load_start() doesn't actually
do the "start", so you added the OMAP_TIMER_CTRL_ST when calling it.
To do this, the macro version takes a 'ctrl' argument where as the
"real" version only takes the autoreload argument.

If you're going to keep the same function name (but just add the __
prefix, I would expect that the functionality of the function doesn't
change.

If the functionality of the macro is different from the "real" function,
it should probably just be given a different name.   In this case,
probably dropping the _start suffix is probably enough.

>  }
> @@ -85,13 +108,13 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
>  {
>  	u32 period;
>  
> -	omap_dm_timer_stop(gptimer);
> +	omap_dm_timer_stop(&clkev);
>  
>  	switch (mode) {
>  	case CLOCK_EVT_MODE_PERIODIC:
> -		period = clk_get_rate(omap_dm_timer_get_fclk(gptimer)) / HZ;
> +		period = clkev.rate / HZ;
>  		period -= 1;
> -		omap_dm_timer_set_load_start(gptimer, 1, 0xffffffff - period);
> +		omap_dm_timer_set_load_start(&clkev, 1, 0xffffffff - period);

Hmm, you're using the driver function here not the macro.  Is that
intended?

Why not use the macro version here with OMAP_TIMER_CTRL_AR |
OMAP_TIMER_CTRL_ST.

Kevin
