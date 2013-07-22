From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ARM: OMAP3EVM: Marking omap3_evm_display_init() with
 CONFIG_BROKEN
Date: Mon, 22 Jul 2013 17:30:25 +0400
Message-ID: <51ED33F1.4000801@cogentembedded.com>
References: <alpine.DEB.2.02.1307220523380.4804@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1307220523380.4804@utopia.booyaka.com>
Sender: stable-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: stable@vger.kernel.org, tony@atomide.com, lokeshvutla@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com
List-Id: linux-omap@vger.kernel.org

Hello.

On 22-07-2013 9:29, Paul Walmsley wrote:

> From: Lokesh Vutla <lokeshvutla@ti.com>

> On 37xx EVM non-dt boot fails with current mainline,
> because of broken GPIO numbering in the board file
> that uses hardcoded GPIOs.

> So marking omap3_evm_display_init() with CONFIG_BROKEN
> for now as suggested by Tony as per the below link:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg90399.html

> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Tested-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

> ---

> Hi -stablers,

> OMAP37xx EVM does not boot on v3.10 without this patch, so please consider
> it for the v3.10 stable releases.  It is upstream already as commit ID
> 8fb61e8d84e673eebf31e564a83bb71a50b1ed48.  Perhaps if I had managed to
> test it sooner, we could have gotten it up during v3.10-rc, but, alas,
> stable it is...

>   arch/arm/mach-omap2/board-omap3evm.c |    4 ++++
>   1 file changed, 4 insertions(+)

> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index f76d0de..278bf25 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -174,6 +174,7 @@ static struct panel_sharp_ls037v7dw01_data omap3_evm_lcd_data = {
>   	.ud_gpio = OMAP3EVM_LCD_PANEL_UD,
>   };
>
> +#ifdef CONFIG_BROKEN
>   static void __init omap3_evm_display_init(void)
>   {
>   	int r;
> @@ -193,6 +194,7 @@ static void __init omap3_evm_display_init(void)
>   	else
>   		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
>   }

    Perhaps it's better to follow what Documentation/SubmittingPatches suggests:

#else
static inline __init void omap3_evm_display_init(void) {}

> +#endif
>
>   static struct omap_dss_device omap3_evm_lcd_device = {
>   	.name			= "lcd",
> @@ -715,7 +717,9 @@ static void __init omap3_evm_init(void)
>
>   	omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 310, NULL);
>   	omap3evm_init_smsc911x();
> +#ifdef CONFIG_BROKEN
>   	omap3_evm_display_init();
> +#endif

    ... and eliminate #ifdef here?

WBR, Sergei
