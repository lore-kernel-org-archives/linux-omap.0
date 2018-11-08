From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH 0/2] mach-omap2: handle autoidle denial
Date: Thu, 8 Nov 2018 07:00:30 +0100
Message-ID: <20181108070030.5febd96b@kemnade.info>
References: <20181004203817.22101-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9j=CCNKyjqUyJ.4CB2by9aA"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004203817.22101-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

--Sig_/9j=CCNKyjqUyJ.4CB2by9aA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

ping.

..after stumbling again about that problem during testing with 4.20-rc1.
will retest it there.

On Thu,  4 Oct 2018 22:38:15 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> On the gta04 with a dm3730 omap_hdq does not work properly when the
> device enters lower power states. Idling uart1 and 2 is enough
> to show up that problem, if there are no other things enabled.
> Further research reveals that hdq iclk must not be turned off during
> transfers, also according to the TRM. That fact is also correctly describ=
ed
> in the flags but the code to handle that is incomplete.
>=20
> To handle multiple users of a single ick, autoidle is disabled
> when a user of that ick requires that (has the OCPIF_SWSUP_IDLE))
>=20
> Changes since the RFC version:
> - mutex lock for autoidle changes
> - deny_idle/allow_idle calls moved to clock enable/disable of the
>   individual modules
>=20
> Andreas Kemnade (2):
>   clk: ti: add a usecount for autoidle
>   arm: omap_hwmod disable ick autoidling when a hwmod requires that
>=20
>  arch/arm/mach-omap2/omap_hwmod.c | 16 ++++++++++++----
>  drivers/clk/ti/autoidle.c        | 32 ++++++++++++++++++++++++--------
>  include/linux/clk/ti.h           |  1 +
>  3 files changed, 37 insertions(+), 12 deletions(-)
>=20
> --=20
> 2.11.0
>=20
>=20

--Sig_/9j=CCNKyjqUyJ.4CB2by9aA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlvj0P4ACgkQfb1qx03i
kySkfA/+PrdYKmkw6xOcY332Q+GNnH+A+p5AD2Sj9R21fJFwPZ8DbRoOWbgV8PPZ
VdbOGrOeL6cFW18HdyU/N6kd4ZUl3VNylWiT8JYf4ScHqbznjFZvrgUDAOCKBJur
eSvthilX2XGYNldaWod6BG+cdy62hgO1Zf4r8Q16Y6mgcBIyS4z5hRKgFWcI/QBX
3s3yOQn5aNGtAnwB2RF5d4U+dH31KZ199WdOB3S5Z4lucVSm5Gk4EtHQ5NoxXgSN
R97YSebOhgKBi8OyzF3q9NpRsZxBsDCroVfTyYMY2qoTJ6q93LGYt137X0JODQTv
lEC/n7P+G0nZBfOyWGXGduEEz4GLHScMQEnDG0z4RyKZFbknqjE1fbp2GV+WC/BT
6dwQQFniE/Dhpb0K5XUkpZQMSGH0cFWUZr5TMuMLM7jt/YtBZqzmNBJ4QhFQSPXp
81pRffp628MclWGWQSyfdVpRGioVvq6lGytjynotXFO5e3kyCAI0Jzs/rOmNRRnO
k98qwNpqQRJjh2Fm6hSz7TSsWbh4Zu6sR7wH3yoyZuzi9H2HZClEZb3EHX4a3Y3u
iG9DbUArU/g/xH5bs6HbL/DzEYdTGjQQDOVjfh7abY5TjK0RBMGihbK1OKHoxfWB
hqWYkDAa85q2skB/RgUjx1wTW22/YLCMByd31hJ4UNrYbmimf40=
=qljx
-----END PGP SIGNATURE-----

--Sig_/9j=CCNKyjqUyJ.4CB2by9aA--
