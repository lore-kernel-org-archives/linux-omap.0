From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/4] mfd: global Suspend and resume support of ehci and
 ohci
Date: Sun, 5 Jun 2011 22:54:15 +0300
Message-ID: <20110605195413.GC18731@legolas.emea.dhcp.ti.com>
References: <20110605185047.GB18731@legolas.emea.dhcp.ti.com>
 <Pine.LNX.4.44L0.1106051519560.5916-100000@netrider.rowland.org>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1106051519560.5916-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 05, 2011 at 03:30:55PM -0400, Alan Stern wrote:
> > > > good point. BTW, do we need this #ifdef CONFIG_PM stuff which has b=
een
> > > > popping on most drivers recently ? To me it looks like driver.pm fi=
eld
> > > > is always available even if PM is disabled, so what's the point ? S=
aving
> > > > a few bytes ?
> > >=20
> > > Basically, yes (you may want to avoid defining the object this points=
 to if
> > > CONFIG_PM is unset).
> >=20
> > wouldn't it look nicer to have a specific section for dev_pm_ops which
> > gets automatically freed if CONFIG_PM isn't set ? I mean, there are a
> > few drivers which don't have the ifdeferry around dev_pm_ops anyway.
> >=20
> > So, something like:
> >=20
> > #define __pm_ops	__section(.pm.ops)
> >=20
> > static const struct dev_pm_ops my_driver_pm_ops __pm_ops =3D {
> > 	.suspend	=3D my_driver_suspend,
> > 	.resume		=3D my_driver_resume,
> > 	[ blablabla ]
> > };
> >=20
> > to simplify things, you could:
> >=20
> > #define DEFINE_DEV_PM_OPS(_ops)		\
> > 	const struct dev_pm_ops _ops __pm_ops
> >=20
> > that would mean changes to all linker scripts, though and a utility call
> > that only does anything ifndef CONFIG_PM to free the .pm.ops section.
>=20
> In my opinion this would make programming harder, not easier.  It's

I tend to disagree with this statement, see below.

> very easy to understand "#ifdef" followed by "#endif"; people see them

very true... Still everybody has to put them in place.

> all the time.  The new tags you propose would force people to go
> searching through tons of source files to see what they mean, and then

only those who want to see "how things work" would be forced to do that,
other people would be allowed to "assume it's doing the right thing".

> readers would still have to figure out when these tags should be used
> or what advantage they might bring.

not really, if you add a macro which adds that correctly and during
review we only accept drivers using that particular macro, things
wouldn't go bad at all.

> It's a little like "typedef struct foo foo_t;" -- doing this forces

hey c'mon. Then you're saying that all __initdata, __devinitdata,
__initconst and all of those are "typedef struct foo foo_t" ;-)

> people to remember one extra piece of information that serves no real
> purpose except perhaps a minimal reduction in the amount of typing. =20

and a guarantee that the unused data will be freed when it's really not
needed ;-)

> Since the limiting factor in kernel programming is human brainpower,
> not source file length, this is a bad tradeoff.  (Not to mention that

OTOH we are going through a big re-factor of the ARM port to reduce the
amount of code. Not that these few characters would change much but my
point is that amount of code also matters. So does uniformity, coding
style, etc...

> it also obscures an important fact: A foo_t is an extended structure
> rather than a single value.)

then it would make sense to have dev_pm_ops only defined when CONFIG_PM
is set to force all drivers stick to a common way of handling this.

Besides, currently, everybody who wants to keep the ifdeferry, needs to
define a macro for &my_dev_pm_ops or have two #ifdef..#endif blocks.

Either you do:

#ifdef CONFIG_PM
static int my_driver_suspend(struct device *dev)
{
	...

	return 0;
}
=2E...

static const struct dev_pm_ops my_driver_pm_ops =3D {
	.suspend	=3D my_driver_suspend,
	...
};

#define DEV_PM_OPS	(&my_driver_pm_ops)
#else
#define DEV_PM_OPS	NULL
#endif

static struct platform_driver my_driver =3D {
	...
	.driver	=3D {
		.pm =3D DEV_PM_OPS
	},
};

or you do:

#ifdef CONFIG_PM
static int my_driver_suspend(struct device *dev)
{
	...

	return 0;
}
=2E...

static const struct dev_pm_ops my_driver_pm_ops =3D {
	.suspend	=3D my_driver_suspend,
	...
};

#endif

static struct platform_driver my_driver =3D {
	...
	.driver	=3D {
#ifdef CONFIG_PM
		.pm =3D &my_driver_pm_ops,
#endif
	},
};

So, while this is a small thing which is easy to understand, it's still
yet another thing that all drivers have to remember to add. And when
everybody needs to remember that, I'd rather have it done
"automatically" by other means.

I mean, we already free .init.* sections after __init anyway, so what's
the problem in freeing another section ? I don't see it as obfuscation
at all. I see it as if the kernel is smart enough to free all unused
data by itself, without myself having to add ifdefs or freeing it by my
own.

On top of all that, today, we have driver with both ways of ifdefs plus
drivers with no ifdeferry at all, leaving dev_pm_ops floating around for
nothing.

IMHO, if things aren't uniform, we will have small problems, such as
this, proliferate because new drivers are based on other drivers,
generally.

--=20
balbi

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN697lAAoJEAv8Txj19kN1utoH/RK6aDhbmzwirpPbTsr2XrPf
9RvAW8aHDorbS5AhcIaVovX6LHr/a6g6jiZxNqz7BvXCBgfnV4SLnnBiHanePk01
Ar+rzr2pP6+x+z7Ok2P1vfIkRc8mgDgh5n1+RAQj4I5DwBD2kzbpmt1+vDxT2YDO
1E/qaTvY/FDiIT3hH+JvhFRLbMjQWTbrJr4aYFQymqu2NIIZk93iihdBUwVvKGmE
TA9/hi7hC0ijjrCpGw5Uzktscv3MUojnzWiolBhk7SnQ4OTkOFgSAzKFQwzzlZVz
i0hn3Tob9WfIwhJTgEKviAT+J9CdUyuIqyUXShsrJxULB5OUmXtEnYYSLO26yNY=
=kuEZ
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
