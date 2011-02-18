From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC/PATCH] OMAP: Fix section mismatch
Date: Fri, 18 Feb 2011 14:59:41 +0100
Message-ID: <20110218135941.GB22310@pengutronix.de>
References: <1298034953-21016-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1298034953-21016-1-git-send-email-weber@corscience.de>
Sender: cpufreq-owner@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "open list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, cpufreq@vger.kernel.org, Dave Jones <davej@redhat.com>
List-Id: linux-omap@vger.kernel.org

Hello,

[added cpufreq@vger.kernel.org and Dave to Cc:]

On Fri, Feb 18, 2011 at 02:15:53PM +0100, Thomas Weber wrote:
> When compiling linux-omap with 'make CONFIG_DEBUG_SECTION_MISMATCH=3D=
y'
> the following output occurs:
>=20
> WARNING: arch/arm/plat-omap/built-in.o(.data+0x6e8): Section mismatch=
 in
> reference from the variable omap_driver to the function
> .init.text:omap_cpu_init()
> The variable omap_driver references
> the function __init omap_cpu_init()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the
> variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
>=20
> This patch fixes this by adding __refdata to the omap_driver variable=
=2E
>=20
> Signed-off-by: Thomas Weber <weber@corscience.de>
> ---
>  arch/arm/plat-omap/cpu-omap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-o=
map.c
> index 11c54ec..17fdd5f 100644
> --- a/arch/arm/plat-omap/cpu-omap.c
> +++ b/arch/arm/plat-omap/cpu-omap.c
> @@ -144,7 +144,7 @@ static struct freq_attr *omap_cpufreq_attr[] =3D =
{
>  	NULL,
>  };
> =20
> -static struct cpufreq_driver omap_driver =3D {
> +static struct cpufreq_driver omap_driver __refdata =3D {
>  	.flags		=3D CPUFREQ_STICKY,
>  	.verify		=3D omap_verify_speed,
>  	.target		=3D omap_target,
This is correct for a single case.  But actually the better fix would b=
e
to remove the .init member of struct cpufreq_driver and change the
prototype of cpufreq_register_driver from

	int (*)(struct cpufreq_driver *)

to

	int (*)(struct cpufreq_driver *, int (*)(struct cpufreq_policy *))=20

and pass the init function directly to it.
This way you don't need __refdata (which should be an exception) and yo=
u
don't waste memory for a pointer that is never used after
cpufreq_register_driver returns.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
