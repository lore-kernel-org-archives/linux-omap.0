From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: OMAP DRM regression on N900
Date: Wed, 21 Aug 2019 21:31:23 +0300
Message-ID: <20190821183123.GC26759@pendragon.ideasonboard.com>
References: <20190818140838.GC30291@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190818140838.GC30291@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Sebastian Reichel <sebastian.reichel@collabora.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Aaro,

On Sun, Aug 18, 2019 at 05:08:38PM +0300, Aaro Koskinen wrote:
> Hi,
> 
> I haven't got display working on N900 since v5.1. Bisected to:
> 
> d17eb4537a7eb16da9eafbfd5717e12b45b77251 is the first bad commit
> commit d17eb4537a7eb16da9eafbfd5717e12b45b77251
> Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Date:   Wed Sep 12 19:41:31 2018 +0300
> 
>     drm/omap: Factor out common init/cleanup code for output devices

Sorry :-(

I'll send a tentative fix, I'd appreciate if you could test it.

> looks like with this commit I get only the TV out:
> 
> $ ls -l /sys/class/drm/
> total 0
> lrwxrwxrwx    1 root     root             0 Aug 18 16:15 card0 -> ../../devices/platform/omapdrm.0/drm/card0
> lrwxrwxrwx    1 root     root             0 Aug 18 16:15 card0-SVIDEO-1 -> ../../devices/platform/omapdrm.0/drm/card0/card0-SVIDEO-1
> lrwxrwxrwx    1 root     root             0 Aug 18 16:15 renderD128 -> ../../devices/platform/omapdrm.0/drm/renderD128
> -r--r--r--    1 root     root          4096 Aug 18 16:15 version
> 
> with the previous commit both outputs are there:
> 
> $ ls -l /sys/class/drm/
> total 0
> lrwxrwxrwx    1 root     root             0 Aug 18 16:28 card0 -> ../../devices/platform/omapdrm.0/drm/card0
> lrwxrwxrwx    1 root     root             0 Aug 18 16:28 card0-LVDS-1 -> ../../devices/platform/omapdrm.0/drm/card0/card0-LVDS-1
> lrwxrwxrwx    1 root     root             0 Aug 18 16:28 card0-SVIDEO-1 -> ../../devices/platform/omapdrm.0/drm/card0/card0-SVIDEO-1
> lrwxrwxrwx    1 root     root             0 Aug 18 16:28 renderD128 -> ../../devices/platform/omapdrm.0/drm/renderD128
> -r--r--r--    1 root     root          4096 Aug 18 16:28 version
> 
> Used .config below.

[snip]

-- 
Regards,

Laurent Pinchart
