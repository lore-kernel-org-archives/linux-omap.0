From: Mark Brown <broonie@kernel.org>
Subject: Re: Regulator regression in next-20180305
Date: Tue, 6 Mar 2018 16:30:35 +0000
Message-ID: <20180306163035.GE13586@sirena.org.uk>
References: <20180305231246.GB5799@atomide.com>
 <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yb+qhiCg54lqZFXW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Maciej Purski <m.purski@samsung.com>, linux-omap@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--Yb+qhiCg54lqZFXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2018 at 08:22:26PM -0300, Fabio Estevam wrote:
> On Mon, Mar 5, 2018 at 8:12 PM, Tony Lindgren <tony@atomide.com> wrote:

> > Looks like with next-20180305 there's a regulator regression
> > where mmc0 won't show any cards or produces errors:

> > mmcblk0: error -110 requesting status
> > mmc1: new high speed SDIO card at address 0001
> > mmcblk0: error -110 requesting status
> > mmcblk0: recovery failed!
> > print_req_error: I/O error, dev mmcblk0, sector 0
> > Buffer I/O error on dev mmcblk0, logical block 0, async page read
> > mmcblk0: error -110 requesting status
> > mmcblk0: recovery failed!

No other error messages?  That seems like there's something going on
that's very different to what Fabio was reporting...  I'm guessing some
voltage application didn't go through but it's hard to tell with so
little data.  dra7 does seem to have what Fabio had though so there's
definitely some effect on the OMAP platforms.

> I have also seen regulator issues due to this series:
> https://lkml.org/lkml/2018/3/5/731

Looking at your stuff I'm having trouble figuring out what's going on -
we're getting double locking of a parent regulator during enable
according to your backtraces but it's not clear to me what took that
lock already.  regulator_enable() walks the supplies before it takes
the lock on the regulator it's immediately being called on, not holding
any locks on supplies while enabling.  regulator_balance_voltage() then
tries to lock the supplies again but lockdep says the lock is already
held by regulator_enable().  It's also weird that this doesn't seem to
be showing up on other boards in kernelci, the regulator setup on those
i.MX boards looks to be quite simple so I'd expect a much wider impact.

I'm wondering if your case is more pain from mutex_lock_nested(), both
regulator_lock_coupled() and regulator_lock_supply() will end up using=20
indexes starting at 0 for the locking classes.  That doesn't smell right
though, but in case my straw clutching works:

If we can't figure it out I'll just drop the series but I'd prefer to at
least understand what's going on.

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e685f8b94acf..2c5b20a97f51 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -159,7 +159,7 @@ static void regulator_lock_supply(struct regulator_dev =
*rdev)
 {
 	int i;
=20
-	for (i =3D 0; rdev; rdev =3D rdev_get_supply(rdev), i++)
+	for (i =3D 1000; rdev; rdev =3D rdev_get_supply(rdev), i++)
 		mutex_lock_nested(&rdev->mutex, i);
 }
=20

--Yb+qhiCg54lqZFXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqewioACgkQJNaLcl1U
h9Bx+wf/S3swz2uKSJ5y19NvOIHzMsSOtAoS4mvk/oMR9d1GyKZV1PFbkndwr3vP
4p96oKTEzKDQi0+rDCM1Rohf6rWrFzVL4uSUEqhIUNmJuBrUp5qlgPpaXYRDN1bP
UXNQoji+imP+OTD+A98SJQfgfALSh4qaPsK/8S+fis5hK7NMlYZfiDDQAyrns4RV
BiSgPoHiLNWIFxMCIF4Ecx+CtcaEBOUJYmUlbc22c7qDkrvGgycFQ2RhprUnWCJH
fjCG4/8YDYAdiVxsNeOeyVK/6BmUTvETjCW3c1UZS5oNTsDt871Lng5QHhtVfr2A
d1CPG/WcdEFgPH3ztRV2kMisAApWLA==
=fsPY
-----END PGP SIGNATURE-----

--Yb+qhiCg54lqZFXW--
