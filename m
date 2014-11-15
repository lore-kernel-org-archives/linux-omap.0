From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] i2c: omap: fix "Too much work in one IRQ" irq
 handling
Date: Fri, 14 Nov 2014 21:47:56 -0600
Message-ID: <20141115034756.GA2917@saruman>
References: <1416014452-6712-1-git-send-email-al.kochet@gmail.com>
 <1416014452-6712-2-git-send-email-al.kochet@gmail.com>
 <20141115014859.GC808@saruman>
 <7C4EE58D-8956-40C2-B649-775B2F551D2A@gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44768 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935166AbaKODri (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Nov 2014 22:47:38 -0500
Content-Disposition: inline
In-Reply-To: <7C4EE58D-8956-40C2-B649-775B2F551D2A@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Kochetkov <al.kochet@gmail.com>
Cc: balbi@ti.com, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(please, never top-post)

On Sat, Nov 15, 2014 at 05:37:41AM +0300, Alexander Kochetkov wrote:
> Hi Felipe,
>=20
> Initially you made the change (66b9298878742f08cb6e79b7c7d5632d782fd1e1):
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/dr=
ivers/i2c/busses/i2c-omap.c?id=3D66b9298878742f08cb6e79b7c7d5632d782fd1e1
>=20
>  		dev_dbg(dev->dev, "IRQ (ISR =3D 0x%04x)\n", stat);
>=20
>  		if (count++ =3D=3D 100) {
>  			dev_warn(dev->dev, "Too much work in one IRQ\n");
> -			break;
> +			omap_i2c_complete_cmd(dev, err);
> +			return IRQ_HANDLED;
>  		}
>=20
>=20
> Than that change transformed into (4a7ec4eda58269a507501f240955d99312fdfd=
5f):
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/dr=
ivers/i2c/busses/i2c-omap.c?id=3D4a7ec4eda58269a507501f240955d99312fdfd5f
>=20
> @@ -853,24 +853,21 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  		dev_dbg(dev->dev, "IRQ (ISR =3D 0x%04x)\n", stat);
>  		if (count++ =3D=3D 100) {
>  			dev_warn(dev->dev, "Too much work in one IRQ\n");
> -			omap_i2c_complete_cmd(dev, err);
> -			return IRQ_HANDLED;
> +			goto out;
>  		}
>=20
>=20
> +out:
> +	omap_i2c_complete_cmd(dev, err);
>  	return IRQ_HANDLED;

look how in both of these commits, omap_i2c_complete_cmd() is called as
it was before they existed. So, at a minimum, you're blaming the wrong
commit.

The commit which changed that was commit 0bdfe0c (i2c: omap: sanitize
exit path) and note how the behavior is still the same because when we
reach our counter, we will 'break' instead of 'goto out'. So, in all of
this, omap_i2c_complete_cmd() is still called just as it was before all
three commits referenced in this thread existed.

If there is a bug (which I'm not yet convinced there is), it already
existed way back.

> As a result we have in master:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/driv=
ers/i2c/busses/i2c-omap.c
>=20
> 	do {
> 		bits =3D omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
> 		stat =3D omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> 		stat &=3D bits;
> 		...
>=20
> 		dev_dbg(dev->dev, "IRQ (ISR =3D 0x%04x)\n", stat);
> 		if (count++ =3D=3D 100) {
> 			dev_warn(dev->dev, "Too much work in one IRQ\n");
> 			break;
> 		}
>                 ...
>=20
> 	} while (stat);
>=20
> 	omap_i2c_complete_cmd(dev, err);
>=20
> out:
> 	spin_unlock_irqrestore(&dev->lock, flags);

how can this be a result of the two commits you pointed above ? In which
world can the two commits you referenced result in this placement for
the 'out' label ?

'out' was moved by commit 0bdfe0c (i2c: omap: sanitize exit path), but
that still guaranteed that omap_i2c_complete_cmd() was going to be
called just as before. The logic hasn't changed, actually.

> While original code was:
>=20
> {
> 	bits =3D omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
> 	while ((stat =3D (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG))) & bits) {
> 		dev_dbg(dev->dev, "IRQ (ISR =3D 0x%04x)\n", stat);
> 		if (count++ =3D=3D 100) {
> 			dev_warn(dev->dev, "Too much work in one IRQ\n");
> 			break;
> 		}
>=20
> 		err =3D 0;
> complete:
>                 ...
>=20
> 		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
> 					OMAP_I2C_STAT_AL)) {
> 			...
> 			omap_i2c_complete_cmd(dev, err);
> 			return IRQ_HANDLED;
> 		}
> 		...
> 	}
> 	return count ? IRQ_HANDLED : IRQ_NONE;
> }
>=20
>=20
> > how ? This is an interesting bug which deserves further explanation.
>=20
> Look at the loops above, and at the omap_i2c_complete_cmd:
>=20
> static inline void
> omap_i2c_complete_cmd(struct omap_i2c_dev *dev, u16 err)
> {
> 	dev->cmd_err |=3D err;
> 	complete(&dev->cmd_complete);
> }
>=20
> You can see, loop will be aborted if counter reached 100. Final state
> of transfer depends on values stored in the 'err' and 'dev->cmd_err'.
> If 'err' and 'dev->cmd_err' are zero, than transfer would be aborted
> with status 0.

