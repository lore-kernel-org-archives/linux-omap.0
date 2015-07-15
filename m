From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: dra7: Add syscon-pllreset syscon to
 SATA PHY
Date: Wed, 15 Jul 2015 05:07:46 -0700
Message-ID: <20150715120745.GE17550@atomide.com>
References: <1433236242-26172-1-git-send-email-rogerq@ti.com>
 <1433236242-26172-4-git-send-email-rogerq@ti.com>
 <55A64253.100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55A64253.100@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [150715 04:24]:
> Hi Roger,
> 
> On Tuesday 02 June 2015 02:40 PM, Roger Quadros wrote:
> > This register is required to be passed to the SATA PHY driver
> > to workaround errata i783 (SATA Lockup After SATA DPLL Unlock/Relock).
> > 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> > ---
> >  arch/arm/boot/dts/dra7.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> > index f03a091..260f300 100644
> > --- a/arch/arm/boot/dts/dra7.dtsi
> > +++ b/arch/arm/boot/dts/dra7.dtsi
> > @@ -1135,6 +1135,7 @@
> >  				ctrl-module = <&omap_control_sata>;
> >  				clocks = <&sys_clkin1>, <&sata_ref_clk>;
> >  				clock-names = "sysclk", "refclk";
> > +				syscon-pllreset = <&dra7_ctrl_core 0x3fc>;
> 
> I think all users of syscon should be made child node of scm_conf. Tony and
> Tero, is that right?
> 
> If so, then we might have to modify the driver too.

Yeah there should not be much need to use syscon outside scm_conf
area and for I2C devices. If there's some other misc register area
in dra7 in addition to scm_conf then it might make sense to use it.

But in general, for the SCM registers, just a normal loadable kernel
driver module doing of_ioremap on a dedicated range of registers is
always a better option :)

Regrds,

Tony
