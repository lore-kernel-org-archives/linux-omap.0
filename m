From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2 04/18] I2C: OMAP2+: Tag all OMAP2+ hwmod defintions
 with I2C IP revision
Date: Tue, 8 Mar 2011 23:08:33 +0100
Message-ID: <4D76A8E1.3020903@ti.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com> <20110308110749.23531.11588.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46831 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151Ab1CHWIb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 17:08:31 -0500
In-Reply-To: <20110308110749.23531.11588.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy@warmcat.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>, Paul Walmsley <paul@pwsan.com>

Same minor comment than before about the subject + typo. Should be:
OMAP2+: hwmod data: Tag all OMAP2+ hwmod definitions with I2C IP revision

On 3/8/2011 12:07 PM, Andy Green wrote:
> Since we cannot trust (or even reliably find) the OMAP I2C
> peripheral unit's own revision register, we must inform the
> OMAP i2c driver of which IP version it is running on.  We
> do this by tagging the omap_hwmod_class for i2c on all the
> OMAP2+ platform / cpu specific hwmod init and passing it up
> to the driver (next patches).
>
> Cc: patches@linaro.org
> Cc: Ben Dooks<ben-linux@fluff.org>
> Reported-by: Peter Maydell<peter.maydell@linaro.org>
> Signed-off-by: Andy Green<andy.green@linaro.org>

Acked-by: Benoit Cousson <b-cousson@ti.com>

Regards,
Benoit

> ---
>
>   arch/arm/mach-omap2/omap_hwmod_2420_data.c |    1 +
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |    1 +
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 +
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
>   4 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index e0bc2c7..de92d75 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -1447,6 +1447,7 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
>   static struct omap_hwmod_class i2c_class = {
>   	.name		= "i2c",
>   	.sysc		=&i2c_sysc,
> +	.rev		= OMAP_I2C_IP_VERSION_1,
>   };
>
>   static struct omap_i2c_dev_attr i2c_dev_attr;
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> index e5c0ced..d737b99 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -1522,6 +1522,7 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
>   static struct omap_hwmod_class i2c_class = {
>   	.name		= "i2c",
>   	.sysc		=&i2c_sysc,
> +	.rev		= OMAP_I2C_IP_VERSION_1,
>   };
>
>   static struct omap_i2c_dev_attr i2c_dev_attr = {
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 63527b6..324162d 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1465,6 +1465,7 @@ static struct omap_hwmod omap3xxx_uart4_hwmod = {
>   static struct omap_hwmod_class i2c_class = {
>   	.name = "i2c",
>   	.sysc =&i2c_sysc,
> +	.rev  = OMAP_I2C_IP_VERSION_1,
>   };
>
>   /*
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 2c86f0c..4b903c7 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -2087,6 +2087,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
>   static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
>   	.name	= "i2c",
>   	.sysc	=&omap44xx_i2c_sysc,
> +	.rev	= OMAP_I2C_IP_VERSION_2,
>   };
>
>   /* i2c1 */
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

