From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 3/8] drm/omap: add support for manually updated displays
Date: Fri, 20 Apr 2018 07:25:33 -0700
Message-ID: <20180420142533.GN5671@atomide.com>
References: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
 <20180330171822.25896-4-sebastian.reichel@collabora.co.uk>
 <a078d8c3-9e65-cc7b-737a-cbd5cf141f95@ti.com>
 <CAPj87rPeBim9NyBmMuDKKEwx2apLhdnZyEB9_sfbVQpUHA95+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPj87rPeBim9NyBmMuDKKEwx2apLhdnZyEB9_sfbVQpUHA95+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Stone <daniel@fooishbar.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, dri-devel <dri-devel@lists.freedesktop.org>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Daniel Stone <daniel@fooishbar.org> [180420 10:21]:
> Hi Tomi,
> 
> On 20 April 2018 at 08:09, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > It's actually not quite clear to me how manual update displays work with
> > DRM...
> >
> > As far as I see, we have essentially two cases: 1) single buffering,
> > where the userspace must set an area in the fb dirty, which then
> > triggers the update, 2) multi buffering, which doesn't need fb dirty,
> > but just a page flip which triggers the update.
> >
> > In the 2) case (which I think is the optimal case which all the modern
> > apps should use), there's no need for delayed work or any work, and the
> > code flow should be very similar to the auto-update model.
> 
> Correct. There's been talk (and I think patches?) of adding a
> per-plane dirty property, so userspace can as an optimisation inform
> the kernel of the area changed between frames. But short of that, a
> pageflip needs to trigger a full-plane update, with no dirtyfb
> required.

For per-plane dirty property patches, which ones do you refer to?

Then for xorg, there's my second attempt on fixing the command mode
rotation at [0]. Not sure if that's enough for a fix?

It seems not very efficient to me and I don't really know where
the the per crtc dirty flag should be stored..

I can easily test patches though with a command mode LCD and normal
HDMI setup on droid 4.

Regards,

Tony

[0] https://lists.x.org/archives/xorg-devel/2018-February/055890.html
