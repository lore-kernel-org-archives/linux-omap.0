From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCHv5 0/6] omapdrm: DSI command mode panel support
Date: Tue, 2 Apr 2019 18:55:08 +0300
Message-ID: <20190402155508.GJ4805@pendragon.ideasonboard.com>
References: <20181121160916.22017-1-sebastian.reichel@collabora.com>
 <3fed7238-776e-9ee7-9c54-b7c44a5e3a2e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3fed7238-776e-9ee7-9c54-b7c44a5e3a2e@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 02, 2019 at 06:36:21PM +0300, Tomi Valkeinen wrote:
> On 21/11/2018 18:09, Sebastian Reichel wrote:
> > Hi,
> > 
> > Here is another round of the DSI command mode panel patchset
> > integrating the feedback from PATCHv4. The patches are based
> > on 4.20-rc1 + fixes from Laurent and Tony. I dropped the patches
> > for OMAP3 support (it needs a workaround for a hardware bug) and
> > for automatic display rotation. They should get their own series,
> > once this patchset has landed.
> 
> The big omapdrm bridge/panel series from Laurent has been merged to
> drm-next. I think this series can now be rebased and merged.
> 
> However, all this needs to be changed to DRM bridge/panel model sooner
> or later (sooner, please!), but perhaps it's best to first go with the
> legacy way.

I would be OK with that, but I'd like to understand what we still need
to do to convert DSI support to DRM bridge and panel. Sebastian, if
you've looked into it, could you provide some insight ?

-- 
Regards,

Laurent Pinchart
