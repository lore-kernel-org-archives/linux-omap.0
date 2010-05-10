From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/1] omap-sham: OMAP macros corrected
Date: Mon, 10 May 2010 20:14:16 +0800
Message-ID: <20100510121416.GA12769@gondor.apana.org.au>
References: <948fcc79dd3d31f4930d4b62bb7ca7a19949fd9a.1273493232.git.dmitry.kasatkin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-crypto-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <948fcc79dd3d31f4930d4b62bb7ca7a19949fd9a.1273493232.git.dmitry.kasatkin@nokia.com>
Sender: linux-crypto-owner@vger.kernel.org
To: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Mon, May 10, 2010 at 03:07:55PM +0300, Dmitry Kasatkin wrote:
> Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
> ---
>  arch/arm/mach-omap2/devices.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index beac46c..79dbf04 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -456,7 +456,7 @@ static inline void omap_init_mcspi(void) {}
>  
>  #if defined(CONFIG_CRYPTO_DEV_OMAP_SHAM) || defined(CONFIG_CRYPTO_DEV_OMAP_SHAM_MODULE)
>  
> -#ifdef CONFIG_ARCH_OMAP24XX
> +#ifdef CONFIG_ARCH_OMAP2
>  static struct resource omap2_sham_resources[] = {
>  	{
>  		.start	= OMAP24XX_SEC_SHA1MD5_BASE,
> @@ -474,7 +474,7 @@ static int omap2_sham_resources_sz = ARRAY_SIZE(omap2_sham_resources);
>  #define omap2_sham_resources_sz		0
>  #endif
>  
> -#ifdef CONFIG_ARCH_OMAP34XX
> +#ifdef CONFIG_ARCH_OMAP3
>  static struct resource omap3_sham_resources[] = {
>  	{
>  		.start	= OMAP34XX_SEC_SHA1MD5_BASE,

Hi Tony:

If I add this patch to cryptodev, is this going to cause any
problems for you?

Thbanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
