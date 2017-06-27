From: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] arm: dts: omap3: Remove interrupt-parent property
Date: Tue, 27 Jun 2017 11:16:35 +0530
Message-ID: <41ab5d17-620e-34b6-bd1c-33ae7bb3234c@techveda.org>
References: <1498541590-4550-1-git-send-email-karthik@techveda.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498541590-4550-1-git-send-email-karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 27 June 2017 11:03 AM, karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org wrote:
> From: Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
> 
Please change the subject of the patch to something which is more meaningful and 
which reflect the changes done to the code base.
> All nodes inhert "interrupt-parent" property from root
> node. So removed that property from usbhsohci, usbhsehci,
> ssi_port1, ssi_port2 nodes.
Adjust description accordingly.
> 
> Signed-off-by: Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
> ---
>  arch/arm/boot/dts/omap3.dtsi | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index a3ff493..bdaf30c 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -713,14 +713,12 @@
>  			usbhsohci: ohci@48064400 {
>  				compatible = "ti,ohci-omap3";
>  				reg = <0x48064400 0x400>;
> -				interrupt-parent = <&intc>;
>  				interrupts = <76>;
>  			};
>  
>  			usbhsehci: ehci@48064800 {
>  				compatible = "ti,ehci-omap";
>  				reg = <0x48064800 0x400>;
> -				interrupt-parent = <&intc>;
>  				interrupts = <77>;
>  			};
>  		};
> @@ -831,7 +829,6 @@
>  				reg-names = "tx",
>  					    "rx";
>  
> -				interrupt-parent = <&intc>;
>  				interrupts = <67>,
>  					     <68>;
>  			};
> @@ -844,7 +841,6 @@
>  				reg-names = "tx",
>  					    "rx";
>  
> -				interrupt-parent = <&intc>;
>  				interrupts = <69>,
>  					     <70>;
>  			};
> 

Thanks
Suniel
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
