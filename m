From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am57xx-beagle-x15: Update Phy supplies
Date: Wed, 16 Sep 2015 10:11:12 -0500
Message-ID: <55F98690.6070601@ti.com>
References: <1441308226-26690-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441308226-26690-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 09/03/2015 02:23 PM, Nishanth Menon wrote:
> Originally, all the SoC PHY rails were supplied by LDO3. However, as a
> result of characterization, it was determined that this posed a risk in
> extreme load  conditions. Hence the PHY rails are split between two
> different LDOs. Update the related node as a result
> 
> LDO3/VDDA_1V8_PHYA supplies vdda_usb1, vdda_usb2, vdda_sata, vdda_usb3
> LDO4/VDDA_1V8_PHYB supplies vdda_pcie1, vdda_pcie0, vdda_hdmi, vdda_pcie
> 
> NOTE: We break compatibility with pre-production boards with this change
> since, the PMIC LDO4 is disabled at OTP level.
> 
> The new configuration is the plan of record and all pre-production
> boards are supposed to be replaced with the latest boards matching the
> mentioned configuration.
> 
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> ---

Gentle ping. Some very few 10 something boards have been created and
stopped production till the latest modifications were done (PMIC USB
interrupt, LDO4 etc) - and all of those boards are now getting
scrapped.. If there are any (as per tracking information, there should
not be any), TI should be contacted to have them replaced.

Is it possible for us to consider this patch in 4.3 cycle - given that
we are this close, might have been great to see 4.3 vanilla function on
the production platform.

>  arch/arm/boot/dts/am57xx-beagle-x15.dts |   13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> index 3a05b94f59ed..ede7fb73c717 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -432,7 +432,7 @@
>  				};
>  
>  				ldo3_reg: ldo3 {
> -					/* VDDA_1V8_PHY */
> +					/* VDDA_1V8_PHYA */
>  					regulator-name = "ldo3";
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <1800000>;
> @@ -440,6 +440,15 @@
>  					regulator-boot-on;
>  				};
>  
> +				ldo4_reg: ldo4 {
> +					/* VDDA_1V8_PHYB */
> +					regulator-name = "ldo4";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
>  				ldo9_reg: ldo9 {
>  					/* VDD_RTC */
>  					regulator-name = "ldo9";
> @@ -681,7 +690,7 @@
>  
>  &hdmi {
>  	status = "ok";
> -	vdda-supply = <&ldo3_reg>;
> +	vdda-supply = <&ldo4_reg>;
>  
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&hdmi_pins>;
> 


-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
