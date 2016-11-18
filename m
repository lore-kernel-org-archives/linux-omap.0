From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC 6/6] ARM: dts: am57xx-beagle-x15-common: enable etnaviv
Date: Thu, 17 Nov 2016 20:56:18 -0600
Message-ID: <e69a797c-bec3-2243-5c19-9d7633092369@ti.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
 <20161118024436.13447-6-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161118024436.13447-6-robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Julien <jboulnois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 11/17/2016 08:44 PM, Robert Nelson wrote:
again.. a short commit message at least please? :)

> Signed-off-by: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: Julien <jboulnois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> CC: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> CC: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
> index 6df7829..3bc47be 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
> @@ -97,6 +97,12 @@
>  		#cooling-cells = <2>;
>  	};
>
> +	gpu-subsystem {
A) do we want to make things clear that this is gpu subsystem for gc320?
B) How about other platforms that could equally reuse?

> +		compatible = "ti,gc320-gpu-subsystem";
> +		cores = <&bb2d>;
> +		status = "okay";
> +	};
> +
>  	hdmi0: connector {
>  		compatible = "hdmi-connector";
>  		label = "hdmi";
> @@ -190,6 +196,11 @@
>  		>;
>  	};
>  };
> +
> +&bb2d {
> +	status = "okay";
> +};
> +
>  &i2c1 {
>  	status = "okay";
>  	clock-frequency = <400000>;
>


-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
