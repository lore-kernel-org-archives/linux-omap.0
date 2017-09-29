From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] i2c-omap: Trigger bus recovery in lockup case
Date: Fri, 29 Sep 2017 18:37:16 +0200
Message-ID: <20170929163716.nprxehj7eyld4io5@earth>
References: <1505403549-12992-1-git-send-email-claudio.foellmi@ergon.ch>
 <9d3e3029-f775-a9aa-8025-badccb699ed8@ti.com>
 <48ddc9bc-2b83-97c9-fbd7-90d4da9f2687@ti.com>
 <0a506277-6c9b-1407-dea3-f9895fdc3e63@ergon.ch>
 <cbb3aaa2-44d1-8a7d-1d8e-1433b0a7b9d3@ti.com>
 <3778fa75-0327-0c36-1721-e89e23a782b6@ergon.ch>
 <20170929125213.by5mwverw2a47lmo@earth>
 <ad684ace-272a-1e45-f65b-b280be86ffc2@ergon.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x773wkzvxrf5fd5b"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ad684ace-272a-1e45-f65b-b280be86ffc2@ergon.ch>
Sender: linux-i2c-owner@vger.kernel.org
To: Claudio Foellmi <claudio.foellmi@ergon.ch>
Cc: Vignesh R <vigneshr@ti.com>, "Strashko, Grygorii" <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Cooper Jr., Franklin" <fcooper@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Wolfram Sang <wsa@the-dreams.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--x773wkzvxrf5fd5b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 29, 2017 at 05:17:47PM +0200, Claudio Foellmi wrote:
> >> Sebastian, can you please check if this helps with your problems on N9=
50?
> >> If it does, I'll turn it into a proper standalone patch.
> >=20
> > No, it does not. Also no interrupts ignoring messages appearing
> > in dmesg:
> >=20
> > n950# dmesg | grep -E "48072000.i2c|lp5523x"
> > [    0.791046] omap_i2c 48072000.i2c: bus 1 rev4.4 at 400 kHz
> > [    4.934265] lp5523x 1-0032: reset command sent (no ACK)!
> > [    6.003875] omap_i2c 48072000.i2c: controller timed out
> > [    6.033874] lp5523x 1-0032: device detection err: -110
> > [    6.039154] lp5523x: probe of 1-0032 failed with error -110
> >=20
>=20
> Hi Sebastian
>=20
> Thank you for trying it out.
> It seems that your symptoms are quite different from the ones that Vignesh
> described earlier. He had never-ending storms of spurious interrupts
> (which that patch would have addressed), but you don't seem to get
> any interrupts at all. Not even the NACK one, which just looks wrong.
>=20
> If you want to still dig deeper, you can enable debug logs for i2c-omap,
> so you can see every single interrupt. But if there are none, I don't see
> what we could possibly do to fix it.
>=20
>=20
> Vignesh, do you still have access to any of those devices with interrupt
> floods? If so, could you try the previous patch on one of them?
>=20
> Also note that Sebastian's issue is definitely not caused (or helped)
> by bus recovery, the timeout he sees resets the adapter right away.
> So he is not affected by my original patch either way.
>=20
> -- Claudio

Yeah, I don't see IRQ storm, so this might be a different issue.
FWIW this is what I see on N950:

n950# dmesg | grep -E "48072000.i2c|lp55"
[    2.136383] omap_i2c 48072000.i2c: bus 1 rev4.4 at 400 kHz
[    8.212951] omap_i2c 48072000.i2c: addr: 0x0032, len: 2, flags: 0x0, sto=
p: 1
[    8.213287] omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)
[    8.213592] omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0002)
[    8.213897] lp5523x 1-0032: reset command sent (no ACK)!
[    8.242462] omap_i2c 48072000.i2c: addr: 0x0032, len: 2, flags: 0x0, sto=
p: 1
[    8.243255] omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0014)
[    8.243469] omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)
[    8.253387] omap_i2c 48072000.i2c: addr: 0x0032, len: 1, flags: 0x0, sto=
p: 0
[    8.253631] omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)
[    9.272735] omap_i2c 48072000.i2c: controller timed out
[    9.278167] lp5523x 1-0032: device detection err: -110
[    9.283843] lp5523x: probe of 1-0032 failed with error -110
[    9.662780] omap_i2c 48072000.i2c: addr: 0x0060, len: 1, flags: 0x0, sto=
p: 0
[    9.670166] omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)
[    9.675659] omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
[    9.682617] omap_i2c 48072000.i2c: addr: 0x0060, len: 1, flags: 0x1, sto=
p: 1
[    9.689819] omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0008)
[    9.695007] omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)

-- Sebastian

--x773wkzvxrf5fd5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnOdrkACgkQ2O7X88g7
+pprhQ//XEhj56O0FrYJnFA2EbQPnIVq7PmY298Uv7GMzlFLuvnX16UGcQ+tkko1
35ZMM4EgzGh+HC+yAZcODCMrAD0253CDSbOnqQb6lkW7JTW4haEpD/5b6E1V28A0
NdaeA68bYaCGiPTZ50Nnq+oUct44cdfqH/FWDjiSNV4K082UbaWgT2uPKPXTvb9p
w4XMFywr0v9HUuii8rNBoEte6u6pdrMtSHan6AEcpaEXPjakjQzWGLQAp24qvSVR
TRlLoK44Ink1LrWmtaCJiL9h3JBaxMaW9L5vzgy7pzK7F30GLv0xvk59wUl6ai0S
tvm+L2+5gY3s1i3f//6acZZtGVZh9rCj5Xkrs9dTHIB/pCNEfIiJkYwiJ6dBLUAD
fD6tUBuMe8OnjHNOB8mxt45GrZl981HNmTDdv8R2GDG2qbrPjPADrO75/tnsxKqJ
fvgl4Fsa4vXUE3Cn4L2c1NFc+pqf7O4wbF9ceYuH8uoIxQ+S4R/wrnJygT7X4Hdb
XTZBaeyKqxqi3c9SQpCDlaeqirBgmMZdYb1rTvBikap0AD/20mTvaZP22KGv/OVj
WxsPxYf3IWuRd051fSBPLKYtGjDd/Rg2q6ga7eFGKX4jWwUeJuCTmbtS8Z6bK+PW
dRcPICgwwP+3KJzfYBmYp6cvEAqnWwVTtYM/MfXir1g2b875gdI=
=Tt2z
-----END PGP SIGNATURE-----

--x773wkzvxrf5fd5b--
