From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Date: Fri, 12 Jan 2018 19:40:35 +0100
Message-ID: <20180112194022.7da1e726@kemnade.info>
References: <cover.1512114576.git.hns@goldelico.com>
        <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
        <20171222124427.GI3374@localhost>
        <20180109184347.28ba0a6e@aktux>
        <20180112144647.GA5992@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gnEi/5NDHd4dB+yFqYL2Bu."; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180112144647.GA5992@localhost>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--Sig_/gnEi/5NDHd4dB+yFqYL2Bu.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jan 2018 15:46:47 +0100
Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Tue, Jan 09, 2018 at 06:43:47PM +0100, Andreas Kemnade wrote:
> > On Fri, 22 Dec 2017 13:44:27 +0100
> > Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> >=20
> > [...] =20
> > > I'd suggest reiterating the problem you're trying to solve and
> > > enumerating the previously discussed potential solutions in order to
> > > find a proper abstraction level for this (before getting lost in
> > > implementation details).
> > >  =20
> > The main point here is in short words: Having a device powered on or off
> > when the uart it is attached to, is used or not used anymore,
> > so the already available userspace applications do not need to be chang=
ed. =20
>=20
> So we'd end up with something in-between a kernel driver and a
> user-space solution. What about devices that need to be (partially)
> powered also when the port isn't open? A pure user-space solution would
> be able to handle all variants.
>=20
Well partly powered devices are at many places, And they hide that problem
from userspace, just get the open()/get() and close()/put() from there and =
power the
device accordingly.=20

So the question still remains why should the kernel hide some things and so=
me
it should not.
If it all is in userspace, then there is still something needed in the devi=
cetree
(if I understand correctly, every information about hardware which cannot be
auto-probed belongs into device tree) so that the userspace knows what kind=
 of
device is at that port. So there can be a daemon powering on and off device=
s.
But that would break existing applications which just expect that they just=
 need
to open/close the device.=20

Or you need to have some inotify handler in userspace and attach it there to
react on close() and open() of that device.
But this thing needs to have two kind of information:

1. the type of chip available to do the right powerup sequence.=20

2. how the chip is wired up to the cpu.=20

So to avoid having hardware information spread all over the table at least
these information would need to be in devicetree. But that also all feels
like a hack and hard to maintain.

Regards,
Andreas

--Sig_/gnEi/5NDHd4dB+yFqYL2Bu.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEjNsZ3bHwkfCKTen3ifE1O/ULBjQFAlpZASMACgkQifE1O/UL
BjQgGw/+N5K5+9MAKgTEUz6W+LlP39ePxdfVKTCQh3w2uhQ6zs0WF3o1NONARvut
bfA8WQ5DjASF2OXn5x+HAsKD0D7hB7/e8D36IN5cOu0S4F+fgMlvjPkROqMk++89
GuI10aML7wUCddW27l29lsOBffgAMXIqmzaIq+AQhMWjhM388LNaJvdVRtW8UGNE
olS2Jkf92v11RF0Ovoms3HJdrfJdnMaN31K+8RtwsjQgUQAvObLXkbB7M818oWuH
UxxpvLsgh3B/HWZzXhq80qhwDA51abkAlag7ZnyrVoAVZUch5qMcA0GAPH1KkYrq
D2jcT3jWOyv/CEEsFxQ3bljVY+907DtExLTRLInZMvYiFv5Zykv2OS9MZtpG5xSb
ljWFT8/GihQ8fB3IdxhEy5lpLSd9ETVuCYLnBFEvP3BDR+Ncum7pM7zcFOQjTfoy
8DopQ6e38Bc5nztnuiULvC2CEfIRXpNVXxDeBzRCo0j2OulS6JlAoFGFvixxGOVM
smrMQexhL5+/Vg5+Oz7GDtxF/WnjfzRhxf/Dxt6NMF1lV9tkRe/aFc+S0VnvGPD6
jN1XUrRrpX4DsJJvuaPYyoBUqYQWh00f7Sz+hOFwyfQBhXpODFyqUOwp6mLwDVCx
cVDu7a/YnFgVdXs0eS5E0h3fOY7BLLvAMNOMpAqIg59cuvLDQyU=
=r+9a
-----END PGP SIGNATURE-----

--Sig_/gnEi/5NDHd4dB+yFqYL2Bu.--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
