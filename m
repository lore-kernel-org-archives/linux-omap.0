From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 08/13] arm/dts: am33xx: Add dt data for usbss
Date: Thu, 30 Aug 2012 15:39:40 +0400
Message-ID: <503F50FC.5040200@mvista.com>
References: <1346323825-24385-1-git-send-email-ravibabu@ti.com> <1346323825-24385-9-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1346323825-24385-9-git-send-email-ravibabu-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 30-08-2012 14:50, Ravi Babu wrote:

> From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

> Added device tree data for usbss on am33xx. There are two musb controllers
> on am33xx platform so have port0_mode and port1_mode additional data.

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Santhapuri, Damodar <damodar.santhapuri-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
> ---
>   arch/arm/boot/dts/am33xx.dtsi |   11 +++++++++++
>   1 files changed, 11 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 59509c4..778b95e 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -154,5 +154,16 @@
>   			#size-cells = <0>;
>   			ti,hwmods = "i2c3";
>   		};
> +
> +		usb_otg_hs: usb_otg_hs {
> +			compatible = "ti,musb-am33xx";
> +			ti,hwmods = "usb_otg_hs";
> +			multipoint = <1>;
> +			num_eps = <16>;
> +			ram_bits = <12>;
> +			port0_mode = <3>;
> +			port1_mode = <3>;

    Hyphen is preferred traditionally to underscore in the device tree files...

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
