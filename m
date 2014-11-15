From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: omap: fix NACK and Arbitration Lost irq handling
Date: Fri, 14 Nov 2014 19:43:36 -0600
Message-ID: <20141115014336.GB808@saruman>
References: <1416014452-6712-1-git-send-email-al.kochet@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416014452-6712-1-git-send-email-al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2014 at 05:20:51AM +0400, Alexander Kochetkov wrote:
> commit 1d7afc95946487945cc7f5019b41255b72224b70 (i2c: omap: ack IRQ in pa=
rts)
> changed the interrupt handler to complete transfers without clearing
> XRDY (AL case) and ARDY (NACK case) flags. XRDY or ARDY interrupt will be
> fired again (in parallel with omap_i2c_xfer_msg). Interrupt handler will
> complete transfers second time. As a result, NACK and AL transfers
> terminates with "transfer timeout" and sometimes client code segfault.
>=20
> The patch restore original logic of handling NACK and AL interrupts and
> fix race between interrupt handler and omap_i2c_xfer_msg (for AL and
> NACK case only).
>=20
> Tested on Beagleboard XM C.
>=20

Assuming this is really correct (I haven't tested), you need to add:

Fixes: 1d7afc9 i2c: omap: ack IRQ in parts
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.7+

here and resend, so it gets backported to older kernels.

> Signed-off-by: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |    2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 90dcc2e..9af7095 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -926,14 +926,12 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
>  		if (stat & OMAP_I2C_STAT_NACK) {
>  			err |=3D OMAP_I2C_STAT_NACK;
>  			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
> -			break;
>  		}
> =20
>  		if (stat & OMAP_I2C_STAT_AL) {
>  			dev_err(dev->dev, "Arbitration lost\n");
>  			err |=3D OMAP_I2C_STAT_AL;
>  			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_AL);
> -			break;
>  		}
> =20
>  		/*
> --=20
> 1.7.9.5
>=20

--=20
balbi

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZq/IAAoJEIaOsuA1yqREhYMP/R8v7SJo12+TfmAnIw/hQ/Ij
j66njArDCzUbVnlEp0PpNR0LUaNZwiuTSPNBYnclNqNpXQXEqfDdeotxkYHTQ9b8
eq3nLDbvOJfS3gFCXnEFP2lxcwogF2CtiLLUHdKIvIiPhG3ALXhuMHWLd4mppxYa
69bHqWvK/yzLxpY1sJTf4AFjf6AqKnigoCTUcnuKUAbtV2vAQRABzeXn2NhCjqFk
A7PmoEYZAfLRxk0VvrNdTgmOjjAvv/RHAxaxwOEstsJuhEQATUxn7uRbtfENgUD3
lsUWct+cc/ZqC5WXLvvWnOPzhjlQO+x/qpNQW0fVrGWbJsHEnNhGbURiXGhZTiVe
tASYHAtow69FIqHhru6aFih8KcTISUUG8fZj45Elo/5XFJLGTiG0Sl/u0OQgMbiA
+gqSky1Mxk3l8QyO67XFi+wxDp1KRDLrSHEUwbyFtB+kmKQtunwrCLY9kxlJ+Nll
9iMnS9zYelyLNRqzqo05l2NI+QXUSfMFo9eIXuA9qJCMyApi+aJu6RDpjYUCbQ2P
Y/JLoz2LVaoUzJjpsYFaS4P2suJym7a0hEOM77M2OSYTtx8/oHJQFLjjaH2T5QWy
HkoHZ8Fzkcqtg8VlivzwgtqY5IAumvvsT9oO6T4tiTOvEmXI2wI9abjofZdp7B44
qnHzXCIUVAtHO0y7xAtI
=J9rF
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
