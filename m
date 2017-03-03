From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/8] Droid4 DTS update
Date: Fri, 3 Mar 2017 08:31:13 -0800
Message-ID: <20170303163113.GX20572@atomide.com>
References: <20170302010900.28532-1-sre@kernel.org>
 <20170302013707.GK20572@atomide.com>
 <20170303111703.jxl3prdisencuddu@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170303111703.jxl3prdisencuddu@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170303 03:18]:
> Hi,
> 
> On Wed, Mar 01, 2017 at 05:37:08PM -0800, Tony Lindgren wrote:
> > * Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170301 17:10]:
> > > Hi,
> > > 
> > > Tony, since your omap4-droid4 dts patches were not
> > > yet in a public repository and they would merge conflict
> > > with my patches I put them all together into a single
> > > patchset. I also added my Tested-By to your patches.
> > 
> > OK
> > 
> > > The mounting-matrix for the sensors and the touchscreen's 
> > > rotation assume, that the phone's default rotation is vertical.
> > > I think that's sensible, because
> > > 
> > >  * Android on the phone uses this as default rotation
> > >    (like almost? all other phones)
> > >  * volume buttons make sense (in horizontal position one
> > >    would expect, that left button means lower volume. I
> > >    know at least Maemo swaps them)
> > > 
> > > That should cover all mainline drivers.
> > 
> > Heheheh cool looks like you configured compass and accelerometer :)
> 
> Easy targets with driver already available :)
> 
> One of them actually does not forward the mount rotation matrix
> to sysfs/userspace at the moment due to missing driver support,
> but the binding is generic.
> 
> > I have a better touchscreen patch that also configures the wakeirq
> > that I did not post yet at http://muru.com/linux/d4/patches/ in the
> > updated set droid4-wip-next-20170217.tar.gz.
> 
> It's part of the LCD patch, so I missed it.

Yeah so it seems sorry. I got most of the patches split out last
night, still need some time before I can send them out.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
