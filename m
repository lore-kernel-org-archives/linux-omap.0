From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: omap: fix "Too much work in one IRQ" irq
 handling
Date: Tue, 18 Nov 2014 10:38:27 -0600
Message-ID: <20141118163827.GA6179@saruman>
References: <1416014452-6712-2-git-send-email-al.kochet@gmail.com>
 <20141115014859.GC808@saruman>
 <7C4EE58D-8956-40C2-B649-775B2F551D2A@gmail.com>
 <20141115034756.GA2917@saruman>
 <20141115035328.GA3289@saruman>
 <A47891AC-7453-43F0-9196-5133A1525C68@gmail.com>
 <20141116154558.GA7422@saruman>
 <20141117144152.GA12644@katana>
 <20141118160059.GI8223@saruman>
 <5D39428D-F359-4F04-8ACC-D607011B88B9@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5D39428D-F359-4F04-8ACC-D607011B88B9-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2014 at 07:31:44PM +0300, Alexander Kochetkov wrote:
>=20
> > Still, as of now we can't consider what Alexander mentions a bug. Good
> > to get it sorted out, but not -rc material.
> >=20
>=20
> Actually, I focused on fixing issues then i2c-omap acts as master in a
> multi master environment.

but that's not supported either. If you wanna do that, then go through
the TRM and implement what's missing. Then give a good commit log
explaining the issues and how you solved them :-)

Still not -rc material :-)

> And must say, that current linux/mainline driver work perfectly with
> minor fixes.

that's good to know. I know some folks still have a few hick ups. The IP
isn't all that great, I'm afraid.

> I could take a look how to switch the driver into mixed master/slave
> mode, but later.
>=20
> Sad to say, I encountered undocumented i2c- hardware issue.
> In short: BB-bit doesn't reflect I2C-bus state after soft reset if SDA
> or SCL line was low during reset until i2c-controller again detect
> START or STOP condition on the wire.

this is another of those which really deserves a mention in code comment
or commit log :-)

> More over, if SDA was low during reset, than next submitted transfer
> will not start ("controller timeout"), if SCL was low during reset,
> than next submitted transfer will start and corrupt signals on wire :(

another thing to add as comment to code :-)

> I'm checking it now. And going to post results to ti forum.
>=20
> BB-bit reflect I2C-bus state, between power-down/power-up modes.

alright, thanks.

--=20
balbi

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUa3YDAAoJEIaOsuA1yqREGmkP/2CT+QgzyOqKihN3hvMTyLnf
bZyjRl3pJYJKSHuqmAzLab6+PXankDLeUDXpDCpheUR8ejpOQJvMBI5esoIXic9o
WouA4rsZEQtEl+3SoYVCIOURcaJkBCKNiMmD6OFDAkl7aBHI5X1BHic/reS3mpr5
4dx+F5K8+beNIPiTGnGOE056s+xClMIiqJw2tjJQHE70Q8ee2swmnMcVJyM9COrx
WxI0avC+Pw9VCFeow6gFeraiCnITRtrZSZvs6nuwm+d7Xn0WxVQtW+UetRGfJVR7
ASob+Wq8/g6dH+qJNxsz17UzPc4HWFRQcmuGjRlFQ8keGBJEUK0lO405bkSeJfw7
ju9/9yeNIkdivAOtpjCHEl6DamiiQEs3VBE4+3zUNowWV55Hy4Gm1bb8OYC22OtF
pVMBrwASe3gWNKp9PQ52+iH2UTMB9AlWko5dJX9dDONcUcGacLGHK4GpiRnDTyVK
bWhPpAhAVytTgZzCxMQPcRZfPUOcx4CthWLHZy1wBtnCk26z9aDAk1h/QqFzllBj
Ib2iCLLeAd2zY4D0wrk9yOvSou6U0F9O+4V2DsYH4pwmSqOgvPBoTgAbdQL07cgq
ctWQ2ubDusbNcHunOiEm/7DEpC8y23HeG5XLipovkbwWEuUZ1MH1S5zxOgj0e7bN
hhq/wHujel9NgfCITMwo
=kxPn
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
