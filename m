From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: davinci-mcasp: Set rule
 constraints if implicit BCLK divider is used
Date: Thu, 19 Mar 2015 09:44:43 +0000
Message-ID: <20150319094443.GN2869@sirena.org.uk>
References: <1426755069-28644-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6642571121633524656=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1426755069-28644-1-git-send-email-jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============6642571121633524656==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="95CBLwa+io9O2zXc"
Content-Disposition: inline


--95CBLwa+io9O2zXc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2015 at 10:51:09AM +0200, Jyri Sarha wrote:
> Set rule constraints to allow only combinations of sample-rate,
> sample-bits, and channels that can be played/captured with reasonable
> sample-rate accuracy.

This doesn't apply against current code, please check and resend.

--95CBLwa+io9O2zXc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCpqKAAoJECTWi3JdVIfQdo4H/21O1uSPQHy9dvVBPpKzLiGi
sl6GUUUXrYeVRCoIu+sp3L9NbkYmdn0Ei+hvGaVx2I/nZiGJMQh5HDOm2sy5QCWI
mgkbCCI4zmbS4Pgh6OO6NYRweGWEepBJIkAetWmsMrswa/saHbNFTSlrguAnIyqZ
904Kfk02Y25CaRGNmlWVi42bRs/2JUm6aqx40Nl0NSM/t+LKYeVOUxB3vlJZu9YP
ZW1tA5MCvSHTXOmYFvOVjdxlNXPkLbDWdRbVgnY9mYPkv6m+/ISzCs4HwemOjpZA
K/fs1CHnO52brxGoDV/0FdCUEiHjK7rMr4on+b13h8TcApBt5RubvdlRzUT6XoM=
=XsX6
-----END PGP SIGNATURE-----

--95CBLwa+io9O2zXc--

--===============6642571121633524656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6642571121633524656==--
