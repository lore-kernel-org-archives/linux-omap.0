From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 04/12] ASoC: davinci-mcasp: Extract DMA
 channels directly from DT
Date: Tue, 22 Oct 2013 13:10:39 +0100
Message-ID: <20131022121039.GC9388@sirena.org.uk>
References: <cover.1382110089.git.jsarha@ti.com>
 <a9fde78982a12aa2d21194f08e4aae5cb25b37a6.1382110090.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2360953524837256965=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <a9fde78982a12aa2d21194f08e4aae5cb25b37a6.1382110090.git.jsarha@ti.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, joelf@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============2360953524837256965==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2013 at 06:37:43PM +0300, Jyri Sarha wrote:
> Extract DMA channels directly from DT as they can not be found from
> platform resources anymore. This is a work-around until davinci audio
> driver is updated to use dmaengine.

Applied, thanks.

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZms3AAoJELSic+t+oim9L1YP/RHOrm/Ixo8afzSU4pZpkQx/
8Xk4gLPSm0EkOB5t5O3rVaWxYYR2xPV1S/YkMUosUw+fpI2yYtUPrAjz1bEyxJai
7YCxbA/TfWb15YYhmYHVnw0iBpzBUy+XPnaImFLvs3JangpxArsLh5GBZv/l/LzK
djM36mHSyzm09ahtsswO6KXjWZYykDOxH9Dh2GJfBJdbKb9G1MlU2nqQYDqPnYYT
NQHZJdPSqp75jNCUg8/ETrYIOpqvk1RAV1a24gmakJrq5Rqr81NbFNC6onubMbrU
ps0mdg908ZXnZ7mgea0XmP0vmt9N6h90A4BaCk3GEojJJCcWaS9zmD4qHaEJm/W4
yPF7yBrrVDPeAv/NAKaWddn8dnbRJxtwDD1oochCeAkx8SFzoG7krxMZ3pV9myTr
GwMIdC+YYuP/tU7lz0wXuUrqkiLaBZaAEDsReKyGuM2ogCIiuWyPfmWD52CNpU0a
owCIp4CadBc3f0CU95mtVReUtYni1me2SW/zHsoC7hPyTfp5xiMVBaVdMqLA4AID
Sc156UKjQ5QTxLoqlCxLslaDQRSRSsk/DYAs9p3Q3Y0UA2lBMmTjLkcM3KiYC87o
P2+5mQx1AF3gWlzYDQsz0p1ODKDPo0Jqlk1NiulMzcxcgDKjkfBHVCredWWSjEbp
hVVB0JBVULO9PezOxHKL
=hcN4
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--

--===============2360953524837256965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2360953524837256965==--