right, this is the same as it was before. If count reaches 100 we will
omap_i2c_complete_cmd().

> > quite frankly, this looks *very* wrong. It creates the possibility
> > for us never completing a command which would cause several
> > timeouts.
>=20
> Pre 66b9298878742f08cb6e79b7c7d5632d782fd1e1 omap-i2c.c version didn't
> cause deadlocks.

which deadlock are you talking about ? How do you trigger it ? Where are
the lockup debug traces ?

> > How have you tested this and how have you figured this was the actual
> > bug ? Based on commit log not matching the patch body (which 'original
> > logic' are you talking about ?), I have to NAK this patch.
>=20
> Well, I tried to debug I2C ISR hang issue (thats another question I
> want to discuss later) using output to console. I places few dev_warn

if you found a bug with the ISR, why discuss it later ? How can I
understand if you found a real bug without proper logs ?

> (not dev_dbg) messages into ISR (like got NACK, got ARDY and so on)
> and got "Too much work  in one IRQ" with incorrect booting.

what do you mean by incorrect booting ?

regards

--=20
balbi

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZszsAAoJEIaOsuA1yqREyEsP/R7cObJzOeoGJoZeYbxnv1H0
b+1XFVYGMVYUlFzspVxBglq6iOv/yW7m+wRJggZcZSeWrKFpBzRl9InqYUYibJWl
rsAeJp42GYwK4hokDY8PBUMMZzPZ3SpV4W4LzLoVYVOXz51L/2jYkCcPHiFJGnCC
ZCkZvWHFSefPypqN6GS3xM+3MEgRYftu4Z9UXBFs2CuCaT5u0PrWM9G7RcJKwzLU
14iDNjpy+HJMzfjeUf8Uc8mvt2o8Me7x00bJpPgfn+6qTci+YudSJ6K5xZUB+MLU
0W+Mbi4OrCD+apDwQhvBM8caUBbE4505rC+ig6XilOVmZ20jzOJ9Pz7lXf/N/4L+
GKc4ooxOkGP+8faBcPAUPE3MT1hSuhMlNApQbQpFA143YCvor+Rf9A7SycoFpBwA
3YJd3jorO4TUKSs2ElbQIg8DtX1O3EBBNFRADJpi+tS4cTaxyvbznPYmIcXf93Tf
NxVZKjuBxwz+Fabc/yT6Mth10GvCgFDiQkUvHrtLEdcFKP7CLjd1pocfcGwttauc
OdTvjAAiiy09WrODqAYppMfwsfJCLvcE7bAIgWLJdXGqxGxp+7eBI0iHPCmOC2wt
TSXd5yV3J+2akocNMb+ylC84/Q0yIKxP+jlYIK3dwkxUcw3Ym7M6O4fwtUS09Bul
w1Nk1veuGxdjNP4YI3Fv
=qjgv
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
