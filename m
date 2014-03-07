From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 4/5] ARM: dts: am437x-gp-evm: Enable USB
Date: Fri, 7 Mar 2014 12:25:12 +0200
Message-ID: <53199E88.8000800@ti.com>
References: <1394183758-3821-1-git-send-email-george.cherian@ti.com> <1394183758-3821-5-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394183758-3821-5-git-send-email-george.cherian-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, anatol.pomozov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi George,

On 03/07/2014 11:15 AM, George Cherian wrote:
> Enable
> 	- ocp2scp
> 	- USB PHY control module
> 	- USB PHY
> 	- dwc3_omap
> 	- USB
> for am437x-gp-evm
> 
> Signed-off-by: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/am437x-gp-evm.dts | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
> index 4eb72b8..1d516a7 100644
> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
> @@ -98,3 +98,31 @@
>  &gpio4 {
>  	status = "okay";
>  };
> +
> +
> +&usb2_phy1 {
> +	status = "okay";
> +};
> +
> +&dwc3_1 {
> +	status = "okay";
> +};

Do you need to explicitly enable dwc3_1 nand dwc3_2?

> +
> +&usb1 {
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> +
> +
> +&usb2_phy2 {
> +	status = "okay";
> +};
> +
> +&dwc3_2 {
> +	status = "okay";
> +};
> +
> +&usb2 {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> 

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
