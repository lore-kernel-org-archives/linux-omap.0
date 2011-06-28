From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 6/8] davinci: da850: add remoteproc dsp device
Date: Tue, 28 Jun 2011 14:18:19 +0400
Message-ID: <4E09AA6B.9090609@mvista.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-7-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1308640714-17961-7-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: davinci-linux-open-source <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 21.06.2011 11:18, Ohad Ben-Cohen wrote:

> From: Mark Grosen <mgrosen-l0cyMroinI0@public.gmane.org>

> Add davinci remoteproc device for the da850's C674x dsp remote
> processor, and support it on the da850-evm and omapl138-hawk boards.

> Signed-off-by: Mark Grosen<mgrosen-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Ohad Ben-Cohen<ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
[...]

> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 133aac4..9280b1e 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -74,6 +74,13 @@ static struct clk pll0_aux_clk = {
>   	.flags		= CLK_PLL | PRE_PLL,
>   };
>
> +static struct clk pll0_sysclk1 = {
> +	.name		= "pll0_sysclk1",
> +	.parent		= &pll0_clk,
> +	.flags		= CLK_PLL,
> +	.div_reg	= PLLDIV1,
> +};
> +
>   static struct clk pll0_sysclk2 = {
>   	.name		= "pll0_sysclk2",
>   	.parent		= &pll0_clk,
> @@ -373,6 +380,12 @@ static struct clk spi1_clk = {
>   	.flags		= DA850_CLK_ASYNC3,
>   };
>
> +static struct clk dsp_clk = {
> +	.name		= "dsp",
> +	.parent		= &pll0_sysclk1,
> +	.lpsc		= DA8XX_LPSC0_GEM,
> +};
> +
>   static struct clk_lookup da850_clks[] = {
>   	CLK(NULL,		"ref",		&ref_clk),
>   	CLK(NULL,		"pll0",		&pll0_clk),
> @@ -419,6 +432,7 @@ static struct clk_lookup da850_clks[] = {
>   	CLK(NULL,		"usb20",	&usb20_clk),
>   	CLK("spi_davinci.0",	NULL,		&spi0_clk),
>   	CLK("spi_davinci.1",	NULL,		&spi1_clk),
> +	CLK(NULL,		"dsp",		&dsp_clk),
>   	CLK(NULL,		NULL,		NULL),
>   };

    How about also adding the clock for DA830?

> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index fc4e98e..3becfd1 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
[...]
> @@ -647,6 +648,20 @@ int __init da850_register_mmcsd1(struct davinci_mmc_config *config)
>   	da850_mmcsd1_device.dev.platform_data = config;
>   	return platform_device_register(&da850_mmcsd1_device);
>   }
> +
> +int __init da850_register_rproc(void)

    Please rename to da8xx_register_rproc() -- there's nothing DA850-specific 
here.

> +{
> +	struct platform_device *rproc;
> +	struct davinci_rproc_pdata rproc_pdata = {
> +		.name		= "dsp",
> +		.firmware	= "davinci-dsp.bin",

    Isn't the firmware DA8xx-specific?

WBR, Sergei
