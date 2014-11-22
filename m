From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/4] i2c: omap: implement workaround for handling invalid
 BB-bit values
Date: Sat, 22 Nov 2014 19:02:22 +0100
Message-ID: <20141122180222.GA9698@katana>
References: <1416518925-20679-1-git-send-email-al.kochet@gmail.com>
 <1416518925-20679-3-git-send-email-al.kochet@gmail.com>
 <20141121160808.GM7508@saruman>
 <20141122132309.GC2679@katana>
 <B6D9B4D7-25CB-456F-88B4-EB6A53E33A9D@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B6D9B4D7-25CB-456F-88B4-EB6A53E33A9D-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2014 at 05:06:10PM +0300, Alexander Kochetkov wrote:
>=20
> 22 =D0=BD=D0=BE=D1=8F=D0=B1. 2014 =D0=B3., =D0=B2 16:23, Wolfram Sang <ws=
a@the-dreams.de> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
>=20
> > Huh, I can't apply this one? Which kernel version is this based on?
>=20
> v.3.13-rc8

Wow, that's old. Can you please rebase the series on top of 3.18-rc4? Or
my i2c/for-next? Or at the very least 3.17?

@Felipe: With which kernel did you test the series? Also, 3.13?


--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcM+uAAoJEBQN5MwUoCm2zk4P/iC6x0VMW9PO1tfCbnatApUl
aO0WzWx1XnqyNt9qo+L7EZjGiDXo9iRfh9Doo39S0Frm3LBnq7NI9N/SlkRWZFcS
txS/579BmuqHSw0+0Sjp/V0B7l5mgpSNXpZjdSKgB6EO/rkC1tN4OurvPJyl5bwh
t1Csu0JHehwpYW4fCJBpa//3VbZ9aepl7rUWj70n2ETBWPQaGmxEKvWY2Ztku4/Y
5Rxf2dcM9nQ68LzRPj5A4HVXPugKOOYWo+Turd51t4DQEamX+aAj3M9hRfdMovwL
GANh2RHLSJ+O3Iy2iwnLvdeUd7yL19EhhjeE5V9T8ZvIzHtoHQCcA+yu6XKMhwXi
+o9wYqC8aZGUEPdhoVtUFSJYwfHCiltzPFz6jqlHVJRM4rnYaPjwilQmRYFtVTGz
Pqc0NIted7naIbj+FN8D5cmL4jeUa3yKuyDbW5MHsPY3BIpxQ/cqMTLT9BZ0uvq0
e5VUcIG3ywTcnSvnAWRLJlxY7BYvXyrjX+CK6TY5v2kLFwd+FHDtlxnL+dDV/Ieg
iiojNHQsd6suJ/lmANh22KZFSZEPbxVMlyz03E5/NG2bUK1nTgTQg19bJ8E309C/
BCVo5rl/4Kbc7+AgzkQ2y1O3cHbkL64Z9I/CaSTCvHQiQFZ5IfI04vYT9d/g5DDg
PcsAqhFcSAEiQ74UehGA
=Z2hb
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
