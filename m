From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v5 3/3] OMAP2+: voltage: add check for missing PMIC info in vp init
Date: Fri, 30 Sep 2011 14:10:19 -0700
Message-ID: <87aa9lhh38.fsf@ti.com>
References: <1317363153-10259-1-git-send-email-abhilash.kv@ti.com>
	<1317363153-10259-2-git-send-email-abhilash.kv@ti.com>
	<1317363153-10259-3-git-send-email-abhilash.kv@ti.com>
	<1317363153-10259-4-git-send-email-abhilash.kv@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317363153-10259-4-git-send-email-abhilash.kv@ti.com> (Abhilash
	K. V.'s message of "Fri, 30 Sep 2011 11:42:33 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Abhilash K V <abhilash.kv@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, paul@pwsan.com, aneesh@ti.com, santosh.shilimkar@ti.com, christian.gmeiner@gmail.com
List-Id: linux-omap@vger.kernel.org

Abhilash K V <abhilash.kv@ti.com> writes:

> From: Abhilash K V <abhilash.kv@ti.com>
>
> If PMIC info is not available in omap_vp_init(), abort.
>
> Signed-off-by: Abhilash K V <abhilash.kv@ti.com>

Looks good.

After minor fixup below, adding to the next round of voltage cleanups
(branch: for_3.2/voltage-cleanup-2.)

> ---
>  arch/arm/mach-omap2/vp.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
> index 66bd700..0ed3d13 100644
> --- a/arch/arm/mach-omap2/vp.c
> +++ b/arch/arm/mach-omap2/vp.c
> @@ -41,6 +41,13 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
>  	u32 val, sys_clk_rate, timeout, waittime;
>  	u32 vddmin, vddmax, vstepmin, vstepmax;
>  
> +	if (!voltdm->pmic || !voltdm->pmic->uv_to_vsel) {
> +		pr_err("%s: PMIC info requried to configure VP for "
> +			"vdd_%s not populated.Hence cannot initialize VP\n",

Added space after '.'

Thanks,

Kevin

> +			__func__, voltdm->name);
> +		return;
> +	}
> +
>  	if (!voltdm->read || !voltdm->write) {
>  		pr_err("%s: No read/write API for accessing vdd_%s regs\n",
>  			__func__, voltdm->name);
