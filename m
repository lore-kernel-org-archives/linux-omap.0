From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.8-rc3
Date: Tue, 15 Jan 2013 10:55:30 +0200
Message-ID: <20130115085530.GA4350@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1301141756460.20390@utopia.booyaka.com>
 <20130114184018.GA18224@blackmetal.musicnaut.iki.fi>
 <20130114191459.GA9402@arwen.pp.htv.fi>
 <20130114204654.GB18224@blackmetal.musicnaut.iki.fi>
 <20130114211846.GA10699@arwen.pp.htv.fi>
 <20130114224222.GC18224@blackmetal.musicnaut.iki.fi>
 <20130115073225.GB14505@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46188 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756491Ab3AOIzp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jan 2013 03:55:45 -0500
Content-Disposition: inline
In-Reply-To: <20130115073225.GB14505@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(quick parens here)

I think n900's problems will go away if you add omap_i2c_wait_for_ardy()
=66rom my patchset.

On Tue, Jan 15, 2013 at 09:32:25AM +0200, Felipe Balbi wrote:
> > [    4.281280] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
> > [    4.281433] twl 1-0048: power (irq 343) chaining IRQs 346..353
> > [    4.281616] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D1
> > [    4.281677] i2c i2c-1: master_xfer[1] R, addr=3D0x49, len=3D1
> > [    4.281707] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x0, s=
top: 0
> > [    4.281799] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
> > [    4.281829] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x1, s=
top: 1
> > [    4.281921] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
> > [    4.296905] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D2
> > [    4.296936] omap_i2c omap_i2c.1: addr: 0x0049, len: 2, flags: 0x0, s=
top: 1
> > [    4.296997] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
> > [    4.313476] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs =
354..371
> >=20
> > This log excerpt has only 3 transfers, but the time duration is already
> > 10x longer compared to vanilla 3.8-rc3.
>=20
> weird, there's nothing extremely expensive added by my patchset, I'll go
> over them and try to figure out what's going on.
>=20
> Thanks for notifying me about it.

Here's from v3.8-rc3 vanilla (just added two small prints):

[    1.688079] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x0, stop:=
 0
[    1.688110] omap_i2c omap_i2c.1: starting transfer
[    1.688140] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    1.688201] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    1.688232] omap_i2c omap_i2c.1: finishing transfer
[    1.688232] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x1, stop:=
 1
[    1.688262] omap_i2c omap_i2c.1: starting transfer
[    1.688354] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    1.688354] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    1.688385] omap_i2c omap_i2c.1: finishing transfer
[    1.688415] i2c i2c-1: master_xfer[0] W, addr=3D0x48, len=3D2
[    1.688446] omap_i2c omap_i2c.1: addr: 0x0048, len: 2, flags: 0x0, stop:=
 1
[    1.688446] omap_i2c omap_i2c.1: starting transfer
[    1.688476] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    1.688568] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    1.688598] omap_i2c omap_i2c.1: finishing transfer
[    1.688629] i2c i2c-1: master_xfer[0] W, addr=3D0x48, len=3D1
[    1.688659] i2c i2c-1: master_xfer[1] R, addr=3D0x48, len=3D6
[    1.688659] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x0, stop:=
 0
[    1.688690] omap_i2c omap_i2c.1: starting transfer
[    1.688720] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    1.688781] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    1.688812] omap_i2c omap_i2c.1: finishing transfer
[    1.688812] omap_i2c omap_i2c.1: addr: 0x0048, len: 6, flags: 0x1, stop:=
 1

and here's from my patchset:

[    1.993865] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x0, stop:=
 0
[    1.993896] omap_i2c omap_i2c.1: starting transfer
[    1.993927] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    1.993957] omap_i2c omap_i2c.1: finished transfer
[    1.993988] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x1, stop:=
 1
[    1.993988] omap_i2c omap_i2c.1: starting transfer
[    1.994079] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    1.994110] omap_i2c omap_i2c.1: finished transfer
[    2.009490] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D2
[    2.009490] omap_i2c omap_i2c.1: addr: 0x0049, len: 2, flags: 0x0, stop:=
 1
[    2.009521] omap_i2c omap_i2c.1: starting transfer
[    2.009552] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    2.009582] omap_i2c omap_i2c.1: finished transfer
[    2.025054] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D1
[    2.025054] i2c i2c-1: master_xfer[1] R, addr=3D0x49, len=3D1
[    2.025085] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x0, stop:=
 0
