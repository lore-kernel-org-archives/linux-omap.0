From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/5] OMAP4: PM: Use the lowpwrstatechange feature on OMAP4
Date: Tue, 14 Dec 2010 11:51:52 -0800
Message-ID: <87zks8rv3b.fsf@deeprootsystems.com>
References: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
	<1292276969-29733-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:41898 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756853Ab0LNTv6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 14:51:58 -0500
Received: by gwb20 with SMTP id 20so840453gwb.1
        for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 11:51:58 -0800 (PST)
In-Reply-To: <1292276969-29733-2-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Mon, 13 Dec 2010 22:49:25 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Benoit Cousson <b-cousson@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> For pwrdm's which support lowperstatechange, do not try waking
> up the domain to put it back to deeper sleep state.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Benoit Cousson <b-cousson@ti.com>

Re: $SUBJECT, the rather than using the cryptic lowpwrstchange name from the 
pwrdm API, just use the more readable "low-power state change"

Also, readability/flow, I have some questions/comments...

> ---
>  arch/arm/mach-omap2/pm.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index cf1c4c9..dc68044 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -114,6 +114,14 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>  		return ret;
>  
>  	if (pwrdm_read_pwrst(pwrdm) < PWRDM_POWER_ON) {
> +		if ((pwrdm_read_pwrst(pwrdm) > state) &&
> +			(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE)) {
> +				ret = pwrdm_set_next_pwrst(pwrdm, state);
> +				pwrdm_set_lowpwrstchange(pwrdm);
> +				pwrdm_wait_transition(pwrdm);
> +				pwrdm_state_switch(pwrdm);
> +				return ret;

Personally, I'd prefer if this function flowed through better instead of
the early return in order to emphasize the common code.

Rather than the return here, can you just set the low-power state change
bit here (and put the clkdm_wakeup + sleep_switch = 1 into the else
clause?

Or, does the next state have to be set before the low-power state change
bit?

Basically, what I'm getting at is this should be a single function with
common flow.  The conditional code based on low-power state change
should be isolated instead of having a special path.

Kevin

> +		}
>  		omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
>  		sleep_switch = 1;
>  		pwrdm_wait_transition(pwrdm);
