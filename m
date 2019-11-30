From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH V5 1/3] drm/panel: simple: Add Logic PD Type 28 display
 support
Date: Sat, 30 Nov 2019 23:16:30 +0100
Message-ID: <20191130221630.GD29715@ravnborg.org>
References: <20191016135147.7743-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191016135147.7743-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sebastian.reichel@collabora.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Adam.

On Wed, Oct 16, 2019 at 08:51:45AM -0500, Adam Ford wrote:
> Previously, there was an omap panel-dpi driver that would
> read generic timings from the device tree and set the display
> timing accordingly.  This driver was removed so the screen
> no longer functions.  This patch modifies the panel-simple
> file to setup the timings to the same values previously used.
> 
> Fixes: 8bf4b1621178 ("drm/omap: Remove panel-dpi driver")
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> V5:  No Change
> V4:  No Change
> V3:  No Change
> V2:  No Change

Applied to drm-misc-next.
Sorry for the delay - has been absent for a while.

	Sam
