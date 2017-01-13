From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/3] can: ti_hecc: Add TI HECC DT binding documentation
Date: Fri, 13 Jan 2017 13:56:33 -0600
Message-ID: <20170113195633.7igh7fdlcsw5ov6g@rob-hp-laptop>
References: <1484143521-4898-1-git-send-email-yegorslists@googlemail.com>
 <1484143521-4898-3-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1484143521-4898-3-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org, andrej.skvortzov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, Anton Glukhov <anton.a.glukhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 11, 2017 at 03:05:20PM +0100, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org wrote:
> From: Anton Glukhov <anton.a.glukhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> DT binding documentation for TI High End CAN Controller
> 
> Signed-off-by: Anton Glukhov <anton.a.glukhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> ---
> Changes v1 -> v2:
> 	change compatible to "ti,am3505"
> 
>  .../devicetree/bindings/net/can/ti_hecc.txt        | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/ti_hecc.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/can/ti_hecc.txt b/Documentation/devicetree/bindings/net/can/ti_hecc.txt
> new file mode 100644
> index 0000000..ce015cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/ti_hecc.txt
> @@ -0,0 +1,31 @@
> +* Texas Instruments High End CAN Controller (HECC)
> +
> +This file provides information, what the device node
> +for the hecc interface contains.
> +
> +Required properties:
> +- compatible: "ti,am3505"
> +- reg: offset and length of the register set for the device
> +- interrupts: interrupt mapping for the hecc interrupts sources
> +- clocks: clock phandles (see clock bindings for details)

> +- ti,scc-ram-offset: offset to scc module ram
> +- ti,hecc-ram-offset: offset to hecc module ram
> +- ti,mbx-offset: offset to mailbox ram

Is there not a common case that would be the default?

> +
> +Optional properties:
> +- ti,int-line: interrupt line

Needs a better description. What are valid values? This is some internal 
setting about which pin to route the interrupt output to I'm guessing.

> +
> +Example:
> +
> +For am3517evm board:
> +	hecc: can@0x5c050000 {
> +		compatible = "ti,am3505";
> +		status = "disabled";
> +		reg = <0x5c050000 0x4000>;
> +		interrupts = <24>;
> +		clocks = <&hecc_ck>;
> +		ti,scc-ram-offset = <0x3000>;
> +		ti,hecc-ram-offset = <0x3000>;
> +		ti,mbx-offset = <0x2000>;
> +		ti,int-line = <0>;
> +	};
> -- 
> 2.1.4
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
