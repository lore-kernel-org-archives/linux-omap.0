From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v8 6/8] usb: musb: omap2430: use the new generic PHY
 framework
Date: Tue, 25 Jun 2013 18:20:23 +0300
Message-ID: <20130625152022.GK21334@arwen.pp.htv.fi>
References: <1372139926-3719-1-git-send-email-kishon@ti.com>
 <1372139926-3719-7-git-send-email-kishon@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="enGqbSaueFq5omEL"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1372139926-3719-7-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: grant.likely@linaro.org, tony@atomide.com, balbi@ti.com, arnd@arndb.de, swarren@nvidia.com, sylvester.nawrocki@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, benoit.cousson@linaro.org, mchehab@redhat.com, cesarb@cesarb.net, davem@davemloft.net, rnayak@ti.com, shawn.guo@linaro.org, santosh.shilimkar@ti.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, nsekhar@ti.com, balajitk@ti.com, george.cherian@ti.com
List-Id: linux-omap@vger.kernel.org

--enGqbSaueFq5omEL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2013 at 11:28:44AM +0530, Kishon Vijay Abraham I wrote:
> Use the generic PHY framework API to get the PHY. The usb_phy_set_resume
> and usb_phy_set_suspend is replaced with power_on and
> power_off to align with the new PHY framework.
>=20
> musb->xceiv can't be removed as of now because musb core uses xceiv.state=
 and
> xceiv.otg. Once there is a separate state machine to handle otg, these ca=
n be
> moved out of xceiv and then we can start using the generic PHY framework.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--enGqbSaueFq5omEL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRybU2AAoJEIaOsuA1yqREYuUP/3G0ujTU8oCkchPd2owVa459
ctcXP8EMSWVFyVeM2M42p8odILAaxkDUUFul6a/OTg/tdw6nPyccRG00AGpcdp5l
mXMM/AsC7LBrQfGXl05NgkeBvr5xauUOyASR/W7P5tDW3rsxUbqOF7ESFny/lZs6
f8HZkpyJv3WAJrzzA+K51oFZxQwg8sayDN+/WGykOf+cIs2XxEiEkVDghFB/Kd01
R/h+yJztnqKALlXw1QiqZ+Mx4RUHs/o4GWfE+MLQnrmVF0TzF5HTatagWd2ucEvh
9REGBIwxhQcCXXXpKB4CjwTLBb9ymz0iXy4JtXq26XRHqxWa3SgKLLABzCekkxEJ
FbU50ZLn5APPAlm/bAQwHr42PJD0lEdYvkKJCPFymWdOe2LiDxBkVA84WuDddR1J
b+kWkJQJ21s0DTV9JIOaFMyLVr2I4o+CiGavZYpTn4P760Eg1Jrmo6iRUvBUw5VR
rpq2wwAAfBN2BcmS2+SkqNuRuazRiQgxGdU5DqhI/5dXkSGBcp9rKAMUwOuA6UtY
bdlE9/hZmXq371QmfgVwv0LcdTA+NXZXQzmd/v/6UHnFriGTLKP7Ac62XHylIhyz
cmgfPy8TeqShKhUZwGM/CwelxB8w2XZVS3JKGGdjj0Og3A4mVjsHDwCEdCEvWHGe
o0ZBkF+K+9drinDBNiSz
=6+6N
-----END PGP SIGNATURE-----

--enGqbSaueFq5omEL--
