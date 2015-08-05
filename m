From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 09/10] ARM: dts: omap4: Use "syscon-phy-power" instead
 of "ctrl-module" in USB PHY node
Date: Wed, 5 Aug 2015 11:01:22 +0300
Message-ID: <55C1C2D2.1080200@ti.com>
References: <1438702233-8027-1-git-send-email-kishon@ti.com> <1438702233-8027-10-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438702233-8027-10-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/08/15 18:30, Kishon Vijay Abraham I wrote:
> Add "syscon-phy-power" property and remove the deprecated "ctrl-module"
> property from USB PHY dt node.
> 
> Since "omap_control_usb2phy" devicetree node is no longer used,
> remove it.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>

Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

cheers,
-roger

> ---
>  arch/arm/boot/dts/omap4.dtsi |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 7d31c6f..b27634d 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -703,7 +703,7 @@
>  			usb2_phy: usb2phy@4a0ad080 {
>  				compatible = "ti,omap-usb2";
>  				reg = <0x4a0ad080 0x58>;
> -				ctrl-module = <&omap_control_usb2phy>;
> +				syscon-phy-power = <&scm_conf 0x300>;
>  				clocks = <&usb_phy_cm_clk32k>;
>  				clock-names = "wkupclk";
>  				#phy-cells = <0>;
> @@ -854,12 +854,6 @@
>  			};
>  		};
>  
> -		omap_control_usb2phy: control-phy@4a002300 {
> -			compatible = "ti,control-phy-usb2";
> -			reg = <0x4a002300 0x4>;
> -			reg-names = "power";
> -		};
> -
>  		omap_control_usbotg: control-phy@4a00233c {
>  			compatible = "ti,control-phy-otghs";
>  			reg = <0x4a00233c 0x4>;
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
