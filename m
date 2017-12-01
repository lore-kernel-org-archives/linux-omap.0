From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/4] omapdrm: panel: fix compatible vendor string for
 td028ttec1
Date: Thu, 30 Nov 2017 19:57:30 -0600
Message-ID: <20171201015730.nvw6sblxn566dhhb@rob-hp-laptop>
References: <cover.1511884135.git.hns@goldelico.com>
 <6ae8f4b7d794c536650cc99025e5b026089cea30.1511884135.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6ae8f4b7d794c536650cc99025e5b026089cea30.1511884135.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 28, 2017 at 04:48:54PM +0100, H. Nikolaus Schaller wrote:
> The vendor name was "toppoly" but other panels and the vendor list
> have defined it as "tpo". So let's fix it in driver and bindings.
> 
> We keep the old definition in parallel to stay compatible with
> potential older DTB setup.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt}      | 4 ++--
>  drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c               | 3 +++
>  drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c      | 3 +++
>  3 files changed, 8 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt} (84%)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
> similarity index 84%
> rename from Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
> rename to Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
> index 7175dc3740ac..ed34253d9fb1 100644
> --- a/Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
> +++ b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
> @@ -2,7 +2,7 @@ Toppoly TD028TTEC1 Panel
>  ========================
>  
>  Required properties:
> -- compatible: "toppoly,td028ttec1"
> +- compatible: "tpo,td028ttec1"
>  
>  Optional properties:
>  - label: a symbolic name for the panel
> @@ -14,7 +14,7 @@ Example
>  -------
>  
>  lcd-panel: td028ttec1@0 {
> -	compatible = "toppoly,td028ttec1";
> +	compatible = "tpo,td028ttec1";
>  	reg = <0>;
>  	spi-max-frequency = <100000>;
>  	spi-cpol;
> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
> index 0a38a0e8c925..a0dfa14f4fab 100644
> --- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
> +++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
> @@ -452,6 +452,8 @@ static int td028ttec1_panel_remove(struct spi_device *spi)
>  }
>  
>  static const struct of_device_id td028ttec1_of_match[] = {
> +	{ .compatible = "omapdss,tpo,td028ttec1", },

Why the omapdss part?
