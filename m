From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP: hwmod: Fix softreset for modules with optional
 clocks
Date: Tue, 21 Sep 2010 19:11:12 +0200
Message-ID: <4C98E730.6030005@ti.com>
References: <1285088279-425-1-git-send-email-b-cousson@ti.com> <1285088279-425-2-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1009211106000.29015@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42813 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753229Ab0IURLR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 13:11:17 -0400
In-Reply-To: <alpine.DEB.2.00.1009211106000.29015@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

On 9/21/2010 7:07 PM, Paul Walmsley wrote:
> Hi Benoit,
>
> one minor comment here -
>
> On Tue, 21 Sep 2010, Benoit Cousson wrote:
>
>> Some modules (like GPIO, DSS...) require optionals clock to be enabled
>> in order to complete the sofreset properly.
>> Add a HWMOD_CONTROL_OPT_CLKS_IN_RESET flag to force all optional clocks
>> to be enabled before reset. Disabled them once the reset is done.
>>
>> TODO:
>> For the moment it is very hard to understand from the HW spec, which
>> optional clock is needed and which one is not. So the current approach
>> will enable all the optional clocks.
>> Paul proposed a much finer approach that will allow to tag only the needed
>> clock in the optional clock table. This might be doable as soon as we have
>> a clear understanding of these dependencies.
>>
>> Reported-by: Partha Basak<p-basak2@ti.com>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod.c             |   51 +++++++++++++++++++++++---
>>   arch/arm/plat-omap/include/plat/omap_hwmod.h |    5 +++
>>   2 files changed, 51 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>> index 8c27923..4309107 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -546,6 +546,36 @@ static int _disable_clocks(struct omap_hwmod *oh)
>>   	return 0;
>>   }
>>
>> +static void _enable_optional_clocks(struct omap_hwmod *oh)
>> +{
>> +	struct omap_hwmod_opt_clk *oc;
>> +	int i;
>> +
>> +	pr_debug("omap_hwmod: %s: enabling optional clocks\n", oh->name);
>> +
>> +	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i>  0; i--, oc++)
>> +		if (oc->_clk) {
>> +			pr_warning("omap_hwmod: enable %s:%s\n", oc->role,
>> +				   oc->_clk->name);
>
> What do you think about maybe converting this to a pr_debug() (and the
> same in the disable code below)?  If you are happy with that, I can make
> the change here when I pull the patch in.

Oops... yes, sure, that was the intent... I've just cleaned the other 
ones, but missed these two.
Thanks for catching that.

Regards,
Benoit

>
>> +			clk_enable(oc->_clk);
>> +		}
>> +}
>> +
>> +static void _disable_optional_clocks(struct omap_hwmod *oh)
>> +{
>> +	struct omap_hwmod_opt_clk *oc;
>> +	int i;
>> +
>> +	pr_debug("omap_hwmod: %s: disabling optional clocks\n", oh->name);
>> +
>> +	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i>  0; i--, oc++)
>> +		if (oc->_clk) {
>> +			pr_warning("omap_hwmod: disable %s:%s\n", oc->role,
>> +				   oc->_clk->name);
>> +			clk_disable(oc->_clk);
>> +		}
>> +}
>> +
>>   /**
>>    * _find_mpu_port_index - find hwmod OCP slave port ID intended for MPU use
>>    * @oh: struct omap_hwmod *
>> @@ -970,8 +1000,9 @@ static int _read_hardreset(struct omap_hwmod *oh, const char *name)
>>    */
>>   static int _reset(struct omap_hwmod *oh)
>>   {
>> -	u32 r, v;
>> +	u32 v;
>>   	int c = 0;
>> +	int ret = 0;
>>
>>   	if (!oh->class->sysc ||
>>   	    !(oh->class->sysc->sysc_flags&  SYSC_HAS_SOFTRESET) ||
>> @@ -985,12 +1016,16 @@ static int _reset(struct omap_hwmod *oh)
>>   		return -EINVAL;
>>   	}
>>
>> +	/* For some modules, all optionnal clocks need to be enabled as well */
>> +	if (oh->flags&  HWMOD_CONTROL_OPT_CLKS_IN_RESET)
>> +		_enable_optional_clocks(oh);
>> +
>>   	pr_debug("omap_hwmod: %s: resetting\n", oh->name);
>>
>>   	v = oh->_sysc_cache;
>> -	r = _set_softreset(oh,&v);
>> -	if (r)
>> -		return r;
>> +	ret = _set_softreset(oh,&v);
>> +	if (ret)
>> +		goto dis_opt_clks;
>>   	_write_sysconfig(v, oh);
>>
>>   	omap_test_timeout((omap_hwmod_readl(oh, oh->class->sysc->syss_offs)&
>> @@ -1008,7 +1043,13 @@ static int _reset(struct omap_hwmod *oh)
>>   	 * _wait_target_ready() or _reset()
>>   	 */
>>
>> -	return (c == MAX_MODULE_SOFTRESET_WAIT) ? -ETIMEDOUT : 0;
>> +	ret = (c == MAX_MODULE_SOFTRESET_WAIT) ? -ETIMEDOUT : 0;
>> +
>> +dis_opt_clks:
>> +	if (oh->flags&  HWMOD_CONTROL_OPT_CLKS_IN_RESET)
>> +		_disable_optional_clocks(oh);
>> +
>> +	return ret;
>>   }
>>
>>   /**
>> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> index 7fde44d..878f919 100644
>> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> @@ -368,6 +368,10 @@ struct omap_hwmod_omap4_prcm {
>>    * HWMOD_SET_DEFAULT_CLOCKACT: program CLOCKACTIVITY bits at startup
>>    * HWMOD_NO_IDLEST : this module does not have idle status - this is the case
>>    *     only for few initiator modules on OMAP2&  3.
>> + * HWMOD_CONTROL_OPT_CLKS_IN_RESET: Enable all optional clocks during reset.
>> + *     This is needed for devices like DSS that require optional clocks enabled
>> + *     in order to complete the reset. Optional clocks will be disabled
>> + *     again after the reset.
>>    */
>>   #define HWMOD_SWSUP_SIDLE			(1<<  0)
>>   #define HWMOD_SWSUP_MSTANDBY			(1<<  1)
>> @@ -376,6 +380,7 @@ struct omap_hwmod_omap4_prcm {
>>   #define HWMOD_NO_OCP_AUTOIDLE			(1<<  4)
>>   #define HWMOD_SET_DEFAULT_CLOCKACT		(1<<  5)
>>   #define HWMOD_NO_IDLEST				(1<<  6)
>> +#define HWMOD_CONTROL_OPT_CLKS_IN_RESET		(1<<  7)
>>
>>   /*
>>    * omap_hwmod._int_flags definitions
>> --
>> 1.6.0.4
>>
>
>
> - Paul

