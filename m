From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/3][v3] drivers: usb: dwc3: Add frame length adjustment
 quirk
Date: Thu, 3 Sep 2015 10:55:21 -0500
Message-ID: <20150903155521.GD4031@saruman.tx.rr.com>
References: <1441260244-27279-1-git-send-email-nikhil.badola@freescale.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441260244-27279-1-git-send-email-nikhil.badola@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikhil Badola <nikhil.badola@freescale.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2015 at 11:34:04AM +0530, Nikhil Badola wrote:
> Add adjust_frame_length_quirk for writing to fladj register
> which adjusts (micro)frame length to value provided by
> "snps,quirk-frame-length-adjustment" property thus avoiding
> USB 2.0 devices to time-out over a longer run
>=20
> Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
> ---
> Changes for v3:
> 	- removed unnecessary if(fladj) condition
> 	- removed stray newline
>=20
>  drivers/usb/dwc3/core.c          | 34 ++++++++++++++++++++++++++++++++++
>  drivers/usb/dwc3/core.h          |  5 +++++
>  drivers/usb/dwc3/platform_data.h |  2 ++
>  3 files changed, 41 insertions(+)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 064123e..75a17bf 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -143,6 +143,32 @@ static int dwc3_soft_reset(struct dwc3 *dwc)
>  	return 0;
>  }
> =20
> +/*
> + * dwc3_frame_length_adjustment - Adjusts frame length if required
> + * @dwc3: Pointer to our controller context structure
> + * @fladj: Value of GFLADJ_30MHZ to adjust frame length
> + */
> +static void dwc3_frame_length_adjustment(struct dwc3 *dwc, u32 fladj)
> +{
> +	if (dwc->revision < DWC3_REVISION_250A)
> +		return;
> +
> +	if (fladj =3D=3D 0)
> +		return;
> +
> +	u32 reg;
> +	u32 dft;

are you seriously telling me that GCC didn't warn you about mixing
declaration and code ?

--=20
balbi

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV6G1pAAoJEIaOsuA1yqREYFsQAJxj+tfMLH5o3CLzP/erFQZY
s0AIsM3mTMCSE6MrkmDYld8RFDJAFuxygRJDdIuDxo65XimCwDIP/FFbkXwiqZjO
9h6IE/lCzhl2bgATUw6KA8XmFFiWxbfS/R4nlADGg7wUlCCa4xs03Ep8HyorTb7B
U7MqyvOJGD2a8FjZOy/ncfZNC0rGAd9IYA1g9W3sM3M7Ksy6/G95XexRaKGw1uKD
LII9VI4BC1JFFg+zwkIk3vTwoOBWhKAlTjNiVO3DmC+AusLHBmX+1adgw53X9Udf
dA33wHRv9O69nsOqWWDj57ObEidHAAjm4pYjl6x15BQrUb73aL3B+3JF5ifQgzRQ
cjHCJsF4V47N+qi9Eko8F3IWg/48U6iQ4S8DgKq2MprFp2/jGONGx19NqhBo82EF
x91NiwpF79zYhhWHHbgtIKRpSRJbc3JSW5QYNk7g5jyW3dmFuIf7Z6WIedSJgwtM
V/uf2mvgly8QFQbsDZxx7rt9TFIDG2cXcGnK4B3rCRH/JCkSda60pr6K1MPd2tgZ
uzDeVk1PQrxQPkMM+uv6FDI+6O3Xz99ybtrnDHTHF/9TSM+/I03wQTT/1ZqkknGa
3SIzw6B/yN069LF4lElxSFiLUWXQbOsQjUvnu0J6GDr/XODk9NVzzdavscXD79Hg
4gERG0o/b/RLbp8mCADw
=0uzn
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--
