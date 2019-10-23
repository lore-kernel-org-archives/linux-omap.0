From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Patch 1/3] ARM: dts: am43xx: add support for clkout1 clock
Date: Wed, 23 Oct 2019 08:56:57 -0700
Message-ID: <20191023155657.GL5610@atomide.com>
References: <20191016184954.14048-1-bparrot@ti.com>
 <20191016184954.14048-2-bparrot@ti.com>
 <20191022154816.GO5610@atomide.com>
 <20191022162134.fpawonjdjvd5kxza@ti.com>
 <586dcabb-0400-50d6-5488-16bddc059286@ti.com>
 <20191022165516.GE5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191022165516.GE5610@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Benoit Parrot <bparrot@ti.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [191022 16:56]:
> * Tero Kristo <t-kristo@ti.com> [191022 16:48]:
> > On 22/10/2019 19:21, Benoit Parrot wrote:
> > > Tony Lindgren <tony@atomide.com> wrote on Tue [2019-Oct-22 08:48:16 -0700]:
> > > > * Benoit Parrot <bparrot@ti.com> [191016 18:47]:
> > > > > --- a/arch/arm/boot/dts/am43xx-clocks.dtsi
> > > > > +++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
> > > > > @@ -704,6 +704,60 @@
> > > > >   		ti,bit-shift = <8>;
> > > > >   		reg = <0x2a48>;
> > > > >   	};
> > > > > +
> > > > > +	clkout1_osc_div_ck: clkout1_osc_div_ck {
> > > > > +		#clock-cells = <0>;
> > > > > +		compatible = "ti,divider-clock";
> > > > > +		clocks = <&sys_clkin_ck>;
> > > > > +		ti,bit-shift = <20>;
> > > > > +		ti,max-div = <4>;
> > > > > +		reg = <0x4100>;
> > > > > +	};
> > > > 
> > > > Here too please describe why the clock names are not generic.
> > > 
> > > Tero originally had this patch in the kernel so this is somewhat of a
> > > revert. Since these "clock" were removed. If the name syntax is no longer
> > > valid for some reason, then I will need a little more informations to
> > > proceed.
> > > 
> > > Tero, can you assist here?
> > 
> > This one is just following the naming convention of the rest of the clocks
> > atm.
> > 
> > If we need to fix all the underscore name clocks, that requires pretty much
> > complete revamp of both the dts data + clock data under the clock driver,
> > and it is not backwards compatible either. How should we tackle that one?
> > 
> > We could maybe add support code in kernel to do s/-/_/g for the "new" clocks
> > so that their parent-child relationships would be retained, and then convert
> > the clocks in phases.
> 
> Well some of them can be fixed by configuring things based
> on the compatible value and then the node name can be just
> clock like it should be.
> 
> Here too one option would be to add custom compatibles like:
> 
> compatible = "ti,clkout1-osc-div", "ti,divider-clock";
> 
> And then have match data configure the rest.
> 
> The other option would be to have lookup tables in the clock
> driver based on the SoC and reg address.
> 
> This is a hidden mine though.. We've hit it already several times,
> and any dts clean-up effort has a chance of breaking things.

Hmm maybe in this case just doing this is enough:

clkout1_osc_div_ck: clock@4100 {
	... 
}

Or do all the TI clocks we have have a dependency to the
node naming?

Regards,

Tony
