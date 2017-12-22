From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod_core: enable optional clocks before
 main clock
Date: Fri, 22 Dec 2017 15:10:22 +0530
Message-ID: <f9fea9e3-7ebb-9a78-92fc-85b7afe3a525@ti.com>
References: <1513934763-23966-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1513934763-23966-1-git-send-email-t-kristo@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Friday 22 December 2017 02:56 PM, Tero Kristo wrote:
> The optional clocks must be enabled before the main clock after the
> transition to clkctrl controlled clocks is done. Otherwise the module
> we attempt to enable might be stuck in transition.
> 
> Reported-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Tested the patch on both DRA7-EVM and DRA72-EVM. I no longer see the issue:

Tested-by: Keerthy <j-keerthy@ti.com>

> ---
> Hi Tony,
> 
> This patch fixes a regression seen in linux-next, where certain peripherals
> fail to enable after the clkctrl changes are in. The case seen has been
> with mcasp3, where it fails to transition to enabled during the audio
> driver probe. Not sure where you want to pick this up, maybe as early
> rc fixes if its too late to push this to linux-next?
> 
>  arch/arm/mach-omap2/omap_hwmod.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 7324048..340d05c 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -976,6 +976,9 @@ static int _enable_clocks(struct omap_hwmod *oh)
>  
>  	pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
>  
> +	if (oh->flags & HWMOD_OPT_CLKS_NEEDED)
> +		_enable_optional_clocks(oh);
> +
>  	if (oh->_clk)
>  		clk_enable(oh->_clk);
>  
> @@ -984,9 +987,6 @@ static int _enable_clocks(struct omap_hwmod *oh)
>  			clk_enable(os->_clk);
>  	}
>  
> -	if (oh->flags & HWMOD_OPT_CLKS_NEEDED)
> -		_enable_optional_clocks(oh);
> -
>  	/* The opt clocks are controlled by the device driver. */
>  
>  	return 0;
> 
