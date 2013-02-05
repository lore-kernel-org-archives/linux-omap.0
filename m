From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 10/13] ARM: dts: OMAP4: Add HS USB Host IP nodes
Date: Tue, 5 Feb 2013 11:54:56 +0530
Message-ID: <5110A5B8.3030803@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-11-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1359993540-20780-11-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Monday 04 February 2013 09:28 PM, Roger Quadros wrote:
> Adds device nodes for HS USB Host module, TLL module,
> OHCI and EHCI controllers.
>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>   arch/arm/boot/dts/omap4.dtsi |   30 ++++++++++++++++++++++++++++++
>   1 files changed, 30 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 739bb79..3429280 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -529,5 +529,35 @@
>   			ti,hwmods = "timer11";
>   			ti,timer-pwm;
>   		};
> +
> +		usbhstll: usbhstll@0x4a062000 {
> +			compatible = "ti,usbhs-tll";
> +			reg = <0x4a062000 0x1000>;
> +			interrupts = <0 78 0x4>;
> +			ti,hwmods = "usb_tll_hs";
> +		};
> +
> +		usbhshost: usbhshost@0x4a064000 {
> +			compatible = "ti,usbhs-host";
> +			reg = <0x4a064000 0x800>;
> +			ti,hwmods = "usb_host_hs";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			usbhsohci: ohci@0x4a064800 {
> +				compatible = "ti,omap3-ohci", "usb-ohci";
> +				reg = <0x4a064800 0x400>;
> +				interrupt-parent = <&gic>;

Just curious.. Were you facing issues if you are not having 
interrupt-parent here? It's also missing in your dt node usbhstll.

Thanks
Kishon
