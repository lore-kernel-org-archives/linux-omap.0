From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] CPUidle: always return with interrupts enabled
Date: Wed, 30 Sep 2009 23:21:33 +0200
Message-ID: <200909302321.33088.rjw@sisk.pl>
References: <1254332153-23493-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1254332153-23493-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 30 September 2009, Kevin Hilman wrote:
> In the case where cpuidle_idle_call() returns before changing state
> due to a need_resched(), it was returning with IRQs disabled.
> 
> This patch ensures IRQs are (re)enabled before returning.

Venki, any comments on this?

> Reported-by: Hemanth V <hemanthv@ti.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  drivers/cpuidle/cpuidle.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index ad41f19..12fdd39 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -76,8 +76,11 @@ static void cpuidle_idle_call(void)
>  #endif
>  	/* ask the governor for the next state */
>  	next_state = cpuidle_curr_governor->select(dev);
> -	if (need_resched())
> +	if (need_resched()) {
> +		local_irq_enable();
>  		return;
> +	}
> +
>  	target_state = &dev->states[next_state];
>  
>  	/* enter the state and update stats */

Best,
Rafael
