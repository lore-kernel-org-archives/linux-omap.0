From: Felipe Balbi <balbi@ti.com>
Subject: Re: New l3-noc error with CPUFREQ_DT built-in with v4.0-rc1
Date: Mon, 23 Feb 2015 21:12:34 -0600
Message-ID: <20150224031234.GA15941@saruman.tx.rr.com>
References: <20150223235947.GC25954@atomide.com>
 <20150224015903.GP32521@atomide.com>
 <20150224022433.GB5198@saruman.tx.rr.com>
 <20150224023505.GQ32521@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33324 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832AbbBXDN0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2015 22:13:26 -0500
Content-Disposition: inline
In-Reply-To: <20150224023505.GQ32521@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2015 at 06:35:06PM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [150223 18:28]:
> > Hi,
> >=20
> > On Mon, Feb 23, 2015 at 05:59:04PM -0800, Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [150223 16:09]:
> > > > Hi Nishanth,
> > > >=20
> > > > Olof told me about a new L3 error happening on omap5-uevm with
> > > > v4.0-rc1:
> > > >=20
> > > > WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:147 l3_interrup=
t_handler+0x214/0x340()
> > > > 4000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Idle): Data =
Access in Supervisor mode during Functional access
> > > > ...
> > > >=20
> > > > I tried bisecting this with no luck, but narrowed it down to
> > > > having CONFIG_CPUFREQ_DT=3Dy causing it, while =3Dm wont' trigger
> > > > it. This got changed by commit 40d1746d2eee ("ARM:
> > > > omap2plus_defconfig: use CONFIG_CPUFREQ_DT").
> > > >=20
> > > > Any ideas?
> > >=20
> > > Hmm so setting CONFIG_CPUFREQ_DT=3Dm in arch/arm/configs/omap2plus_de=
fconfig
> > > produces the same output with make omap2plus_defconfig as with =3Dy..=
 So
> > > CPUFREQ_DT can't be the real cause of the problem.
> > >=20
> > > It's now looking like the l3-noc warning does not get triggered on
> > > every boot.
> > >=20
> > > It also seems the zImage triggering the error does not trigger the
> > > error on every boot. To trigger the error, it seems the device needs =
to
> > > be powered down for at least 10 or so seconds between the boots.
> > > So far no luck reproducing the error on v3.19.
> > >=20
> > > The easy way to reproduce is to power down omap5 for at least 10 seco=
nds,
> > > make omap2lus_defconfig on v4.0-rc1 and boot it.
> > >=20
> > > And so far it looks like next-20150204 works and next-20150209
> > > failed at once so far. But of course I would not trust anything
> > > at this point :)
> >=20
> > got a log of the failure ? Is it pointing to a device or one of the L4s?
>=20
> Well mostly the MASTER MPU TARGET L4PER2, the following stack dump is
> really the stack dump of the l3_interrupt_handler.
> =20
> > Might be worth to boot with just the bare minimum (UART & timers) and
> > disable everything else. You might need to build busybox and append that
> > to the kernel so you don't need to rely on MMC/USB/etc for rootfs.
> >=20
> > After that, you could start enabling modules one by one (as modules, not
> > built-in) and loading them one by one to see which one causes the
> > failure. Big PITA, I know, but I can't think of any other way to go
> > about this.
>=20
> It seems the best way to deal with this is to make the l3_handle_target
> actually show the address where the error happened to limit it down
> to a single device..

you can't really do that from within l3. It doesn't have enough
information to figure that out. Since it pointed you to l4per2, then you
need to decode l4per2's debug registers. That has never been
implemented, though. What happened here is that l4per2 detected the
bogus access from one of the devices attached to it and passed the error
up to l3. Since we only have l3 decoding, that's what you see and it
ends up being really cryptic.

If you decode l4per2's registers, I'm sure it'll point you to a real
device. I guess just to prove the concept, you just hack it inside l3
irq handler, though ideally we would have a real drivers/bus/omap-l4.c,
or something like that.

--=20
balbi

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU6+wiAAoJEIaOsuA1yqREO2sQALXO7cWn+fwTTF5yyHq2nixP
YYpSY1KT+QxC0HUccDod9Ge1CzvBOBn2Y+YJVbg09uSuMqI47y6oEXHyFMHgrCRO
GyB1s2/Nvxi6IysKYVwaWjAxS2bxilXSxnwzcRrd07EoCViLePgtIyQt/Tsk5SvC
Ude8DFFxo50RDkj/bEdjXFLrqxa79xRYupX14CcL/pHSFQ6w2SOIBUY/dqHk+m0A
+bLQzQnpXQUuWXh+1M26AoVULLtH7FkltZSmo1SFdUpPCDyxyMFkFj2awY0AsmhT
hETCmAlnKkNmYjD3Me6gkj/0iU6X8fqj34/4jkLqIbHUGPw4L65qLCdsF3yaY2M+
Qfk7YIydgKaF6UjoqUVci2CLCLosxY9ku6i9jJAasLmu/nqSjszBAu/+vzEQqt3M
GxLMNkgbb9MnvrA5cOOsEMAxyya3uX/G3d1Yf3aLfNt4IITZROWZCnXhldk0BcZu
D3tbKL+AXnU7oKtAQXUMj8cYYALy3VgJNtsfn+S2LTF7LIqSehTNmMU6rv1+oep3
giTvMtlTPHmGPykZuyW1euwjsME5vH0k/lS86vMowBUTpNNRnq5banHEvpyTY4K1
eB2jJpnkW3/0FmqaLffX9W4vgMLPIEUIfTt+iPKS/wp66sZnnT0woECq6lSurCH4
ETP+YDwhlAufHBA5PASI
=DX9k
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
