From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: fix typo "CONFIG_BRIDGE_DVFS"
Date: Mon, 1 Apr 2013 08:54:15 -0700
Message-ID: <20130401155414.GE10155@atomide.com>
References: <1364254205.1390.307.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1364254205.1390.307.camel@x61.thuisdomein>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Paul Bolle <pebolle@tiscali.nl> [130325 16:34]:
> Commit 90173882ed15a8034d6d162da5f343a2c7d87587 ("omap: add dsp platform
> device") used CONFIG_BRIDGE_DVFS were it obviously meant
> CONFIG_TIDSPBRIDGE_DVFS. Fix that.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested. As this typo has been in the tree since v2.6.37, this really
> needs some testing.

Thanks, applying into omap-for-v3.10/fixes-non-critical.

Regards,

Tony
 
>  arch/arm/mach-omap2/dsp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/dsp.c b/arch/arm/mach-omap2/dsp.c
> index b155500..b8208b4 100644
> --- a/arch/arm/mach-omap2/dsp.c
> +++ b/arch/arm/mach-omap2/dsp.c
> @@ -26,7 +26,7 @@
>  #include "control.h"
>  #include "cm2xxx_3xxx.h"
>  #include "prm2xxx_3xxx.h"
> -#ifdef CONFIG_BRIDGE_DVFS
> +#ifdef CONFIG_TIDSPBRIDGE_DVFS
>  #include "omap-pm.h"
>  #endif
>  
> @@ -35,7 +35,7 @@
>  static struct platform_device *omap_dsp_pdev;
>  
>  static struct omap_dsp_platform_data omap_dsp_pdata __initdata = {
> -#ifdef CONFIG_BRIDGE_DVFS
> +#ifdef CONFIG_TIDSPBRIDGE_DVFS
>  	.dsp_set_min_opp = omap_pm_dsp_set_min_opp,
>  	.dsp_get_opp = omap_pm_dsp_get_opp,
>  	.cpu_set_freq = omap_pm_cpu_set_freq,
> -- 
> 1.7.11.7
> 
