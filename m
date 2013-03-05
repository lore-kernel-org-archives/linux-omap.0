From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 7/8] ARM: dts: omap5: add dwc3 omap dt data
Date: Tue, 05 Mar 2013 18:41:58 +0400
Message-ID: <51360436.6050409@cogentembedded.com>
References: <1362494223-14151-1-git-send-email-kishon@ti.com> <1362494223-14151-8-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1362494223-14151-8-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, balbi@ti.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 05-03-2013 18:37, Kishon Vijay Abraham I wrote:

> Add dwc3 omap glue data to the omap5 dt data file. The information about
> the dt node added here is available @
> Documentation/devicetree/bindings/usb/omap-usb.txt

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   arch/arm/boot/dts/omap5.dtsi |   11 +++++++++++
>   1 file changed, 11 insertions(+)

> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index bd73257..c4eb2ec 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -505,6 +505,17 @@
>   			ti,type = <2>;
>   		};
>
> +		omap_dwc3@4a020000 {
> +			compatible = "ti,dwc3";
> +			ti,hwmods = "usb_otg_ss";
> +			reg = <0x4a020000 0x1000>;
> +			interrupts = <0 93 4>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;

   Why the above two props? You don't seem to have the subnodes...

WBR, Sergei

