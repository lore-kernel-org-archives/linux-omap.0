From: Felipe Balbi <balbi@ti.com>
Subject: Re: CONFIG_DEBUG_SHIRQ and PM
Date: Wed, 26 Aug 2015 15:03:00 -0500
Message-ID: <20150826200300.GU14625@saruman.tx.rr.com>
References: <20150825195830.GH27534@saruman.tx.rr.com>
 <CAAEAJfCY1BRuoQCWfD2pCq36E54vDB5Coy2S7rz3RfL2BVLGaw@mail.gmail.com>
 <20150826193820.GT14625@saruman.tx.rr.com>
 <CAAEAJfAPVgxhRnfYJYzebFJDRJ4Ooam6n+0B5HJ-+uLJ0exTLA@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3yk1sSvxP8cRAjBs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAEAJfAPVgxhRnfYJYzebFJDRJ4Ooam6n+0B5HJ-+uLJ0exTLA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Felipe Balbi <balbi@ti.com>, Ingo Molnar <mingo@elte.hu>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--3yk1sSvxP8cRAjBs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2015 at 04:53:27PM -0300, Ezequiel Garcia wrote:
> On 26 August 2015 at 16:38, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Wed, Aug 26, 2015 at 04:29:52PM -0300, Ezequiel Garcia wrote:
> >> Felipe,
> >>
> >> On 25 August 2015 at 16:58, Felipe Balbi <balbi@ti.com> wrote:
> >> > Hi Ingo,
> >> >
> >> > I'm facing an issue with CONFIG_DEBUG_SHIRQ and pm_runtime when using
> >> > devm_request_*irq().
> >> >
> >>
> >> I may be jumping on the gun here, but I believe here's your problem.
> >> Using devm_request_irq with shared IRQs is not a good idea.
> >>
> >> Or at least, it forces you to handle interrupts after your device
> >> is _completely_ removed (e.g. your IRQ cookie could be bogus).
> >>
> >> AFAICS, the CONFIG_DEBUG_SHIRQ option is just triggering a couple
> >> spurious interrupts, that are expected to happen anyway.
> >>
> >> Your IRQ is shared, and so you may get any IRQ at any time,
> >> coming from another device (not yours).
> >>
> >> So, if I'm right, my suggestion is simple: use request_irq/free_irq
> >> and free your IRQ before you disable your clocks, remove your device,
> >> etc.
> >
> > yeah, that's just a workaround though. Specially with IRQ flags coming
> > from DT, driver might have no knowledge that its IRQ is shared to start
> > with.
> >
>=20
> Really? Is there any way the DT can set the IRQF_SHARED flag?
> The caller of devm_request_irq / request_irq needs to pass the irqflags,
> so I'd say the driver is perfectly aware of the IRQ being shared or not.
>=20
> Maybe you can clarify what I'm missing here.

hmm, that's true. Now that I look at it, DT can pass triggering flags.

> > Besides, removing devm_* is just a workaround to the real problem. It
> > seems, to me at least, that drivers shouldn't be calling
> > pm_runtime_put_sync(); pm_runtime_disable() from their ->remove(),
> > rather the bus driver should be responsible for doing so; much
> > usb_bus_type and pci_bus_type do. Of course, this has the side effect of
> > requiring buses to make sure that by the time ->probe() is called, that
> > device's clocks are stable and running and the device is active.
> >
> > However, that's not done today for the platform_bus_type and, frankly,
> > that would be somewhat of a complex problem to solve, considering that
> > different SoCs integrate IPs the way they want.
> >
> > Personally, I think removing devm_* is but a workaround to the real
> > thing we're dealing with.
> >
>=20
> I don't see any problems here: if your interrupt is shared, then you must
> be prepared to handle it any time, coming from any sources (not only
> your device). And CONFIG_DEBUG_SHIRQ does exactly that, in order to
> make sure all the drivers passing IRQF_SHARED comply with that rule.

you need to be sure of that with non-shared IRQs anyway. Also, an IRQ
which isn't shared in SoC A, might become shared in SoC B which uses the
same IP.

> So you either avoid using devm_request_irq, or you prepare your handler
> accordingly to be ready to handle an interrupt _any time_.

the handler is ready to handle at any time, what isn't correct is the
fact that clocks get gated before IRQ is freed.

There should be no such special case as "if your handler is shared,
don't use devm_request_*irq()" because if we just disable PM_RUNTIME, it
works as expected anyway.

--=20
balbi

--3yk1sSvxP8cRAjBs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV3ht0AAoJEIaOsuA1yqREqeAP/1syL/OK+0RlomOMOxn2+h2t
sh+zNBnE5VV6hgdCIkl8OkiixD/nlh6yjtUv+jqefLYRsVYUJHL00xazGbky36IB
AZi54ZBb4WEovyLlpq643JvQ/3bt8FQEALs57F8esPu4swyrsEmzh0sHc85+8CLt
VVQoenaikJ7QEvr0ghQ+CFsx/XKYF2qGNuXTzEQR9whskpxfrheALE+fheHYPBJO
NACVCWqEzvoXRwgeFk3eZrqOnnWAwgLM0i+hhCd0/8fk9OLUmaC/yEwzE8oNhEwc
LscmhZFqG76BN6S7f65+JgUGrLTDbzAsRpDUhIuHoE0/+ur8iYzXkzla5XfK2miP
Pnw2WIfWX38qySB3Kd1PsTRBOvFcdyZH4lucNO/LBcSh7FvcNfc1JQcsib1fyjpp
gAY8OQo715IDrEQcroxwqY+YWBonOZRyjPMd1CCdxNTpXso9rL5vK4IIR+0Fbx9L
ZIDw3ySqrJVWXcrMpJsjRXuVZES/pjgJCww1O709eFaTexzcMUX8xDd+hrNJiQK5
TJEoG2fY3Tu1Zz/QM9GoszGEqkxEjhooOo85MVY+3TU/71JMBsE4V0uTnozMdiEb
Tn90jnC0D8hoBXBr2+vCVoV5i6zTykON3ZsmyQ/eRf8RyZhyHhvpGMGOgY0aECSJ
Fs7YQaQcuXpleezmCOfB
=KhyX
-----END PGP SIGNATURE-----

--3yk1sSvxP8cRAjBs--
