From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 4/5] ARM: dts: DRA7: Add memory map region entries
 for qspi
Date: Fri, 31 Jul 2015 19:19:03 +0100
Message-ID: <20150731181903.GN20873@sirena.org.uk>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
 <1438072876-16338-5-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1845614372539546579=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438072876-16338-5-git-send-email-vigneshr@ti.com>
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
Cc: devicetree@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, Huang Shijie <b32955@freescale.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============1845614372539546579==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MSd2ShuMixI0uVaZ"
Content-Disposition: inline


--MSd2ShuMixI0uVaZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2015 at 02:11:15PM +0530, Vignesh R wrote:
> Add qspi memory mapped region entries for DRA7xx based SoCs.
>=20
> Signed-off-by: Vignesh R <vigneshr@ti.com>

>  		qspi: qspi@47900000 {
>  			compatible =3D "ti,am4372-qspi";
> -			reg =3D <0x47900000 0x100>;
> +			reg =3D <0x47900000 0x100>,
> +			      <0x30000000 0x3ffffff>;
> +			reg-names =3D "qspi_base", "qspi_mmap";

The DT binding document for the controller needs to be extended to
document this change in the binding.

--MSd2ShuMixI0uVaZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVu7wXAAoJECTWi3JdVIfQvi8H/2W+R7cKglm9p4j8auQ7ZMvY
87fE/A0i6i5RnQF2TW2eDB4V1QTHIi8rPQPOY7CAt2rP0URkAHDJPY5Nw0p7LRrt
VLMWSndfvZrL9tmhTxwXIXuQM2ZanipaEx555WtJTbdPcttcuqmWt6MHiH1kWlfc
YK0VkfbdI7YtBctKCZfGTk1aUE/5jJZ4A4pi4FSUUSYFR4U/GypjxisNkNo4e+1L
xKZg25o6iRhWh6RlDi3zxLFhVBMG5UJz3LZ3GhQM0+6pbDpyfy9kqaJkorCyj0ss
x+oZq31kYiknF1O9zAuuXvlrLYNqkYFEkCBJASZJbNq/0LOmqKSB4Yg1AtheJtI=
=kTX6
-----END PGP SIGNATURE-----

--MSd2ShuMixI0uVaZ--


--===============1845614372539546579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1845614372539546579==--
