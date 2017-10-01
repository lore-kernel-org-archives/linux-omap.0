From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/7] dt-bindings: bus: Minimal TI sysc interconnect
 target module binding
Date: Sun, 1 Oct 2017 10:14:07 -0700
Message-ID: <20171001171406.GL4394@atomide.com>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-2-tony@atomide.com>
 <20171001131151.loanjnvarkihbhik@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171001131151.loanjnvarkihbhik@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org> [171001 06:12]:
> On Fri, Sep 29, 2017 at 03:34:05PM -0700, Tony Lindgren wrote:
> > Note that additional properties for sysc capabilities will be added
> > later on. For now, we can already use this binding for interconnect
> > target modules that do not have any child device drivers available.
> > This allows us to idle the unused interconnect target modules during
> > init without the need for legacy hwmod platform data for doing it.
> 
> DT backwards compatibility is about booting an old DT file with a
> newer kernel. Since old DT file does not contain a "ti,sysc-omap*"
> node you don't need to add "ti,hwmod = *" support to it. Instead a
> DT file, that uses ti,hwmod in the device node and does not have a
> "ti,sysc-omap*" at all should still work.

Not sure if I parse that right, but I'm assuming you suggest leaving
out ti,hwmod to start with. Well I considered that, but it causes
the "waiting for a magical flip issue". So initially we need to use
both ti,sysc and ti,hwmod until ti,sysc alone has the equal
functionality. That's because then we can do the following steps:

1. We want to add compatible = ti,sysc so we can define the
   nodes and get the parent-children hierarhcy right. We can
   already use the parent-child features even with ti,hwmods
   before we have complete dts based data. We are currently
   missing that capability without doing device specific parent
   drivers like we do with drivers/usb/musb/musb_am335x.c. Note
   that in this step we are moving the ti,hwmod to the parent
   node

2. When ti,sysc can configure things based on dts data alone the
   same way as the legacy platform data, we can just drop the
   ti,hwmod property. We also want to be able to test one driver
   at a time between ti,sysc + ti,hwmod vs ti,sysc only

3. Once ti,hwmod properties have been removed from the mainline
   kernel, we can add a warning about ti,hwmod properties being
   deprecated

4. Then later on, we can also drop the hwmod platform data and
   continue produce warnings if ti,hwmod is seen

> IMHO we should break DT ABI for OMAP at some point, so that we can
> get rid of the hwmod database. My suggestion would be, that
> simple-bus checks if any child device is != "ti,omap-sysc*" and
> does panic("please update DT!").

Yes we can eventually drop the static data and ti,hwmod while
providing helpful information to the users.

Regards,

Tony

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
