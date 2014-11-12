From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 4/4] arm: dts: omap3-gta04: Add static configuration for
 devconf1 register
Date: Wed, 12 Nov 2014 07:02:11 -0800
Message-ID: <20141112150210.GC26481@atomide.com>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com>
 <1415051968-4878-5-git-send-email-marek@goldelico.com>
 <5463585D.9070209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5463585D.9070209-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org> [141112 04:56]:
> Hi,
> 
> On 03/11/14 23:59, Marek Belisko wrote:
> > gta04 board need for tvout enabled 2 bits in devconf1 register (tvbypass and acbias).
> > Add single pinmux entry and enable it.
> > 
> > Signed-off-by: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/omap3-gta04.dtsi | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> > index e4d05f0..a456d37 100644
> > --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> > +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> > @@ -118,6 +118,17 @@
> >  			};
> >  		};
> >  	};
> > +
> > +	/* pinmux for devconf1 */
> > +	control_devconf1: pinmux@480022d8 {
> > +		compatible = "pinctrl-single";
> > +		reg = <0x480022d8 4>;	/* single register */
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		pinctrl-single,bit-per-mux;
> > +		pinctrl-single,register-width = <32>;
> > +		pinctrl-single,function-mask = <0xfc0bd5>;
> > +	};
> >  };
> >  
> >  &omap3_pmx_core {
> > @@ -497,3 +508,14 @@
> >  		};
> >  	};
> >  };
> > +
> > +&control_devconf1 {
> > +	pinctrl-name = "default";
> > +	pinctrl-0 = < &tv_acbias_pins>;
> > +
> > +	tv_acbias_pins: pinmux_tv_acbias_pins {
> > +		pinctrl-single,bits = <
> > +			0 0x40800 0x40800
> 
> I think it would be good to have a comment in the .dts above, mentioning
> that TVOUTBYPASS and TVACEN bits are being set.
> 
> > +		>;
> > +	};
> > +};
> > 
> 
> OMAP3630 seems to have CONTROL_AVDAC1 and CONTROL_AVDAC2 registers. Did
> you check if the SoC you use have those? It looks like they need
> configuration also, if the exist.

Those look like AVDAC specific control registers that are not mux
registers. So those should be accessed the existing SCM (System Control
Mmodule) syscon area by the DSS code. For examples, see what
pbias-regulator.c is doing for some other registers in the syscon area.
 
> So, I don't think tvbypass and acbias are really pinmux stuff, but it
> does seem like an easy way to handle the devconf1 register, and I don't
> see any issues with the setting being fixed.

The CONTROL_DEVCONF registers seem to be all related to muxing signals
and configuring ping signal levels. So I think the pinctrl-single is
OK to use with these.
 
> However, devconf1 register seems to have bits for many devices,
> including mcbsp, mmc, and even some "Force MPU writes to be nonposted" bit.

Yes the"Force MPU writes to be nonposted" debug bit is an odd one
there :) But we're not using that luckily anywhere..
 
> And, with a quick grep, I see CONTROL_DEVCONF1 touched in multiple
> places in the kernel. I wonder if adding a pinmux entry for it could
> cause some rather odd problems.

They can all use pinctrl-single no problem.
 
> Tony, any idea about this? How should CONTROL_DEVCONFx registers be
> accessed?

If they are pinctrl related like the CONTROL_DEVCONF registers, then
pincatrl-single is OK. However, for any registers in the SCM that are
not just routing signals, then the syscon mapping should be used. And
we should have a separate driver implementing some standard Linux
generic framework driver. For example a regulator or clock driver.

Anyways, I'll drop this $subject patch for now and set up a new branch
for the .dts changes.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
