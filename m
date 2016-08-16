From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 4/7] Bluetooth: hci_uart: Add support for word alignment
Date: Tue, 16 Aug 2016 09:51:04 +0200
Message-ID: <20160816075104.blnfshsv7cgcm7gb@earth>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-5-git-send-email-sre@kernel.org>
 <F96C9280-2B85-42A0-A1DB-2C0C231F5C1D@holtmann.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eo5f46o7vgkagkpi"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F96C9280-2B85-42A0-A1DB-2C0C231F5C1D-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Ville Tervo <ville.tervo-X3B1VOXEql0@public.gmane.org>, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--eo5f46o7vgkagkpi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Tue, Aug 16, 2016 at 09:05:19AM +0200, Marcel Holtmann wrote:
> Hi Sebatian,
>=20
> > This will be used by Nokia's H4+ protocol, which
> > adds padding to packets to reach word alignment.
> > ---
> > drivers/bluetooth/hci_h4.c   | 10 ++++++++++
> > drivers/bluetooth/hci_uart.h |  1 +
> > 2 files changed, 11 insertions(+)
> >=20
> > diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
> > index 635597b6e168..a934e4eb692b 100644
> > --- a/drivers/bluetooth/hci_h4.c
> > +++ b/drivers/bluetooth/hci_h4.c
> > @@ -253,11 +253,21 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev,=
 struct sk_buff *skb,
> > 			}
> >=20
> > 			if (!dlen) {
> > +				if ((&pkts[i])->wordaligned && !(skb->len % 2)) {
> > +					buffer++;
> > +					count--;
> > +				}
> > +
> > 				/* No more data, complete frame */
> > 				(&pkts[i])->recv(hdev, skb);
> > 				skb =3D NULL;
> > 			}
> > 		} else {
> > +			if ((&pkts[i])->wordaligned && !(skb->len % 2)) {
> > +				buffer++;
> > +				count--;
> > +			}
> > +
> > 			/* Complete frame */
> > 			(&pkts[i])->recv(hdev, skb);
> > 			skb =3D NULL;
> > diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> > index 839bad1d8152..a7d67aec3632 100644
> > --- a/drivers/bluetooth/hci_uart.h
> > +++ b/drivers/bluetooth/hci_uart.h
> > @@ -121,6 +121,7 @@ struct h4_recv_pkt {
> > 	u8  loff;	/* Data length offset in header */
> > 	u8  lsize;	/* Data length field size */
> > 	u16 maxlen;	/* Max overall packet length */
> > +	bool wordaligned;	/* packets are word aligned */
>=20
> I wonder if not a u8 align would be a way better choice here. We
> set it to 1 for all existing packet types. And the Nokia driver
> can use 2 here.

Sounds less hacky than my approach. Also it made me notice, that my
code is not safe, since the buffer size is not checked. I will use
u8 align and fix the buffer size check.

-- Sebastian

--eo5f46o7vgkagkpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXssXlAAoJENju1/PIO/qa66YP/itYjvxMOTrBHtDb6Ob/5xFg
emzNE0SxNA4jmC3reWmcgNtebAfnRNXZdGN7zP9DGlX98rX4iqI+08rOOtC05Z90
T6/QguGy/UP9F4Y6itWPq6eCNkXEphSwgwZUb/nLZcqvpGPi/EahmBDB65/DuHHe
XUUON9zG9b02J+P020kzBtsTBI6UPYFpCpukmrAUb7n3e4rX+5cglG54+TYY01yY
gyEiLNoUkkgRtulsQO9Y6J4nAwthP40hc6yw+xdYlDi/MdhVwenc5ZiRfKHxILKQ
OGxTnkHlUbpwJnn4qMkdTv5aOfM4lc6C3tNrhU/Co5hHpl09GOiSaUfnkg6ByM1U
DLBSmvE6fz52z4xbmDTsgcY9owQ/JySKVEPkuEcYy8NGXAPCQpyT2EAh4LURTY2j
1Mh6bPedAEJK3J3zjDz4jGqaIrMRcN9wiD8MF/hgnA4hnL86eNJVvZzGPmgMa/Sm
5vBC7/a7LFEo2W+yq8nWwU/FVPC2p6Y4hQbRQOTEksPq3D6Ybsx273lCLlLvdX6p
KMB9xEtAZTpKs6lwdGyo95f/xhCLoCHXiNG+cFic2Iw5srVaUhR8PGSXtS6i6KgA
o0OnHNGvinvUVL/dBxnl2BZZJgp1DpBFOK1h2XI6D89HA6q5dd1iRJirNy2eiTga
bbDiWT+t6ceUsT/6V12b
=K8NM
-----END PGP SIGNATURE-----

--eo5f46o7vgkagkpi--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
