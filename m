From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nokia N900: v4.16-rc4: oops in iio when grepping sysfs
Date: Sat, 10 Mar 2018 13:00:53 +0100
Message-ID: <20180310120053.GB31614@amd>
References: <20180309221220.GA15272@amd>
 <20180309222821.GA16973@kroah.com>
 <20180309230124.GA17721@amd>
 <1bb9aa1e-1a78-5d1c-d2d6-f2cd6b925f31@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1bb9aa1e-1a78-5d1c-d2d6-f2cd6b925f31@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg KH <greg@kroah.com>, jic23@kernel.org, akinobu.mita@gmail.com, javier@osg.samsung.com, gregor.boirie@parrot.com, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, security@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sat 2018-03-10 12:19:29, Lars-Peter Clausen wrote:
> On 03/10/2018 12:01 AM, Pavel Machek wrote:
> [...]
> >> What file are you opening to cause this?
> >=20
> > Strace says:
> >=20
> > openat(7, "in_intensity_both_thresh_rising_en",
> >>> O_RDONLY|O_LARGEFILE|O_NOFOLLOW) =3D 3
> > fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D4096, ...}) =3D 0
> > ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbe83b714) =3D -1 ENOTTY
> >>> (Inappropriate ioctl for device)
> > read(3,
> > Message from syslogd@localhost at Mar  9 23:54:39 ...
> >  kernel:[ 3097.357696] Internal error: Oops: 80000007 [#2] ARM
> >=20
> > So that would be:
> >=20
> > ./devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0029/iio:device1/e=
vents/in_intensity_both_thresh_rising_en
> >=20
> > And indeed, manually cat-ing that file reproduces the problem.
> >=20
> > pavel@n900:/sys/devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0029=
/iio:device1$
> > cat name
> > tsl2563
> >=20
> > I can not find tsl2563 in MAINTAINERS, file is
> > ./drivers/iio/light/tsl2563.c . I added few people pointed by git log.
>=20
> The driver registers event attributes, but does not provide a handle to
> access those attributes.
>=20
> Now the question is how to best handle this case.
>=20
> 1) Return an error when the device is registered and abort registration
> 2) Skip registering the event attributes
> 3) Skip registering the event attributes, but print a warning
> 4) Register the attributes, but return an error when they are accessed
>=20
> I'd prefer 2 since it offers a nice method of disabling all events for a
> device (e.g. if not interrupt is provided).

2 works for me.

Tested-by: Pavel Machek <pavel@ucw.cz>
Reported-by: Pavel Machek <pavel@ucw.cz>

Now grep -ri asdfasdf /sys finishes.

Thanks,
								Pavel

> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -477,7 +477,8 @@ int iio_device_register_eventset(struct iio_dev
>  	struct attribute **attr;
>=20
>  	if (!(indio_dev->info->event_attrs ||
> -	      iio_check_for_dynamic_events(indio_dev)))
> +	      iio_check_for_dynamic_events(indio_dev)) ||
> +	    !indio_dev->info->read_event_config)
>  		return 0;
>=20
>  	indio_dev->event_interface =3D

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqjyPUACgkQMOfwapXb+vKYcQCgsW3F4PGJPs/Sd+qmGxbE6FB6
fMoAoLrsw3Ko+09FqnqvF7GoQ6eIXoEA
=82F1
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
