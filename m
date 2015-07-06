From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] thermal: consistently use int for temperatures
Date: Mon, 6 Jul 2015 10:34:48 +0200
Message-ID: <CAMuHMdV0rHrNMt1kUg0CwoJ0etQ7sK0jF_My1qLRJLz0z958rA@mail.gmail.com>
References: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean Delvare <jdelvare@suse.de>, Peter Feuerer <peter@piie.net>, Heiko Stuebner <heiko@sntech.de>, Lukasz Majewski <l.majewski@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, Darren Hart <dvhart@infradead.org>, lm-sen
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 6, 2015 at 9:19 AM, Sascha Hauer <s.hauer@pengutronix.de> w=
rote:
> The thermal code uses int, long and unsigned long for temperatures
> in different places.
>
> Using an unsigned type limits the thermal framework to positive
> temperatures without need. Also several drivers currently will report
> temperatures near UINT_MAX for temperatures below 0=C2=B0C. This will=
 probably
> immediately shut the machine down due to overtemperature if started b=
elow
> 0=C2=B0C.
>
> 'long' is 64bit on several architectures. This is not needed since IN=
T_MAX =C2=B0mC
> is above the melting point of all known materials.
>
> Consistently use a plain 'int' for temperatures throughout the therma=
l code and
> the drivers. This only changes the places in the drivers where the te=
mperature
> is passed around as pointer, when drivers internally use another type=
 this is
> not changed.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Peter Feuerer <peter@piie.net>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: platform-driver-x86@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: lm-sensors@lm-sensors.org

=46or rcar-thermal:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_th=
ermal.c
> index fe4e767..5d4ae7d 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -200,8 +200,7 @@ err_out_unlock:
>         return ret;
>  }
>
> -static int rcar_thermal_get_temp(struct thermal_zone_device *zone,
> -                                unsigned long *temp)
> +static int rcar_thermal_get_temp(struct thermal_zone_device *zone, i=
nt *temp)
>  {
>         struct rcar_thermal_priv *priv =3D rcar_zone_to_priv(zone);
>
> @@ -235,7 +234,7 @@ static int rcar_thermal_get_trip_type(struct ther=
mal_zone_device *zone,
>  }
>
>  static int rcar_thermal_get_trip_temp(struct thermal_zone_device *zo=
ne,
> -                                     int trip, unsigned long *temp)
> +                                     int trip, int *temp)
>  {
>         struct rcar_thermal_priv *priv =3D rcar_zone_to_priv(zone);
>         struct device *dev =3D rcar_priv_to_dev(priv);
> @@ -299,7 +298,7 @@ static void _rcar_thermal_irq_ctrl(struct rcar_th=
ermal_priv *priv, int enable)
>  static void rcar_thermal_work(struct work_struct *work)
>  {
>         struct rcar_thermal_priv *priv;
> -       unsigned long cctemp, nctemp;
> +       int cctemp, nctemp;
>
>         priv =3D container_of(work, struct rcar_thermal_priv, work.wo=
rk);
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
