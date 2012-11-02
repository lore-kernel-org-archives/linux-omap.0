From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: ensure writes to dev->buf_len are ordered
Date: Fri, 2 Nov 2012 10:54:47 +0200
Message-ID: <20121102085447.GE17063@arwen.pp.htv.fi>
References: <1351155648-20429-1-git-send-email-balbi@ti.com>
 <20121101222316.GC22956@pengutronix.de>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121101222316.GC22956-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 01, 2012 at 11:23:16PM +0100, Wolfram Sang wrote:
> On Thu, Oct 25, 2012 at 12:00:48PM +0300, Felipe Balbi wrote:
> > if we allow compiler reorder our writes, we could
> > fall into a situation where dev->buf_len is reset
> > for no apparent reason.
> >=20
> > This bug was found with a simple script which would
> > transfer data to an i2c client from 1 to 1024 bytes
> > (a simple for loop), when we got to transfer sizes
> > bigger than the fifo size, dev->buf_len was reset
> > to zero before we had an oportunity to handle XDR
> > Interrupt. Because dev->buf_len was zero, we entered
> > omap_i2c_transmit_data() to transfer zero bytes,
> > which would mean we would just silently exit
> > omap_i2c_transmit_data() without actually writing
> > anything to DATA register. That would cause XDR
> > IRQ to trigger forever and we would never transfer
> > the remaining bytes.
> >=20
> > After adding the memory barrier, we also drop resetting
> > dev->buf_len to zero in omap_i2c_xfer_msg() because
> > both omap_i2c_transmit_data() and omap_i2c_receive_data()
> > will act until dev->buf_len reaches zero, rendering the
> > other write in omap_i2c_xfer_msg() redundant.
> >=20
> > This patch has been tested with pandaboard for a few
> > iterations of the script mentioned above.
> >=20
> > Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > ---
> >=20
> > This bug has been there forever, but it's quite annoying.
> > I think it deserves being pushed upstream during this -rc
> > cycle, but if Wolfram decides to wait until v3.8, I don't
> > mind.
>=20
> I would add this into 3.7, but what about the comments suggesting to use
> barrier()?

I was waiting for more comments, will respin the patch next week.

cheers

--=20
balbi

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQk4pXAAoJEIaOsuA1yqRE/ocP/20F4gSgmDLQWcFgmjk5AwKQ
8hsyXjmqngRdJZoattP+dkMNHr67dkSBROJEKM1gREVco+11RVB739yCILWQuPFT
3uqXIx/z7xJWcaPjpTz5FXioTNqJQ9brg+eZzhdh34aPeO1reQ1/PaolUu15jN9l
ovpbTQL64wvsLs0aOTc7AJuuTHtx8HH6sJstIEyLO4ZIAwgGntWnh4r+26+KScUb
SInFfS0NCIa+X6shkXHl6FGdh3mxJtAkQUFywrDGOvo7pG3ZkKh6sPR9Kv9ZlcM9
OVva/wpaFjHLfXgSOHwuthQMpUy090LS2UuYeLx4M1ekTDkPIdIsoUZPS6mIug0w
2RSUJwtUPGmweM4IUJnDVSkHW5MqNgcYwRSi3G6odAqP4qbXz7QS9fMcHMccfS76
DvoJPhUrEm1QLGGS6Ec0bhjcQQUeyHjjLnoefwsf+TlvZP4O6FOgyZ06RAubR1tG
b/iRIvdbR/wjVdVqyHUS6Acc8U/t+MziahQ+kLnbAmH8CVdXghd5+fxPVIkNPqm/
HxKanAakJkCUYAZVxp6zM1o3fNmiaSwBxOe1pvQyKCHY7MmEeh5JeBLpV8QGj6kL
SNrgP48QTjzdeyYtB79FZpP74IVUXZABlOT7TsL2Ql44Gcc3Kbw2BqqtlLqHdxif
Ww+BbeFXSv018MO11pCe
=wz2X
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--
