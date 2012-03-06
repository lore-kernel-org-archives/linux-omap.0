From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 1/4] ARM: OMAP4: suspend: Program all domains to retention
Date: Mon, 05 Mar 2012 16:33:31 -0800
Message-ID: <871up6in50.fsf@ti.com>
References: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
	<1330529106-10423-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:59115 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932091Ab2CFAdn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 19:33:43 -0500
Received: by mail-pz0-f47.google.com with SMTP id o14so5061061dad.34
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 16:33:32 -0800 (PST)
In-Reply-To: <1330529106-10423-2-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Wed, 29 Feb 2012 17:25:03 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Tero Kristo <t-kristo@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> Remove the FIXME's in the suspend sequence since
> we now intend to support system level RET support.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

So this is the only patch in this series that is still needed.  However...

It doesn't seem like this all by itself is ready for mainline as we'll
suddenly start putting all powerdomains in retention without any
additional support.

I guess at a minimum it needs working IO wakeup support from the IO
daisy chain series.  Are there other dependencies here?

If not, I can queue this when Paul is ready to merge the IO wakeup
stuff.

Kevin

> ---
>  arch/arm/mach-omap2/pm44xx.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index c264ef7..1ab30a3 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -151,12 +151,6 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
>  	if (!strncmp(pwrdm->name, "cpu", 3))
>  		return 0;
>  
> -	/*
> -	 * FIXME: Remove this check when core retention is supported
> -	 * Only MPUSS power domain is added in the list.
> -	 */
> -	if (strcmp(pwrdm->name, "mpu_pwrdm"))
> -		return 0;
>  
>  	pwrst = kmalloc(sizeof(struct power_state), GFP_ATOMIC);
>  	if (!pwrst)
