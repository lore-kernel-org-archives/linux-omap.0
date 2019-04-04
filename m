From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv6 4/4] drm/omap: add support for manually updated displays
Date: Wed, 3 Apr 2019 17:11:09 -0700
Message-ID: <20190404001109.GZ49658@atomide.com>
References: <20190403195413.djfrgzuj7povdksi@earth.universe>
 <20190403201326.3127-1-sebastian.reichel@collabora.com>
 <20190403201326.3127-5-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403201326.3127-5-sebastian.reichel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.com> [190403 20:14]:
> This adds the required infrastructure for manually updated displays,
> such as DSI command mode panels. While those panels often support
> partial updates we currently always do a full refresh.
> 
> The display will be refreshed when something calls the dirty callback,
> such as libdrm's drmModeDirtyFB(). This is currently being done at least
> by the kernel console and Xorg (with modesetting driver) in their
> default configuration. Weston does not implement this and the fbdev
> backend does not work (display will not update). Weston's DRM backend
> uses double buffering and the page flip will also trigger a display
> refresh.

I've tested this with Linux next and the latest lm3532
patches and it works fine as long as we leave out the
backlight = <&lcd_backlight> entry from dts like I
replied in the lm3532 tread. So as far as I'm concerned,
we're good to go:

Tested-by: Tony Lindgren <tony@atomide.com>
