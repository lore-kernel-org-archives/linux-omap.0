From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RFC 6/9] clk: ti: add support for omap4 module clocks
Date: Mon, 4 Jan 2016 09:36:05 +0200
Message-ID: <568A20E5.6040005@ti.com>
References: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
 <1450447141-29936-7-git-send-email-t-kristo@ti.com>
 <20160101054815.21738.79820@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160101054815.21738.79820@quark.deferred.io>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01/01/2016 07:48 AM, Michael Turquette wrote:
> Hi Tero,
>
> Quoting Tero Kristo (2015-12-18 05:58:58)
>> Previously, hwmod core has been used for controlling the hwmod level
>> clocks. This has certain drawbacks, like being unable to share the
>> clocks for multiple users, missing usecounting and generally being
>> totally incompatible with common clock framework.
>>
>> Add support for new clock type under the TI clock driver, which will
>> be used to convert all the existing hwmdo clocks to. This helps to
>> get rid of the clock related hwmod data from kernel and instead
>> parsing this from DT.
>
> I'm really happy to see this series. Looks pretty good to me.
>
>> +static int _omap4_hwmod_clk_enable(struct clk_hw *hw)
>> +{
>> +       struct clk_hw_omap *clk = to_clk_hw_omap(hw);
>> +       u32 val;
>> +       int timeout = 0;
>> +       int ret;
>> +
>> +       if (!clk->enable_bit)
>> +               return 0;
>> +
>> +       if (clk->clkdm) {
>> +               ret = ti_clk_ll_ops->clkdm_clk_enable(clk->clkdm, hw->clk);
>> +               if (ret) {
>> +                       WARN(1,
>> +                            "%s: could not enable %s's clockdomain %s: %d\n",
>> +                            __func__, clk_hw_get_name(hw),
>> +                            clk->clkdm_name, ret);
>> +                       return ret;
>> +               }
>> +       }
>> +
>> +       val = ti_clk_ll_ops->clk_readl(clk->enable_reg);
>> +
>> +       val &= ~OMAP4_MODULEMODE_MASK;
>> +       val |= clk->enable_bit;
>> +
>> +       ti_clk_ll_ops->clk_writel(val, clk->enable_reg);
>> +
>> +       /* Wait until module is enabled */
>> +       while (!_omap4_is_ready(val)) {
>> +               udelay(1);
>
> This should really be a .prepare callback if you plan to keep the delays
> in there.

If this is changed to a .prepare, then all OMAP power management is 
effectively ruined as all clocks are going to be enabled all the time. 
hwmod core doesn't support .prepare/.enable at the moment that well, and 
changing that is going to be a big burden (educated guess, haven't 
checked this yet)... The call chain that comes here is:

device driver -> pm_runtime -> hwmod_core -> hwmod_clk_enable / disable.

The delay within this function should usually be pretty short, just to 
wait that the module comes up from idle.

I recall the discussions regarding the udelays within clk_enable/disable 
calls, but what is the preferred approach then? Typically 
clk_enable/disable just becomes a NOP if it is not allowed to wait for 
hardware to complete transitioning before exiting the function.

-Tero

>
> Regards,
> Mike
>

