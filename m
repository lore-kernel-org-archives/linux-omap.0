From: Felipe Balbi <balbi@ti.com>
Subject: Re: CONFIG_DEBUG_SHIRQ and PM
Date: Wed, 26 Aug 2015 15:24:29 -0500
Message-ID: <20150826202429.GV14625@saruman.tx.rr.com>
References: <20150825195830.GH27534@saruman.tx.rr.com>
 <CAAEAJfCY1BRuoQCWfD2pCq36E54vDB5Coy2S7rz3RfL2BVLGaw@mail.gmail.com>
 <20150826193820.GT14625@saruman.tx.rr.com>
 <CAAEAJfAPVgxhRnfYJYzebFJDRJ4Ooam6n+0B5HJ-+uLJ0exTLA@mail.gmail.com>
 <20150826200300.GU14625@saruman.tx.rr.com>
 <CAAEAJfB3iiRENEKm6xx-kLae5AR6BV0XVo0KNkb8-okvLjhFhg@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jWL1oGPK2mPq0rME"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAEAJfB3iiRENEKm6xx-kLae5AR6BV0XVo0KNkb8-okvLjhFhg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Felipe Balbi <balbi@ti.com>, Ingo Molnar <mingo@elte.hu>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--jWL1oGPK2mPq0rME
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 26, 2015 at 05:15:51PM -0300, Ezequiel Garcia wrote:

<snip>

> >> be prepared to handle it any time, coming from any sources (not only
> >> your device). And CONFIG_DEBUG_SHIRQ does exactly that, in order to
> >> make sure all the drivers passing IRQF_SHARED comply with that rule.
> >
> > you need to be sure of that with non-shared IRQs anyway.
>=20
> Not entirely. If your IRQ is not shared, then you usually have a register
> to enable or unmask your peripheral interrupts. So the driver is in contr=
ol
> of when it will get interrupts.
>=20
> If the IRQ is shared, this won't do. This is what I mean by "shared IRQs
> must be prepared to receive an interrupt any time", in the sense that
> the driver has no way of preventing IRQs (because they may be
> coming from any source).

right, the problem is much less likely on non-shared lines but the fine
that a line is shared or not is a function of HW integration, not the
e.g. USB Controller, so that knowledge really doesn't fit the driver in
a sense.

We might as well get rid of IRQF_SHARED and assume all lines are
shareable.

> In the same sense, shared IRQs handlers need to double-check
> the IRQ is coming to the current device by checking some IRQ
> status register to see if there's pending work.

you should the status register even on non-shared IRQs to catch spurious
right ?

> > Also, an IRQ
> > which isn't shared in SoC A, might become shared in SoC B which uses the
> > same IP.
> >
> >> So you either avoid using devm_request_irq, or you prepare your handler
> >> accordingly to be ready to handle an interrupt _any time_.
> >
> > the handler is ready to handle at any time, what isn't correct is the
> > fact that clocks get gated before IRQ is freed.
> >
> > There should be no such special case as "if your handler is shared,
> > don't use devm_request_*irq()" because if we just disable PM_RUNTIME, it
> > works as expected anyway.
> >
>=20
> Yeah, I meant to say: if you use devm_request_irq with IRQF_SHARED
> then you _must_ be prepared to get an IRQ *after* your remove() has
> been called.
>=20
> Let's consider this snippet from tw68:
>=20
> static irqreturn_t tw68_irq(int irq, void *dev_id)
> {
>         struct tw68_dev *dev =3D dev_id;
>         u32 status, orig;
>         int loop;
>=20
>         status =3D orig =3D tw_readl(TW68_INTSTAT) & dev->pci_irqmask;

Now try to read that register when your clock is gated. That's the
problem I'm talking about. Everything about the handler is functioning
correctly; however clocks are gated in ->remove() and free_irq() is
only called *AFTER* ->remove() has returned.

>         [etc]
> }
>=20
> The IRQ handler accesses the device struct and then
> reads through PCI. So if you use devm_request_irq
> you need to make sure the device struct is still allocated
> after remove(), and the PCI read won't stall or crash.

dude, that's not the problem I'm talking about. I still have my
private_data around, what I don't have is:

              _            _   =20
  __ _    ___| | ___   ___| | __
 / _` |  / __| |/ _ \ / __| |/ /
| (_| | | (__| | (_) | (__|   <=20
 \__,_|  \___|_|\___/ \___|_|\_\
                               =20

> Interestingly, tw68 uses devm_request_irq with IRQF_SHARED :-)
>=20
> Still, I don't think that's a good idea, since it relies on
> the IRQ being freed *before* the device struct.

that's not an issue at all. If you're using devm_request_irq() you're
likely using devm_kzalloc() for the device struct anyway. Also, you
called devm_kzalloc() before devm_request_irq() so IRQ *will* be freed
before your private data; there's nothing wrong there.

--=20
balbi

--jWL1oGPK2mPq0rME
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV3iB9AAoJEIaOsuA1yqREUp8P/A4X+xhr2veehTmMB8NaAhox
W7jVeDyUdlyoXfdxZuK3g0b0e6iVwvmF6mL/KxgAZFATSC43mmmmZhnQ/rud7vwe
+ZUGtcxLbITtsjcQVlW7cunVR7a4pjThmA2+DHObEaFvt3Su/La5R0mc5ZvAMOWe
D2W19vokmBmztUjSjcjZ1DcWvbXDR78n2KFs4LoN3rVXGswKltG67HZh4erI0yGp
PPt+2NY2kKNi2DItZ/SjcG81J/sWGKZaamlePjW/ZAc/9CoyVmOH6vBOsWoIhOxi
9mB8UlFLWQseBp9uIuftbW+++2MEUP4bz1IAuwJ05zkKxN2/lLgEdK8osawJK9xG
MJoHI2FBavfXUPLbCdZG21rfSBxXK9CDHwMl/KBDzt6TnGl+heiZToVJTpVJaxw6
6DbQ5CciAqQnOCVd+50E6tS4cUMjr3KzNZeA/3DH1A5Q/ZL7uo3cyhzod7S8b1Z9
qrLrszzk5cJSEGYKg0J1DGtu1FQowNOEX+p3oVermcITLc4StgTs9uV8NIcmwfuX
oY/wDVvTA29qaG8LPEWUvK5S5uEk+eEhUIeogotSkfAjb6lH7q8dFu5q+bgK8U8v
5TlX7NqlB4X/ktWgrSoTjHONT+6Lvh04GTRzziTztmOH7qxiEsdCxGqarl21+up3
2QfjTzk5Tl14R1yP4zrQ
=gQQa
-----END PGP SIGNATURE-----

--jWL1oGPK2mPq0rME--
