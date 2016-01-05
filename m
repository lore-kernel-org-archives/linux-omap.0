From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [RFC 6/9] clk: ti: add support for omap4 module clocks
Date: Mon, 04 Jan 2016 17:29:54 -0800
Message-ID: <20160105012954.15239.57130@quark.deferred.io>
References: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
 <1450447141-29936-7-git-send-email-t-kristo@ti.com>
 <20160101054815.21738.79820@quark.deferred.io> <568A20E5.6040005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <568A20E5.6040005@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Tero Kristo (2016-01-03 23:36:05)
> On 01/01/2016 07:48 AM, Michael Turquette wrote:
> > Hi Tero,
> >
> > Quoting Tero Kristo (2015-12-18 05:58:58)
> >> Previously, hwmod core has been used for controlling the hwmod level
> >> clocks. This has certain drawbacks, like being unable to share the
> >> clocks for multiple users, missing usecounting and generally being
> >> totally incompatible with common clock framework.
> >>
> >> Add support for new clock type under the TI clock driver, which will
> >> be used to convert all the existing hwmdo clocks to. This helps to
> >> get rid of the clock related hwmod data from kernel and instead
> >> parsing this from DT.
> >
> > I'm really happy to see this series. Looks pretty good to me.
> >
> >> +static int _omap4_hwmod_clk_enable(struct clk_hw *hw)
> >> +{
> >> +       struct clk_hw_omap *clk = to_clk_hw_omap(hw);
> >> +       u32 val;
> >> +       int timeout = 0;
> >> +       int ret;
> >> +
> >> +       if (!clk->enable_bit)
> >> +               return 0;
> >> +
> >> +       if (clk->clkdm) {
> >> +               ret = ti_clk_ll_ops->clkdm_clk_enable(clk->clkdm, hw->clk);
> >> +               if (ret) {
> >> +                       WARN(1,
> >> +                            "%s: could not enable %s's clockdomain %s: %d\n",
> >> +                            __func__, clk_hw_get_name(hw),
> >> +                            clk->clkdm_name, ret);
> >> +                       return ret;
> >> +               }
> >> +       }
> >> +
> >> +       val = ti_clk_ll_ops->clk_readl(clk->enable_reg);
> >> +
> >> +       val &= ~OMAP4_MODULEMODE_MASK;
> >> +       val |= clk->enable_bit;
> >> +
> >> +       ti_clk_ll_ops->clk_writel(val, clk->enable_reg);
> >> +
> >> +       /* Wait until module is enabled */
> >> +       while (!_omap4_is_ready(val)) {
> >> +               udelay(1);
> >
> > This should really be a .prepare callback if you plan to keep the delays
> > in there.
> 
> If this is changed to a .prepare, then all OMAP power management is 
> effectively ruined as all clocks are going to be enabled all the time. 

Let's not ruin system PM.

> hwmod core doesn't support .prepare/.enable at the moment that well, and 
> changing that is going to be a big burden (educated guess, haven't 
> checked this yet)... The call chain that comes here is:
> 
> device driver -> pm_runtime -> hwmod_core -> hwmod_clk_enable / disable.

Right, and for calls to pm_runtime_get/put from process context it
should result in a call to clk_prepare_enable/clk_disable_unprepare. I
guess that change is hugely invasive from your statements above?

> 
> The delay within this function should usually be pretty short, just to 
> wait that the module comes up from idle.
> 
> I recall the discussions regarding the udelays within clk_enable/disable 
> calls, but what is the preferred approach then?

There are many cases where a clk only provides .{un}prepare ops and does
NOT provide any .{en,dis}able ops.

> Typically 
> clk_enable/disable just becomes a NOP

Yes, it becomes a NOP (though it is critical that drivers with knowledge
of this do not try to skip the step of calling clk_enable).

> if it is not allowed to wait for 
> hardware to complete transitioning before exiting the function.

The clk.h api clearly states that clk_prepare must be called and
complete before calling clk_enable. So if a clk only provides a .prepare
with delays but no .enable, and a consumer driver complies with that api
rule then we're guaranteed to have a toggling line when clk_enable
returns.

Regards,
Mike

> 
> -Tero
> 
> >
> > Regards,
> > Mike
> >
> 
