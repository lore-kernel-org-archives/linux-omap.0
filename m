From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH v8 6/6] ARM: dts: am335x-boneblack: Add HDMI audio
 support
Date: Sat, 19 Mar 2016 07:39:49 +0100
Message-ID: <20160319073949.b8bcd213e92355353368fad5@free.fr>
References: <cover.1458214526.git.jsarha@ti.com>
	<dd3484868647610840d4803dd3378014ce1c95b7.1458214526.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <dd3484868647610840d4803dd3378014ce1c95b7.1458214526.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 17 Mar 2016 14:22:34 +0200
Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org> wrote:

> @@ -76,16 +87,22 @@
>  };
> =20
>  &i2c0 {
> -	tda19988 {
> +	tda19988: tda19988 {
>  		compatible =3D "nxp,tda998x";
>  		reg =3D <0x70>;
> +
>  		pinctrl-names =3D "default", "off";
>  		pinctrl-0 =3D <&nxp_hdmi_bonelt_pins>;
>  		pinctrl-1 =3D <&nxp_hdmi_bonelt_off_pins>;
> =20
> -		port {
> -			hdmi_0: endpoint@0 {
> -				remote-endpoint =3D <&lcdc_0>;
> +		#sound-dai-cells =3D <0>;
> +		audio-ports =3D <	AFMT_I2S	0x03>;
> +
> +		ports {
> +			port@0 {
> +				hdmi_0: endpoint@0 {
> +					remote-endpoint =3D <&lcdc_0>;
> +				};
>  			};
>  		};
>  	};

Why did you add a 'ports' container? As there is only one port,
it is useless.

Also, you don't need '@0' in the 'port' and 'endpoint'.
If you want to keep it, you must add 'reg =3D 0;'s.

--=20
Ken ar c'henta=F1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
