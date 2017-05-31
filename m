From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3b 5/5] ARM: OMAP2+: hwmod: populate clkctrl clocks for
 hwmods if available
Date: Wed, 31 May 2017 17:40:07 +0300
Message-ID: <221e96f4-b1bf-4ae8-3ce8-b5536a8e18ba@ti.com>
References: <1496155669-1677-1-git-send-email-t-kristo@ti.com>
 <1496155669-1677-6-git-send-email-t-kristo@ti.com>
 <20170530181516.GB3730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170530181516.GB3730@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 30/05/17 21:15, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [170530 07:52]:
>> If clkctrl clocks are available on a device, populate these automatically
>> to replace hwmod main_clk info. First, the patch parses all "ti,clkctrl"
>> compatible nodes and maps these against existing clockdomain data. Once
>> done, individual hwmod init routines can search for a clkctrl clock
>> handle based on the clockdomain info and the created mapping.
> ...
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>   /**
>>    * _init_main_clk - get a struct clk * for the the hwmod's main functional clk
>>    * @oh: struct omap_hwmod *
>> + * @np: device node mapped to this hwmod
>>    *
>>    * Called from _init_clocks().  Populates the @oh _clk (main
>>    * functional clock pointer) if a clock matching the hwmod name is found,
>>    * or a main_clk is present.  Returns 0 on success or -EINVAL on error.
>>    */
>> -static int _init_main_clk(struct omap_hwmod *oh)
>> +static int _init_main_clk(struct omap_hwmod *oh, struct device_node *np)
>>   {
>>   	int ret = 0;
>> -	char name[MOD_CLK_MAX_NAME_LEN];
>> -	struct clk *clk;
>> -	static const char modck[] = "_mod_ck";
>> +	struct clk *clk = NULL;
>>   
>> -	if (strlen(oh->name) >= MOD_CLK_MAX_NAME_LEN - strlen(modck))
>> -		pr_warn("%s: warning: cropping name for %s\n", __func__,
>> -			oh->name);
>> -
>> -	strlcpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - strlen(modck));
>> -	strlcat(name, modck, MOD_CLK_MAX_NAME_LEN);
>> +	if (np) {
>> +		clk = _lookup_clkctrl_clk(oh, np);
This func call above maps the hwmod to a clkctrl clock. See below.

>> +
>> +		if (!IS_ERR_OR_NULL(clk)) {
>> +			pr_debug("%s: mapped main_clk %s for %s\n", __func__,
>> +				 __clk_get_name(clk), oh->name);
>> +			oh->main_clk = __clk_get_name(clk);
>> +			oh->_clk = clk;
>> +			soc_ops.disable_direct_prcm(oh);
>> +		}
>> +	}
> 
> Shouldn't we just parse all "ti,clkctrl" matches to
> a list, then match against that list?

Yeah, this is actually what we are doing. Check out what 
_init_clkctrl_providers() is doing. _lookup_clkctrl_clk() is then used 
to match each individual hwmod to its main clkctrl clk.

> 
> Again I'm worried that the "struct device_node *np"
> here won't really map to struct omap_hwmod but to one of
> the child devices. Or what is the np here?

The np is actually not needed for anything anymore here, so I will drop 
it from v4.

-Tero
