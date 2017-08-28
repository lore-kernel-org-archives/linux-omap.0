From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 17/17] ARM: dts: Add missing hwmod related properties for
 dra7
Date: Mon, 28 Aug 2017 15:27:46 -0700
Message-ID: <20170828222746.GQ6008@atomide.com>
References: <20170828211918.11573-1-tony@atomide.com>
 <20170828211918.11573-18-tony@atomide.com>
 <8c0ecbf6-26fb-1998-6bb5-0a74d9daa2ab@ti.com>
 <20170828213753.GP6008@atomide.com>
 <fd064c10-2051-1579-bde1-60c3fed2b4a0@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <fd064c10-2051-1579-bde1-60c3fed2b4a0-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [170828 14:53]:
> On 08/28/2017 04:37 PM, Tony Lindgren wrote:
> > * Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [170828 14:35]:
> > > On 08/28/2017 04:19 PM, Tony Lindgren wrote:
> > > > On dra7 we're missing the smartreflex and hdq nodes with their
> > > > related "ti,hwmods" property that the SoC interconnect code needs.
> > > > 
> > > > Note that this will only show up as a bug with "doesn't have
> > > > mpu register target base" boot errors when the legacy platform
> > > > data is removed.
> > > > 
> > > > Note that the related driver also needs to be updated to probe
> > > > using device tree and get the platform data passed to it using
> > > > auxdata with arch/arm/mach-omap2/pdata-quirks.c.
> > > > 
> > > > Let's also update the related binding documentation while at it.
> > ...
> > > > @@ -1489,6 +1497,18 @@
> > > >    			};
> > > >    		};
> > > > +		smartreflex_core: smartreflex4a0dd000 {
> > > > +			compatible = "ti,dra7-smartreflex-core";
> > > > +			ti,hwmods = "smartreflex_core";
> > > > +			reg = <0x4a0dd000 0x80>;
> > > > +		};
> > > > +
> > > > +		smartreflex_mpu: smartreflex@4a0d9000 {
> > > > +			compatible = "ti,dra7-smartreflex-mpu";
> > > > +			ti,hwmods = "smartreflex_mpu";
> > > > +			reg = <0x4a0d9000 0x80>;
> > > > +		};
> > > 
> > > 
> > > Have you checked TRM for these?
> > > http://www.ti.com/lit/ug/sprui30d/sprui30d.pdf
> > > 
> > > These are disabled on the SoC and marked as reserved.
> > 
> > Then why do we still have legacy hwmod data for them?
> 
> We should probably drop them - probably legacy of autogeneration at some
> point in history.

OK thanks, will drop them and update this patch accordingly.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
