From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/8] omapdrm: DSI command mode panel support
Date: Thu, 8 Feb 2018 15:13:41 -0800
Message-ID: <20180208231341.GB4383@atomide.com>
References: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [180208 10:31]:
> Hi,
> 
> These are the remaining patches from my previous patchset to get
> Droid 4 (omap4) display working. The patches have been rebased to
> current master branch from Torvalds (581e400ff935). Since N950
> (omap3) is broken even with the workaround I moved it to the end,
> so that it can be skipped.
> 
> Working on Droid 4:
>  * Framebuffer Console, updated at 1Hz due to blinking cursor
>  * kmstest (static image)
>  * Display blanking
>  * Xorg with omap and modesetting driver
>  * No updates send when nothing needs to be sent
>  * Orientation DRM property is attached to the DSI panel

Great, still works for me :) Seems like the dts change is
safe to merge along with the driver changes once no more
comments. For patches 1 - 7, please feel free to add:

Tested-by: Tony Lindgren <tony@atomide.com>
