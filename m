From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 02/17][V2] ARM: OMAP4: cpuidle - Declare the states with
	the driver declaration
Date: Mon, 09 Apr 2012 15:37:24 -0700
Message-ID: <87vcl8a5wb.fsf@ti.com>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
	<1333570371-1389-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1333570371-1389-3-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
	(Daniel Lezcano's message of "Wed, 4 Apr 2012 22:12:36 +0200")
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> The cpuidle API allows to declare statically the states in the driver
> structure. Let's use it.
> We do no longer need the fill_cstate function called at runtime and
> by the way adding more instructions at boot time.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Reviewed-by: Jean Pihet <j-pihet-l0cyMroinI0@public.gmane.org>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-omap2/cpuidle44xx.c |   57 +++++++++++++++++++++---------------
>  1 files changed, 33 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index ee0bc50..6d86b59 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -132,21 +132,39 @@ struct cpuidle_driver omap4_idle_driver = {
>  	.name				= "omap4_idle",
>  	.owner				= THIS_MODULE,
>  	.en_core_tk_irqen		= 1,
> +	.states = {
> +		{
> +			/* C1 - CPU0 ON + CPU1 ON + MPU ON */
> +			.exit_latency = 2 + 2,
> +			.target_residency = 5,
> +			.flags = CPUIDLE_FLAG_TIME_VALID,
> +			.enter = omap4_enter_idle,
> +			.name = "C1",
> +			.desc = "MPUSS ON"
> +		},
> +		{
> +                        /* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
> +			.exit_latency = 328 + 440,
> +			.target_residency = 960,
> +			.flags = CPUIDLE_FLAG_TIME_VALID,
> +			.enter = omap4_enter_idle,
> +			.name = "C2",
> +			.desc = "MPUSS CSWR",
> +		},
> +		{
> +			/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
> +			.exit_latency = 460 + 518,
> +			.target_residency = 1100,
> +			.flags = CPUIDLE_FLAG_TIME_VALID,
> +			.enter = omap4_enter_idle,
> +			.name = "C3",
> +			.desc = "MPUSS OSWR",
> +		},
> +	},
> +	.state_count = OMAP4_NUM_STATES,

I think you can drop OMAP4_NUM_STATES here, and just use:

	.state_count = ARRAY_SIZE(omap4_idle_driver.states),

Then drop OMAP4_NUM_STATES all together in patch 3.

Kevin
