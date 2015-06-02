From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v2 1/7] ASoC: core: If component
 doesn't have of_node use parent's node instead
Date: Tue, 2 Jun 2015 21:09:22 +0100
Message-ID: <20150602200922.GQ14071@sirena.org.uk>
References: <1432666751-24794-1-git-send-email-jsarha@ti.com>
 <1432666751-24794-2-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7529407807999104804=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1432666751-24794-2-git-send-email-jsarha@ti.com>
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
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, moinejf@free.fr, airlied@linux.ie, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============7529407807999104804==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BzJ6Fzq6EYQX8BP0"
Content-Disposition: inline


--BzJ6Fzq6EYQX8BP0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2015 at 09:59:05PM +0300, Jyri Sarha wrote:
> If an ASoC component device does not have a device tree node, use its
> parent's node instead, when looking for a matching DAI based on a
> device tree reference.

Applied, thanks.

--BzJ6Fzq6EYQX8BP0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbg1xAAoJECTWi3JdVIfQCzcH/RBpRv9Q4cf2Dc09ctm0BMpI
RKT2+zKp9ESmoZHTkokEIMKS4w1RdyC1MtXxle9xHtG0aw6kHi42LJ7LSytPp+aG
teO9oiLACEcLlXIJ7Qxgd5waE+yRNbjLHdT7fpEOmUNAW0RA1ZJz8W19Zaxt+9tV
qPjBURxo8CawHRDfs3G+aMpKUgB4lEN3ddkOrmDoox4iYSRxY/KHmQI7DzPt/yxU
gOQ0X1gRKwSDAcsTSHg+dK+5PdhRL3gT0DT6IsPfBjIuCU433iBdl/s6cv4a1ugD
KPJRUM33mfMaDR4HcL2vdpLr0FbPZG5qt3jQLdUYDpKchlFzqrp1UKwpsEyxQHQ=
=+mEr
-----END PGP SIGNATURE-----

--BzJ6Fzq6EYQX8BP0--

--===============7529407807999104804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7529407807999104804==--
