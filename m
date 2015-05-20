From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap3-gta04: Add GSM audio support
Date: Wed, 20 May 2015 10:58:22 -0700
Message-ID: <20150520175822.GG10274@atomide.com>
References: <1431027305-17627-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431027305-17627-1-git-send-email-marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [150507 12:36]:
> Add voice audio card which is used for telephony on gta04 board.
> gtm601 codec is UMTS modem with pcm interface which get samples from
> microphone and provide data from other party side. Use simple audio card
> to describe audio card.
> 
> Signed-off-by: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>

Applying into omap-for-v4.2/dt thanks.

Tony

> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index b9f6881..a3a4156 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -48,6 +48,28 @@
>  		ti,mcbsp = <&mcbsp2>;
>  	};
>  
> +	 /* GSM audio */
> +	sound_telephony {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "GTA04 voice";
> +		simple-audio-card,bitclock-master = <&telephony_link_master>;
> +		simple-audio-card,frame-master = <&telephony_link_master>;
> +		simple-audio-card,format = "i2s";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&mcbsp4>;
> +		};
> +
> +		telephony_link_master: simple-audio-card,codec {
> +			sound-dai = <&gtm601_codec>;
> +		};
> +	};
> +
> +	gtm601_codec: gsm_codec {
> +		compatible = "option,gtm601";
> +		#sound-dai-cells = <0>;
> +	};
> +
>  	spi_lcd {
>  		compatible = "spi-gpio";
>  		#address-cells = <0x1>;
> @@ -517,3 +539,7 @@
>  &mcbsp2 {
>  	status = "okay";
>  };
> +
> +&mcbsp4 {
> +	status = "okay";
> +};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
