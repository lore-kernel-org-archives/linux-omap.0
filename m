From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC v2]: Issues implementing clock handling mechanism within
 UART driver
Date: Mon, 1 Aug 2011 12:03:30 +0300
Message-ID: <20110801090328.GG31013@legolas.emea.dhcp.ti.com>
References: <1311845395-31917-1-git-send-email-govindraj.raja@ti.com>
 <20110729095512.GE31013@legolas.emea.dhcp.ti.com>
 <CAAL8m4xjN15RfwbDd_c1HdoKY327CWOn5qwuoUT=fop4J0K5cw@mail.gmail.com>
 <20110729113713.GK31013@legolas.emea.dhcp.ti.com>
 <CAAL8m4wq7RQ_Rp-+LMWYY=dtTnhtR5UY+8HpO5C_54goKezaTg@mail.gmail.com>
 <20110729121907.GM31013@legolas.emea.dhcp.ti.com>
 <CAAL8m4wQqS64xG0Vi9YCOdy3f2=1V7UkJCErpikHOra4X=g7+w@mail.gmail.com>
 <20110729140210.GT31013@legolas.emea.dhcp.ti.com>
 <CAAL8m4wdKu_XGFaGxuAJ9uypRyyQMkR8HL7Y6E=pBkwX=L43nA@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vad/o1hfAYqRLqLQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:39853 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752606Ab1HAJDf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 05:03:35 -0400
Content-Disposition: inline
In-Reply-To: <CAAL8m4wdKu_XGFaGxuAJ9uypRyyQMkR8HL7Y6E=pBkwX=L43nA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: balbi@ti.com, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>


--Vad/o1hfAYqRLqLQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 29, 2011 at 08:43:49PM +0530, Govindraj wrote:

[giant snip]

> Actually there is much more than this:
>=20
> <<SNIP>>
>=20
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index 180299e..221ffb9 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -12,7 +12,8 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> -#undef DEBUG
> +//#undef DEBUG
> +#define DEBUG

trailing... but you know that :-p

> @@ -254,14 +255,14 @@ void omap2_clk_disable(struct clk *clk)
>  		return;
>  	}
>=20
> -	pr_debug("clock: %s: decrementing usecount\n", clk->name);
> +//	pr_debug("clock: %s: decrementing usecount\n", clk->name);
>=20
>  	clk->usecount--;
>=20
>  	if (clk->usecount > 0)
>  		return;
>=20
> -	pr_debug("clock: %s: disabling in hardware\n", clk->name);
> +//	pr_debug("clock: %s: disabling in hardware\n", clk->name);
>=20
>  	if (clk->ops && clk->ops->disable) {
>  		trace_clock_disable(clk->name, 0, smp_processor_id());

this hunk is unnecessary. Clocks are always on when they are called.

> @@ -290,14 +291,14 @@ int omap2_clk_enable(struct clk *clk)
>  {
>  	int ret;
>=20
> -	pr_debug("clock: %s: incrementing usecount\n", clk->name);
> +//	pr_debug("clock: %s: incrementing usecount\n", clk->name);
>=20
>  	clk->usecount++;
>=20
>  	if (clk->usecount > 1)
>  		return 0;
>=20
> -	pr_debug("clock: %s: enabling in hardware\n", clk->name);
> +//	pr_debug("clock: %s: enabling in hardware\n", clk->name);

these two is ok.

> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_=
hwmod.c
> index 7ed0479..8ca7d40 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -124,7 +124,8 @@
>   * XXX error return values should be checked to ensure that they are
>   * appropriate
>   */
> -#undef DEBUG
> +//#undef DEBUG
> +#define DEBUG

trailing.

> @@ -597,7 +598,8 @@ static int _enable_clocks(struct omap_hwmod *oh)
>  {
>  	int i;
>=20
> -	pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
> +	if (strcmp(oh->class->name, "uart"))
> +		pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);

instead of doing checks, you could move the print to the end of the
function, when clocks are already enabled. When doind that, of course,
update the comment to say "%s: clocks enabled\n".

> @@ -627,7 +629,8 @@ static int _disable_clocks(struct omap_hwmod *oh)
>  {
>  	int i;
>=20
> -	pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);
> +	if (strcmp(oh->class->name, "uart"))
> +		pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);

check not needed, clocks are still on.

>=20
>  	if (oh->_clk)
>  		clk_disable(oh->_clk);
> @@ -1232,7 +1235,8 @@ static int _enable(struct omap_hwmod *oh)
>  		return -EINVAL;
>  	}
>=20
> -	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
> +	if (strcmp(oh->class->name, "uart"))
> +		pr_debug("omap_hwmod: %s: enabling\n", oh->name);

