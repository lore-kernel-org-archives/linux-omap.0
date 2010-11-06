From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 6/6] omap: iommu: code reorganization and cleanup
Date: Sat, 06 Nov 2010 17:28:46 -0400
Message-ID: <4CD5C88E.5050009@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com> <1289006396-27230-7-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60949 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697Ab0KFV2D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Nov 2010 17:28:03 -0400
In-Reply-To: <1289006396-27230-7-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 11/5/2010 9:19 PM, Ramirez Luna, Omar wrote:
> Since omap-iommu is now using hwmod, there are structures and
> arrays that can be cleaned up to increase the readability of
> the code.

This patch should be merged with the previous one as well.

I do not see the need to split in 3 patches these changes.
It will be much readable and will avoid people, like me, doing comment 
on a piece of code you will remove 2 patches later.
That cleanup must be done when the hwmod is introduced since that code 
was already useless at that time.

I can understand the phased approach when you have huge changes to do, 
but in that case, that does not worth it. It make the review even more 
painful.


> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
> ---
>   arch/arm/mach-omap2/omap-iommu.c        |   95 +++++++++++--------------------
>   arch/arm/plat-omap/include/plat/iommu.h |    2 +-
>   2 files changed, 34 insertions(+), 63 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
> index 0a76bce..135474b 100644
> --- a/arch/arm/mach-omap2/omap-iommu.c
> +++ b/arch/arm/mach-omap2/omap-iommu.c
> @@ -17,53 +17,17 @@
>   #include<plat/omap_hwmod.h>
>   #include<plat/omap_device.h>
>
> -struct iommu_device {
> -	struct iommu_platform_data pdata;
> +static char *omap3_devices[] = {
> +	"isp",
> +	"iva2",
> +	NULL,
>   };
> -static struct iommu_device *devices;
> -static int num_iommu_devices;
> -
> -#ifdef CONFIG_ARCH_OMAP3
> -static struct iommu_device omap3_devices[] = {
> -	{
> -		.pdata = {
> -			.name = "isp",
> -		},
> -	},
> -#if defined(CONFIG_MPU_BRIDGE_IOMMU)
> -	{
> -		.pdata = {
> -			.name = "iva2",
> -		},
> -	},
> -#endif
> -};
> -#define NR_OMAP3_IOMMU_DEVICES ARRAY_SIZE(omap3_devices)
> -#else
> -#define omap3_devices		NULL
> -#define NR_OMAP3_IOMMU_DEVICES	0
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP4
> -static struct iommu_device omap4_devices[] = {
> -	{
> -		.pdata = {
> -			.name = "ducati",
> -		},
> -	},
> -#if defined(CONFIG_MPU_TESLA_IOMMU)
> -	{
> -		.pdata = {
> -			.name = "tesla",
> -		},
> -	},
> -#endif
> +
> +static char *omap4_devices[] = {
> +	"ducati",
> +	"tesla",
> +	NULL,

Not needed if you iterate over the class.

Benoit
