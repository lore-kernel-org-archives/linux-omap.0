From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 08/25] OMAP4: PM: Keep static dep between MPUSS-EMIF and
	MPUSS-L3 and DUCATI-L3
Date: Thu, 08 Sep 2011 11:06:35 -0700
Message-ID: <87ehzqhpsk.fsf@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-9-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315144466-9395-9-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sun, 4 Sep 2011 19:24:09 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, rnayak@ti.com
List-Id: linux-omap@vger.kernel.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> As per OMAP4430 TRM, the dynamic dependency between MPUSS -> EMIF
> and MPUSS -> L3* and DUCATI -> L3 *clockdomains is enable by default.
> Refer register CM_MPU_DYNAMICDEP description for details.
>
> But these dynamic dependencies doesn't work as expected. The hardware
> recommendation is to keep above dependencies.

Minor nit on changelog wording...

The use of "above dependencies" here is a bit confusing, since the only
thing refered to above are dynamic dependencies.

I think this should be worked to be clear that what is being kept are
the *static* dependencies (assuming I understand it correctly.)


> Without this system locks up or randomly crashesh.

Is 'crashesh' a particular kind of crash. maybe a silent one?  ;)


> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/pm44xx.c |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index 4bbc6fe..35ba028 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -116,6 +116,8 @@ static void omap_default_idle(void)
>  static int __init omap4_pm_init(void)
>  {
>  	int ret;
> +	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm;
> +	struct clockdomain *ducati_clkdm, *l3_2_clkdm;
>  
>  	if (!cpu_is_omap44xx())
>  		return -ENODEV;
> @@ -128,6 +130,32 @@ static int __init omap4_pm_init(void)
>  		goto err2;
>  	}
>  
> +	/*
> +	 * The dynamic dependency between MPUSS -> MEMIF and
> +	 * MPUSS -> L3_* and DUCATI -> doesn't work as expected.
> +	 * The hardware recommendation is to keep above dependencies.

same here... "The hardware recommendation is to use static dependencies."

> +	 * Without this system locks up or randomly crashesh.
> +	 */
> +	mpuss_clkdm = clkdm_lookup("mpuss_clkdm");
> +	emif_clkdm = clkdm_lookup("l3_emif_clkdm");
> +	l3_1_clkdm = clkdm_lookup("l3_1_clkdm");
> +	l3_2_clkdm = clkdm_lookup("l3_2_clkdm");
> +	ducati_clkdm = clkdm_lookup("ducati_clkdm");
> +	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) ||
> +			(!l3_2_clkdm) || (!ducati_clkdm))
> +		goto err2;
> +
> +	ret = clkdm_add_wkdep(mpuss_clkdm, emif_clkdm);
> +	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_1_clkdm);
> +	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_2_clkdm);
> +	ret |= clkdm_add_wkdep(ducati_clkdm, l3_1_clkdm);
> +	ret |= clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);
> +	if (ret) {
> +		pr_err("Failed to add MPUSS -> L3/EMIF, DUCATI -> L3 "
> +				"wakeup dependency\n");
> +		goto err2;
> +	}
> +
>  #ifdef CONFIG_SUSPEND
>  	suspend_set_ops(&omap_pm_ops);
>  #endif /* CONFIG_SUSPEND */

Kevin
