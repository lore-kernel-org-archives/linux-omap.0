From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 07/10] ARM: OMAP5 / DRA7: Enable CPU RET on suspend
Date: Wed, 27 Aug 2014 11:58:09 -0700
Message-ID: <7hbnr5dake.fsf@paris.lan>
References: <1408716154-26101-1-git-send-email-nm@ti.com>
	<1408716154-26101-8-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408716154-26101-8-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Fri, 22 Aug 2014 09:02:31 -0500")
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> On OMAP5 / DRA7, prevent a CPU powerdomain OFF and resulting MPU OSWR
> and instead attempt a CPU RET and side effect, MPU RET in suspend.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> [nm@ti.com: update to do save_state only on DRA7]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c |    4 ++++
>  arch/arm/mach-omap2/omap-wakeupgen.c      |    2 +-
>  arch/arm/mach-omap2/pm44xx.c              |    9 +++++++--
>  3 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> index 207fce2..0d640eb 100644
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> @@ -242,6 +242,10 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
>  		save_state = 1;
>  		break;
>  	case PWRDM_POWER_RET:
> +		if (soc_is_omap54xx() || soc_is_dra7xx()) {

Aren't we trying to get away from these soc_* checks for anything other
than init code?

Kevin

> +			save_state = 0;
> +			break;
> +		}
>  	default:
>  		/*
>  		 * CPUx CSWR is invalid hardware state. Also CPUx OSWR
> diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
> index e844e16..87c1c0d 100644
> --- a/arch/arm/mach-omap2/omap-wakeupgen.c
> +++ b/arch/arm/mach-omap2/omap-wakeupgen.c
> @@ -381,7 +381,7 @@ static struct notifier_block irq_notifier_block = {
>  static void __init irq_pm_init(void)
>  {
>  	/* FIXME: Remove this when MPU OSWR support is added */
> -	if (!soc_is_omap54xx())
> +	if (!soc_is_omap54xx() && !soc_is_dra7xx())
>  		cpu_pm_register_notifier(&irq_notifier_block);
>  }
>  #else
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index b6f243d..c063833 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -36,6 +36,8 @@ struct power_state {
>  	struct list_head node;
>  };
>  
> +static u32 cpu_suspend_state = PWRDM_POWER_OFF;
> +
>  static LIST_HEAD(pwrst_list);
>  
>  #ifdef CONFIG_SUSPEND
> @@ -66,7 +68,7 @@ static int omap4_pm_suspend(void)
>  	 * domain CSWR is not supported by hardware.
>  	 * More details can be found in OMAP4430 TRM section 4.3.4.2.
>  	 */
> -	omap4_enter_lowpower(cpu_id, PWRDM_POWER_OFF);
> +	omap4_enter_lowpower(cpu_id, cpu_suspend_state);
>  
>  	/* Restore next powerdomain state */
>  	list_for_each_entry(pwrst, &pwrst_list, node) {
> @@ -112,8 +114,11 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
>  	 * through hotplug path and CPU0 explicitly programmed
>  	 * further down in the code path
>  	 */
> -	if (!strncmp(pwrdm->name, "cpu", 3))
> +	if (!strncmp(pwrdm->name, "cpu", 3)) {
> +		if (soc_is_omap54xx() || soc_is_dra7xx())
> +			cpu_suspend_state = PWRDM_POWER_RET;
>  		return 0;
> +	}
>  
>  	pwrst = kmalloc(sizeof(struct power_state), GFP_ATOMIC);
>  	if (!pwrst)
