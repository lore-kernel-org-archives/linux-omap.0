From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: dts: am335x-bone*: usb0 is hardwired for peripheral
Date: Tue, 24 Feb 2015 10:19:41 -0600
Message-ID: <20150224161941.GM29829@saruman.tx.rr.com>
References: <1424794243-23394-1-git-send-email-robertcnelson@gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pjk796cY0SfIo9Z2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45154 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397AbbBXQUc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Feb 2015 11:20:32 -0500
Content-Disposition: inline
In-Reply-To: <1424794243-23394-1-git-send-email-robertcnelson@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--Pjk796cY0SfIo9Z2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2015 at 10:10:43AM -0600, Robert Nelson wrote:
> Fixes: http://bugs.elinux.org/issues/127
>=20
> the bb.org community was seeing random reboots before this change.
>=20
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>

that's a dead giveaway considering the connector in the board :-)

Thanks

Reviewed-by: Felipe Balbi <balbi@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dt=
s/am335x-bone-common.dtsi
> index 6cc25ed..2c6248d 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -195,6 +195,7 @@
> =20
>  &usb0 {
>  	status =3D "okay";
> +	dr_mode =3D "peripheral";
>  };
> =20
>  &usb1 {
> --=20
> 2.1.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--Pjk796cY0SfIo9Z2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7KSdAAoJEIaOsuA1yqREJ0cP/3EqEizNfsl6551eAb4930uN
dXtAdardyMGBu7fvCxxKpYtVk1Zill4KA41lCai4olL790bATnBO3DWY1MG4K5kN
QkK1aG0LG7GcHYIHJ1NvWWYDz3rOV3K3KNu5jd0cmrTMS61P7/ieyoCnd+IYzlfh
X8CF7RNk3hWL+SCMGQDgnzSe24dd+C1mX9kMAav2gZE2WGO59ydCiMQNiPKBSshg
KRm6N/cHXMXKfkB1NHNuSkHpod6S0khmMFPLVwE1tjtCWT8caxKhq6z0HHLJuELq
XW634TVSrMhKXH/bBDJV7BYms3SJb09cXdno4YlCvSTc1+q3ichdFsdsoEi/ZSRT
yAcPBJe5yz+tbIjL9jc1JMTFM9R4GVpaTjS9Q5LqY3QAz3vLAuUyYtWYIenfoGvf
+rI6hf2TQw7cCMF9fGBZWSlSsT6fI/ki9sulMX18YKrlnSyK5Kl4gH0NhDFhebaI
d856/pdZvGgKZTjKn/nzdCTa9xKBMGj/G8h9N3R9aTLRUkdscvjC2xtEoZCbKR+C
uKYKLKEhBWpRfx5oIadvO6daPyrHmis7goK0mrtZQNCVf/wQZMHLcP6styW8T9/H
2Dw9Mns0GfyvsUrTodsxDGp2xaMkXWfKe5sUfa6O9jN4odM1txsgVuxHwNoPx1fv
2u6FfF2x0Y0etUy1Lq9T
=g3Ab
-----END PGP SIGNATURE-----

--Pjk796cY0SfIo9Z2--
