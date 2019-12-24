From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] bus: ti-sysc: Implement quirk handling for CLKDM_NOAUTO
Date: Tue, 24 Dec 2019 09:52:42 +0200
Message-ID: <e209a2ce-c26e-d689-48d1-7920a3052438@ti.com>
References: <20191210161342.15142-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191210161342.15142-1-tony@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: "Andrew F . Davis" <afd@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 10/12/2019 18:13, Tony Lindgren wrote:
> For dra7 dcan and dwc3 instances we need to block clockdomain autoidle.
> Let's do this with CLKDM_NOAUTO quirk flag and enable it for dcan and
> dwc3.
> 
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
>   drivers/bus/ti-sysc.c                 | 10 ++++++++--
>   include/linux/platform_data/ti-sysc.h |  1 +
>   2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -473,7 +473,7 @@ static void sysc_clkdm_deny_idle(struct sysc *ddata)
>   {
>   	struct ti_sysc_platform_data *pdata;
>   
> -	if (ddata->legacy_mode)
> +	if (ddata->legacy_mode || (ddata->cfg.quirks & SYSC_QUIRK_CLKDM_NOAUTO))
>   		return;
>   
>   	pdata = dev_get_platdata(ddata->dev);
> @@ -485,7 +485,7 @@ static void sysc_clkdm_allow_idle(struct sysc *ddata)
>   {
>   	struct ti_sysc_platform_data *pdata;
>   
> -	if (ddata->legacy_mode)
> +	if (ddata->legacy_mode || (ddata->cfg.quirks & SYSC_QUIRK_CLKDM_NOAUTO))
>   		return;
>   
>   	pdata = dev_get_platdata(ddata->dev);
> @@ -1245,6 +1245,12 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
>   	/* Quirks that need to be set based on detected module */
>   	SYSC_QUIRK("aess", 0, 0, 0x10, -1, 0x40000000, 0xffffffff,
>   		   SYSC_MODULE_QUIRK_AESS),
> +	SYSC_QUIRK("dcan", 0x48480000, 0x20, -1, -1, 0xa3170504, 0xffffffff,
> +		   SYSC_QUIRK_CLKDM_NOAUTO),
> +	SYSC_QUIRK("dwc3", 0x48880000, 0, 0x10, -1, 0x500a0200, 0xffffffff,
> +		   SYSC_QUIRK_CLKDM_NOAUTO),
> +	SYSC_QUIRK("dwc3", 0x488c0000, 0, 0x10, -1, 0x500a0200, 0xffffffff,
> +		   SYSC_QUIRK_CLKDM_NOAUTO),
>   	SYSC_QUIRK("hdq1w", 0, 0, 0x14, 0x18, 0x00000006, 0xffffffff,
>   		   SYSC_MODULE_QUIRK_HDQ1W),
>   	SYSC_QUIRK("hdq1w", 0, 0, 0x14, 0x18, 0x0000000a, 0xffffffff,
> diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
> --- a/include/linux/platform_data/ti-sysc.h
> +++ b/include/linux/platform_data/ti-sysc.h
> @@ -49,6 +49,7 @@ struct sysc_regbits {
>   	s8 emufree_shift;
>   };
>   
> +#define SYSC_QUIRK_CLKDM_NOAUTO		BIT(21)
>   #define SYSC_QUIRK_FORCE_MSTANDBY	BIT(20)
>   #define SYSC_MODULE_QUIRK_AESS		BIT(19)
>   #define SYSC_MODULE_QUIRK_SGX		BIT(18)
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
