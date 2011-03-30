From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/5] OMAP3: l3: fix for "irq 10: nobody cared" message
Date: Wed, 30 Mar 2011 11:57:46 +0530
Message-ID: <4D92CD62.9060707@ti.com>
References: <1301419219-30547-1-git-send-email-omar.ramirez@ti.com> <1301419219-30547-2-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:60915 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753336Ab1C3G2D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 02:28:03 -0400
Received: by ywj3 with SMTP id 3so511979ywj.33
        for <linux-omap@vger.kernel.org>; Tue, 29 Mar 2011 23:28:01 -0700 (PDT)
In-Reply-To: <1301419219-30547-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, l-o <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, sricharan <r.sricharan@ti.com>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>

On 3/29/2011 10:50 PM, Omar Ramirez Luna wrote:
> If an error occurs in the L3 on any other initiator than MPU,
> the interrupt goes unhandled given that the 'base' register
> was calculated with the initialized err_source value (which
> coincidentally points to MPU) and not with the actual source
> of the error.
>
> Removed parenthesis that are not needed for the touched lines.
>
> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
> ---

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

>   arch/arm/mach-omap2/omap_l3_smx.c |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-omap2/omap_l3_smx.c
> index 5f2da75..4321e79 100644
> --- a/arch/arm/mach-omap2/omap_l3_smx.c
> +++ b/arch/arm/mach-omap2/omap_l3_smx.c
> @@ -196,11 +196,11 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
>   		/* No timeout error for debug sources */
>   	}
>
> -	base = ((l3->rt) + (*(omap3_l3_bases[int_type] + err_source)));
> -
>   	/* identify the error source */
>   	for (err_source = 0; !(status&  (1<<  err_source)); err_source++)
>   									;
> +
> +	base = l3->rt + *(omap3_l3_bases[int_type] + err_source);
>   	error = omap3_l3_readll(base, L3_ERROR_LOG);
>
>   	if (error) {

