From: Felipe Balbi <balbi@ti.com>
Subject: Re: CONFIG_DEBUG_SHIRQ and PM
Date: Wed, 26 Aug 2015 14:38:20 -0500
Message-ID: <20150826193820.GT14625@saruman.tx.rr.com>
References: <20150825195830.GH27534@saruman.tx.rr.com>
 <CAAEAJfCY1BRuoQCWfD2pCq36E54vDB5Coy2S7rz3RfL2BVLGaw@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HjGz34yYE1BNnn/x"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAEAJfCY1BRuoQCWfD2pCq36E54vDB5Coy2S7rz3RfL2BVLGaw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Felipe Balbi <balbi@ti.com>, Ingo Molnar <mingo@elte.hu>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--HjGz34yYE1BNnn/x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 26, 2015 at 04:29:52PM -0300, Ezequiel Garcia wrote:
> Felipe,
>=20
> On 25 August 2015 at 16:58, Felipe Balbi <balbi@ti.com> wrote:
> > Hi Ingo,
> >
> > I'm facing an issue with CONFIG_DEBUG_SHIRQ and pm_runtime when using
> > devm_request_*irq().
> >
>=20
> I may be jumping on the gun here, but I believe here's your problem.
> Using devm_request_irq with shared IRQs is not a good idea.
>=20
> Or at least, it forces you to handle interrupts after your device
> is _completely_ removed (e.g. your IRQ cookie could be bogus).
>=20
> AFAICS, the CONFIG_DEBUG_SHIRQ option is just triggering a couple
> spurious interrupts, that are expected to happen anyway.
>=20
> Your IRQ is shared, and so you may get any IRQ at any time,
> coming from another device (not yours).
>=20
> So, if I'm right, my suggestion is simple: use request_irq/free_irq
> and free your IRQ before you disable your clocks, remove your device,
> etc.

yeah, that's just a workaround though. Specially with IRQ flags coming
=66rom DT, driver might have no knowledge that its IRQ is shared to start
with.

Besides, removing devm_* is just a workaround to the real problem. It
seems, to me at least, that drivers shouldn't be calling
pm_runtime_put_sync(); pm_runtime_disable() from their ->remove(),
rather the bus driver should be responsible for doing so; much
usb_bus_type and pci_bus_type do. Of course, this has the side effect of
requiring buses to make sure that by the time ->probe() is called, that
device's clocks are stable and running and the device is active.

However, that's not done today for the platform_bus_type and, frankly,
that would be somewhat of a complex problem to solve, considering that
different SoCs integrate IPs the way they want.

Personally, I think removing devm_* is but a workaround to the real
thing we're dealing with.

--=20
balbi

--HjGz34yYE1BNnn/x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV3hWsAAoJEIaOsuA1yqREYV4QAICEVNU8BDCLm9jWGp1PX+/W
qA3pIZlPhWDhnVGj6ryjygXh7IKBUXwmOAdli7JQA7OernXBlzxxY8lXE2dVw3c6
DF1v8aQV217QeXN0jHobWA5WZTyX4V60qCfXB0oDTPsA1J2qcehXgksKju9EEoJO
YnQfUZVijtgNIyYJmJLSVb2khOP/+s0VNgawgi2nKW7PltDREfjZx4YjL7foJnPS
WUd/SOT4Ifw5FIysXAKsC6M6FMQrvVb/KmK3+NdyTPeC39Muc4MEilYA3J0dMRKA
lry/PixoGbSq3VpgIq/e5yFUwiLyzwQFPIsavvqA8ClF9CWmArBSLAJZ+s2GYdoJ
u7TXYuWbx30tcfcaICCpHOtqP2ox6Jpdza9RpyTlNsxeEfHfiEpdDf+8UfBq6AHF
H4+pVj4vGAFpJi0MQCJCuuXnokKDoCOYlJsvKZbzr+DStWvwefs9ND3L86NfCtt2
ghczxv87YLwnULV+JfezdqZQgDBe0gVrjKd00bRLmt7YI+Bclz90Ee/Pagf75Zjd
Xvzry5yzF1lappNyHxhlEgwGHP3wcFzjLv/isOFCk0now1KgvOLoWx8amlH0d//j
9Rbmy++RLqamwXJppuPCWer4O/rLF0Nyh6OAkip9i+krNEwXI/HZTn+9KR9Z4tRk
GNJKkM5YLxHe9yTxk7p7
=aWj6
-----END PGP SIGNATURE-----

--HjGz34yYE1BNnn/x--
