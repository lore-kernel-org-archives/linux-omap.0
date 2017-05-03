From: Ravikumar <rk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/1] ARM: dts: dra7: Reduce cpu thermal shutdown
 temperature
Date: Wed, 3 May 2017 19:27:40 +0530
Message-ID: <e96e275d-1ba0-c904-e469-d86c6e687912@ti.com>
References: <20170412062442.17736-1-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170412062442.17736-1-rk-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org" <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wednesday 12 April 2017 11:54 AM, Kattekola, Ravikumar wrote:
> On dra7, as per TRM, the HW shutdown (TSHUT) temperature is hardcoded
> to 123C and cannot be modified by SW. This means when the temperature
> reaches 123C HW asserts TSHUT output which signals a warm reset.
> This reset is held until the temperature goes below the TSHUT low (105C).
>
> While in SW, the thermal driver continuously monitors current temperature
> and takes decisions based on whether it reached an alert or a critical point.
> The intention of setting a SW critical point is to prevent force reset by HW
> and instead do an orderly_poweroff(). But if the SW critical temperature is
> greater than or equal to that of HW then it defeats the purpose. To address
> this and let SW take action before HW does keep the SW critical temperature
> less than HW TSHUT value.
>
> The value for SW critical temperature was chosen as 120C just to ensure
> we give SW sometime before HW catches up.
>
> Document reference
> SPRUI30C – DRA75x, DRA74x Technical Reference Manual - November 2016
> SPRUHZ6H - AM572x Technical Reference Manual - November 2016
>
> Tested on:
> DRA75x PG 2.0 Rev H EVM
>
> Signed-off-by: Ravikumar Kattekola <rk-l0cyMroinI0@public.gmane.org>
> ---
>   arch/arm/boot/dts/dra7.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 57892f2..e714466 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -2017,4 +2017,8 @@
>   	coefficients = <0 2000>;
>   };
>   
> +&cpu_crit {
> +	temperature = <120000>; /* milli Celsius */
> +};
> +
>   /include/ "dra7xx-clocks.dtsi"
Ping..
Any comments?

Regards,
RK
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
