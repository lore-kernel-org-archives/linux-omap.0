From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 1/8] ARM: OMAP2+: PM: protect the power domain state change
 by a mutex
Date: Wed, 20 Jun 2012 14:47:33 +0530
Message-ID: <4FE1952D.1020102@ti.com>
References: <1339685591-11177-1-git-send-email-j-pihet@ti.com> <1339685591-11177-2-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:40090 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751726Ab2FTJRk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jun 2012 05:17:40 -0400
Received: by obbwc20 with SMTP id wc20so11357292obb.3
        for <linux-omap@vger.kernel.org>; Wed, 20 Jun 2012 02:17:39 -0700 (PDT)
In-Reply-To: <1339685591-11177-2-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Jean Pihet <j-pihet@ti.com>

On Thursday 14 June 2012 08:23 PM, Jean Pihet wrote:
> omap_set_pwrdm_state is intented to be the only API for changing
> a power domain state.

Yes, but there are others which are used to _read_ the power domain
state. Shouldn't those be protected too?

> This patch protects the power domains settings and structs from
> concurrent accesses to the function by using a mutex.
>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>
> ---
>   arch/arm/mach-omap2/pm.c          |    8 ++++++--
>   arch/arm/mach-omap2/powerdomain.c |    1 +
>   arch/arm/mach-omap2/powerdomain.h |    3 ++-
>   3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 9cb5ced..a05f00c 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -100,15 +100,17 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 pwrst)
>   	if (!pwrdm || IS_ERR(pwrdm))
>   		return -EINVAL;
>
> +	mutex_lock(&pwrdm->lock);
> +
>   	while (!(pwrdm->pwrsts&  (1<<  pwrst))) {
>   		if (pwrst == PWRDM_POWER_OFF)
> -			return ret;
> +			goto out;
>   		pwrst--;
>   	}
>
>   	next_pwrst = pwrdm_read_next_pwrst(pwrdm);
>   	if (next_pwrst == pwrst)
> -		return ret;
> +		goto out;
>
>   	curr_pwrst = pwrdm_read_pwrst(pwrdm);
>   	if (curr_pwrst<  PWRDM_POWER_ON) {
> @@ -141,6 +143,8 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 pwrst)
>   		break;
>   	}
>
> +out:
> +	mutex_unlock(&pwrdm->lock);
>   	return ret;
>   }
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 9611490..1641e72 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -102,6 +102,7 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
>   	INIT_LIST_HEAD(&pwrdm->voltdm_node);
>   	voltdm_add_pwrdm(voltdm, pwrdm);
>
> +	mutex_init(&pwrdm->lock);
>   	list_add(&pwrdm->node,&pwrdm_list);
>
>   	/* Initialize the powerdomain's state counter */
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
> index 8f88d65..bab84fc 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -19,7 +19,7 @@
>
>   #include<linux/types.h>
>   #include<linux/list.h>
> -
> +#include<linux/mutex.h>
>   #include<linux/atomic.h>
>
>   #include<plat/cpu.h>
> @@ -116,6 +116,7 @@ struct powerdomain {
>   	struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
>   	struct list_head node;
>   	struct list_head voltdm_node;
> +	struct mutex lock;
>   	int state;
>   	unsigned state_counter[PWRDM_MAX_PWRSTS];
>   	unsigned ret_logic_off_counter;

