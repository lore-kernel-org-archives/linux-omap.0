From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] bus: ti-sysc: Add module enable quirk for audio AESS
Date: Thu, 14 Nov 2019 12:25:08 +0200
Message-ID: <4188f17f-67ce-42f8-c9c0-b7d6c74173a1@ti.com>
References: <20191113173702.57107-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191113173702.57107-1-tony@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: "Andrew F . Davis" <afd@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 13/11/2019 19.37, Tony Lindgren wrote:
> We must set the autogating bit on enable for AESS (Audio Engine SubSystem)
> when probed with ti-sysc interconnect target module driver. Otherwise it
> won't idle properly.
> 
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/bus/ti-sysc.c                 | 14 +++++++++++++-
>  include/linux/platform_data/ti-sysc.h |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)

Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -1248,6 +1248,8 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
>  		   SYSC_QUIRK_SWSUP_SIDLE),
>  
>  	/* Quirks that need to be set based on detected module */
> +	SYSC_QUIRK("aess", 0, 0, 0x10, -1, 0x40000000, 0xffffffff,
> +		   SYSC_MODULE_QUIRK_AESS),
>  	SYSC_QUIRK("hdq1w", 0, 0, 0x14, 0x18, 0x00000006, 0xffffffff,
>  		   SYSC_MODULE_QUIRK_HDQ1W),
>  	SYSC_QUIRK("hdq1w", 0, 0, 0x14, 0x18, 0x0000000a, 0xffffffff,
> @@ -1276,7 +1278,6 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
>  #ifdef DEBUG
>  	SYSC_QUIRK("adc", 0, 0, 0x10, -1, 0x47300001, 0xffffffff, 0),
>  	SYSC_QUIRK("atl", 0, 0, -1, -1, 0x0a070100, 0xffffffff, 0),
> -	SYSC_QUIRK("aess", 0, 0, 0x10, -1, 0x40000000, 0xffffffff, 0),
>  	SYSC_QUIRK("cm", 0, 0, -1, -1, 0x40000301, 0xffffffff, 0),
>  	SYSC_QUIRK("control", 0, 0, 0x10, -1, 0x40000900, 0xffffffff, 0),
>  	SYSC_QUIRK("cpgmac", 0, 0x1200, 0x1208, 0x1204, 0x4edb1902,
> @@ -1408,6 +1409,14 @@ static void sysc_clk_enable_quirk_hdq1w(struct sysc *ddata)
>  	sysc_write(ddata, offset, val);
>  }
>  
> +/* AESS (Audio Engine SubSystem) needs autogating set after enable */
> +static void sysc_module_enable_quirk_aess(struct sysc *ddata)
> +{
> +	int offset = 0x7c;	/* AESS_AUTO_GATING_ENABLE */
> +
> +	sysc_write(ddata, offset, 1);
> +}
> +
>  /* I2C needs extra enable bit toggling for reset */
>  static void sysc_clk_quirk_i2c(struct sysc *ddata, bool enable)
>  {
> @@ -1490,6 +1499,9 @@ static void sysc_init_module_quirks(struct sysc *ddata)
>  		return;
>  	}
>  
> +	if (ddata->cfg.quirks & SYSC_MODULE_QUIRK_AESS)
> +		ddata->module_enable_quirk = sysc_module_enable_quirk_aess;
> +
>  	if (ddata->cfg.quirks & SYSC_MODULE_QUIRK_SGX)
>  		ddata->module_enable_quirk = sysc_module_enable_quirk_sgx;
>  
> diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
> --- a/include/linux/platform_data/ti-sysc.h
> +++ b/include/linux/platform_data/ti-sysc.h
> @@ -49,6 +49,7 @@ struct sysc_regbits {
>  	s8 emufree_shift;
>  };
>  
> +#define SYSC_MODULE_QUIRK_AESS		BIT(19)
>  #define SYSC_MODULE_QUIRK_SGX		BIT(18)
>  #define SYSC_MODULE_QUIRK_HDQ1W		BIT(17)
>  #define SYSC_MODULE_QUIRK_I2C		BIT(16)
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
