From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 09/17] ARM: dts: Add missing iss node and binding for
 omap4
Date: Tue, 29 Aug 2017 07:22:53 -0700
Message-ID: <20170829142253.GT6008@atomide.com>
References: <20170828211918.11573-1-tony@atomide.com>
 <20170828211918.11573-10-tony@atomide.com>
 <1768059.eopKmxhyQx@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1768059.eopKmxhyQx@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [170829 05:37]:
> On Tuesday, 29 August 2017 00:19:10 EEST Tony Lindgren wrote:
> > On omap4 we're missing the iss node with it's related "ti,hwmods"
> > property that the SoC interconnect code needs.
> > 
> > Note that this will only show up as a bug with "doesn't have
> > mpu register target base" boot errors when the legacy platform
> > data is removed.
...

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/ti-iss.txt
> > @@ -0,0 +1,32 @@
> > +Texas Instruments Imaging Subsystem (ISS) binding
> > +
> > +ISS is used for cameras on Texas Instruments SoCs.
> > +
> > +
> > +Required properties:
> > +
> > +compatible: Shall be one of the following:
> > +	    "ti,omap4-iss"
> > +
> > +reg: Shall contain the device instance IO range
> > +
> > +interrupts: Shall contain the device instance interrupt
> > +
> > +
> > +Optional properties:
> > +
> > +reg-names: Shall contain the IO range names if multiple IO
> > +	   ranges are used by the SoC
> > +
> > +ti,hwmods: Shall contain the TI interconnect module name if needed
> > +	   by the SoC
> 
> This isn't enough. The ISS isn't a stand-alone IP core, it is connected to 
> external devices and those connections must be modelled in DT similarly to the 
> OMAP3 ISP.

OK I'll add a note about those so the driver can add those later
with a separate patch.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
