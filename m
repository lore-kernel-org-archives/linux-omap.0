From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 2/2] arm: dts: gta04: add gps support
Date: Mon, 4 Feb 2019 09:30:32 +0100
Message-ID: <20190204083032.GB4686@localhost>
References: <20190131180640.14480-1-andreas@kemnade.info>
 <20190131180640.14480-3-andreas@kemnade.info>
 <20190201100416.GD3691@localhost>
 <20190201200630.2efc9eef@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190201200630.2efc9eef@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Johan Hovold <johan@kernel.org>, mark.rutland@arm.com, devicetree@vger.kernel.org, letux-kernel@openphoenux.org, tony@atomide.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 01, 2019 at 08:06:30PM +0100, Andreas Kemnade wrote:
> On Fri, 1 Feb 2019 11:04:16 +0100
> Johan Hovold <johan@kernel.org> wrote:
> 
> > On Thu, Jan 31, 2019 at 07:06:40PM +0100, Andreas Kemnade wrote:
> > > The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
> > > which one is mounted so use the compatibility entry for w2sg0004
> > > for all which will work for both.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > > Changes in v3:
> > > - converted to a patchset
> > > - added vcc-supply
> > > 
> > > Changes in v2:
> > > - some s/gps/gnss/
> > > - not added vcc-supply because the regulator is not modelled
> > >   in dts at all
> > > 
> > > w2sg0004 bindings are in next-20190129
> > > 
> > >  arch/arm/boot/dts/omap3-gta04.dtsi | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> > > index 02d8274a2f47..4ea0f7dc37c6 100644
> > > --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> > > +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> > > @@ -320,6 +320,12 @@  
> > >  		>;  
> > >         };
> > >  
> > > +	gps_pins: pinmux_gps_pins {  
> > 
> > s/gps/gnss/ would be more consistent, but whatever.
> > 
> well, gps is already in the file at another place. So it is a bit
> inconsistent in any case, without further cleanup. If someone comes
> up with a strong opinion here I would of course change it.

Up to you. As long as the gnss node is named "gnss" I don't have a
strong opinion on the other names (as long as they follow the spec of
course).

Johan
