From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: dts: am437x-gp/epos-evm: drop unused panel
 timings
Date: Tue, 11 Feb 2020 08:27:19 -0800
Message-ID: <20200211162719.GF64767@atomide.com>
References: <20191211165331.GC43123@atomide.com>
 <45dae8f7-2f5e-6948-5a05-dc8a09ace1fa@ti.com>
 <20191212203550.GB4892@pendragon.ideasonboard.com>
 <add3d8af-6977-68e6-fb77-2fa748c4714a@ti.com>
 <b39e52f1-3e73-5f26-6206-0956cf482631@ti.com>
 <20200211110712.GB28355@pendragon.ideasonboard.com>
 <3b4d10c6-7cb2-af53-3a39-31eef441bfdd@ti.com>
 <98da360f-880b-af56-b285-4d9b39f8a342@wizzup.org>
 <20200211160524.GE64767@atomide.com>
 <87b1111e-af06-1e2a-8baa-c3f9a15f1874@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87b1111e-af06-1e2a-8baa-c3f9a15f1874-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Merlijn Wajer <merlijn-tF0PIh4TN3odnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org> [200211 16:14]:
> On 11/02/2020 18:05, Tony Lindgren wrote:
> > * Merlijn Wajer <merlijn-tF0PIh4TN3odnm+yROfE0A@public.gmane.org> [200211 12:54]:
> > > Hi,
> > > 
> > > On 11/02/2020 12:08, Tomi Valkeinen wrote:
> > > > On 11/02/2020 13:07, Laurent Pinchart wrote:
> > > > 
> > > > > > Hopefully soon (in five years? =) we can say that omapdrm supports all
> > > > > > the boards, and we can deprecate omapfb.
> > > > > 
> > > > > I'd love to send a patch to remove omapfb, but I'll let you do the
> > > > > honours :-)
> > > > 
> > > > Not before we add DSI support to omapdrm...
> > 
> > Hmm do your mean RFBI? The DSI support we already have :)
> 
> Oh, I didn't even remember RFBI... But it is not supported in omapfb either,
> so it's not blocking removal of omapfb.

Oh OK.

> We are still missing DSI command mode support, and moving it to the common DRM model.

Nope, DSI command mode support has been working just fine for
a while now :) And Sebastian has a WIP git tree of the common DRM
model changes for it. I don't think we have devices with DSI
command mode working for omapfb but not for omapdrm?

What got missed for v5.6-rc1 is the LCD backlight patch though,
I think the only issue there is default-brightness vs more common
default-brightness-value usage if you have any input to that.

> > > This is probably known, but for devices that would like use PowerVR SGX,
> > > there sometimes is only userspace available that works with omap(l)fb,
> > > and not with DRM. The Nokia N900 is such an example.
> > > 
> > > There might be a newer release of (closed) userspace coming for the
> > > aging device(s), but as it stands, I don't think it's possible to do 3D
> > > with PowerVR SGX on omapdrm currently.
> > > 
> > > But I might be wrong...
> > 
> > Yes SGX is a bottleneck currently for omap3 users. And I think
> > RFBI is blocking n8x0 from moving to omapdrm and finally leaving
> > drivers/video/fbdev/omap2 behind.
> > 
> > With those blockers fixed, I'd also be happy to just get rid of
> > drivers/video/fbdev/omap2 as there should be no reason to
> > keep using it.
> 
> I don't know what to do about SGX, but if someone sends patches to omapdrm
> to allow using SGX, I'll review =).

OK so then the only blocker seems to be the lack of SGX blobs
for omap3 devices which seems to be in process of getting fixed.

Regards,

Tony
