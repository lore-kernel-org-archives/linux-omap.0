From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC v2]: Issues implementing clock handling mechanism within
 UART driver
Date: Mon, 1 Aug 2011 13:02:04 +0300
Message-ID: <20110801100203.GN31013@legolas.emea.dhcp.ti.com>
References: <20110729095512.GE31013@legolas.emea.dhcp.ti.com>
 <CAAL8m4xjN15RfwbDd_c1HdoKY327CWOn5qwuoUT=fop4J0K5cw@mail.gmail.com>
 <20110729113713.GK31013@legolas.emea.dhcp.ti.com>
 <CAAL8m4wq7RQ_Rp-+LMWYY=dtTnhtR5UY+8HpO5C_54goKezaTg@mail.gmail.com>
 <20110729121907.GM31013@legolas.emea.dhcp.ti.com>
 <CAAL8m4wQqS64xG0Vi9YCOdy3f2=1V7UkJCErpikHOra4X=g7+w@mail.gmail.com>
 <20110729140210.GT31013@legolas.emea.dhcp.ti.com>
 <CAAL8m4wdKu_XGFaGxuAJ9uypRyyQMkR8HL7Y6E=pBkwX=L43nA@mail.gmail.com>
 <20110801090328.GG31013@legolas.emea.dhcp.ti.com>
 <CAMrsUdL_9mzKsjrKf=spihxcRTQc6Tsr+MAP9GFAz_7sE27B6Q@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fBycuDTqZgS1bANG"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMrsUdL_9mzKsjrKf=spihxcRTQc6Tsr+MAP9GFAz_7sE27B6Q@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: balbi@ti.com, Govindraj <govindraj.ti@gmail.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org


--fBycuDTqZgS1bANG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(fix your mailer dude)

