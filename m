From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH] clk: ti: omap3: Fix am3517 mdio clock alias
Date: Mon, 25 Jun 2018 05:46:39 -0500
Message-ID: <CAHCN7x+hp8KfChRvCeFzE4mNJDdHWBs1YaEe0AXhdMKTA0DLQA@mail.gmail.com>
References: <20180623110912.20633-1-aford173@gmail.com> <20180623143824.GA14050@ethiopia>
 <6ed7daab-08b5-edb7-8207-a32c402f6b2a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <6ed7daab-08b5-edb7-8207-a32c402f6b2a@ti.com>
Sender: stable-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Derald Woods <woods.technical@gmail.com>, linux-clk <linux-clk@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 25, 2018 at 1:27 AM Tero Kristo <t-kristo@ti.com> wrote:
>
> On 23/06/18 17:38, Derald D. Woods wrote:
> > On Sat, Jun 23, 2018 at 06:09:12AM -0500, Adam Ford wrote:
> >> A previous patch removed OMAP clock aliases that were perceived
> >> to be unnecessary.  Unfortunately, it broke the ethernet on the
> >> am3517-evm.  This patch renables the MDIO clock.
> >>
> >> Fixes: 0ed266d7ae5e ("clk: ti: omap3: cleanup unnecessary clock aliases")
> >> Cc: stable@vger.kernel.org #4.16+
> >>
> >
> > On AM3517-EVM, you can add:
> >
> > Tested-by: Derald D. Woods <woods.technical@gmail.com>
> >
> >> Signed-off-by: Adam Ford <aford173@gmail.com>
>
> Can you try adding the alternative solution with the DT change I just
> proposed?
>
> clocks = <&emac_fck>;
> clock-names = "fck";
>
> ... under the mdio node?
>

By itself, that wasn't enough, but I was able to do that and also add

clocks = <&emac_ick>;
clock-names = "ick";

under the emac node and together that fixed the issue.

I'll update my patch and re-submit as V2.

adam
> The target is to get rid of the clock aliases under the driver files.
>
> -Tero
>
> >>
> >> diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
> >> index 8aa5f5793835..f84734bd0aa7 100644
> >> --- a/drivers/clk/ti/clk-3xxx.c
> >> +++ b/drivers/clk/ti/clk-3xxx.c
> >> @@ -254,6 +254,8 @@ static struct ti_dt_clk omap36xx_am35xx_omap3430es2plus_clks[] = {
> >>   };
> >>
> >>   static struct ti_dt_clk am35xx_clks[] = {
> >> +    DT_CLK("davinci_emac.0", NULL, "emac_ick"),
> >> +    DT_CLK("davinci_mdio.0", NULL, "emac_fck"),
> >>      DT_CLK(NULL, "hsotgusb_ick", "hsotgusb_ick_am35xx"),
> >>      DT_CLK(NULL, "hsotgusb_fck", "hsotgusb_fck_am35xx"),
> >>      DT_CLK(NULL, "uart4_ick", "uart4_ick_am35xx"),
> >> --
> >> 2.17.1
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