move it further down.

> @@ -1264,8 +1268,9 @@ static int _enable(struct omap_hwmod *oh)
>  		}
>  	} else {
>  		_disable_clocks(oh);
> -		pr_debug("omap_hwmod: %s: _wait_target_ready: %d\n",
> -			 oh->name, r);
> +		if (strcmp(oh->class->name, "uart"))
> +			pr_debug("omap_hwmod: %s: _wait_target_ready: %d\n",
> +				 oh->name, r);

instead of adding check, move the print before _disable_clocks(oh).

> @@ -1287,7 +1292,8 @@ static int _idle(struct omap_hwmod *oh)
>  		return -EINVAL;
>  	}
>=20
> -	pr_debug("omap_hwmod: %s: idling\n", oh->name);
> +	if (strcmp(oh->class->name, "uart"))
> +		pr_debug("omap_hwmod: %s: idling\n", oh->name);

I believe clocks are still on here too, no checks needed.

> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_d=
evice.c
> index 49fc0df..7b27704 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -75,7 +75,8 @@
>   * (device must be reinitialized at this point to use it again)
>   *
>   */
> -#undef DEBUG
> +//#undef DEBUG
> +#define DEBUG

trailing.

> @@ -114,7 +115,8 @@ static int _omap_device_activate(struct
> omap_device *od, u8 ignore_lat)
>  {
>  	struct timespec a, b, c;
>=20
> -	pr_debug("omap_device: %s: activating\n", od->pdev.name);
> +	if (strcmp(od->hwmods[0]->class->name, "uart"))
> +		pr_debug("omap_device: %s: activating\n", od->pdev.name);

move it to the end of the function.

> @@ -138,25 +140,29 @@ static int _omap_device_activate(struct
> omap_device *od, u8 ignore_lat)
>  		c =3D timespec_sub(b, a);
>  		act_lat =3D timespec_to_ns(&c);
>=20
> -		pr_debug("omap_device: %s: pm_lat %d: activate: elapsed time "
> -			 "%llu nsec\n", od->pdev.name, od->pm_lat_level,
> -			 act_lat);
> +		if (strcmp(od->hwmods[0]->class->name, "uart"))
> +			pr_debug("omap_device: %s: pm_lat %d: activate: elapsed time "
> +				 "%llu nsec\n", od->pdev.name, od->pm_lat_level,
> +				 act_lat);

move it further down.

>=20
>  		if (act_lat > odpl->activate_lat) {
>  			odpl->activate_lat_worst =3D act_lat;
>  			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
>  				odpl->activate_lat =3D act_lat;
> -				pr_warning("omap_device: %s.%d: new worst case "
> -					   "activate latency %d: %llu\n",
> -					   od->pdev.name, od->pdev.id,
> -					   od->pm_lat_level, act_lat);
> -			} else
> -				pr_warning("omap_device: %s.%d: activate "
> -					   "latency %d higher than exptected. "
> -					   "(%llu > %d)\n",
> -					   od->pdev.name, od->pdev.id,
> -					   od->pm_lat_level, act_lat,
> -					   odpl->activate_lat);
> +				if (strcmp(od->hwmods[0]->class->name, "uart"))
> +					pr_warning("omap_device: %s.%d: new worst case "
> +						"activate latency %d: %llu\n",
> +						od->pdev.name, od->pdev.id,
> +						od->pm_lat_level, act_lat);
> +			} else {
> +				if (strcmp(od->hwmods[0]->class->name, "uart"))
> +					pr_warning("omap_device: %s.%d: activate "
> +						"latency %d higher than exptected. "
> +						"(%llu > %d)\n",
> +						od->pdev.name, od->pdev.id,
> +						od->pm_lat_level, act_lat,
> +						odpl->activate_lat);

->activate_func() has already been called here, clocks are already on.

> @@ -183,7 +189,8 @@ static int _omap_device_deactivate(struct
> omap_device *od, u8 ignore_lat)
>  {
>  	struct timespec a, b, c;
>=20
> -	pr_debug("omap_device: %s: deactivating\n", od->pdev.name);
> +	if (strcmp(od->hwmods[0]->class->name, "uart"))
> +		pr_debug("omap_device: %s: deactivating\n", od->pdev.name);

clocks are still on here.

> @@ -206,25 +213,29 @@ static int _omap_device_deactivate(struct
> omap_device *od, u8 ignore_lat)
>  		c =3D timespec_sub(b, a);
>  		deact_lat =3D timespec_to_ns(&c);
>=20
> -		pr_debug("omap_device: %s: pm_lat %d: deactivate: elapsed time "
> -			 "%llu nsec\n", od->pdev.name, od->pm_lat_level,
> -			 deact_lat);
> +		if (strcmp(od->hwmods[0]->class->name, "uart"))
> +			pr_debug("omap_device: %s: pm_lat %d: deactivate: elapsed time "
> +				 "%llu nsec\n", od->pdev.name, od->pm_lat_level,
> +				 deact_lat);

I'll leave this to Kevin to decide what to do, but clocks are off
here...

>  		if (deact_lat > odpl->deactivate_lat) {
>  			odpl->deactivate_lat_worst =3D deact_lat;
>  			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
>  				odpl->deactivate_lat =3D deact_lat;
> -				pr_warning("omap_device: %s.%d: new worst case "
> -					   "deactivate latency %d: %llu\n",
> -					   od->pdev.name, od->pdev.id,
> -					   od->pm_lat_level, deact_lat);
> -			} else
> -				pr_warning("omap_device: %s.%d: deactivate "
> +				if (strcmp(od->hwmods[0]->class->name, "uart"))
> +					pr_warning("omap_device: %s.%d: new worst case "
> +						   "deactivate latency %d: %llu\n",
> +						   od->pdev.name, od->pdev.id,
> +						   od->pm_lat_level, deact_lat);
> +			} else {
> +				if (strcmp(od->hwmods[0]->class->name, "uart"))
> +					pr_warning("omap_device: %s.%d: deactivate "
>  					   "latency %d higher than exptected. "
>  					   "(%llu > %d)\n",
>  					   od->pdev.name, od->pdev.id,
>  					   od->pm_lat_level, deact_lat,
>  					   odpl->deactivate_lat);
> +			}

and here...

--=20
balbi

--Vad/o1hfAYqRLqLQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJONmvgAAoJEAv8Txj19kN1d0MH/1B8dwDrMatHJ8NnWf6RBHHf
amQSJ6dprDBBaazahIf14vVwhU+n6z706TygGD8gFezwEkaHRCJeW7vNY5pwE15V
oeTY3YfQ1lMoGOLsvEhyFcCoMGxv3qPS+8rHy+NxCxfhuANA+Foxtvop7Q6hTwwz
8tR98a1ZR+5YbFZuUMxt68NePgCkFVcRfCNPKKP45flREdoQetKeGCu7yTkK8eV0
e7b2QuppxTykRM5luG+E225LO6z/w+KjwebiOySfOgHI82mjvjIeuLYVHFXd1zmx
24UW1y2y/2kRRXmW2us1J3h1hGVhpEVA3mH+ADHACuRhsH9S7lKoQLRWMT5mDeQ=
=5ftE
-----END PGP SIGNATURE-----

--Vad/o1hfAYqRLqLQ--
