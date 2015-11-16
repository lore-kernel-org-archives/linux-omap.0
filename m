From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 8/8] DT:omap3+ads7846: use new common touchscreen bindings
Date: Mon, 16 Nov 2015 16:37:12 +0200
Message-ID: <CANOLnOO=J=se7K7GnJZPrkXJpm-_+vshsRUCeWo1GVsum8jyeg@mail.gmail.com>
References: <cover.1447446957.git.hns@goldelico.com>
	<df5bd5fdcc2284a7d8e2d5132bc865701a8ca38f.1447446957.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <df5bd5fdcc2284a7d8e2d5132bc865701a8ca38f.1447446957.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Andrey Gelman <andrey.gelman-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, linux-i
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Nov 13, 2015 at 10:35 PM, H. Nikolaus Schaller
<hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
> The standard touch screen bindings [1] replace the private ti,swap-xy
> with touchscreen-swaped-x-y. And for the Openpandora we use
> touchscreen-size etc. to match the LCD screen size.
>
> [1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.=
txt
>
> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---
>  arch/arm/boot/dts/omap3-lilly-a83x.dtsi              |  2 +-
>  arch/arm/boot/dts/omap3-pandora-common.dtsi          | 17 ++++++++++=
+++----
>  arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi |  2 +-
>  3 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/=
dts/omap3-lilly-a83x.dtsi
> index d0dd036..01dae66 100644
> --- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
> +++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
> @@ -325,7 +325,7 @@
>                 ti,y-max =3D /bits/ 16 <3600>;
>                 ti,x-plate-ohms =3D /bits/ 16 <80>;
>                 ti,pressure-max =3D /bits/ 16 <255>;
> -               ti,swap-xy;
> +               touchscreen-swapped-x-y;
>
>                 linux,wakeup;
>         };
> diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/b=
oot/dts/omap3-pandora-common.dtsi
> index f672a04..9497cc6 100644
> --- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
> +++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
> @@ -696,10 +696,19 @@
>                 pendown-gpio =3D <&gpio3 30 0>;
>                 vcc-supply =3D <&vaux4>;
>
> -               ti,x-min =3D /bits/ 16 <0>;
> -               ti,x-max =3D /bits/ 16 <8000>;
> -               ti,y-min =3D /bits/ 16 <0>;
> -               ti,y-max =3D /bits/ 16 <4800>;
> +               touchscreen-size-x =3D <800>;
> +               touchscreen-size-y =3D <480>;
> +               touchscreen-max-pressure =3D <1000>;
> +               touchscreen-fuzz-x =3D <16>;
> +               touchscreen-fuzz-y =3D <16>;
> +               touchscreen-fuzz-pressure =3D <10>;
> +               touchscreen-inverted-x;
> +               touchscreen-inverted-y;
> +
> +               ti,x-min =3D /bits/ 16 <160>;
> +               ti,x-max =3D /bits/ 16 <3900>;
> +               ti,y-min =3D /bits/ 16 <220>;
> +               ti,y-max =3D /bits/ 16 <3750>;

I'm not sure this is a good idea, there have been at least 3 different
batches of LCDs which slightly different touchscreens attached, with
such thresholds we might end up with unreachable touchscreen points on
some units. If I understand right, calibration won't help if for some
screen locations ADC reading goes below/above these min/max thresholds
on some specific units? If so there should probably be at least 10%
margin in either case to make calibration useful.

Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
