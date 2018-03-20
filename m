From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 3/8] drm/omap: add support for manually updated displays
Date: Tue, 20 Mar 2018 07:29:11 -0700
Message-ID: <20180320142911.GY5799@atomide.com>
References: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
 <20180208183035.8461-4-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180208183035.8461-4-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [180208 18:31]:
> This adds the required infrastructure for manually
> updated displays, such as DSI command mode panels.
> 
> While those panels often support partial updates
> we currently always do a full refresh. Display
> will be refreshed when something calls the dirty
> callback, such as libdrm's drmModeDirtyFB().
> 
> This is currently being implemented for the kernel
> console and for Xorg. Weston currently does not
> implement this and is known not to work on manually
> updated displays.

Tested-by: Tony Lindgren <tony@atomide.com>
