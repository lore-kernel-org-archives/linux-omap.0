From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: [PATCH] power management: remove some useless code
	from	arm platforms
Date: Fri, 27 Apr 2007 01:12:26 +0400
Message-ID: <463115BA.70505@gmail.com>
References: <1177604177.6814.81.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177604177.6814.81.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-omap-open-source@linux.omap.com, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

Johannes Berg wrote:
> This patch kills some useless code omap1/omap2.
Although the change looks harmless it'd be nice  CC-ing
appropriate "arch" or "mach" lists.

Added omap list to CC.

BTW, you change OMAP stuff only, so your subject is slightly irrelevant.


Regards,
Dmitry
>
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
>
> ---
>  arch/arm/mach-omap1/pm.c |   36 ++++++------------------------------
>  arch/arm/mach-omap2/pm.c |   38 ++++++--------------------------------
>  2 files changed, 12 insertions(+), 62 deletions(-)
>
> --- wireless-dev.orig/arch/arm/mach-omap1/pm.c	2007-04-26 17:23:20.263249310 +0200
> +++ wireless-dev/arch/arm/mach-omap1/pm.c	2007-04-26 17:28:00.003249310 +0200
> @@ -620,26 +620,11 @@ static void (*saved_idle)(void) = NULL;
>   */
>  static int omap_pm_prepare(suspend_state_t state)
>  {
> -	int error = 0;
> -
>  	/* We cannot sleep in idle until we have resumed */
>  	saved_idle = pm_idle;
>  	pm_idle = NULL;
>  
> -	switch (state)
> -	{
> -	case PM_SUSPEND_STANDBY:
> -	case PM_SUSPEND_MEM:
> -		break;
> -
> -	case PM_SUSPEND_DISK:
> -		return -ENOTSUPP;
> -
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return error;
> +	return 0;
>  }
>  
>  
> @@ -651,20 +636,11 @@ static int omap_pm_prepare(suspend_state
>  
>  static int omap_pm_enter(suspend_state_t state)
>  {
> -	switch (state)
> -	{
> -	case PM_SUSPEND_STANDBY:
> -	case PM_SUSPEND_MEM:
> -		omap_pm_suspend();
> -		break;
> -
> -	case PM_SUSPEND_DISK:
> -		return -ENOTSUPP;
> -
> -	default:
> -		return -EINVAL;
> -	}
> -
> +	/*
> +	 * since we mark only "mem" as valid
> +	 * there's no need to check "state" here
> +	 */
> +	omap_pm_suspend();
>  	return 0;
>  }
>  
> --- wireless-dev.orig/arch/arm/mach-omap2/pm.c	2007-04-26 17:23:20.403249310 +0200
> +++ wireless-dev/arch/arm/mach-omap2/pm.c	2007-04-26 17:28:20.323249310 +0200
> @@ -73,26 +73,11 @@ void omap2_pm_idle(void)
>  
>  static int omap2_pm_prepare(suspend_state_t state)
>  {
> -	int error = 0;
> -
>  	/* We cannot sleep in idle until we have resumed */
>  	saved_idle = pm_idle;
>  	pm_idle = NULL;
>  
> -	switch (state)
> -	{
> -	case PM_SUSPEND_STANDBY:
> -	case PM_SUSPEND_MEM:
> -		break;
> -
> -	case PM_SUSPEND_DISK:
> -		return -ENOTSUPP;
> -
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return error;
> +	return 0;
>  }
>  
>  #define INT0_WAKE_MASK	(OMAP_IRQ_BIT(INT_24XX_GPIO_BANK1) |	\
> @@ -345,22 +330,11 @@ static int omap2_pm_suspend(void)
>  
>  static int omap2_pm_enter(suspend_state_t state)
>  {
> -	int ret = 0;
> -
> -	switch (state)
> -	{
> -	case PM_SUSPEND_STANDBY:
> -	case PM_SUSPEND_MEM:
> -		ret = omap2_pm_suspend();
> -		break;
> -	case PM_SUSPEND_DISK:
> -		ret = -ENOTSUPP;
> -		break;
> -	default:
> -		ret = -EINVAL;
> -	}
> -
> -	return ret;
> +	/*
> +	 * since we mark only 'mem' as valid, there's
> +	 * no need to check 'state' here
> +	 */
> +	return omap2_pm_suspend();
>  }
>  
>  static int omap2_pm_finish(suspend_state_t state)
>
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>
