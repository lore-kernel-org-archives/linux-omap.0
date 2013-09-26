From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH v3 01/11] ASoC: davinci-evm: Move
 sysclk logic away from evm_hw_params
Date: Thu, 26 Sep 2013 20:36:23 +0100
Message-ID: <20130926193623.GA6066@sirena.org.uk>
References: <cover.1379590035.git.jsarha@ti.com>
 <dad0f7eb787d3f65848425a67d668e3935033195.1379590036.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4162402319421978488=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <dad0f7eb787d3f65848425a67d668e3935033195.1379590036.git.jsarha@ti.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, joelf@ti.com, rob.herring@calxeda.com, peter.ujfalusi@ti.com, bcousson@baylibre.com, grant.likely@linaro.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============4162402319421978488==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 26, 2013 at 10:18:26PM +0300, Jyri Sarha wrote:
> The sysclk rate does not change runtime so it should be initialized at
> init time.

If you want the DT maintainers to review this stuff you probably need
to send it to them rather than spam the ASoC maintainers again.

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSRIy0AAoJELSic+t+oim9gtIP/iFXrrXmUKg9DlccEnzMrDmX
ntVetZukxfy0L3fOV39AP2EYDdlUMnQPhZ2bfiAxZv9yOL1dmr4v9Fq5bniNX+Ff
ted1+2XyS4IsvZq06RlJFl/BTkc5pTwBv6Tu9k6Xt2mjPss6y1533IeNpYxe1lru
J7ZmVFLHy3VQ6ZZs7/zQeqR+p89gwY/wn/M6rgIZdABKUg06vQ/X58ltZrF0fOPr
36tTa9LbK6sUV89rr8mc4qCUyAFBunH7L6otDU4vgqKbCS5Naw8vg2gtV770H6O5
ISNZkgUUJZkHKFk8RFl25qCqQp1KNAH4KIvGxiB3C9UALfxEvPJKJb3GHcmVjqIj
NRfWoZLJIJeoXEd/2MQzWx8Ssnc3v/iFCzzrhnXGbEfZ28nkGUZ2XMk52ae76St/
Mgd8QL8eTPxqjtAy5jd5ztYJfr9Wwmh+eM35bR7iEsz8oCsBRmOF8u2upDSXxkgz
9bcHqVBRT9ke+qZOoGAgZ83BDG/4khayMjkyd6rjsWm6baZqAmD+n0VmzTaxWZgV
YKJ7k06FEzuEbh+VaOL0XMv4NMfyyxEmOQ/pxGUcmBnjVTRtnmPHGF9gDYGCdt7z
RgyByAN40xVFMweRPrMOOgfyFLmCi/xsaU4iQaCGd982im0smC4k132ZQCozrDhk
8sCVks1nx1ID/G6eDgdg
=uVBh
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

--===============4162402319421978488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4162402319421978488==--