On Mon, Aug 01, 2011 at 03:26:52PM +0530, Raja, Govindraj wrote:
>      > @@ -254,14 +255,14 @@ void omap2_clk_disable(struct clk *clk)
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD return;
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD }
>      >
>      > - =EF=BF=BD =EF=BF=BD pr_debug("clock: %s: decrementing usecount\n=
", clk->name);
>      > +// =EF=BF=BD pr_debug("clock: %s: decrementing usecount\n", clk->=
name);
>      >
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD clk->usecount--;
>      >
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD if (clk->usecount > 0)
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD return;
>      >
>      > - =EF=BF=BD =EF=BF=BD pr_debug("clock: %s: disabling in hardware\n=
", clk->name);
>      > +// =EF=BF=BD pr_debug("clock: %s: disabling in hardware\n", clk->=
name);
>      >
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD if (clk->ops && clk->ops->disable) {
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD trace_clock_disable(clk->name, 0, smp_processor_id());
>=20
>      this hunk is unnecessary. Clocks are always on when they are called.
>=20
>    The problem is:
>    [1]:
>    runtime_put -> *power.lock* - > rpm->suspend -> above pr_debug ->
>    console_write -> get_sync
>    -> *power.lock* -> rpm resume
>    power.lock contention.

Are you sure ? If the device is still on, won't that get_sync() only
increase the pm counter ? Instead of going through everything ?? Oh
well, this is becoming quite racy :-(

>      > @@ -290,14 +291,14 @@ int omap2_clk_enable(struct clk *clk)
>      > =EF=BF=BD{
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD int ret;
>      >
>      > - =EF=BF=BD =EF=BF=BD pr_debug("clock: %s: incrementing usecount\n=
", clk->name);
>      > +// =EF=BF=BD pr_debug("clock: %s: incrementing usecount\n", clk->=
name);
>      >
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD clk->usecount++;
>      >
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD if (clk->usecount > 1)
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD return 0;
>      >
>      > - =EF=BF=BD =EF=BF=BD pr_debug("clock: %s: enabling in hardware\n"=
, clk->name);
>      > +// =EF=BF=BD pr_debug("clock: %s: enabling in hardware\n", clk->n=
ame);
>=20
>      these two is ok.
>      > diff --git a/arch/arm/mach-omap2/omap_hwmod.c
>      b/arch/arm/mach-omap2/omap_hwmod.c
>      > index 7ed0479..8ca7d40 100644
>      > --- a/arch/arm/mach-omap2/omap_hwmod.c
>      > +++ b/arch/arm/mach-omap2/omap_hwmod.c
>      > @@ -124,7 +124,8 @@
>      > =EF=BF=BD * XXX error return values should be checked to ensure th=
at they are
>      > =EF=BF=BD * appropriate
>      > =EF=BF=BD */
>      > -#undef DEBUG
>      > +//#undef DEBUG
>      > +#define DEBUG
>=20
>      trailing.
>      > @@ -597,7 +598,8 @@ static int _enable_clocks(struct omap_hwmod *o=
h)
>      > =EF=BF=BD{
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD int i;
>      >
>      > - =EF=BF=BD =EF=BF=BD pr_debug("omap_hwmod: %s: enabling clocks\n"=
, oh->name);
>      > + =EF=BF=BD =EF=BF=BD if (strcmp(oh->class->name, "uart"))
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD pr_d=
ebug("omap_hwmod: %s: enabling clocks\n", oh->name);
>=20
>      instead of doing checks, you could move the print to the end of the
>      function, when clocks are already enabled. When doind that, of cours=
e,
>      update the comment to say "%s: clocks enabled\n".
>=20
>    the problem is the prints causing power.lock contention same as=EF=BF=
=BD
>    the=EF=BF=BDscenario=EF=BF=BDin [1] above.
>    =EF=BF=BD
>=20
>      > @@ -627,7 +629,8 @@ static int _disable_clocks(struct omap_hwmod *=
oh)
>      > =EF=BF=BD{
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD int i;
>      >
>      > - =EF=BF=BD =EF=BF=BD pr_debug("omap_hwmod: %s: disabling clocks\n=
", oh->name);
>      > + =EF=BF=BD =EF=BF=BD if (strcmp(oh->class->name, "uart"))
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD pr_d=
ebug("omap_hwmod: %s: disabling clocks\n",
>      oh->name);
>=20
>      check not needed, clocks are still on.
>=20
>    scenario=EF=BF=BD[1]
>    =EF=BF=BD
>=20
>      >
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD if (oh->_clk)
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD clk_disable(oh->_clk);
>      > @@ -1232,7 +1235,8 @@ static int _enable(struct omap_hwmod *oh)
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD return -EINVAL;
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD }
>      >
>      > - =EF=BF=BD =EF=BF=BD pr_debug("omap_hwmod: %s: enabling\n", oh->n=
ame);
>      > + =EF=BF=BD =EF=BF=BD if (strcmp(oh->class->name, "uart"))
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD pr_d=
ebug("omap_hwmod: %s: enabling\n", oh->name);
>=20
>      move it further down.
>      > @@ -1264,8 +1268,9 @@ static int _enable(struct omap_hwmod *oh)
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD }
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD } else {
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD _disable_clocks(oh);
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD pr_d=
ebug("omap_hwmod: %s: _wait_target_ready: %d\n",
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDoh->name, r);
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD if (=
strcmp(oh->class->name, "uart"))
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD pr_debug("omap_hwmod: %s: _wait_target=
_ready:
>      %d\n",
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BDoh->name, r);
>=20
>      instead of adding check, move the print before _disable_clocks(oh).
>      > @@ -1287,7 +1292,8 @@ static int _idle(struct omap_hwmod *oh)
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD return -EINVAL;
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD }
>      >
>      > - =EF=BF=BD =EF=BF=BD pr_debug("omap_hwmod: %s: idling\n", oh->nam=
e);
>      > + =EF=BF=BD =EF=BF=BD if (strcmp(oh->class->name, "uart"))
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD pr_d=
ebug("omap_hwmod: %s: idling\n", oh->name);
>=20
>      I believe clocks are still on here too, no checks needed.
>      > diff --git a/arch/arm/plat-omap/omap_device.c
>      b/arch/arm/plat-omap/omap_device.c
>      > index 49fc0df..7b27704 100644
>      > --- a/arch/arm/plat-omap/omap_device.c
>      > +++ b/arch/arm/plat-omap/omap_device.c
>      > @@ -75,7 +75,8 @@
>      > =EF=BF=BD * (device must be reinitialized at this point to use it =
again)
>      > =EF=BF=BD *
>      > =EF=BF=BD */
>      > -#undef DEBUG
>      > +//#undef DEBUG
>      > +#define DEBUG
>=20
>      trailing.
>      > @@ -114,7 +115,8 @@ static int _omap_device_activate(struct
>      > omap_device *od, u8 ignore_lat)
>      > =EF=BF=BD{
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD struct timespec a, b, c;
>      >
>      > - =EF=BF=BD =EF=BF=BD pr_debug("omap_device: %s: activating\n", od=
->[2]pdev.name);
>      > + =EF=BF=BD =EF=BF=BD if (strcmp(od->hwmods[0]->class->name, "uart=
"))
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD pr_d=
ebug("omap_device: %s: activating\n",
>      od->[3]pdev.name);
>=20
>      move it to the end of the function.
>      > @@ -138,25 +140,29 @@ static int _omap_device_activate(struct
>      > omap_device *od, u8 ignore_lat)
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD c =3D timespec_sub(b, a);
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD act_lat =3D timespec_to_ns(&c);
>      >
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD pr_d=
ebug("omap_device: %s: pm_lat %d: activate: elapsed
>      time "
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD"%llu nsec\n", od->[4]pdev.na=
me,
>      od->pm_lat_level,
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDact_lat);
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD if (=
strcmp(od->hwmods[0]->class->name, "uart"))
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD pr_debug("omap_device: %s: pm_lat %d: =
activate:
>      elapsed time "
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD"%llu nsec\n", od->[5]pdev.name,
>      od->pm_lat_level,
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BDact_lat);
>=20
>      move it further down.
>      >
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD if (act_lat > odpl->activate_lat) {
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD odpl->activate_lat_worst =3D ac=
t_lat;
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD if (odpl->flags &
>      OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD odpl->activate_lat =3D act_lat;
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD pr_warning("omap_device: %s.%d: new
>      worst case "
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD"activate la=
tency %d:
>      %llu\n",
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDod->[6]pdev.=
name,
>      od->[7]pdev.id,
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDod->pm_lat_l=
evel, act_lat);
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD } else
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD pr_warning("omap_device: %s.%d: activate
>      "
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD"latency %d =
higher than
>      exptected. "
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD"(%llu > %d)=
\n",
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDod->[8]pdev.=
name,
>      od->[9]pdev.id,
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDod->pm_lat_l=
evel, act_lat,
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDodpl->activa=
te_lat);
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD if (strcmp(od->hwmods[0]->class->name,
>      "uart"))
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD pr_warning("omap_device: %s.%d:
>      new worst case "
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD "activate latency %d:
>      %llu\n",
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD od->[10]pdev.name,
>      od->[11]pdev.id,
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD od->pm_lat_level,
>      act_lat);
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD } else {
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD if (strcmp(od->hwmods[0]->class->name,
>      "uart"))
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD pr_warning("omap_device: %s.%d:
>      activate "
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD "latency %d higher than
>      exptected. "
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD "(%llu > %d)\n",
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD od->[12]pdev.name,
>      od->[13]pdev.id,
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD od->pm_lat_level,
>      act_lat,
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD odpl->activate_lat);
>=20
>      ->activate_func() has already been called here, clocks are already o=
n.
>      > @@ -183,7 +189,8 @@ static int _omap_device_deactivate(struct
>      > omap_device *od, u8 ignore_lat)
>      > =EF=BF=BD{
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD struct timespec a, b, c;
>      >
>      > - =EF=BF=BD =EF=BF=BD pr_debug("omap_device: %s: deactivating\n", =
od->[14]pdev.name);
>      > + =EF=BF=BD =EF=BF=BD if (strcmp(od->hwmods[0]->class->name, "uart=
"))
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD pr_d=
ebug("omap_device: %s: deactivating\n",
>      od->[15]pdev.name);
>=20
>      clocks are still on here.
>      > @@ -206,25 +213,29 @@ static int _omap_device_deactivate(struct
>      > omap_device *od, u8 ignore_lat)
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD c =3D timespec_sub(b, a);
>      > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD deact_lat =3D timespec_to_ns(&c);
>      >
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD pr_d=
ebug("omap_device: %s: pm_lat %d: deactivate:
>      elapsed time "
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD"%llu nsec\n", od->[16]pdev.n=
ame,
>      od->pm_lat_level,
>      > - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDdeact_lat);
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD if (=
strcmp(od->hwmods[0]->class->name, "uart"))
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD pr_debug("omap_device: %s: pm_lat %d:
>      deactivate: elapsed time "
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD"%llu nsec\n", od->[17]pdev.name,
>      od->pm_lat_level,
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BDdeact_lat);
>=20
>      I'll leave this to Kevin to decide what to do, but clocks are off
>      here...
>=20
>    Yes fine.=EF=BF=BD
>    Since most of these prints will be printed if DEBUG macro
>    is defined in respective files and *debug* is used in command line.
>    Can't leave uart clocks active always on debug cases.
>    [If *debug* =EF=BF=BDused as command line]
>    and gate uart clocks only for non debug cases.
>    With this approach=EF=BF=BDat least=EF=BF=BDwe can have a clean soluti=
on
>    in uart driver also without adding clock gating from idle path.
>    Not sure if this=EF=BF=BDagreeable.
>    As of now gating from idle path seems to be only clean approach.

I see.. that could be one way... let's see how Kevin feels about it
though.

--=20
balbi

--fBycuDTqZgS1bANG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJONnmbAAoJEAv8Txj19kN1l0gIAKnJleANT8uvGiGZQB2gDJNV
HRqsBjl+eWSLv/1s2ZrUg3JTuOcW9erUCc3oqJkMzCQpFgWBBibxAM8eT5T/8sn2
mzrfDxeX3ymViASYEHcBlhxvS9bfVG/d2YG7Kr09xfJWzWJNabcIGZiRpYqmsWT3
cv97NH8NYKjzTzq+papMQG5GgjICTcPJ20vQzWsJUqq0TrN8T/rIRQGciC5G3ZUe
oAsbEX6ywDXqPFTO2B/Fx5MuS9edsA82TavzRWvbbYMRKw95gWdONhNKnanIPYCg
21B2FuvvJJErHnkjwMcjJOMTBHJa2OG2ZGponykvLFZIqhRDfVDIN9tWGGY7qGg=
=gg/B
-----END PGP SIGNATURE-----

--fBycuDTqZgS1bANG--
