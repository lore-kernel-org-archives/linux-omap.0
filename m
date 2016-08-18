From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH for 4.8] Revert "ASoC: omap-mcpdm: Add
 support for pdmclk clock handling"
Date: Thu, 18 Aug 2016 15:52:06 +0100
Message-ID: <20160818145206.GP9347@sirena.org.uk>
References: <20160818110059.13457-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7744728657082004849=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160818110059.13457-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============7744728657082004849==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FX8H79VVjfzinewO"
Content-Disposition: inline


--FX8H79VVjfzinewO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 18, 2016 at 02:00:59PM +0300, Peter Ujfalusi wrote:
> This reverts commit 65aca64d05b5eaa5ce15e18b458a8d338ddbd478.


Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--FX8H79VVjfzinewO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXtcuVAAoJECTWi3JdVIfQziIH/jp6NckpRfQCPEL4zkTvQmCS
FjPFZ7Zy/QmpXQtKkxgsDsn1WjeBWqMWt64LHR34tpLMBOpyCoL4H+Y/jGl1jCXy
L7eS4ZaPSOeH01OoWJvl2ZaXDrUUsY8RxZBi9DUZhTY3jnoX3OlLtOSF1+CkKUou
7K1dqGqndKJzA8suYxiSbcsOeiMma3NYbJp4ONfhUumt0jyn0jO5oJDe8RH2loHo
SFWzqyorYKQNlZeiNd9D1yENQ2Jdw2Rx6YX3fBO7HpuCzRJMX0GXj130Q8InZD3P
qmdzy/x0xF2hdf0mHNBUBtepup+66l3FfNQC9gUD3wC8AAuuYoVdaz6iNZ9tDzc=
=LZwV
-----END PGP SIGNATURE-----

--FX8H79VVjfzinewO--

--===============7744728657082004849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7744728657082004849==--
