From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC][PATCH 1/2] ARM: OMAP4: clock: Add device tree support for
 AUXCLKs
Date: Thu, 21 Mar 2013 15:54:06 +0200
Message-ID: <514B10FE.1000805@ti.com>
References: <1363703220-4777-1-git-send-email-rogerq@ti.com>
 <1363703220-4777-2-git-send-email-rogerq@ti.com> <514B0650.5070406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <514B0650.5070406-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/21/2013 03:08 PM, Rajendra Nayak wrote:
> []..
> 
>> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
>> index 0274ff7..23f2064 100644
>> --- a/arch/arm/mach-omap2/board-generic.c
>> +++ b/arch/arm/mach-omap2/board-generic.c
>> @@ -158,7 +158,7 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
>>  	.init_irq	= omap_gic_of_init,
>>  	.init_machine	= omap_generic_init,
>>  	.init_late	= omap4430_init_late,
>> -	.init_time	= omap4_local_timer_init,
>> +	.init_time	= omap4_init_time,
>>  	.dt_compat	= omap4_boards_compat,
>>  	.restart	= omap44xx_restart,
>>  MACHINE_END
> 
> []..
>> +#ifdef CONFIG_OF
>> +int __init omap4_clk_init_dt(void)
>> +{
>> +	struct device_node *np;
>> +
>> +	np = of_find_compatible_node(NULL, NULL, "ti,omap4-scrm");
>> +	if (np) {
>> +		scrm_data.clks = scrm_clks;
>> +		scrm_data.clk_num = ARRAY_SIZE(scrm_clks);
>> +		of_clk_add_provider(np, of_clk_src_onecell_get,	&scrm_data);
>> +	}
>> +
>> +	return 0;
>> +}
> 
> []..
>> +
>> +void __init omap4_init_time(void)
>> +{
>> +	omap4_clk_init_dt();
>> +	omap4_local_timer_init();
>> +}
> 
> I guess you did all this because of_clk_add_provider() needs
> slab to be initialized. With the below patch[1], now clk inits
> happen within .init_timer already, so none of this would
> be needed.
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg231288.html
> 

Right. I can then call omap4_clk_init_dt() from within omap4xxx_clk_init().

Any comments about the main subject? Does the approach look fine?

cheers,
-roger
