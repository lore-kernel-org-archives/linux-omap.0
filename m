From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] clocksource: arm_global_timer: fix suspend resume
Date: Fri, 13 Nov 2015 10:43:39 -0600
Message-ID: <87a8qhq284.fsf@saruman.tx.rr.com>
References: <1447431951-23713-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447431951-23713-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@arm.linux.org.uk, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Grygorii Strashko <grygorii.strashko@ti.com> writes:
> Now the System stall is observed on TI AM437x based board
> (am437x-gp-evm) during resuming from System suspend when ARM Global
> timer is selected as clocksource device - SysRq are working, but
> nothing else. The reason of stall is that ARM Global timer loses its
> contexts.
>
> The reason of stall is that ARM Global timer loses its contexts during
> System suspend:
>    GT_CONTROL.TIMER_ENABLE =3D 0 (unbanked)
>    GT_COUNTERx =3D 0
>
> Hence, update ARM Global timer driver to reflect above behaviour
> - save GT_CONTROL.TIMER_ENABLE during suspend and restore on resume;
> - ensure clocksource and clockevent devices have coresponding flags
>   (CLOCK_SOURCE_SUSPEND_NONSTOP and CLOCK_EVT_FEAT_C3STOP) set
>   depending on presence of "always-on" DT property.
>
> CC: Arnd Bergmann <arnd@arndb.de>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/clocksource/arm_global_timer.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource=
/arm_global_timer.c
> index a2cb6fa..1bbaf64 100644
> --- a/drivers/clocksource/arm_global_timer.c
> +++ b/drivers/clocksource/arm_global_timer.c
> @@ -51,6 +51,8 @@ static void __iomem *gt_base;
>  static unsigned long gt_clk_rate;
>  static int gt_ppi;
>  static struct clock_event_device __percpu *gt_evt;
> +static bool gt_always_on;
> +static u32 gt_control;
>=20=20
>  /*
>   * To get the value from the Global Timer Counter register proceed as fo=
llows:
> @@ -168,6 +170,9 @@ static int gt_clockevents_init(struct clock_event_dev=
ice *clk)
>  {
>  	int cpu =3D smp_processor_id();
>=20=20
> +	if (!gt_always_on)
> +		clk->features |=3D CLOCK_EVT_FEAT_C3STOP;
> +
>  	clk->name =3D "arm_global_timer";
>  	clk->features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
>  		CLOCK_EVT_FEAT_PERCPU;
> @@ -195,12 +200,25 @@ static cycle_t gt_clocksource_read(struct clocksour=
ce *cs)
>  	return gt_counter_read();
>  }
>=20=20
> +static void gt_suspend(struct clocksource *cs)
> +{
> +	gt_control =3D readl(gt_base + GT_CONTROL);
> +}
> +
> +static void gt_resume(struct clocksource *cs)
> +{
> +	/* enables timer on all the cores */
> +	writel(gt_control & GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);

do you really need to save context if all you restore is TIMER_ENABLE
bit ? seems like you could skip gt_suspend altogether. Is there really a
situation where this driver is running and GT isn't enabled ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWRhM7AAoJEIaOsuA1yqREYMAP/As3r9Vlx2ZxjmsQ14Rfh/5P
ZdDbsJdFTR+QalJFumHSSgj5a+L3D+8XWVL50jI6iZgIamSisDSY13b6KX+YE1ef
rDTRf1kqG6cY8dJaHmO+kMzHarxVgXYKDGdsk65YTbCumq4UTN/gUh1hptYqrpMt
aRjsZFaI0TkiuMuOmytiKzcEJ9ipiwolKHJm0veGYccZ9cbH6z5izYhR+2vrAcu1
MRPYyjyzSg1QyDGx0Vuty9q7DzUrjKfwxSxBhwTlShwvR0uvD1H00eqjtH2HGWUF
yjjeehE47NpCImopAkYadj3rH6TCQjyNZ2LUHzL9+CWZOQjorzzZYaN/6hvg/Uqi
Rkgb6fiMQnAv1AVcVBGzCX2o+mJukGKoj3q/5fGHjC+vRjQRwJZ+xdbQfqrZztPl
b8gHdwXHiBzbSdZdFy0nDK5UEXcioWX0y1JwoCHFKWrWmoK0AJsY1JaerW1UREjE
cbxhC4tYitq92GOXfqEIfuFzx4ZUfEQFA5dtJ/YxOdgx+ZeWEVk2IjZwrP9kAqc0
4WI2o3lWGx0oRGIiQEUvwRIqSwOCOeoMyuDg9UY2p/e75E8ZBOzWM9LVN6fDbl8z
0eDRmiEhWP5B73Z8Lw2oKwBbHz7GGw2mQnqJCzQL+klGSh4v6Y/Xzfb75JupWvvZ
t4aPHJB2GUddruyWocrN
=gioG
-----END PGP SIGNATURE-----
--=-=-=--
