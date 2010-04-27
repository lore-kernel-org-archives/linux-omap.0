From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 12/22] OMAP3: PM: Minimizing the passing around of sr id in smartreflex.c
Date: Tue, 27 Apr 2010 12:02:00 -0700
Message-ID: <87pr1kius7.fsf@deeprootsystems.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
	<1271408597-3066-2-git-send-email-thara@ti.com>
	<1271408597-3066-3-git-send-email-thara@ti.com>
	<1271408597-3066-4-git-send-email-thara@ti.com>
	<1271408597-3066-5-git-send-email-thara@ti.com>
	<1271408597-3066-6-git-send-email-thara@ti.com>
	<1271408597-3066-7-git-send-email-thara@ti.com>
	<1271408597-3066-8-git-send-email-thara@ti.com>
	<1271408597-3066-9-git-send-email-thara@ti.com>
	<1271408597-3066-10-git-send-email-thara@ti.com>
	<1271408597-3066-11-git-send-email-thara@ti.com>
	<1271408597-3066-12-git-send-email-thara@ti.com>
	<1271408597-3066-13-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:58852 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224Ab0D0TCF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 15:02:05 -0400
Received: by pxi17 with SMTP id 17so2366889pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 12:02:05 -0700 (PDT)
In-Reply-To: <1271408597-3066-13-git-send-email-thara@ti.com> (Thara Gopinath's message of "Fri\, 16 Apr 2010 14\:33\:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch ensures that sr id is passed as a parameter only to
> public APIs in smartreflex.c and other APIs in smartreflex.c
> uses the omap_sr strucutres.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

Good change, but...

> ---
>  arch/arm/mach-omap2/smartreflex.c |   36 +++++++++++++-----------------------
>  1 files changed, 13 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index fffd5f7..c6942e9 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -190,16 +190,8 @@ static void sr_configure(struct omap_sr *sr)
>  	sr->is_sr_reset = 0;
>  }
>  
> -static void sr_start_vddautocomp(int srid)
> +static void sr_start_vddautocomp(struct omap_sr *sr)
>  {
> -	struct omap_sr *sr = _sr_lookup(srid);
> -
> -	if (!sr) {
> -		pr_warning("omap_sr struct corresponding to SR%d not found\n",
> -								srid + 1);
> -		return;
> -	}
> -
>  	if (!sr_class || !(sr_class->enable)) {
>  		pr_warning("smartreflex class driver not registered\n");
>  		return;
> @@ -211,30 +203,22 @@ static void sr_start_vddautocomp(int srid)
>  	}
>  
>  	sr->is_autocomp_active = 1;
> -	if (!sr_class->enable(srid)) {
> +	if (!sr_class->enable(sr->srid)) {

... the class3 layer is still taking SR ID as a parameter and it
should also just take an sr_info ptr.

Kevin
