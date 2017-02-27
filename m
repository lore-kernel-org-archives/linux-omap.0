From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 2/3] can: ti_hecc: Add TI HECC DT binding documentation
Date: Mon, 27 Feb 2017 10:44:52 -0600
Message-ID: <20170227164452.3y3ilfxcb2s5ltnt@rob-hp-laptop>
References: <1487346753-19286-1-git-send-email-yegorslists@googlemail.com>
 <1487346753-19286-3-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1487346753-19286-3-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, andrej.skvortzov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Anton Glukhov <anton.a.glukhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 17, 2017 at 04:52:32PM +0100, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org wrote:
> From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> 
> DT binding documentation for TI High End CAN Controller
> 
> Signed-off-by: Anton Glukhov <anton.a.glukhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> ---
>  .../devicetree/bindings/net/can/ti_hecc.txt        | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/ti_hecc.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/can/ti_hecc.txt b/Documentation/devicetree/bindings/net/can/ti_hecc.txt
> new file mode 100644
> index 0000000..a7c601e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/ti_hecc.txt
> @@ -0,0 +1,33 @@
> +Texas Instruments High End CAN Controller (HECC)
> +================================================
> +
> +This file provides information, what the device node
> +for the hecc interface contains.
> +
> +Required properties:
> +- compatible: "ti,am3517-hecc"
> +- reg: addresses and lengths of the register spaces for 'hecc', 'hecc-ram'
> +       and 'mbx'
> +- reg-names :"hecc", "hecc-ram", "mbx"
> +- interrupts: interrupt mapping for the hecc interrupts sources
> +- clocks: clock phandles (see clock bindings for details)
> +
> +Optional properties:
> +- ti,use-hecc1int: if provided configures HECC to produce all interrupts
> +		   on HECC1INT interrupt line. By default HECC0INT interrupt
> +		   line will be used.
> +- xceiver-supply: regulator that powers the CAN transceiver
> +
> +Example:
> +
> +For am3517evm board:
> +	hecc: can@0x5c050000 {

Drop the '0x'.

> +		compatible = "ti,am3517-hecc";
> +		status = "disabled";

No need to put status in examples.

With that,

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> +		reg = <0x5c050000 0x80>,
> +		      <0x5c053000 0x180>,
> +		      <0x5c052000 0x200>;
> +		reg-names = "hecc", "hecc-ram", "mbx";
> +		interrupts = <24>;
> +		clocks = <&hecc_ck>;
> +	};
> -- 
> 2.1.4
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
