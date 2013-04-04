From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC][PATCH 1/2] ARM: OMAP4: clock: Add device tree support for
 AUXCLKs
Date: Thu, 4 Apr 2013 10:50:10 +0530
Message-ID: <515D0D8A.7030500@ti.com>
References: <1363703220-4777-1-git-send-email-rogerq@ti.com> <1363703220-4777-2-git-send-email-rogerq@ti.com> <20130403234242.GE10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130403234242.GE10155@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Roger Quadros <rogerq@ti.com>, b-cousson@ti.com, linux@arm.linux.org.uk, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Thursday 04 April 2013 05:12 AM, Tony Lindgren wrote:
> Hi,
> 
[]..

>> @@ -1663,6 +1664,40 @@ static struct omap_clk omap44xx_clks[] = {
>>  	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
>>  };
>>  
>> +static struct clk *scrm_clks[] = {
>> +	&auxclk0_ck,
>> +	&auxclk1_ck,
>> +	&auxclk2_ck,
>> +	&auxclk3_ck,
>> +	&auxclk4_ck,
>> +	&auxclk5_ck,
>> +};
> 
> Hmm I don't like the idea of specifying the auxclk both in the
> cclock44xx_data.c and in DT..
> 
>> +static struct clk_onecell_data scrm_data;
>> +
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
>> +
>> +#else
>> +
>> +int __init omap4_clk_init_dt(void)
>> +{
>> +	return 0;
>> +}
>> +#endif /* CONFIG_OF */
>> +
>>  int __init omap4xxx_clk_init(void)
>>  {
>>  	u32 cpu_clkflg;
> 
> .. and I'm not too keen on adding driver specific stuff to this file.
> 
> How about just add a minimal drivers/clk/omap/clk-xyz.c that takes
> the configuration from DT and is based on the binding we already have in
> Documentation/devicetree/bindings/clock/clock-bindings.txt?
> 
> Then as we add new bindings there we can drop them from current
> cclock44xx_data.c, no? That is after omap4 is DT only..

The patch just provides an alternative for clkdev mapping in case of DT.
Are you suggesting we move all *clock data* related to auxclks (and eventually
all clocks) into DT?
We have discussed this multiple times in the past, and moving 250 clock nodes
with each needing multiple register offsets, masks, shifts etc into DT makes it
completely un-readable. For me, having a way for devices to reference a clock that they
use for a device using DT makes sense, but not moving all clock data into dts files.

regards,
Rajendra

> 
> Regards,
> 
> Tony
> 
