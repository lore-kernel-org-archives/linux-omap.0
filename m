From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] arm: dts: Enable beaglebone cape-manager
Date: Thu, 14 May 2015 08:39:58 -0700
Message-ID: <20150514153957.GK15563@atomide.com>
References: <1431504292-32132-1-git-send-email-pantelis.antoniou@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431504292-32132-1-git-send-email-pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org> [150513 01:06]:
> Enable the cape manager on the beaglebone family of boards.

I don't think we have the "ti,bone-capemgr" binding in use yet
in Linux next?

An ack from the DT people would be good to have here for the
binding.

Regards,

Tony
 
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 42 +++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index 236b7db..28d9764 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -375,3 +375,45 @@
>  &sham {
>  	status = "okay";
>  };
> +
> +/* the cape manager */
> +/ {
> +	bone_capemgr {
> +		compatible = "ti,bone-capemgr";
> +		status = "okay";
> +
> +		eeprom = <&baseboard_data>;
> +
> +		/* map board revisions to compatible definitions */
> +		baseboardmaps {
> +			baseboard_beaglebone: board@0 {
> +				board-name = "A335BONE";
> +				compatible-name = "ti,beaglebone";
> +			};
> +
> +			baseboard_beaglebone_black: board@1 {
> +				board-name = "A335BNLT";
> +				compatible-name = "ti,beaglebone-black";
> +			};
> +		};
> +
> +		/* only 4 slots defined */
> +		slots {
> +			slot@0 {
> +				eeprom = <&cape0_data>;
> +			};
> +
> +			slot@1 {
> +				eeprom = <&cape1_data>;
> +			};
> +
> +			slot@2 {
> +				eeprom = <&cape2_data>;
> +			};
> +
> +			slot@3 {
> +				eeprom = <&cape3_data>;
> +			};
> +		};
> +	};
> +};
> -- 
> 1.7.12
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
