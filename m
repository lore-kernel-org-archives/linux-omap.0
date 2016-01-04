From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC 6/9] clk: ti: add support for omap4 module clocks
Date: Mon, 4 Jan 2016 11:21:04 +0100
Message-ID: <CAMuHMdUZMUSYC1XHydVQHRibWtHw2=T-7nXe=5Pf4UCcb=mKTQ@mail.gmail.com>
References: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
	<1450447141-29936-7-git-send-email-t-kristo@ti.com>
	<20160101054815.21738.79820@quark.deferred.io>
	<568A20E5.6040005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <568A20E5.6040005@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Tero,

On Mon, Jan 4, 2016 at 8:36 AM, Tero Kristo <t-kristo@ti.com> wrote:
> On 01/01/2016 07:48 AM, Michael Turquette wrote:
>> Quoting Tero Kristo (2015-12-18 05:58:58)
>>> +static int _omap4_hwmod_clk_enable(struct clk_hw *hw)
>>> +{
>>> +       struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
>>> +       u32 val;
>>> +       int timeout =3D 0;
>>> +       int ret;
>>> +
>>> +       if (!clk->enable_bit)
>>> +               return 0;
>>> +
>>> +       if (clk->clkdm) {
>>> +               ret =3D ti_clk_ll_ops->clkdm_clk_enable(clk->clkdm,
>>> hw->clk);
>>> +               if (ret) {
>>> +                       WARN(1,
>>> +                            "%s: could not enable %s's clockdomain=
 %s:
>>> %d\n",
>>> +                            __func__, clk_hw_get_name(hw),
>>> +                            clk->clkdm_name, ret);
>>> +                       return ret;
>>> +               }
>>> +       }
>>> +
>>> +       val =3D ti_clk_ll_ops->clk_readl(clk->enable_reg);
>>> +
>>> +       val &=3D ~OMAP4_MODULEMODE_MASK;
>>> +       val |=3D clk->enable_bit;
>>> +
>>> +       ti_clk_ll_ops->clk_writel(val, clk->enable_reg);
>>> +
>>> +       /* Wait until module is enabled */
>>> +       while (!_omap4_is_ready(val)) {
>>> +               udelay(1);
>>
>> This should really be a .prepare callback if you plan to keep the de=
lays
>> in there.
>
> If this is changed to a .prepare, then all OMAP power management is
> effectively ruined as all clocks are going to be enabled all the time=
=2E hwmod
> core doesn't support .prepare/.enable at the moment that well, and ch=
anging
> that is going to be a big burden (educated guess, haven't checked thi=
s
> yet)... The call chain that comes here is:
>
> device driver -> pm_runtime -> hwmod_core -> hwmod_clk_enable / disab=
le.
>
> The delay within this function should usually be pretty short, just t=
o wait
> that the module comes up from idle.

Does it take multiple =C2=B5s? Perhaps even one =C2=B5s is much longer =
than needed?

> I recall the discussions regarding the udelays within clk_enable/disa=
ble
> calls, but what is the preferred approach then? Typically clk_enable/=
disable
> just becomes a NOP if it is not allowed to wait for hardware to compl=
ete
> transitioning before exiting the function.

=46WIW, there are small loops with just a cpu_relax() in various clock =
drivers
under drivers/clk/shmobile/.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
