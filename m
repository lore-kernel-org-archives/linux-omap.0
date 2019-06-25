From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v3 3/5] dt-bindings: drm/panel: simple: add ortustech,
 com37h3m05dtc panel
Date: Tue, 25 Jun 2019 22:26:11 +0200
Message-ID: <20190625202611.GA18595@ravnborg.org>
References: <cover.1559905870.git.hns@goldelico.com>
 <a650cb8df1bdf58ec3c8a182532692db16b77f70.1559905870.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a650cb8df1bdf58ec3c8a182532692db16b77f70.1559905870.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, tomi.valkeinen@ti.com, imirkin@alum.mit.edu, marek.belisko@gmail.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 07, 2019 at 01:11:09PM +0200, H. Nikolaus Schaller wrote:
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

We need OK from one of the DT people before we can apply this.

	Sam

> ---
>  .../display/panel/ortustech,com37h3m05dtc.txt        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ortustech,com37h3m05dtc.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/ortustech,com37h3m05dtc.txt b/Documentation/devicetree/bindings/display/panel/ortustech,com37h3m05dtc.txt
> new file mode 100644
> index 000000000000..c16907c02f80
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/ortustech,com37h3m05dtc.txt
> @@ -0,0 +1,12 @@
> +OrtusTech COM37H3M05DTC Blanview 3.7" VGA portrait TFT-LCD panel
> +
> +Required properties:
> +- compatible: should be "ortustech,com37h3m05dtc"
> +
> +Optional properties:
> +- enable-gpios: GPIO pin to enable or disable the panel
> +- backlight: phandle of the backlight device attached to the panel
> +- power-supply: phandle of the regulator that provides the supply voltage
> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.
> -- 
> 2.19.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
