From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: dra7: Fix efuse register size for ABB
Date: Mon, 4 May 2015 09:26:09 -0700
Message-ID: <20150504162609.GN24469@atomide.com>
References: <1429221394-18896-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429221394-18896-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Gessner <Matt.Gessner-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [150416 14:57]:
> Fix a typo in DRA7 dtsi where 12 bytes are needed for register
> description of ABB efuse registers, however only 8 bytes are provided
> to map. For some weird reason, this does not generate abort at offset
> 0x8, probably due to default maps already provided in io.c for the bus
> register ranges.
> 
> Reported-by: Matt Gessner <Matt.Gessner-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
> Reported-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

Applying into omap-for-v4.1/fixes thanks.

Tony

> ---
>  arch/arm/boot/dts/dra7.dtsi |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 5332b57b4950..92b8bb873f43 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -911,7 +911,7 @@
>  			ti,clock-cycles = <16>;
>  
>  			reg = <0x4ae07ddc 0x4>, <0x4ae07de0 0x4>,
> -			      <0x4ae06014 0x4>, <0x4a003b20 0x8>,
> +			      <0x4ae06014 0x4>, <0x4a003b20 0xc>,
>  			      <0x4ae0c158 0x4>;
>  			reg-names = "setup-address", "control-address",
>  				    "int-address", "efuse-address",
> @@ -944,7 +944,7 @@
>  			ti,clock-cycles = <16>;
>  
>  			reg = <0x4ae07e34 0x4>, <0x4ae07e24 0x4>,
> -			      <0x4ae06010 0x4>, <0x4a0025cc 0x8>,
> +			      <0x4ae06010 0x4>, <0x4a0025cc 0xc>,
>  			      <0x4a002470 0x4>;
>  			reg-names = "setup-address", "control-address",
>  				    "int-address", "efuse-address",
> @@ -977,7 +977,7 @@
>  			ti,clock-cycles = <16>;
>  
>  			reg = <0x4ae07e30 0x4>, <0x4ae07e20 0x4>,
> -			      <0x4ae06010 0x4>, <0x4a0025e0 0x8>,
> +			      <0x4ae06010 0x4>, <0x4a0025e0 0xc>,
>  			      <0x4a00246c 0x4>;
>  			reg-names = "setup-address", "control-address",
>  				    "int-address", "efuse-address",
> @@ -1010,7 +1010,7 @@
>  			ti,clock-cycles = <16>;
>  
>  			reg = <0x4ae07de4 0x4>, <0x4ae07de8 0x4>,
> -			      <0x4ae06010 0x4>, <0x4a003b08 0x8>,
> +			      <0x4ae06010 0x4>, <0x4a003b08 0xc>,
>  			      <0x4ae0c154 0x4>;
>  			reg-names = "setup-address", "control-address",
>  				    "int-address", "efuse-address",
> -- 
> 1.7.9.5
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
