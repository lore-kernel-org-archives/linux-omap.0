From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/8] usb: musb: Add support for ti81xx platform
Date: Mon, 12 Dec 2011 21:09:02 +0200
Message-ID: <20111212190900.GB3408@legolas.emea.dhcp.ti.com>
References: <1318332369-9732-1-git-send-email-ajay.gupta@ti.com>
 <1318332369-9732-6-git-send-email-ajay.gupta@ti.com>
 <20111212184900.GE32251@atomide.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111212184900.GE32251-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2011 at 10:49:01AM -0800, Tony Lindgren wrote:
> * Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org> [111011 03:53]:
> > From: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
> >=20
> > TI81XX platform has two musb interfaces and uses CPPI4.1 DMA engine.
> > It has builtin USB PHYs as AM35x. The current set of patches adds suppo=
rt
> > for one instance and only in PIO mode.
>=20
> This one should get queued by Felipe via the USB tree.

Yeah, I was mostly waiting until you applied your part so we wouldn't
have a file without a user in the tree ;-)

Let's just refresh this one a bit and add devicetree match table so it's
ready for the long run

--=20
balbi

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO5lFMAAoJEIaOsuA1yqREdpkP/i0yszmmx1C+DrBhmWryjScU
8kb4paKqOhigJbzLOk+MmuOJyeho7+6oA5nAgU1qrlalckCwMyJvcRSC+KZ5cTu+
ecJQ94NFFcBWyM4nxlZS+EG0SW0VnWWT5B+hVUb9yfY20wvVp8OWUlBjCgWLxfcF
jFju0Sxg3QK7ErT7LOXnz8K0IqomeS9ZZX7kKYUfmBdLHFKmg9h0V3zgNBdDE4au
5foYw2qb8clwaJ3uYkBPx6sTGUhZIU4VXDxXpVoRXSm+xWZjhQ0MRNTekZjay9p6
pXHTdDjqxY9QiC4u8XVhMim7DLgx4zoXSa9omOs2Yo5DOd/qz2rXnZEFBcu50g2i
YOq/nEZvxKK4DsOHoRermuuectw/JYra64I0ZtdzToBA0qunJey09KGbun4RdAV7
I4adc8obL4fcXNHgK0EHjnhiQBg23Ox9krRx5C18KZlL6oF+B8ypfKJ7b0LQGXHh
YW87A+BqRNUMePEbgg0QjWeb8HkfnsCs3Fy72ZHfbl1gXwfuftIFpt7l1/W2VHGt
JNd9ypa5GkEVMPlYQWXbo8jXXZYFUbmZWbNZy/mPrQDA/27xMgtFEsluKml2sPXF
p2b6xOVlEx5MbEgWVmI2FeToqWYSzRVLBTjBMJrJV2rLB9WSK7MYqatIKHJh3JfE
YVcyjcuIHBdLJJYrXdoj
=nChg
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
