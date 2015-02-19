From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/3] ARM: dts: omap3-pandora: add common device tree
Date: Fri, 20 Feb 2015 00:47:39 +0200
Message-ID: <CANOLnOO9xPtaPTXxdZhh3KwU1Ai0XqTDOCkXgiJ7eg6bYKnDBw@mail.gmail.com>
References: <1424202743-26387-1-git-send-email-marek@goldelico.com>
	<1424202743-26387-2-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1424202743-26387-2-git-send-email-marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, "Dr. H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 17, 2015 at 9:52 PM, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wr=
ote:
> From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>
> This device tree allows to boot, supports the panel,
> framebuffer, touch screen, as well as some more peripherals.
> Since there is a OMAP3530 based 600 MHz variant and a DM3730 based
> 1 GHz variant we must include this common device tree code
> in one of two CPU specific device trees.
>
> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> Signed-off-by: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---
>  arch/arm/boot/dts/omap3-pandora-common.dtsi | 640 ++++++++++++++++++=
++++++++++
>  1 file changed, 640 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap3-pandora-common.dtsi
>
> diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/b=
oot/dts/omap3-pandora-common.dtsi
> new file mode 100644
> index 0000000..78ef1ee
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
> ...
> +
> +       penirq_pins: pinmux_penirq_pins {
> +               pinctrl-single,pins =3D <
> +                       /* here we could enable to wakeup the cpu fro=
m suspend by a pen touch */
> +                       OMAP3_CORE1_IOPAD(0x210c, MUX_MODE4)    /* GP=
IO_94 */

We need PIN_INPUT here, otherwise the touchscreen doesn't react to pen =
down.
(Sorry missed it last time).


Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
