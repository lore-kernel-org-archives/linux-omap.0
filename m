From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 2/4] OMAP4: TWL: Add common omapdss supplies
Date: Fri, 2 Sep 2011 12:10:00 +0530
Message-ID: <4E607A40.8000707@ti.com>
References: <1314001599-17951-1-git-send-email-tomi.valkeinen@ti.com> <1314001599-17951-3-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45313 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962Ab1IBGk6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Sep 2011 02:40:58 -0400
In-Reply-To: <1314001599-17951-3-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi,

On Monday 22 August 2011 01:56 PM, Valkeinen, Tomi wrote:
> OMAP DSS normally gets power from VCXIO on OMAP4. Add configuration for
> this into twl-common.c
>
> Mark VCXIO as always_on, as VCXIO is used by multiple components,
> including the MPU, and turning it off when DSS doesn't need it would
> lead the device to halt.

I had a query. Is this the right place to set always_on to true? Won't 
this lead to VCXIO being always on all omap4 boards? Is it necessary 
that VCXIO will be used to power on MPU for all omap4 boards?

Archit

>
> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> ---
>   arch/arm/mach-omap2/twl-common.c |    9 +++++++++
>   1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
> index 4f6d216..52243577 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -235,6 +235,12 @@ static struct regulator_init_data omap4_vana_idata = {
>   	},
>   };
>
> +static struct regulator_consumer_supply omap4_vcxio_supply[] = {
> +	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dss"),
> +	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
> +	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.1"),
> +};
> +
>   static struct regulator_init_data omap4_vcxio_idata = {
>   	.constraints = {
>   		.min_uV			= 1800000,
> @@ -243,7 +249,10 @@ static struct regulator_init_data omap4_vcxio_idata = {
>   					| REGULATOR_MODE_STANDBY,
>   		.valid_ops_mask		= REGULATOR_CHANGE_MODE
>   					| REGULATOR_CHANGE_STATUS,
> +		.always_on		= true,
>   	},
> +	.num_consumer_supplies	= ARRAY_SIZE(omap4_vcxio_supply),
> +	.consumer_supplies	= omap4_vcxio_supply,
>   };
>
>   static struct regulator_init_data omap4_vusb_idata = {

