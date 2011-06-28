From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/7] OMAP4: hwmod data: TEMP: Do not idle MMC1 & MMC2
 after boot
Date: Tue, 28 Jun 2011 11:40:59 +0200
Message-ID: <4E09A1AB.2000208@ti.com>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com>	<1309192391-12410-4-git-send-email-b-cousson@ti.com> <87boxi4xna.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47399 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756233Ab1F1JlF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 05:41:05 -0400
In-Reply-To: <87boxi4xna.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 6/28/2011 2:17 AM, Hilman, Kevin wrote:
> Benoit Cousson<b-cousson@ti.com>  writes:
>
>> Since the MMC driver is not pm_runtime adapted, do not put
>> them in idle after boot.
>> It will allow the driver to work as expected until the migration
>> to pm_runtime.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> Cc: Rajendra Nayak<rnayak@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 ++
>>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> Similar is needed for OMAP3 as well to boot this series.

I'm still hoping to base that on top of the MMC pm_runtime series Balaji 
did to avoid all these hacks that Russell did not like:-)

Thanks for the test and fix. I'll update the series with your patch.

Benoit


>
> Kevin
>
>
>
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/om
> index dec1a38..aaa3201 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -3500,6 +3500,7 @@ static struct omap_hwmod omap3xxx_mmc1_hwmod = {
>          .slaves_cnt     = ARRAY_SIZE(omap3xxx_mmc1_slaves),
>          .class          =&omap34xx_mmc_class,
>          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       .flags          = HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
>   };
>
>   /* MMC/SD/SDIO2 */
> @@ -3543,6 +3544,7 @@ static struct omap_hwmod omap3xxx_mmc2_hwmod = {
>          .slaves_cnt     = ARRAY_SIZE(omap3xxx_mmc2_slaves),
>          .class          =&omap34xx_mmc_class,
>          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       .flags          = HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
>   };
>

