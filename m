From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Powerdomain: Fix unchecked dereference of
 arch_pwrdm
Date: Wed, 27 Nov 2013 19:55:40 -0600
Message-ID: <5296A29C.50006@ti.com>
References: <1385553437-22568-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40116 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758459Ab3K1Bzn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Nov 2013 20:55:43 -0500
In-Reply-To: <1385553437-22568-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org
Cc: tony@atomide.com, dan.carpenter@oracle.com

On 11/27/2013 05:57 AM, Rajendra Nayak wrote:
> Commit 'cd8abed' "ARM: OMAP2+: Powerdomain: Remove the need to
> always have a voltdm associated to a pwrdm" leads to the following
> Smatch complaint:
> 
> arch/arm/mach-omap2/powerdomain.c:131 _pwrdm_register()
> 	 error: we previously assumed 'arch_pwrdm' could be null (see line 105)
> 
> So, fix the unchecked dereference of arch_pwrdm.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/powerdomain.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index e233dfc..93a2a6e 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -128,7 +128,8 @@ skip_voltdm:
>  	for (i = 0; i < pwrdm->banks; i++)
>  		pwrdm->ret_mem_off_counter[i] = 0;
>  
> -	arch_pwrdm->pwrdm_wait_transition(pwrdm);
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_wait_transition)
> +		arch_pwrdm->pwrdm_wait_transition(pwrdm);
>  	pwrdm->state = pwrdm_read_pwrst(pwrdm);
>  	pwrdm->state_counter[pwrdm->state] = 1;
>  
> 
Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
