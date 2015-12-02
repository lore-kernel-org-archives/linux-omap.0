From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/5] spi: introduce accelerated read support for spi
 flash devices
Date: Wed, 2 Dec 2015 19:41:25 +0000
Message-ID: <20151202194125.GL1929@sirena.org.uk>
References: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
 <1448860515-28336-2-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6700869830520781660=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1448860515-28336-2-git-send-email-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vignesh R <vigneshr@ti.com>
Cc: devicetree@vger.kernel.org, hramrach@gmail.com, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============6700869830520781660==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/bs84jhnE1DqD3f3"
Content-Disposition: inline


--/bs84jhnE1DqD3f3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 30, 2015 at 10:45:11AM +0530, Vignesh R wrote:
> In addition to providing direct access to SPI bus, some spi controller
> hardwares (like ti-qspi) provide special port (like memory mapped port)
> that are optimized to improve SPI flash read performance.

I'm reasonably OK with this from the SPI side but I'd really like to see
people working on MTD say that this makes sense.

--/bs84jhnE1DqD3f3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWX0lkAAoJECTWi3JdVIfQbBsH/i+LzrX/mNNWMO2Q8w2kJhx5
nwO6kUbQ+a4yvvd3YPcsrjAHB2s8cLUNnvxqGrYmu1By8TTW6icaxjxyTV+q0L4C
xEwYBM63BTG0qjpc+7uBwPQ9bDpDAU6uNDz3XD5zg4GxHffzkQSOKIMzpcCNnXv6
nqmU+cYVUAtkpC3UbJsFuXFyWynJgZ6sEBxMfhC/+80Ua4l4cVYtDXdDAiypKVC5
of9zgQt7bCSYyn3jLJpERnfn/ZUhVCxcb1eDmJuV+Jko7O3vg8SQ8mK+2ifrS1xK
oBhsZ4ZCj4ldptHi+/z15+L99IQB3iW4bFVaKIwwcOju329G1oUvs66hD07PcYw=
=ym/f
-----END PGP SIGNATURE-----

--/bs84jhnE1DqD3f3--


--===============6700869830520781660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6700869830520781660==--
