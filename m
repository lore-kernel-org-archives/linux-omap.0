From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/3][v2] drivers: usb: dwc3: Add frame length adjustment
 quirk
Date: Tue, 1 Sep 2015 02:20:33 -0500
Message-ID: <20150901072033.GA2873@saruman.tx.rr.com>
References: <1439785496-27243-1-git-send-email-nikhil.badola@freescale.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1439785496-27243-1-git-send-email-nikhil.badola@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikhil Badola <nikhil.badola@freescale.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 17, 2015 at 09:54:56AM +0530, Nikhil Badola wrote:
> +static void dwc3_frame_length_adjustment(struct dwc3 *dwc, u32 fladj)
> +{
> +	if (dwc->revision < DWC3_REVISION_250A)
> +		return;
> +
> +	if (fladj =3D=3D 0)
> +		return;
> +
> +	if (fladj) {

right here you know fladj to be non-zero.

> @@ -957,6 +990,7 @@ static int dwc3_probe(struct platform_device *pdev)
>  		goto err1;
>  	}
> =20
> +

stray change

--=20
balbi

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV5VHBAAoJEIaOsuA1yqREPAIQAJrIJxZtf99ghjsy7rPLOoqj
rSUUjf+gcls0txUsNE3toybybh1AuHrp95aQkLArWerYk7sM5YNGMmUA+nkKjwnp
dTcBLqJduwrwbPfYy+uXeqJfXkSRoyMChYCXTZXzC1L4zpWRkIJJG3PuLlMwc7gP
++8RZfc7NcHk+bFiB4E0150t1H+sWxePwxPGFPbO2TtZhqc/xIss403t3UVuqyMt
snPcpHYSqLNy41SiwDnjjqyJCa+P3mtV8UzyrljDON8ZVLneuW4hWGobMrr8vErY
MQipUoE1Z67460gx++QJpHC0cWWdXnXFUsUOC6XzKmgZVGQd+DMYeL9ONnaLCqeF
1YdY7wrOQ/pm6U9tMvlbmCQcDg7Eawnm3ETAewUolirwXJ++T1JCqVmwZqaFSCM3
/uG5lfKlAZigc6act/ixbPzXDvVut/04oiFpG5gDtbo53Vp8gdWvEE5aip7x0fBZ
aZigKQgH3eTbt7T86uHZZlBk0rpQpLrJygjw5PqNDE227G+Pc9d2p8Dxzm8g5sgS
FTQQXHBu0Q/SnMuePBPc0oao+E8gVJjRmaOe2hR9et/4xaW7po+/fJSd6q2BRpME
8A5sU0MsoXg2wSgyhQ7vAjk3XbnyT5ess0MP4Ndi8pzsT0P9CNk7Ias9w0JJP215
rC0SDnJr7OjNTeJlKo3k
=hPjM
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
