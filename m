From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: omap: fix "Too much work in one IRQ" irq
 handling
Date: Fri, 14 Nov 2014 19:48:59 -0600
Message-ID: <20141115014859.GC808@saruman>
References: <1416014452-6712-1-git-send-email-al.kochet@gmail.com>
 <1416014452-6712-2-git-send-email-al.kochet@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416014452-6712-2-git-send-email-al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 15, 2014 at 05:20:52AM +0400, Alexander Kochetkov wrote:
> commit 66b9298878742f08cb6e79b7c7d5632d782fd1e1 (i2c: omap: switch over
> to do {} while loop) changed the interrupt handler to abort transfers
> in case interrupt serviced 100 times but commit's comment states that
> "No functional changes otherwise.".

look at the patch again, the commit you describe is *not* the one giving
up on servicing interrupts after 100 times. That commit, really, *only*
switched over from while() {} to do {} while(), the only functional
change there is that the while loop will always execute at least once.

> Also, original commit could report status 0 (no error) on aborted transfe=
rs.

how ? This is an interesting bug which deserves further explanation.

> The patch restore original logic. In case interrupt serviced 100 times ju=
st
> quit interrupt handler and don't abort active transfer.
>=20
> Signed-off-by: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 9af7095..34b9011 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -920,7 +920,7 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
>  		dev_dbg(dev->dev, "IRQ (ISR =3D 0x%04x)\n", stat);
>  		if (count++ =3D=3D 100) {
>  			dev_warn(dev->dev, "Too much work in one IRQ\n");
> -			break;
> +			goto out;

quite frankly, this looks *very* wrong. It creates the possibility for
us never completing a command which would cause several timeouts.

How have you tested this and how have you figured this was the actual
bug ? Based on commit log not matching the patch body (which 'original
logic' are you talking about ?), I have to NAK this patch.

--=20
balbi

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZrELAAoJEIaOsuA1yqREr4sQAKSX+jsL0Wdix9tuijL8LVI1
Mlsz+4DSGcxG48tjpPN2ktTurQpwl6ajJaryLfRypCe7+pdsLBQOfTofeL35C1+1
0F2JghaODUoQUNmiJ42RaWSOIty2rP47FGuRAKBz1Eip+zKbc22c0csfwPXsWDZd
OKNAxxpQE2iuaAw0R31peP7JrGJD4jN85PBSxM7fT4gUgWk/xsXNFsiKWqoSh3cL
czXeoPOzOE5IWRbAEC7dQjcaFBKHfSUg6szvCBS0OOEQTJdNINwV+mnH5l5XKCSb
e03/RzOXrR2XiVDYJEvWR2JMEmyzjXpwcK1DlPJbV4fUg2p0PTN6O8XENDpHlbX2
USah+HNDra0T4MIhJzu6PnF8Xi4++6HTm/1qPmZyOTsGO1I+cWwNkAW1fbVJl5Sf
HQcO2LcTKWeng1YlvkwxxgXi4p2ZCaPzZsLY3oghJ4p2pcKzOTs/ypsrqCPruCLR
j4GcMSXnspPrexYKfmcof4N1vKUsiAokSMrAkIo/x62k9dRU0jd4uZZEvqozvvMB
Vk4fOetb1iDFVerNTroKneqKg/1lFK3V9RxBnvYZ4XK8l1U51ncNghbb5njDoj5R
if01royzkkTWFKgAaaPblZ5tIJjRMAbt2bVgfTMw7PlUR7reCbzBDLWwG8gM5Ldq
2FdK5Fh3IcyGDqVaB7Uo
=0cxe
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
