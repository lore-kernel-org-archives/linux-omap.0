From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: omap: Remove OMAP_MUX dependency
 from Nokia N810 audio support
Date: Thu, 26 Apr 2018 14:03:25 +0100
Message-ID: <20180426130325.GH21755@sirena.org.uk>
References: <20180426115115.13744-1-peter.ujfalusi@ti.com>
 <20180426115115.13744-6-peter.ujfalusi@ti.com>
 <20180426125437.GG21755@sirena.org.uk>
 <ee48f54c-9096-fe46-163b-c826b509b73d@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1454623166739919466=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <ee48f54c-9096-fe46-163b-c826b509b73d@ti.com>
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
Cc: alsa-devel@alsa-project.org, aaro.koskinen@iki.fi, tony@atomide.com, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org


--===============1454623166739919466==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dMyqICaxQaaUjrCL"
Content-Disposition: inline


--dMyqICaxQaaUjrCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 26, 2018 at 04:01:51PM +0300, Peter Ujfalusi wrote:
> On 2018-04-26 15:54, Mark Brown wrote:

> > You're missing your signoff here.

> I have not changed the patch itself, just picked it from the list to
> include to the series. Afaik in this case my signoff is not needed.

No, you need to add your signoff for *anything* you're submitting.  It's
about tracking the path the patch takes to mainline.

> Can you add my (or I can resend the series):
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

OK.

--dMyqICaxQaaUjrCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrhzhwACgkQJNaLcl1U
h9A7FQf/Zm8/TUrQtMgCHL4Rzl6IdJUrXa/csAtIfrKQH59ffxmrDdKAnpQTegKP
fOK/C6bwacUdRiH4cG2aeB2h8PbWC6MPR3/mrV2Bd9zrQ43otayzSQHMiNe6F4jY
V1t2tO7Kfjz3Nuno/S2H0W0mbSHjqEwAa85ruMM+psdWsp22A+lWXjt/lSwKgno9
MecmZUSsG8H16vZJcHcPR06ngywBYM1qpgtwX+Qv/c26aLN46gZXAaolH9MdusK4
NpjWq0XhESgPSRdTf/OJFkb6TvK42mL8Xc+2MyEurB1Sh2OCzD02uA7yXH0BfXSY
f0kSR8+wG0hE1Ip15zd7JGPDqde51A==
=Qzjo
-----END PGP SIGNATURE-----

--dMyqICaxQaaUjrCL--

--===============1454623166739919466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1454623166739919466==--
