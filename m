From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Wed, 6 Jan 2016 18:40:40 +0100
Message-ID: <20160106174039.GA14271@earth>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <568662FC.9050206@gmail.com> <20160104170206.GC12777@atomide.com>
 <201601041834.56056@pali> <20160104174001.GD12777@atomide.com>
 <568AC0F9.2010304@gmail.com> <20160105041356.GE12777@atomide.com>
 <20160105084947.GG22661@pali> <20160105224929.GF12777@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8797231424484297234=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160105224929.GF12777@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, pavel@ucw.cz, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org


--===============8797231424484297234==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 05, 2016 at 02:49:29PM -0800, Tony Lindgren wrote:
> Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for debug")
> unified the GPMC debug for the SoCs with GPMC. The commit also left
> out the option for HWMOD_INIT_NO_RESET as we now require proper timings
> for GPMC to be able to remap GPMC devices out of address 0.
>=20
> Unfortunately on 900, onenand now only partially works with the device

You may want to change 900 to n900 (maybe even Nokia N900) before
actually committing this.

> tree provided timings. It works enough to get detected but the clock
> rate supported by the onenand chip gets misdetected. This in turn causes
> the GPMC timings to be miscalculated and this leads into file system
> corruption on n900.
>=20
> Looks like onenand needs CS_CONFIG1 bit 27 WRITETYPE set for for sync
> write. This is needed also for async timings when we write to onenand
> with omap2_onenand_set_async_mode(). Without sync write bit set, the
> async read for the onenand ONENAND_REG_VERSION_ID will return 0xfff.
>=20
> Let's exit with an error if onenand rate is not detected. And let's
> remove the extra call to omap2_onenand_set_async_mode() as we only
> need to do this once at the end of omap2_onenand_setup_async().
>=20
> Reported-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

-- Sebastian

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWjVGUAAoJENju1/PIO/qaE0EQAIHQdGqh6xvLHTUu4rq3dDYr
U8gAr5sGqyTrf2dQCWLOCADTDhdByqWica48D6YGA8a6/VMaWOaDZpZs8jF+fYiw
klJUsE8lZ+ZZADvgqd1yxJXtSjFDvySf5MloOwgforM9OVrq+q59MoUBm7+oqaRV
ieKaUlUhA6jyXtXO7f5pE7Ooi0bZyIwHYTswenqBarftmOjxCjz2U5Qmdy/GtkOl
xo8zU4FUs4p1zxmciZf2Zhqs4g/TmFBM/x9IpJrklJ9kSYKsYhVuDUS2DO6wFzFW
uZlx1kRCtIWx1HwhtiH3QliHLxlbQb4wNY+c3NbbV7kqiuPOja7tYtawTNzlggHF
vvD3ds+219kvYs4FhmBHH4cQSPqJR2m/SpxJAIbi3B2KVkZ0sp+yqrf9tTAB986y
YwqIyIFOVfDN81gn3n08Wr6FEJzZk34HGpNLWCkW5W4YJsZ7p8w+yTtDn1eJgSdb
wCEClZ1VijZVKnyBBhQTthXuUCbd2acE6x99KaoDky46anZPKqWT6iLdRZOnGPOo
pjEV390WLtx/A5t/uDPFMK9Ngisq1Il+nHTG5bkRZcVmMlXLtt3ADPfG/YDujk+9
wSf5a+DcB4rZOzdLVRQ1R8aznAx2NlGyQtJEy+BQJ2R7HUKUDLm4XZNxXBitPIyN
q3DRGJkojxkoBSYI5VMv
=C0h8
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--


--===============8797231424484297234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8797231424484297234==--
