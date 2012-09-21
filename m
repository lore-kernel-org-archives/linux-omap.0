From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] serial: omap: fix the overrun case
Date: Fri, 21 Sep 2012 15:07:53 +0300
Message-ID: <20120921120752.GG16003@arwen.pp.htv.fi>
References: <1348222976-7241-1-git-send-email-shubhrajyoti@ti.com>
 <20120921110050.GC16003@arwen.pp.htv.fi>
 <CAKdam55VG8KTRZNvPgur9M-wkbD7wyJt27Jsvks=r4PNiuEGaQ@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKdam55VG8KTRZNvPgur9M-wkbD7wyJt27Jsvks=r4PNiuEGaQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: balbi@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2012 at 05:09:56PM +0530, Poddar, Sourav wrote:
> Hi Felipe,
>=20
> On Fri, Sep 21, 2012 at 4:30 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Fri, Sep 21, 2012 at 03:52:56PM +0530, Shubhrajyoti D wrote:
> >> Overrun also causes an internal flag to be set, which disables further
> >> reception. Before the next frame can
> >> be received, the MPU must:
> >> =E2=80=A2 Reset the RX FIFO.
> >> =E2=80=A2 clear the internal flag.
> >>
> >> In the uart mode a dummy read is needed. Add the same.
> >
> > Very nice patch but I think commit log can be a bit more verbose.
> >
> > Please make the problem a little clearer. Why do we even get that
> > interrupt fired if BRK_ERROR_BITS aren't set ?
> >
> According to LSR registers, there are few other bits like RX_FIFO_E( atle=
ast 1
> character in RX_FIFO or TX FIFO Empty), which might be the cause of an
> interrupt. ?

right. In that case, is it really correct to just return if
BRK_ERROR_BITS aren't set ? IRQ line will not toggle and we just might
end up with an IRQ storm, right ?

--=20
balbi

--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQXFiXAAoJEIaOsuA1yqREX2oP/2FywlS1qPBc8elm79pdRfbw
MmeENv8PI7SQxn+RJC1bhH56WYSeF43srN5sE96G1dChs5zZemfS6cMukO5pIZVa
nINXKJ9kNYZtmdBTIo4e4SLgAulmNfg93oFjwyqpSHKo8r+ELU3JK+A6FKGF8hTo
0JR41hCEhBDKad9xNfkOsq4YFQ8QV8ZBPSfSpU2nB0oGbbeVzEKvW+r+GmRGAtap
rrqEcmt0nEp4+ilQ7O1Rd2P5lAlBPgeaq0p+XINBlfoZf10fTkQmnLt0RTN8KNc/
bTL3h4bV+ncq94EAjGXdn5V1TXlI0plKL5kcU2ioylRgtKHO4UDy0c2KYdPF0oY0
HqHGLKTAph65hUiEaPXXcYN6z54FKNyFF2dbq+4+5hzuK+UaXveds1o66uziffMA
R08QowC9rfSZz+thmxAS0w/LabsMbqrPPd5XbVBQK1ZRgLBYm3fdsi5+3YcvxiT/
NZvZr175ABEfvVFu3s1GagMT2ZVDzLVzi2GqAMZIpXIDfND5ZvXK9GpI3tF82Gp+
p20ONxB/w5xX5uMKQidyxBMs0UNvMOA9KoFSjWyPMXticrgLQTcZKOY4Axlvms83
A57DkcKBbX5fgVNQ6diW+xrQTuEQYYdBZzWcnT/yaoUS5YbewPr8Ld+YUKofktd2
piUltdefZ4iVfJ8BuO99
=LplN
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--
