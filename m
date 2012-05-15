From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv5 1/8] ARM: OMAP4: suspend: Program all domains to retention
Date: Tue, 15 May 2012 12:52:46 -0700
Message-ID: <87fwb1jk6p.fsf@ti.com>
References: <1336989796-26594-1-git-send-email-t-kristo@ti.com>
	<1336989796-26594-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:36818 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966599Ab2EOTwr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 15:52:47 -0400
Received: by dajz8 with SMTP id z8so7791064daj.2
        for <linux-omap@vger.kernel.org>; Tue, 15 May 2012 12:52:46 -0700 (PDT)
In-Reply-To: <1336989796-26594-2-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Mon, 14 May 2012 13:03:09 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Tero Kristo <t-kristo@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> Remove the FIXME's in the suspend sequence since
> we now intend to support system level RET support.

minor: this should probably go at the end of the series, after retention
is supported.  Otherwise, ending up with only this patch applied
(e.g. during a git bisect) will lead to a broken boot I suspect.

Kevin

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/pm44xx.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index 8856253..31990d5 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -101,12 +101,6 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
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
