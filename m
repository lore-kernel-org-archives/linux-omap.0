From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] Device tree binding for Avago APDS990X light sensor
Date: Wed, 27 Dec 2017 23:16:44 +0200
Message-ID: <20171227211643.nnwtm4j6cyftlm66@kekkonen.localdomain>
References: <20171227091828.GA3307@amd>
 <20171227180000.6ejpbqmr736nqx5i@kekkonen.localdomain>
 <20171227200147.GB16799@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171227200147.GB16799@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, abcloriens-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, clayton-fehKsxFhGzZIf6P1QZMOBw@public.gmane.org, martijn-28JJ9oSIdodmR6Xm/wNWPw@public.gmane.org, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 27, 2017 at 09:01:47PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > +Required properties:
> > > +- compatible: "avago,apds990x"
> > > +- reg: address on the I2C bus
> > > +- interrupts: external interrupt line number
> > > +- Vdd-supply: power supply for VDD
> > > +- Vled-supply: power supply for LEDA
> > 
> > AFAIK the custom is to use lower case letters for regulator supplies.
> > 
> > > +- ga: Glass attenuation
> > > +- cf1: Clear channel factor 1
> > > +- irf1: IR channel factor 1
> > > +- cf2: Clear channel factor 2
> > > +- irf2: IR channel factor 2
> > > +- df: Device factor
> > > +- pdrive: IR current, one of APDS_IRLED_CURR_XXXmA values
> > > +- ppcount: Proximity pulse count
> > 
> > Are these device specific? If so, please add the vendor prefix to them.
> 
> Well, whole binding is "vendor specific". Does it make sense to add
> prefix in such case?

Yes, it does. If you later find one or more of these are generic, you could
remove the vendor prefix. I doubt that'll happen though, these seem very
device specific parameters.

-- 
Sakari Ailus
sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
