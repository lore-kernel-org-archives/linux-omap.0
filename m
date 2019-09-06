From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] bus: ti-sysc: Fix handling of invalid clocks
Date: Fri, 6 Sep 2019 10:39:22 +0300
Message-ID: <3c9f7340-f17f-cecd-3ae4-ec8a1af7c2bf@ti.com>
References: <20190905215356.8168-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190905215356.8168-1-tony@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 06/09/2019 00:53, Tony Lindgren wrote:
> We can currently get "Unable to handle kernel paging request at
> virtual address" for invalid clocks with dts node but no driver:
> 
> (__clk_get_hw) from [<c0138ebc>] (ti_sysc_find_one_clockdomain+0x18/0x34)
> (ti_sysc_find_one_clockdomain) from [<c0138f0c>] (ti_sysc_clkdm_init+0x34/0xdc)
> (ti_sysc_clkdm_init) from [<c0584660>] (sysc_probe+0xa50/0x10e8)
> (sysc_probe) from [<c065c6ac>] (platform_drv_probe+0x58/0xa8)
> 
> Let's add IS_ERR checks to ti_sysc_clkdm_init() as And let's start treating
> clk_get() with -ENOENT as a proper error. If the clock name is specified
> in device tree we must succeed with clk_get() to continue. For modules with
> no clock names specified in device tree we will just ignore the clocks.
> 
> Fixes: 2b2f7def058a ("bus: ti-sysc: Add support for missing clockdomain handling")
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
>   arch/arm/mach-omap2/pdata-quirks.c | 4 ++--
>   drivers/bus/ti-sysc.c              | 5 +----
>   2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -491,11 +491,11 @@ static int ti_sysc_clkdm_init(struct device *dev,
>   			      struct clk *fck, struct clk *ick,
>   			      struct ti_sysc_cookie *cookie)
>   {
> -	if (fck)
> +	if (!IS_ERR(fck))
>   		cookie->clkdm = ti_sysc_find_one_clockdomain(fck);
>   	if (cookie->clkdm)
>   		return 0;
> -	if (ick)
> +	if (!IS_ERR(ick))
>   		cookie->clkdm = ti_sysc_find_one_clockdomain(ick);
>   	if (cookie->clkdm)
>   		return 0;
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -280,9 +280,6 @@ static int sysc_get_one_clock(struct sysc *ddata, const char *name)
>   
>   	ddata->clocks[index] = devm_clk_get(ddata->dev, name);
>   	if (IS_ERR(ddata->clocks[index])) {
> -		if (PTR_ERR(ddata->clocks[index]) == -ENOENT)
> -			return 0;
> -
>   		dev_err(ddata->dev, "clock get error for %s: %li\n",
>   			name, PTR_ERR(ddata->clocks[index]));
>   
> @@ -357,7 +354,7 @@ static int sysc_get_clocks(struct sysc *ddata)
>   			continue;
>   
>   		error = sysc_get_one_clock(ddata, name);
> -		if (error && error != -ENOENT)
> +		if (error)
>   			return error;
>   	}
>   
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
