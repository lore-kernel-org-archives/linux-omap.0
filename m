From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCHv4 00/15] clk: ti: add support for hwmod clocks
Date: Tue, 13 Dec 2016 14:02:24 -0800
Message-ID: <148166654419.37646.7680435609801736363@resonance>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
 <2cfa10a9-9ea0-23e4-30de-9aece13e47e3@ti.com>
 <20161028233750.GQ16026@codeaurora.org>
 <7371ef35-5d95-bf78-4c97-c61091a1fa4b@ti.com>
 <148156710975.37646.2957511113527634913@resonance>
 <20161213004914.GM5423@codeaurora.org> <20161213013133.GR4920@atomide.com>
 <148160402543.37646.6019420188689675769@resonance>
 <4b016883-e7c9-94d8-d964-3c8dfee6ee13@ti.com>
 <20161213153724.GT4920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20161213153724.GT4920@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Tony Lindgren (2016-12-13 07:37:24)
> * Tero Kristo <t-kristo@ti.com> [161213 00:31]:
> > On 13/12/16 06:40, Michael Turquette wrote:
> > > Quoting Tony Lindgren (2016-12-12 17:31:34)
> > > > * Stephen Boyd <sboyd@codeaurora.org> [161212 16:49]:
> > > > > I spent a bunch of time looking at this again today. From a DT
> > > > > perspective we don't want to have clocks or clockdomains nodes
> > > > > below the cm1/cm2/prm dt nodes. That's getting to the point of
> > > > > describing individual elements of a device that should be
> > > > > described in the driver instead of DT.
> > > > =

> > > > I agree we don't need separate clocks and clockdomain nodes.. But
> > > > I think you're missing something here though. The clockdomains in
> > > > this case are separate devices on the interconnect, not individual
> > > > elements within a device. The outputs of a clockdomain are individu=
al
> > > > elements of a clockdomain and can be just described as indexed
> > > > outputs of the clockdomain.
> > > =

> > > Is the goal to describe this hardware topology in DT? Is that right
> > > thing to do? I think it's cool to have this modeled *somehow* in Linu=
x,
> > > but I'm not sure DT is the right place to model the interconnect and
> > > every device hanging off of it.
> =

> Well struct device is what we should use, the DT nodes pretty much
> map with that :)
> =

> > > I don't want to put words in Stephen's mouth, but I think the issue o=
ver
> > > whether clockdomains are CCF clock providers or some genpd thing is
> > > probably less important to him than the fact that the DT bindings are
> > > super detailed to inner workings of the SoC.
> > =

> > Ok, so your preference would be to reduce the data under DT, and the id=
eal
> > approach would be a single prcm node. I think we still need to keep the=
 prm
> > / cm1 / cm2 as separate nodes, as they are pretty individual from hardw=
are
> > point of view, provide quite different features, and they reside in some
> > cases in quite different address spaces also. Anyway, here's what I gat=
her
> > we should probably have in DT:
> > =

> > - reset provider
> >   * example: resets =3D <&prm OMAP4_IVA2_RESET>;
> >   * only from 'prm' node
> > =

> > - genpd provider (for the hwmods, clockdomains, powerdomains, voltage
> > domains)
> >   * examples: power-domains =3D <&cm2 OMAP4_DSS_CORE_MOD>;
> >               power-domains =3D <&cm2 OMAP4_DSS_CLKDM>;
> >               power-domains =3D <&prm OMAP4_DSS_PWRDM>;
> >               power-domains =3D <&prm OMAP4_CORE_VOLTDM>;
> >   * from all 'prm', 'cm1' and 'cm2' nodes, though 'prm' would be the on=
ly
> > one providing _CLKDM, _PWRDM, _VOLTDM genpds.
> > =

> > - clock provider (for anything that requires clocks)
> >   * example: clocks =3D <&cm1 OMAP4_DPLL_MPU_CK>;
> >   * from all 'prm', 'cm1' and 'cm2' nodes
> =

> Makes sense to me in general.
> =

> For the clkctrl clocks, here's what I'd like to see. The driver should be
> just a regular device driver along the lines we did with the ADPLL as in
> Documentation/devicetree/bindings/clock/ti/adpll.txt.
> =

> For the binding, something like the following should work as a minimal
> example, this follows what we have in the hardware:
> =

> &prm {
>         ...
> =

>         /* See "CD_WKUP Clock Domain" in 4430 TRM page 393 */
>         wkup_cm: clock@1800 {
>                 compatible =3D "ti,clkctrl";
>                 reg =3D <0x1800 0x100>;
>                 #clock-cells =3D <1>;
>                 clocks =3D <&wkup_l4_iclk2 &wkup_32k_fclk
>                           &32k_fclk &gp1_fclk>;
>                 clock-output-names =3D
>                         "sysctrl_padconf_wkup",
>                         "badgap",
>                         "sysctrl_general_wkup",
>                         "gpio1",
>                         "keyboard",
>                         "sar_ram",
>                         "32ktimer",
>                         "gptimer1";

Is there a technical reason to use clock-output-names? If you share a
header between the clock provider driver and DT with the phandle offsets
then we should be able to avoid this property altogether. Stephen and I
are trying to phase this one out as much as possible.

Regards,
Mike

>         };
>         ...
> =

>         /* See "CD_EMU Clock Domain" in 4430 TRM page 424 */
>         emu_cm: clock@1a00 {
>                 compatible =3D "ti,clkctrl";
>                 reg =3D <0x1a00 0x100>;
>                 #clock-cells =3D <1>;
>                 clocks =3D <&emu_sys_clk &core_dpll_emu_clk>;
>                 clock-output-names =3D "debug";
>         };
>         ...
> };
> =

> So the device tree nodes could be minimal as above and the rest can
> be taken care of by the driver. We may need separate compatible strings
> for the various instances, not sure about that.
> =

> Note that the clkctrl hardware manages multiple clocks for each
> interconnect target module. AFAIK we don't need to care about that from
> the consumer device driver point of view as it can't separately manage
> functional and interface clock.
> =

> We need few clockctrl clocks early for system timers, but those can
> be registered earlier in the driver.
> =

> Then some clkctrl clocks have optional aux clocks. I think those can
> be just be regular child clocks of the module clocks.
> =

> > This would eventually cause an ABI breakage for the clock handles, if we
> > transfer the existing clocks to this format, and remove the existing cl=
ock
> > handles from DT. Otherwise, I think we could just transition the existi=
ng
> > hwmod data to this new format only, and add the clockdomain / powerdoma=
in /
> > voltagedomain support a bit later.
> =

> Let's not break anything while doing this.. And let's not mess with the
> hwmod except where it helps moving that into regular device drivers.
> If necessary we can maybe first register the new clock instances, then
> register the old clocks if new clock is not found?
> =

> Regards,
> =

> Tony
