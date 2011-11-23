From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [RFC 1/3] pinctrl: add a driver for the OMAP pinmux
Date: Wed, 23 Nov 2011 11:14:32 +0100
Message-ID: <20111123101432.GA14404@game.jcrosoft.org>
References: <1321274409-24643-2-git-send-email-rnayak@ti.com>
 <20111114172312.GI31337@atomide.com>
 <4EC1EB9D.1000503@ti.com>
 <CACRpkdYuw+AfVtgfsbpkd=uvfWd8yE-n25EC0FDffhiGUS2MBw@mail.gmail.com>
 <CAJuYYwSgzkDed5-R=PaBR_F6ssj_EhxLDfCREXUA=UaynkgZyg@mail.gmail.com>
 <CACRpkdbBQoOU8hyew6tXth3Ohrg5_rN7M+tbVsYFcOjgq73aCw@mail.gmail.com>
 <CAJuYYwT_useS-8cH+qfDu5t7wh73yUuJAVXMjP5CXBS2VM3bag@mail.gmail.com>
 <CACRpkdax0GK=mNNao7FPc6JG0RwVywSEzGJPC_u73iJ_eOTgqQ@mail.gmail.com>
 <20111122175409.GE31337@atomide.com>
 <74CDBE0F657A3D45AFBB94109FB122FF174F08C5B3@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF174F08C5B3@HQMAIL01.nvidia.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "linus.walleij@stericsson.com" <linus.walleij@stericsson.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 16:28 Tue 22 Nov     , Stephen Warren wrote:
> Tony Lindgren wrote at Tuesday, November 22, 2011 10:54 AM:
> > * Linus Walleij <linus.walleij@linaro.org> [111122 03:30]:
> > > On Tue, Nov 22, 2011 at 12:09 PM, Thomas Abraham
> > > <thomas.abraham@linaro.org> wrote:
> > > > On 17 November 2011 19:27, Linus Walleij <linus.walleij@linaro.org> wrote:
> > > >>
> > > >> Maybe I'm mistaken about the device tree ambitions, but
> > > >> I was sort of hoping that it would not contain too much
> > > >> custom magic numbers that need to be cross-referenced
> > > >> elsewhere ... or rather - the more understandable the device
> > > >> tree is, the more we win.
> > > >
> > > > Device tree is expected to describe the hardware. So to
> > > > cross-reference the hardware manual to understand device tree should
> > > > be fine I guess. For instance, GPIO numbers in dts would be written as
> > > > a numeric number and not a enum or other format. And by looking up the
> > > > manual, we understand the actual details of the GPIO pin.
> > > >
> > > > If dt-compiler had a option to support #define like in C, the numbers
> > > > could have been made more easier to understand. Like, 3 to mean
> > > > GPIO_PULL_UP in Exynos dts file.
> > >
> > > OK I think I get it now, so DT bindings shall really NOT be read
> > > by any of the pinctrl core, it is *supposed* to be all driver-specific.
> > > Then it makes perfect sense to have it as it is.
> > 
> > Yes the driver nodes should describe in DT which pins to use:
> > 
> >         serial@12340000 {
> >                 compatible = "8250";
> >                 reg = <0x12340000 0x40>;
> >                 reg-shift = <2>;
> >                 interrupts = < 10 >;
> > 		pins = "uart1_rx", "uart1_tx";
> >         };
> 
> Sorry to jump in late here, but I wasn't aware of this thread.
> 
> I don't necessarily agree with that. Describing the HW doesn't necessarily
> mean that each device needs to describe what pinmux pins it uses; one
> could quite easily have the pinmux describe what settings the various
> pins should have and which drivers will use those pins. That would map
> very well to the pinctrl subsystem's mapping table, and at least Tegra's
> existing pinmux tables, which are both just a big array of settings which
> end up getting provided to drivers.
> 
> I'll try and track down the rest of this thread and catch up though...
I agreee here


as example on at91 I try to found a good way to let the macb driver to ask the
pin configuration

so in my mind i do not need put all pins in each board but in the dtsi and
then in the drivers just said
	pins = "mii";
	or
	pins = "rmii";
	or if I want to use the alternative config

	pins = "mii_alt";
	or
	pins = "rmii_alt";

and then in the dtsi I describe the  pin used for those configs
which is soc specifific not board

Best Regards,
J.
