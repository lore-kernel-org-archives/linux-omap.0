From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 13/17] ARM: dts: Add missing fdif node and binding for
 omap4
Date: Tue, 29 Aug 2017 12:01:07 -0700
Message-ID: <20170829190107.GE6008@atomide.com>
References: <20170828211918.11573-1-tony@atomide.com>
 <5996934.WE9heBV2Dy@avalon>
 <20170829142941.GU6008@atomide.com>
 <5659095.JaecBxseot@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5659095.JaecBxseot@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [170829 10:13]:
> On Tuesday, 29 August 2017 17:29:42 EEST Tony Lindgren wrote:
> > > Are there SoCs that don't need this ?
> > 
> > DaVinci or Keystone maybe? And I do have patches coming that will
> > remove the need for "ti,hwmods" but that's still maybe 200 patches
> > away or something..
> 
> That would be amazing :-)

Yeah.. FYI, the way to get there is to have a generic interonnect
target agent driver for the module, then have the device ip
instance(s) just be children of the interconnect target. But
it will be a while until I can start posting those patches.

Until that's available, we can have minimal device specific
interconnect target module drivers just like we have
drivers/usb/musb/musb_am335x.c. That's the parent for two
musb instances and one cppi41 dma instance. See also the
related "usb@47400000" node in am33xx.dtsi and it's children.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
