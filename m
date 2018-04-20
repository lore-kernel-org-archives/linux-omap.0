From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 3/8] drm/omap: add support for manually updated displays
Date: Fri, 20 Apr 2018 07:44:01 -0700
Message-ID: <20180420144401.GO5671@atomide.com>
References: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
 <20180330171822.25896-4-sebastian.reichel@collabora.co.uk>
 <a078d8c3-9e65-cc7b-737a-cbd5cf141f95@ti.com>
 <CAPj87rPeBim9NyBmMuDKKEwx2apLhdnZyEB9_sfbVQpUHA95+Q@mail.gmail.com>
 <20180420142533.GN5671@atomide.com>
 <CAPj87rPLEEa6_13T38BQM4HXV5v17MzjGmLE2WSPJTo09qUJpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPj87rPLEEa6_13T38BQM4HXV5v17MzjGmLE2WSPJTo09qUJpQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Stone <daniel@fooishbar.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, dri-devel <dri-devel@lists.freedesktop.org>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

* Daniel Stone <daniel@fooishbar.org> [180420 14:41]:
> Hi Tony!
> 
> On 20 April 2018 at 15:25, Tony Lindgren <tony@atomide.com> wrote:
> > * Daniel Stone <daniel@fooishbar.org> [180420 10:21]:
> >> On 20 April 2018 at 08:09, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >> > It's actually not quite clear to me how manual update displays work with
> >> > DRM...
> >> >
> >> > As far as I see, we have essentially two cases: 1) single buffering,
> >> > where the userspace must set an area in the fb dirty, which then
> >> > triggers the update, 2) multi buffering, which doesn't need fb dirty,
> >> > but just a page flip which triggers the update.
> >> >
> >> > In the 2) case (which I think is the optimal case which all the modern
> >> > apps should use), there's no need for delayed work or any work, and the
> >> > code flow should be very similar to the auto-update model.
> >>
> >> Correct. There's been talk (and I think patches?) of adding a
> >> per-plane dirty property, so userspace can as an optimisation inform
> >> the kernel of the area changed between frames. But short of that, a
> >> pageflip needs to trigger a full-plane update, with no dirtyfb
> >> required.
> >
> > For per-plane dirty property patches, which ones do you refer to?
> 
> Here's the latest iteration of that series:
> https://lists.freedesktop.org/archives/dri-devel/2018-April/171900.html
> <1522885748-67122-1-git-send-email-drawat@vmware.com>

OK thanks for the link.

> > Then for xorg, there's my second attempt on fixing the command mode
> > rotation at [0]. Not sure if that's enough for a fix?
> >
> > It seems not very efficient to me and I don't really know where
> > the the per crtc dirty flag should be stored..
> 
> I try to deny all knowledge of X11 these days, I'm afraid.

:)

Tony
