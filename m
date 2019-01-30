From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] arm: dts: gta04: add gps support
Date: Wed, 30 Jan 2019 10:02:32 +0100
Message-ID: <20190130090232.GL3691@localhost>
References: <20190125194310.11170-1-andreas@kemnade.info>
 <20190128075356.GJ3691@localhost>
 <20190128163025.7daa385b@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128163025.7daa385b@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Johan Hovold <johan@kernel.org>, bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 28, 2019 at 05:44:29PM +0100, Andreas Kemnade wrote:
> On Mon, 28 Jan 2019 08:53:56 +0100
> Johan Hovold <johan@kernel.org> wrote:
> 
> > On Fri, Jan 25, 2019 at 08:43:10PM +0100, Andreas Kemnade wrote:
> > > The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
> > > which one is mounted so use the compatibility entry for w2sg0004
> > > for all which will work for both.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > > w2sg0004 bindings (together with the corresponding support is in
> > > https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss gnss-next)
> > >  arch/arm/boot/dts/omap3-gta04.dtsi | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)

> > > +	gps: gps {  
> > 
> > The node should be named "gnss" as per the binding.
> > 
> > > +		compatible = "wi2wi,w2sg0004";
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&gps_pins>;
> > > +		sirf,onoff-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
> > > +		lna-supply = <&vsim>;  
> > 
> > Also, the vcc-supply is a required property.
> > 
> well, it is not require in the driver and it has different behavior
> (on even when not opened if on-off is there) than the lna-supply used
> here. So maybe fix the binding documentation?

The device-tree describes hardware, and how a particular driver happens
to implement a binding is not relevant.

That said, there is a bit of an on-going, shall we say philosophical,
debate about this. The regulator maintainer takes a firm position that
all mandatory physical supplies should be represented in firmware
	
	https://lore.kernel.org/lkml/20181123133126.GF2089@sirena.org.uk/T/#u
	https://lore.kernel.org/lkml/20180409102244.GB11532@sirena.org.uk/T/#u

while Rob appears to take a slightly different stance on fixed
regulators while admitting that this an issue which has not yet been
fully resolved:

	https://lore.kernel.org/lkml/20180425171123.xhyoay3nu463btoq@rob-hp-laptop/T/#u

Since this is a new binding, and the hardware requires the vcc supply
and this is reflected in the binding, I think you should add a fixed
regulator. At least until you hear otherwise. ;)

Johan
