From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 12/15] ARM: OMAP: timer: Add suspend-resume callbacks
 for clockevent device
Date: Sat, 03 Nov 2012 13:15:03 +0100
Message-ID: <50950AC7.1030707@deeprootsystems.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-13-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:44385 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab2KCMPE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 08:15:04 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so1949040wib.1
        for <linux-omap@vger.kernel.org>; Sat, 03 Nov 2012 05:15:03 -0700 (PDT)
In-Reply-To: <1351859566-24818-13-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

On 11/02/2012 01:32 PM, Vaibhav Bedia wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
>
> The current OMAP timer code registers two timers -
> one as clocksource and one as clockevent.
> AM33XX has only one usable timer in the WKUP domain
> so one of the timers needs suspend-resume support
> to restore the configuration to pre-suspend state.

The changelog describes "what", but doesn't answer "why?"

> commit adc78e6 (timekeeping: Add suspend and resume
> of clock event devices) introduced .suspend and .resume
> callbacks for clock event devices. Leverages these
> callbacks to have AM33XX clockevent timer which is
> in not in WKUP domain to behave properly across system
> suspend.

You say it behaves properly without describing what improper
behavior is happening.

> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
>   arch/arm/mach-omap2/timer.c |   31 +++++++++++++++++++++++++++++++
>   1 files changed, 31 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 6584ee0..e8781fd 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -135,6 +135,35 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
>   	}
>   }
>
> +static void omap_clkevt_suspend(struct clock_event_device *unused)
> +{
> +	char name[10];
> +	struct omap_hwmod *oh;
> +
> +	sprintf(name, "timer%d", 2);

hard-coded timer ID?  the rest of the code is using timer_id

> +	oh = omap_hwmod_lookup(name);
> +	if (!oh)
> +		return;
> +
> +	omap_hwmod_idle(oh);
> +}
> +
> +static void omap_clkevt_resume(struct clock_event_device *unused)
> +{
> +	char name[10];
> +	struct omap_hwmod *oh;
> +
> +	sprintf(name, "timer%d", 2);
> +	oh = omap_hwmod_lookup(name);
> +	if (!oh)
> +		return;
> +
> +	omap_hwmod_enable(oh);
> +	__omap_dm_timer_load_start(&clkev,
> +			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
> +	__omap_dm_timer_int_enable(&clkev, OMAP_TIMER_INT_OVERFLOW);
> +}

I don't like the sprintf/hwmod_lookup for every suspend/resume.  Just add a
new file-global static 'struct omap_hwmod clockevt_oh' along side 
clockevent_gpt,
and assign it at init time in dmtimer_init_one.  Then you don't have to 
do this
sprintf/lookup on every suspend/resume.

Kevin

>   static struct clock_event_device clockevent_gpt = {
>   	.name		= "gp_timer",
>   	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> @@ -142,6 +171,8 @@ static struct clock_event_device clockevent_gpt = {
>   	.rating		= 300,
>   	.set_next_event	= omap2_gp_timer_set_next_event,
>   	.set_mode	= omap2_gp_timer_set_mode,
> +	.suspend	= omap_clkevt_suspend,
> +	.resume		= omap_clkevt_resume,
>   };
>
>   static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
>