[    2.025085] omap_i2c omap_i2c.1: starting transfer
[    2.025146] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    2.025177] omap_i2c omap_i2c.1: finished transfer
[    2.025177] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x1, stop:=
 1
[    2.025207] omap_i2c omap_i2c.1: starting transfer
[    2.025268] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    2.025329] omap_i2c omap_i2c.1: finished transfer
[    2.040679] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D2
[    2.040710] omap_i2c omap_i2c.1: addr: 0x0049, len: 2, flags: 0x0, stop:=
 1
[    2.040710] omap_i2c omap_i2c.1: starting transfer
[    2.040771] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    2.040802] omap_i2c omap_i2c.1: finished transfer

Looks like the transfer itself is faster with my patchset. I don't have
an idea of what's causing extra delay, for whatever reason client driver
seems to take longer to start more i2c transfers. I've added extra
prints to see what's going on:


| [    1.818725] omap_i2c omap_i2c.1: pm_runtime_get_sync()
| [    1.818725] omap_i2c omap_i2c.1: omap_i2c_wait_for_bb()
| [    1.818725] omap_i2c omap_i2c.1: omap_i2c_xfer_msg()
| [    1.818756] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x0, sto=
p: 0
| [    1.818756] omap_i2c omap_i2c.1: starting transfer
| [    1.818786] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
| [    1.818847] omap_i2c omap_i2c.1: finished transfer
| [    1.818847] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x1, sto=
p: 1
| [    1.818847] omap_i2c omap_i2c.1: starting transfer
| [    1.818939] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
| [    1.818969] omap_i2c omap_i2c.1: finished transfer
| [    1.819000] omap_i2c omap_i2c.1: waiting for ARDY
| [    1.819000] omap_i2c omap_i2c.1: ARDY
| [    1.819000] omap_i2c omap_i2c.1: 2. omap_i2c_wait_for_bb()
| [    1.819030] omap_i2c omap_i2c.1: pm_runtime_mark_last_busy()
| [    1.819030] omap_i2c omap_i2c.1: return
| [    1.819061] i2c i2c-1: master_xfer[0] W, addr=3D0x48, len=3D1
| [    1.819061] i2c i2c-1: master_xfer[1] R, addr=3D0x48, len=3D1
| [    1.819091] omap_i2c omap_i2c.1: pm_runtime_get_sync()
| [    1.819091] omap_i2c omap_i2c.1: omap_i2c_wait_for_bb()
| [    1.819122] omap_i2c omap_i2c.1: omap_i2c_xfer_msg()
| [    1.819122] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x0, sto=
p: 0
| [    1.819122] omap_i2c omap_i2c.1: starting transfer
| [    1.819183] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
| [    1.819213] omap_i2c omap_i2c.1: finished transfer
| [    1.819213] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x1, sto=
p: 1
| [    1.819244] omap_i2c omap_i2c.1: starting transfer
| [    1.819305] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
| [    1.819366] omap_i2c omap_i2c.1: finished transfer
| [    1.819366] omap_i2c omap_i2c.1: waiting for ARDY
| [    1.819366] omap_i2c omap_i2c.1: ARDY
| [    1.819396] omap_i2c omap_i2c.1: 2. omap_i2c_wait_for_bb()
| [    1.819396] omap_i2c omap_i2c.1: pm_runtime_mark_last_busy()
| [    1.819396] omap_i2c omap_i2c.1: return
| [    1.819427] i2c i2c-1: master_xfer[0] W, addr=3D0x48, len=3D1
| [    1.819458] i2c i2c-1: master_xfer[1] R, addr=3D0x48, len=3D1
| [    1.819458] omap_i2c omap_i2c.1: pm_runtime_get_sync()
| [    1.819458] omap_i2c omap_i2c.1: omap_i2c_wait_for_bb()
| [    1.819488] omap_i2c omap_i2c.1: omap_i2c_xfer_msg()
| [    1.819488] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x0, sto=
p: 0
| [    1.819519] omap_i2c omap_i2c.1: starting transfer
| [    1.819549] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
| [    1.819580] omap_i2c omap_i2c.1: finished transfer
| [    1.819580] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x1, sto=
p: 1
| [    1.819610] omap_i2c omap_i2c.1: starting transfer
| [    1.819671] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
| [    1.819732] omap_i2c omap_i2c.1: finished transfer
| [    1.819732] omap_i2c omap_i2c.1: waiting for ARDY
| [    1.819732] omap_i2c omap_i2c.1: ARDY
| [    1.819763] omap_i2c omap_i2c.1: 2. omap_i2c_wait_for_bb()
| [    1.819763] omap_i2c omap_i2c.1: pm_runtime_mark_last_busy()
| [    1.819793] omap_i2c omap_i2c.1: return

