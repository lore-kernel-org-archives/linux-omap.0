From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC 0/2] i2c: omap: new fixes for driver
Date: Tue, 13 Jan 2015 11:04:01 +0100
Message-ID: <20150113100401.GD1059@katana>
References: <1417294803-14729-1-git-send-email-al.kochet@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417294803-14729-1-git-send-email-al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2014 at 01:00:01AM +0400, Alexander Kochetkov wrote:
> The first patch fix i2c-omap driver for omap2420, found by code review and
> later reported by Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> here[1].
> Candidate for stable?
>=20
> The second patch unhide the reson of system lockup.
>=20
> The patch is rebased on branch 'i2c/for-next' of
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
> (6e79807443cba7397cd855ed29d6faba51d4c893)
>=20
> Tony, could you check, what the patches fix the problem reported[1]?
> Kevin, could you run tests for patches on all omap boards?
>=20
> Regards,
> Alexander.

Thanks for working hard on this driver. I'll mark these patches as RFC,
since they did not get any additional tags from other people. If they
are intended for upstream, please resend a rebased version.

   Wolfram


--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtO2RAAoJEBQN5MwUoCm29U0P/3maGNQk4DCqn2dN3imY6PKC
M6MLEKEYasqIusdG4N+0j5jrB7n0IW01DmuDT5VRQTqgyXeXtSj77uYcB+jDqzTi
kLw1SbUyMp1reguTQITMFet71EsvjY5zHMJ8Lje0DwttEJakBLl2bg7pWcZKaVbw
ETHFe8CFcpFegPtzae2t6Y9Wwp11+RnWaZD9jfomgNTf/MhSfkDmMNIzWpIpoD00
m9G3egX/uqFN3mxnKBf4rmRyab5kND1wlI5D/rQ6d8RNAT1RKlrSfnCXMPNwgyW8
s2Gk4SM/SU5WPtnExCx/3HQr0oA/AsOpa3O67fQdbgmd9h7K3IKrLAyyTvTCZNLe
n13e/dzG4BpWT/rQzjkHk3jJM/JSIoid5HWjkDERM5vPxCXAy/TZu6AoiKkXzDYR
a+Vru17+1NmgkLUvc14vn5W6mAg6PYiI2t1/6rJPV4QbysVtPlmgUXy9cM7LsqIT
JipBMEXl9zgIAeWO5UcLMOCMi+Wr9q4qeW6DhjMT9sPJYY9Jny142FWyOrcI4k1L
fVOO1LKuINAhXUm98Z05KxpsIToHCHYoPsWiq/q5pl0VrO8l7Cx2DPFqgmVLjBuX
JqQ5jBIO577wS7oFVJzXmfLVql70mIullL3nPTGT3Ic0V4nCw3idA1zmo22Ep3q9
6yvFq+FoSNd0wkfNf/IZ
=DJ+X
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--
