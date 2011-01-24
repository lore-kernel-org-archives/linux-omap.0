From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/5] ARM: twd: Add context save restore support
Date: Mon, 24 Jan 2011 16:46:08 +0530
Message-ID: <fae59ce4176caaa32c9515eb2e425328@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
 <1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com>
 <20110124110609.GJ16202@n2100.arm.linux.org.uk> <20110124111114.GA19409@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:56861 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752155Ab1AXLQL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 06:16:11 -0500
Received: by mail-fx0-f45.google.com with SMTP id 12so4217503fxm.32
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 03:16:10 -0800 (PST)
In-Reply-To: <20110124111114.GA19409@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, ccross@android.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Monday, January 24, 2011 4:41 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel@lists.infradead.org; catalin.marinas@arm.com;
> ccross@android.com; linus.ml.walleij@gmail.com; linux-
> omap@vger.kernel.org
> Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
>
> On Mon, Jan 24, 2011 at 11:06:09AM +0000, Russell King - ARM Linux
> wrote:
> > On Mon, Jan 24, 2011 at 02:21:17PM +0530, Santosh Shilimkar wrote:
> > > In CPU low power state, local timer looses its register context.
> This
> > > patch adds context save restore hooks which can be used by
> platforms
> > > appropriately.
> >
> > I thought the whole point of CLOCK_EVT_FEAT_C3STOP was that the
> generic
> > timer stuff wouldn't rely on it being kept alive?
> >
> > Hmm, it looks like we bypass the clockevents code by only setting
> the
> > TWD load value at initialization time, not when we switch to
> periodic
> > mode.  We really ought to rewrite it whenever we switch back to
> periodic
> > mode.
> >
> > I suspect fixing that means you won't need this save/restore
> support.
>
> Untested, but should do what's required.
:) I was just typing an email and you sent a patch. Will test this
and update you.

>
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index fd91566..60636f4 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -36,6 +36,7 @@ static void twd_set_mode(enum clock_event_mode
> mode,
>  		/* timer load already set up */
>  		ctrl = TWD_TIMER_CONTROL_ENABLE |
> TWD_TIMER_CONTROL_IT_ENABLE
>  			| TWD_TIMER_CONTROL_PERIODIC;
> +		__raw_writel(twd_timer_rate / HZ, twd_base +
> TWD_TIMER_LOAD);
>  		break;
>  	case CLOCK_EVT_MODE_ONESHOT:
>  		/* period set, and timer enabled in 'next_event' hook */
> @@ -81,7 +82,7 @@ int twd_timer_ack(void)
>
>  static void __cpuinit twd_calibrate_rate(void)
>  {
> -	unsigned long load, count;
> +	unsigned long count;
>  	u64 waitjiffies;
>
>  	/*
> @@ -116,10 +117,6 @@ static void __cpuinit twd_calibrate_rate(void)
>  		printk("%lu.%02luMHz.\n", twd_timer_rate / 1000000,
>  			(twd_timer_rate / 1000000) % 100);
>  	}
> -
> -	load = twd_timer_rate / HZ;
> -
> -	__raw_writel(load, twd_base + TWD_TIMER_LOAD);
>  }
>
>  /*
