From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: omap: fix "Too much work in one IRQ" irq
 handling
Date: Tue, 18 Nov 2014 17:12:41 +0100
Message-ID: <20141118161241.GH30004@katana>
References: <1416014452-6712-1-git-send-email-al.kochet@gmail.com>
 <1416014452-6712-2-git-send-email-al.kochet@gmail.com>
 <20141115014859.GC808@saruman>
 <7C4EE58D-8956-40C2-B649-775B2F551D2A@gmail.com>
 <20141115034756.GA2917@saruman>
 <20141115035328.GA3289@saruman>
 <A47891AC-7453-43F0-9196-5133A1525C68@gmail.com>
 <20141116154558.GA7422@saruman>
 <20141117144152.GA12644@katana>
 <20141118160059.GI8223@saruman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dMyqICaxQaaUjrCL"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141118160059.GI8223@saruman>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--dMyqICaxQaaUjrCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > right, Linux doesn't support being the slave. That's also a missing
> > > feature, not a bug.
> >=20
> > This is going to change. I sent out RFC patches for slave support [1]
> > and will send V1 this week. This won't affect your driver, though,
> > unless you implement the backend into it.
> >=20
> > Just to keep your heads up.
> >=20
> > [1] http://thread.gmane.org/gmane.linux.kernel/1783295
>=20
> sweet :-)

V1 was sent out a few seconds ago :)

https://lkml.org/lkml/2014/11/18/678

> Still, as of now we can't consider what Alexander mentions a bug. Good
> to get it sorted out, but not -rc material.

I got confused with all the patches sent out for his issues. Can you ack
them once you are fine and mention if you consider them important for
this or the next release? That would be really helpful!


--dMyqICaxQaaUjrCL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUa2/5AAoJEBQN5MwUoCm2wbQQAJRMYWeig0w2oFaI4QBK/Wbe
qtynhUdpOsFpogiy+j/toJi1KDJijejE7qw6drCUTLZTeqEQPIP/1ndvT5qclNVO
ydw9ZOrnP/1rdsh71vFzqc1rNlPXjm2XziByohg2bCvOQlu3o8GtwQJ5VRVLZyQT
a/0YA96rkA8G9pWaMBnlnRxZCj8eL2ODRa++BBhzIcE4vZKPmmTlAk4VdjUkV0PK
L264wZn1RgiLEDiBREtfa1mEoPHnwH6kL2JXEpv/v99cfsD7N4dazveZAQdWzI3z
YIlbVogRneXqui7JjvVIWbPxUK+bZr1qQDsOeKScQvPRsKGYrQeMfBHx5rEQBtlB
jQTn7QjRRCJx7y8W/wtaGLnB/DNeXyUfO0kvvd7Olc9W3UR/CryTP1awq15Ao4vA
afluJ7BOqoviTJKtttJjOh4uXYa/PbD+TQ0ieO86uk41hd4qhK4PJKZS9017o2zt
TqhGaEKpGUTYdXW0mNt3ern7SttTcDP29l3Efu/gql4e2BTsGRWBIpdUgtTuodAT
BfFv5a/6kUwEhdWFXCURrIzW8UiBcKdYCio6Hv3px0LLLcwBQEULJyZHjYhwIpvY
Dze1S4o+0Pj4v1gb9KEAzw7x7kAdb2ltGmsG6KzacuOpR/nSNmlM07P1jxPKSwme
SPjCOJHfO1y0vmMe7d/7
=1fcd
-----END PGP SIGNATURE-----

--dMyqICaxQaaUjrCL--
