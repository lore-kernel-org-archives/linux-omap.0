From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: omap: abolish variable name confusion
Date: Thu, 9 Jul 2015 21:49:41 +0200
Message-ID: <20150709194941.GH4744@katana>
References: <1435260890-32335-1-git-send-email-balbi@ti.com>
 <1435260890-32335-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ISKrrfpKsPiF35CV"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435260890-32335-2-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--ISKrrfpKsPiF35CV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2015 at 02:34:49PM -0500, Felipe Balbi wrote:
> struct device pointers are usually called
> dev. Calling our struct omap_i2c_dev pointers
> also dev has caused enough confusion.
>=20
> This is the result of a few simple sed rules
> to convert all struct omap_i2c_dev pointers
> to be called omap instead.
>=20
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

I couldn't apply this one. On what was it based?


--ISKrrfpKsPiF35CV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVntBVAAoJEBQN5MwUoCm2VhUP/3gso3hL8IXKU4/q8K6LYnS7
lECYMxjR/WcN5xGT1pFc14FIDbzn5jRVLZUre/udz4gsKRv1LDbtdbw9PUKWe6gL
5pav+my8FRxFUmRSa7ouDSUGpBx+URnI5cFe8ywipBYZxk8AgCp8RbRLSGQUsr4O
JRTVENHOtagqeQV/1pI+lGr7yCqW7EH+bdD3hrWSnBnzaGCla8h7PoDNNgH2AyAD
KJgApjiaTSihyCysJ+22PjEgVWcYDj3TZPgHr2uwsICWbQGNEOTEMOkSoyq2+vZz
f7yRojOJP4NsCS1roDkJ22bokBJdjE+2uOIX583x5Y7BuCYTCRD9ToEaraGsFt80
uFkDZrjPaxF3S83165W7rEPjWYVO7bPUmTjmrRzaNknnxdPOGJ3rfazIisWbR3k9
i/lsyHiXawM1WKAr0wM/ZWumprOEA/JR2qA8q3nX2ndnrjqfyi/1gBt2uMz68kwe
UEWUqCzkIKdRJiwmfBDBb2cMGVE5v4rvT4TI9Vy+cNjv+QyaQdgNuz5CdeQtWNwY
Yg5TKMozoGTJ14KSA+yXuLDyiSLoC2N3HbY9fr4cCyoX+q0SRXDbFhYOboGThAgw
x0Ln6Z33V2ao/CkOEV6wfrtwF3e3/SRc4ED8+IJGriTn3pCLAw+0Eo4mEU0EVz2s
MljqyDNfs9qIMmRSoco8
=QM3I
-----END PGP SIGNATURE-----

--ISKrrfpKsPiF35CV--
