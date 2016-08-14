From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: don't print error when adding adapter fails
Date: Mon, 15 Aug 2016 00:17:20 +0200
Message-ID: <20160814221719.GA10501@katana>
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net, kernel@stlinux.com, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 09, 2016 at 01:36:16PM +0200, Wolfram Sang wrote:
> Since v4.8-rc1, the I2C core will print detailed information when adding =
an I2C
> adapter fails. So, drivers can skip this now.
>=20
> I am still undecided if I apply this as a single patch or break it out. B=
ut for
> reviewing, avoiding the patch bomb is probably a good thing.
>=20
> Should go via subsystem tree, I'd think.
>=20
> Wolfram Sang (1):
>   i2c: don't print error when adding adapter fails
>=20

Applied to for-next, thanks!


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXsO3vAAoJEBQN5MwUoCm2w3IP/jptxJ55zOpqqrP4YiIo9d1P
ldYqyfLqKHVN00p64U+1H3ryKADkcH4kyXCMj8NNrFmD1Sjp4t+IpSJrfbyjhjxD
iYkgvfZCKtLXECOE3AnrtBvlwv0wdBIP4Riztq2WgAfwXJvebU8K3dld3fx0f3k0
KUpk5uQ24K5RbYcSPS+PqqDi7LRvu1iRfsOyqA3j8n7nQ4uKVLLYbcst5NyFpG7x
168XGity4IdRjQM4PeEEQkXWgN9UdbS/5Ah7vG52Ug3iEfzXgMSyjrUM5NfuxGv8
oku57fUtN2y+uH2Od5gL0S27m49mGDxNPnhPK4CPItekcz2wxwaFlnb+3eOpRT57
sADpkE1bpl70FdaWJdSeI9F689dUCvWVsRpg7dglHI8yxzk+oQOE8KfWMXSX0CCn
JUBsKsSBR1FUDpFAaACjGvMSf4E/2gosQC6pxF2jSo3Y/i2JH+HgzhtQcxRJ2v5f
zG711NoBMbzZMRteYN5NHidiDrzZeo9fGoGxWLmKuayR2oifMB8O1IVAwx8HeVJh
hPGCi0ZSGsCYYZ/SZ6QmzYZAfrKnt/EDFjyywJ/egf6yvDB1xkIkbFGkK+V1OhGp
C61jKV4qHvvDxkOf2l7W77AWxJOswfJW3JZzkMC+1eniXU1yULAsJ09I9Jhol3AZ
GpCRWj5TN9jg1a0kP26G
=vwEG
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
