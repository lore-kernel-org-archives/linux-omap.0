From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 5/7] phy: omap-usb2: Add clock names to Documentation
 binding
Date: Mon, 28 Apr 2014 21:23:35 +0400
Message-ID: <535E8E97.7040809@cogentembedded.com>
References: <1398693687-13967-1-git-send-email-rogerq@ti.com> <1398693687-13967-6-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398693687-13967-6-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: george.cherian-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 04/28/2014 06:01 PM, Roger Quadros wrote:

> Add "wkupclk" and "refclk" information to DT binding information.

> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>   Documentation/devicetree/bindings/phy/ti-phy.txt | 7 +++++++
>   1 file changed, 7 insertions(+)

> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
> index 788fb0f..9ce458f 100644
> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
> @@ -32,6 +32,11 @@ Required properties:
>    - reg : Address and length of the register set for the device.
>    - #phy-cells: determine the number of cells that should be given in the
>      phandle while referencing this phy.
> + - clocks: a list of phandles and clock-specifier pairs, one for each entry in
> +   clock-names.

    I thought clock specifier includes phandle. Anyway, this description 
doesn't seem to match your example...

> + - clock-names: should include:
> +   * "wkupclk" - wakeup clock.
> +   * "refclk" - reference clock (optional).
>
>   Optional properties:
>    - ctrl-module : phandle of the control module used by PHY driver to power on
> @@ -44,6 +49,8 @@ usb2phy@4a0ad080 {
>   	reg = <0x4a0ad080 0x58>;
>   	ctrl-module = <&omap_control_usb>;
>   	#phy-cells = <0>;
> +	clocks = <&usb_phy_cm_clk32k>, <&usb_otg_ss_refclk960m>;
> +	clock-names = "wkupclk", "refclk";
>   };

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
