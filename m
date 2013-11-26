From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/17] spi/qspi: Add support to switc to memory mapped
 operation.
Date: Tue, 26 Nov 2013 12:57:40 +0000
Message-ID: <20131126125740.GG14725@sirena.org.uk>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-7-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3572201131095542308=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1385451313-1875-7-git-send-email-sourav.poddar@ti.com>
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


--===============3572201131095542308==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gA19+fZe+9B2YWyg"
Content-Disposition: inline


--gA19+fZe+9B2YWyg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2013 at 01:05:02PM +0530, Sourav Poddar wrote:

> +void enable_qspi_memory_mapped(struct ti_qspi *qspi)

> +void disable_qspi_memory_mapped(struct ti_qspi *qspi)

These are driver internal functions so they should be static.  It'd also
be more normal to put the qspi_ at the start of the name though it's not
too big a deal.

--gA19+fZe+9B2YWyg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlJrBAAoJELSic+t+oim9zkMP/2jywiWq1j5owDTh2cR3TwoQ
8HrNa4S3j+0szlK5Pi17welJCcMaCcbs21o+tx4pfqLoeZVtFifc7OkYx0wVzzB7
DmLZsg9h5SyNO9CN4As2t2QMD5MrqBsjiXRGTgL8iV5uCdDu0P5U6s1+Ow0uf52J
W0fN6ewe3lMQ9PygsxfIiR8R9fEMyjSmJvxfWM+JyeHK//Ut6mM9EZPaCv+sLikH
PEh+nP6PB4CA7CWAAA3pIPNLJHGgHYrPFIOKDMgBUko+uLs/JMfht1V9cheS9965
czCScwhf4jH+dkuBxktESzCnOt5BtQP9Ckfo9dBiCSt6QR+iAmmoFT6Yh3+m/ZZd
Ukh5U595dXuB6MvuERZT23q5XuqGNodT9ydk96wtJXXwOBPHvhbacQka3rgpMkp2
keFDcASC/YkwsArXjFXP0o6jMdqyZ8v/7Yng4BjDhEfNCgh2GmeHO9OHshQLHL4S
dWIPSw4JKwsWgzmEn/1x8YdI/PEG17XuiJJ5pYTaEmgfYsIfz5u8PuTTegswCVab
VDvyt3rVHb0xNithnBbewCigW2Z249Nn6w9KaW5DDvKlkDuV7dfQlcO08XPVk6lJ
GA03pa8rAz2redCctuAbkkMvIbL1eDCwYmNHyXSHCnzyICfQDvi5SgkjZMGNyCiV
xWgWyVa7l/lB23miXdJl
=Y4ug
-----END PGP SIGNATURE-----

--gA19+fZe+9B2YWyg--


--===============3572201131095542308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============3572201131095542308==--
