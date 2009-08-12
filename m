From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Warnings: pm branch
Date: Wed, 12 Aug 2009 07:15:58 -0700
Message-ID: <87d4712k4h.fsf@deeprootsystems.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702F5989815@dbde02.ent.ti.com>
	<873a7y74mj.fsf@deeprootsystems.com>
	<03d301ca1b32$14f97d10$LocalHost@wipultra793>
	<7803.10.24.255.18.1250081698.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:42825 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbZHLOQA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 10:16:00 -0400
Received: by wf-out-1314.google.com with SMTP id 26so10885wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2009 07:16:01 -0700 (PDT)
In-Reply-To: <7803.10.24.255.18.1250081698.squirrel@dbdmail.itg.ti.com> (Hemanth V.'s message of "Wed\, 12 Aug 2009 18\:24\:58 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, linux-omap@vger.kernel.org

"Hemanth V" <hemanthv@ti.com> writes:

[...]

> Below patch seems to fix the issue.

After looking closer, I think this is the right fix as the
cpuidle_idle_call() can return with interrupts disabled, but...

[...]

> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 8504a21..3014104 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -75,8 +75,10 @@ static void cpuidle_idle_call(void)
>  #endif
>  	/* ask the governor for the next state */
>  	next_state = cpuidle_curr_governor->select(dev);
> +
>  	if (need_resched())
> -		return;
> +		goto out;
> +
>  	target_state = &dev->states[next_state];
>
>  	/* enter the state and update stats */
> @@ -91,6 +93,12 @@ static void cpuidle_idle_call(void)
>  	/* give the governor an opportunity to reflect on the outcome */
>  	if (cpuidle_curr_governor->reflect)
>  		cpuidle_curr_governor->reflect(dev);
> +
> +	return;
> +

... I think you want to drop this return.  If it returns here, it
will still not enable IRQs.  I think it should just fall through
to the enable and return.

> +out:
> +	local_irq_enable();
> +	return;
>  }
>
>  /**


Kevin
