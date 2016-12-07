From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 03/12] power_supply: axp288_charger: Replace the extcon
 API
Date: Wed, 7 Dec 2016 04:05:27 +0100
Message-ID: <20161207030527.n2u4q4tf7po74clg@earth>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
 <CGME20161130055742epcas1p3cbb269d69275ed6684a7baab0841519b@epcas1p3.samsung.com>
 <1480485460-2663-4-git-send-email-cw00.choi@samsung.com>
 <584605A6.1010803@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q7qlgssekejc346v"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <584605A6.1010803@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com, Peter.Chen@nxp.com, wens@csie.org, yoshihiro.shimoda.uh@renesas.com, maxime.ripard@free-electrons.com, b-liu@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, chanwoo@kernel.org
List-Id: linux-omap@vger.kernel.org


--q7qlgssekejc346v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chanwoo,

On Tue, Dec 06, 2016 at 09:26:14AM +0900, Chanwoo Choi wrote:
> Could you please review and pick the patch3/4 for power-supply driver?

Patches look fine. As I expect the merge window to open next week I
would rather not queue this for 4.10 and instead do it once 4.10-rc1
has been tagged.

-- Sebastian

--q7qlgssekejc346v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhHfHQACgkQ2O7X88g7
+prFpxAAqP/w2pJaL/br9YQqakmUKvXOMVfsXG0PkYe9w44C9LGy9CL65bMjnU6G
EpGF71NglC81KLJ3hiK7W4RAN/v+LhIe59TThZJR6LMpzfk7Y0Gntuy7AmueF6b4
bJOSYcsLsXMfRjDo1bTCF8/38GWihIbI8cgAPzrfBECgbq2ZSs3EsFS4gtbUkeQU
gDH4QEsc9upwcUfinHj4IGgK8ZE7fOeQHicPuBeYrWPtssPDLop0pPns3dnTFxYl
yxYi6IRKmxf7blzx0smMBXHeTml+ulXFfo+4PADBUnJbpxhHq3CSRSItiURxCTVI
KJ5pME6tcpEbmsrRsDFvzH4RvzCD924fHS0CbGDgK8n1VuehGeCEO57mobOtnddf
i7wVTwIPVlfzXqIB91tD5egMANeOwKTSkPhJy7zmmBO8bJjREWWINGzCbI8enZsO
CHJJDbPHqezooTzSOevGUEj39st5hlgf4eFGqpPY55+a1C+3pAuM8gPzQuc7p3Kz
75zwNr6OtXaW4S+jd9stQARmEv8W/ulQOg9Jje0XRvL512ODbxKZtbMTN6gW+WDf
ZM2Q18cGgFz7dvyq0kpl9dPEE3O/hqHjYwAQTEEk+U1xqyasyjoZi/GnR6Ol8uBM
JFWB0zEehTSDcCM5tCd1ArQs/Ycomy7HR998oZeShTaX/SsDHAA=
=LVYQ
-----END PGP SIGNATURE-----

--q7qlgssekejc346v--
