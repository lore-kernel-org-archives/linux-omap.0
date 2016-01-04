From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RFC 6/9] clk: ti: add support for omap4 module clocks
Date: Mon, 4 Jan 2016 15:27:57 +0200
Message-ID: <568A735D.2060309@ti.com>
References: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
 <1450447141-29936-7-git-send-email-t-kristo@ti.com>
 <20160101054815.21738.79820@quark.deferred.io> <568A20E5.6040005@ti.com>
 <CAMuHMdUZMUSYC1XHydVQHRibWtHw2=T-7nXe=5Pf4UCcb=mKTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUZMUSYC1XHydVQHRibWtHw2=T-7nXe=5Pf4UCcb=mKTQ@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 01/04/2016 12:21 PM, Geert Uytterhoeven wrote:
> Hi Tero,
>
> On Mon, Jan 4, 2016 at 8:36 AM, Tero Kristo <t-kristo@ti.com> wrote:
>> On 01/01/2016 07:48 AM, Michael Turquette wrote:
>>> Quoting Tero Kristo (2015-12-18 05:58:58)
>>>> +static int _omap4_hwmod_clk_enable(struct clk_hw *hw)
>>>> +{
>>>> +       struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
>>>> +       u32 val;
>>>> +       int timeout =3D 0;
>>>> +       int ret;
>>>> +
>>>> +       if (!clk->enable_bit)
>>>> +               return 0;
>>>> +
>>>> +       if (clk->clkdm) {
>>>> +               ret =3D ti_clk_ll_ops->clkdm_clk_enable(clk->clkdm=
,
>>>> hw->clk);
>>>> +               if (ret) {
>>>> +                       WARN(1,
>>>> +                            "%s: could not enable %s's clockdomai=
n %s:
>>>> %d\n",
>>>> +                            __func__, clk_hw_get_name(hw),
>>>> +                            clk->clkdm_name, ret);
>>>> +                       return ret;
>>>> +               }
>>>> +       }
>>>> +
>>>> +       val =3D ti_clk_ll_ops->clk_readl(clk->enable_reg);
>>>> +
>>>> +       val &=3D ~OMAP4_MODULEMODE_MASK;
>>>> +       val |=3D clk->enable_bit;
>>>> +
>>>> +       ti_clk_ll_ops->clk_writel(val, clk->enable_reg);
>>>> +
>>>> +       /* Wait until module is enabled */
>>>> +       while (!_omap4_is_ready(val)) {
>>>> +               udelay(1);
>>>
>>> This should really be a .prepare callback if you plan to keep the d=
elays
>>> in there.
>>
>> If this is changed to a .prepare, then all OMAP power management is
>> effectively ruined as all clocks are going to be enabled all the tim=
e. hwmod
>> core doesn't support .prepare/.enable at the moment that well, and c=
hanging
>> that is going to be a big burden (educated guess, haven't checked th=
is
>> yet)... The call chain that comes here is:
>>
>> device driver -> pm_runtime -> hwmod_core -> hwmod_clk_enable / disa=
ble.
>>
>> The delay within this function should usually be pretty short, just =
to wait
>> that the module comes up from idle.
>
> Does it take multiple =C2=B5s? Perhaps even one =C2=B5s is much longe=
r than needed?
>
>> I recall the discussions regarding the udelays within clk_enable/dis=
able
>> calls, but what is the preferred approach then? Typically clk_enable=
/disable
>> just becomes a NOP if it is not allowed to wait for hardware to comp=
lete
>> transitioning before exiting the function.
>
> FWIW, there are small loops with just a cpu_relax() in various clock =
drivers
> under drivers/clk/shmobile/.

Just did a quick profiling round, and the clk_enable/disable delay loop=
s=20
take anything from 0...1500ns, most typically consuming some 400-600ns.=
=20
So, based on this, dropping the udelay and adding cpu_relax instead=20
looks like a good change. I just verified that changing the udelay to=20
cpu_relax works fine also, I just need to change the bail-out period to=
=20
be something sane.

-Tero



>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linu=
x-m68k.org
>
> In personal conversations with technical people, I call myself a hack=
er. But
> when I'm talking to journalists I just say "programmer" or something =
like that.
>                                  -- Linus Torvalds
>

