From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V4 2/3] dt-bindings: Add Logic PD Type 28 display panel
Date: Wed, 9 Oct 2019 18:31:30 -0500
Message-ID: <20191009233130.GA1002@bogus>
References: <20191001233923.16514-1-aford173@gmail.com>
 <20191001233923.16514-5-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191001233923.16514-5-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, adam.ford@logicpd.com, Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 01, 2019 at 06:39:22PM -0500, Adam Ford wrote:
> This patch adds documentation of device tree bindings for the WVGA panel
> Logic PD Type 28 display.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V4:  Update per Rob H's suggestions and copy other panel yaml example from 5.4-rc1
> V3:  Correct build errors from 'make dt_binding_check'

The example still fails to build here.

> V2:  Use YAML instead of TXT for binding
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml b/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml
> new file mode 100644
> index 000000000000..e2c62e8f1db4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/logicpd,type28.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Logic PD Type 28 4.3" WQVGA TFT LCD panel
> +
> +maintainers:
> +  - Adam Ford <aford173@gmail.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: logicpd,type28
> +
> +  power-supply: true
> +  enable-gpios: true
> +  backlight: true
> +  port: true
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    lcd0: display {
> +      compatible = "logicpd,type28";
> +      enable-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;
> +      backlight = <&backlight>;
> +      port {
> +        lcd_in: endpoint {
> +          remote-endpoint = <&dpi_out>;
> +        };
> +      };
> +    };
> +
> +...
> -- 
> 2.17.1
> 
