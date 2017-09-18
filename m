From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] arm: omap: dra7xx: Set OPT_CLKS_IN_RESET flag for gpio1
Date: Mon, 18 Sep 2017 17:09:51 +0530
Message-ID: <c8768202-96e1-8bda-7e09-ddf296c19c57@ti.com>
References: <1504694038-32159-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1504694038-32159-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 06 September 2017 04:03 PM, Keerthy wrote:
> gpio1 soft reset fails in the kexec path as the optional clock
> is not enabled hence enable the HWMOD_CONTROL_OPT_CLKS_IN_RESET
> flag for gpio1 hwmod.

A gentle ping on this as well.

> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index 7cc3247..6ae729a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1037,6 +1037,7 @@ struct omap_hwmod dra7xx_sha0_hwmod = {
>  	.name		= "gpio1",
>  	.class		= &dra7xx_gpio_hwmod_class,
>  	.clkdm_name	= "wkupaon_clkdm",
> +	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
>  	.main_clk	= "wkupaon_iclk_mux",
>  	.prcm = {
>  		.omap4 = {
> 
