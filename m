From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 5/6] Revert "ARM: OMAP2+: Provide alias to USB PHY
 clock"
Date: Wed, 9 Oct 2013 10:10:56 +0300
Message-ID: <52550180.1000506@ti.com>
References: <1381226799-29158-1-git-send-email-rogerq@ti.com>
 <1381226799-29158-6-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1381226799-29158-6-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 10/08/2013 01:06 PM, Roger Quadros wrote:
> This reverts commit 741532c4a995be11815cb72d4d7a48f442a22fea.
> 
> The proper clock reference is provided in device tree so we
> no longer need this.

Could you please Ack this one? I think it is best if it goes through Benoit's tree.

cheers,
-roger

> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/mach-omap2/board-generic.c |   23 +----------------------
>  1 files changed, 1 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index cd85b36..da4e9b2 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -15,7 +15,6 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/irqdomain.h>
> -#include <linux/clk.h>
>  
>  #include <asm/mach/arch.h>
>  
> @@ -36,21 +35,6 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
>  	{ }
>  };
>  
> -/*
> - * Create alias for USB host PHY clock.
> - * Remove this when clock phandle can be provided via DT
> - */
> -static void __init legacy_init_ehci_clk(char *clkname)
> -{
> -	int ret;
> -
> -	ret = clk_add_alias("main_clk", NULL, clkname, NULL);
> -	if (ret) {
> -		pr_err("%s:Failed to add main_clk alias to %s :%d\n",
> -						__func__, clkname, ret);
> -	}
> -}
> -
>  static void __init omap_generic_init(void)
>  {
>  	omap_sdrc_init(NULL, NULL);
> @@ -61,15 +45,10 @@ static void __init omap_generic_init(void)
>  	 * HACK: call display setup code for selected boards to enable omapdss.
>  	 * This will be removed when omapdss supports DT.
>  	 */
> -	if (of_machine_is_compatible("ti,omap4-panda")) {
> +	if (of_machine_is_compatible("ti,omap4-panda"))
>  		omap4_panda_display_init_of();
> -		legacy_init_ehci_clk("auxclk3_ck");
> -
> -	}
>  	else if (of_machine_is_compatible("ti,omap4-sdp"))
>  		omap_4430sdp_display_init_of();
> -	else if (of_machine_is_compatible("ti,omap5-uevm"))
> -		legacy_init_ehci_clk("auxclk1_ck");
>  }
>  
>  #ifdef CONFIG_SOC_OMAP2420
> 
