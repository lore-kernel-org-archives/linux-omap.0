From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/17] spi/qspi: parse register by name.
Date: Tue, 26 Nov 2013 12:24:42 +0000
Message-ID: <20131126122442.GC14725@sirena.org.uk>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-4-git-send-email-sourav.poddar@ti.com>
 <20131126103029.GY14725@sirena.org.uk> <5294835D.5090902@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4356137134076900306=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <5294835D.5090902@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: devicetree@vger.kernel.org, computersforpeace@gmail.com, balbi@ti.com, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============4356137134076900306==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xYEba/cIt2nZJmCG"
Content-Disposition: inline


--xYEba/cIt2nZJmCG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2013 at 04:47:49PM +0530, Sourav Poddar wrote:

> I have added "reg-names" property in dt bindings. (17/17) patch of
> this series has that info.

Do device tree binding changes early on in the series rather than at the
end, one of the things that gets reviewed for is binding updates.

Your code should also cope with the existing bindings, falling back on
the current behaviour if it can't get the names or the extra resources.

--xYEba/cIt2nZJmCG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlJMHAAoJELSic+t+oim9Fz0P/ibhevhum+cYlpunkpWiHJHB
aPEJuWG9k5nxupW4yOc2bm0GlsMk2303XRkBI7fgIMvdGxC2C7MS1M0HMv++11mT
+0BENkReILTgGbWILIifAZz/ooeqDPPHvsKBkZSy24WgYf2JZLONZSOrwTmHF4Nj
5vcRh7z/gpnT3mDtvuhZptTBTENgYV3Rgo1QT88fGHz+ZydmbEG1s2BWL6T8widb
7OO+A9wTt/rSvCU7jLq/mL80mzRv4SmnvyF/BgFQF0MFee6YlLfDnp3n+nYssrf8
zRGwD6KFF0coOudbbphvTf2YgOSGPpHvFJkB0L0uUNAd2ThexdM3z/FHBrFtQORC
d5g0p9rswi4ldWkKvwf/rb6QW7U4RvA9+F4n1ciQTvtRT5jFhdxu5S8EVk+AO4es
ClxT0Tjwwb8ar20o2TmvlXG9oULUKsxWTPji2ALUexmf/zrlPzXtIXhcN1NexNQ1
9qmlviJ48q1oW0lteR/AurEVlmjSAJ5tHSJOVRgBYe7lYyZESxwNB75xWRrxEoh1
kObNCfzsqN8uVP6UO50Rb+V2ZLEtHbt6Ii8s2ZQtaV/5GqwpOEPCj8gfSJvKzE3C
pMbq6odgU+cFUHp9Q5d5gqRc9CyhPjFDQU8qxkhdDMMk5ChRsByAm8kL6pa2cu/3
jZA+uNBRrCvorMInpCSm
=w3+Q
-----END PGP SIGNATURE-----

--xYEba/cIt2nZJmCG--


--===============4356137134076900306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============4356137134076900306==--
