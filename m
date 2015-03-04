From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap-pcm: Allow only formats with 1,
 2, and 4 byte physical size
Date: Wed, 4 Mar 2015 17:29:01 +0000
Message-ID: <20150304172901.GT21293@sirena.org.uk>
References: <1425382133-17120-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7812084302802810725=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1425382133-17120-1-git-send-email-jsarha@ti.com>
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
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org


--===============7812084302802810725==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ePL2GmOEVZCdDbf3"
Content-Disposition: inline


--ePL2GmOEVZCdDbf3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2015 at 01:28:53PM +0200, Jyri Sarha wrote:
> sDMA support only transfer elements with 1, 2, and 4 byte physical
> size. Initialize the pcm driver accordingly.

Applied, thanks.

--ePL2GmOEVZCdDbf3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU90DcAAoJECTWi3JdVIfQ3dgH/iotieW8R+SEERVNDQqkxIUe
hXsyWcraIcpuHednQ6qA3j8IqV8Bl8CrQqVoyWQpgiMKlDZ5ioUHFfhhgH1lnSAF
XR2ijRTCHsme3IdWs3F6BKLh7CAkNLKImZr71v7E/LWEPWegeAc7p4gpi2c4ypSA
wvFtvyduePsGyH+yZLO6z+Ayt8uHq840Rutb9F8a+E38GmndUc2ZmNroqJqoylri
4a10ayCS30l+d+0fEQVYDrnVtUkdHluH7FT3UAyiBlnWWxJMwPvxToleapNkxs8L
4eYOLP/VbkjSrpcx6ln1IrkDovTM1IRqwHg2LfqynohclPWUv6iXDf7SrvzDuf4=
=ktDt
-----END PGP SIGNATURE-----

--ePL2GmOEVZCdDbf3--

--===============7812084302802810725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7812084302802810725==--