as you can see, from pm_runtime_get_sync() to return, the time spent is
about the same in all cases (around 305us).

one thing I note, however, is that after we start waiting for ARDY,
there's no point in "omap_i2c_wait_for_bb()" since I only exit
omap_i2c_xfer_msg() after all bytes have been unloaded on SDA line.

Removing that saves some extra time (about 30us):

[    1.751983] omap_i2c omap_i2c.1: pm_runtime_get_sync()
[    1.751983] omap_i2c omap_i2c.1: omap_i2c_xfer_msg()
[    1.751983] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x0, stop:=
 0
[    1.752014] omap_i2c omap_i2c.1: starting transfer
[    1.752044] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    1.752075] omap_i2c omap_i2c.1: finished transfer
[    1.752105] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x1, stop:=
 1
[    1.752105] omap_i2c omap_i2c.1: starting transfer
[    1.752197] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    1.752227] omap_i2c omap_i2c.1: finished transfer
[    1.752227] omap_i2c omap_i2c.1: waiting for ARDY
[    1.752258] omap_i2c omap_i2c.1: ARDY
[    1.752258] omap_i2c omap_i2c.1: pm_runtime_mark_last_busy()
[    1.752258] omap_i2c omap_i2c.1: return
[    1.752288] i2c i2c-1: master_xfer[0] W, addr=3D0x48, len=3D2
[    1.752319] omap_i2c omap_i2c.1: pm_runtime_get_sync()
[    1.752319] omap_i2c omap_i2c.1: omap_i2c_xfer_msg()
[    1.752349] omap_i2c omap_i2c.1: addr: 0x0048, len: 2, flags: 0x0, stop:=
 1
[    1.752349] omap_i2c omap_i2c.1: starting transfer
[    1.752380] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    1.752410] omap_i2c omap_i2c.1: finished transfer
[    1.752441] omap_i2c omap_i2c.1: waiting for ARDY
[    1.752441] omap_i2c omap_i2c.1: ARDY
[    1.752471] omap_i2c omap_i2c.1: pm_runtime_mark_last_busy()
[    1.752471] omap_i2c omap_i2c.1: return

For whatever reason, in some cases client driver takes longer to
initiate a transfer and I don't think there's anything we can do about
that during boot up.

Anyway, whenever I can see a big delay, it's always from "return" to the
next "i2c i2c-1: master_xfer[0] W, addr=3D0x48, len=3D1" message.

--=20
balbi

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ9RmCAAoJEIaOsuA1yqRE5BwP/jVfyEVsONsi+nBt4fGa2+J0
Z8QGzk9/mwqvlMTRct8tYrsmCg3cQzojOxkd2gWqlPxcDtuRi1ylyPFl8U8/XD0w
keEhBZJMRfzz2kELRyQcOixToL2ZES3OqV+DMIOuSttQ2MU4Lzr8IZcMbfSStJv1
txfFTffZtcJWhBEwwOfkygd+JJWAuT5R9xnysKiV+rhlRnp3o7bhTZue9YDS+2yW
hqhprj0MWR5TnhvNiC1w52xGxqIu2cRigXiyc8pMY62sz1q2P2Um9t583LLh62s3
A0CMzxn5h/iXyY3iz79QU7TMTYppBOhDhhtsYRjFnoHeIa/6G7E0GYFJbJhI6ulR
qpCdcZHELE2el/OorkiraEcvo7/QPc7Qr2A62Yw9fgscXgAir9rFWTlG/OEIRYtU
vvrWqr939ifNLZ7bWNmAClVBMmCLHAThlwjH1+1MOvEKE7smNOasESuQ2hTNaozQ
gggWI1X4NLpYRlGJsd5/ot7jmrYuVl4zXLbG4o+XOBI6Y5FiXriJVNmbcnuRi9Qk
OZuXcKXCqwDUFD2sMgBt4oG9IxhUbiMPK1IrK7QQuQ1beBV6j8O+btSzDnY9LC9S
t9v8WZisi+rMQzRRP69bHuM2PZKvc/Acn28krpY+db7CnLZSkdMacCzG5eJX0sLq
5xcuKtNtCz20w0/ILcq3
=awS3
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
