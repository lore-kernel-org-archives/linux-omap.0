From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/4] OMAP3 and 4 hwmod I2C units only allow 16 bit access
Date: Thu, 3 Mar 2011 18:42:10 +0100
Message-ID: <4D6FD2F2.8050701@ti.com>
References: <20110303134744.30648.91218.stgit@otae.warmcat.com> <20110303135022.30648.8996.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53838 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758196Ab1CCRmS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 12:42:18 -0500
In-Reply-To: <20110303135022.30648.8996.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy@warmcat.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, Andy Green <andy.green@linaro.org>, paul Walmsley <paul@pwsan.com>

On 3/3/2011 2:50 PM, Andy Green wrote:
> Peter Maydell noticed when running under QEMU he was getting
> errors reporting 32-bit access to I2C peripheral unit registers
> that are documented to be 8 or 16-bit only[1][2]

Well, in that case, it is more a QEMU bug since the HW is working fine 
with 32 bits access to sysconfig :-)

> The I2C driver is blameless as it wraps its accesses in a
> function using __raw_writew and __raw_readw, it turned out it
> is the hwmod stuff.
>
> However the hwmod code already has a flag to force a
> perhipheral unit to only be accessed using 16-bit operations..

In fact that flag was added because 32 bits access to I2C sysconfig was 
generating bus abort on 2420 only: 
(2004290f55f03c52e22044a5843928cf0f6cc56a).

Since 2430, OMAP3 and OMAP4 are working fine with 32 bits, we were lazy 
and didn't add that flag.

Did you check this patch on a real HW? Since this was reported using 
QEMU only.

Otherwise, I'm fine with that patch, it will not change anything but 
will improve the consistency across SoC version.

BTW, It will be good if you could update the omap_hwmod_2430_data.c file 
as well.

Thanks,
Benoit

> This patch applies the 16-bit only flag to the OMAP3xxx and
> OMAP44xx hwmod structs.
>
> [1] OMAP4430 Technical reference manual section 23.1.6.2
> [2] OMAP3530 Techincal reference manual section 18.6
>
> Cc: patches@linaro.org
> Reported-by: Peter Maydell<peter.maydell@linaro.org>
> Signed-off-by: Andy Green<andy.green@linaro.org>
> ---
>
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    3 +++
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++----
>   2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 541092c..1409779 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1170,6 +1170,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_i2c1_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_i2c1_hwmod = {
>   	.name		= "i2c1",
> +	.flags		= HWMOD_16BIT_REG,
>   	.mpu_irqs	= i2c1_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
>   	.sdma_reqs	= i2c1_sdma_reqs,
> @@ -1212,6 +1213,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_i2c2_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_i2c2_hwmod = {
>   	.name		= "i2c2",
> +	.flags		= HWMOD_16BIT_REG,
>   	.mpu_irqs	= i2c2_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(i2c2_mpu_irqs),
>   	.sdma_reqs	= i2c2_sdma_reqs,
> @@ -1254,6 +1256,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_i2c3_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_i2c3_hwmod = {
>   	.name		= "i2c3",
> +	.flags		= HWMOD_16BIT_REG,
>   	.mpu_irqs	= i2c3_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(i2c3_mpu_irqs),
>   	.sdma_reqs	= i2c3_sdma_reqs,
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index ce646f2..c500416 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -2280,7 +2280,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c1_slaves[] = {
>   static struct omap_hwmod omap44xx_i2c1_hwmod = {
>   	.name		= "i2c1",
>   	.class		=&omap44xx_i2c_hwmod_class,
> -	.flags		= HWMOD_INIT_NO_RESET,
> +	.flags		= HWMOD_INIT_NO_RESET | HWMOD_16BIT_REG,
>   	.mpu_irqs	= omap44xx_i2c1_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c1_irqs),
>   	.sdma_reqs	= omap44xx_i2c1_sdma_reqs,
> @@ -2396,7 +2396,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c2_slaves[] = {
>   static struct omap_hwmod omap44xx_i2c2_hwmod = {
>   	.name		= "i2c2",
>   	.class		=&omap44xx_i2c_hwmod_class,
> -	.flags		= HWMOD_INIT_NO_RESET,
> +	.flags		= HWMOD_INIT_NO_RESET | HWMOD_16BIT_REG,
>   	.mpu_irqs	= omap44xx_i2c2_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c2_irqs),
>   	.sdma_reqs	= omap44xx_i2c2_sdma_reqs,
> @@ -2449,7 +2449,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c3_slaves[] = {
>   static struct omap_hwmod omap44xx_i2c3_hwmod = {
>   	.name		= "i2c3",
>   	.class		=&omap44xx_i2c_hwmod_class,
> -	.flags		= HWMOD_INIT_NO_RESET,
> +	.flags		= HWMOD_INIT_NO_RESET | HWMOD_16BIT_REG,
>   	.mpu_irqs	= omap44xx_i2c3_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c3_irqs),
>   	.sdma_reqs	= omap44xx_i2c3_sdma_reqs,
> @@ -2502,7 +2502,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c4_slaves[] = {
>   static struct omap_hwmod omap44xx_i2c4_hwmod = {
>   	.name		= "i2c4",
>   	.class		=&omap44xx_i2c_hwmod_class,
> -	.flags		= HWMOD_INIT_NO_RESET,
> +	.flags		= HWMOD_INIT_NO_RESET | HWMOD_16BIT_REG,
>   	.mpu_irqs	= omap44xx_i2c4_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c4_irqs),
>   	.sdma_reqs	= omap44xx_i2c4_sdma_reqs,
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

