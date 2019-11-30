From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH V5 2/3] dt-bindings: Add Logic PD Type 28 display panel
Date: Sat, 30 Nov 2019 23:15:33 +0100
Message-ID: <20191130221533.GC29715@ravnborg.org>
References: <20191016135147.7743-1-aford173@gmail.com>
 <20191016135147.7743-2-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191016135147.7743-2-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sebastian.reichel@collabora.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Adam.
On Wed, Oct 16, 2019 at 08:51:46AM -0500, Adam Ford wrote:
> This patch adds documentation of device tree bindings for the WVGA panel
> Logic PD Type 28 display.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V5:  Replace GPIO_ACTIVE_HIGH with 0 to fix make dt_binding_check -k
> V4:  Update per Rob H's suggestions and copy other panel yaml example from 5.4-rc1
> V3:  Correct build errors from 'make dt_binding_check'
> V2:  Use YAML instead of TXT for binding
> 

Applied to drm-misc-next.
It was applied before the driver changes so we had bindings
for the driver changes when applied.

	Sam
