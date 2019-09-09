From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/2] cpufreq: ti-cpufreq: Add support for AM3517
Date: Mon, 9 Sep 2019 20:13:03 +0200
Message-ID: <6081134F-AACD-412C-B36A-BF9463C9712B@goldelico.com>
References: <20190909154502.19804-1-aford173@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190909154502.19804-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: linux-omap@vger.kernel.org, neolynx@gmail.com, letux-kernel@openphoenux.org, andreas@kemnade.info, tony@atomide.com, adam.ford@logicpd.com, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Adam,

> Am 09.09.2019 um 17:45 schrieb Adam Ford <aford173@gmail.com>:
>=20
> The AM3517 only lists 600MHz @ 1.2V, but the revister values for

a small typo...

s/revister/register/

> 0x4830A204 =3D 1b86 802f, it seems like am3517 might be a derivative
> of the omap36 which has OPPs would be OPP50 (300 MHz) and OPP100
> (600 MHz).
>=20
> This patch simply enable adds the am3517 to the compatible table
> using the omap3630 structure instead of the 3430.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
>=20
> diff --git a/drivers/cpufreq/ti-cpufreq.c =
b/drivers/cpufreq/ti-cpufreq.c
> index f2f58d689320..6b69fb1d6bdf 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -270,6 +270,7 @@ static int ti_cpufreq_setup_syscon_register(struct =
ti_cpufreq_data *opp_data)
>=20
> static const struct of_device_id ti_cpufreq_of_match[] =3D {
> 	{ .compatible =3D "ti,am33xx", .data =3D &am3x_soc_data, },
> +	{ .compatible =3D "ti,am3517", .data =3D &omap36xx_soc_data, },
> 	{ .compatible =3D "ti,am43", .data =3D &am4x_soc_data, },
> 	{ .compatible =3D "ti,dra7", .data =3D &dra7_soc_data },
> 	{ .compatible =3D "ti,omap34xx", .data =3D &omap34xx_soc_data, =
},
> --=20
> 2.17.1
>=20

Looks good to me.

Should I include your two patches to my patch set (and resend)?
Or should we keep them separated?

BR and thanks,
Nikolaus
