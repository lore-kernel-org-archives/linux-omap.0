From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/4] ARM: dts: DRA7: Add timer12 node
Date: Mon, 5 Oct 2015 19:47:12 -0500
Message-ID: <87y4fgesbz.fsf@saruman.tx.rr.com>
References: <1444087704-1429-1-git-send-email-s-anna@ti.com> <1444087704-1429-4-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444087704-1429-4-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> writes:

> Add the DT node for Timer12 present on DRA7 family of
> SoCs. Timer12 is present in PD_WKUPAON power domain, and
> has the same capabilities as the other timers, except for
> the fact that it serves as a secure timer on HS devices
> and is clocked only from the secure 32K clock.
>
> The node is marked disabled for now, and the kernel should
> refrain from using this secure timer on HS devices.
>
> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/dra7.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index e289c706d27d..37d632dad576 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -762,6 +762,16 @@
>  			ti,hwmods =3D "timer11";
>  		};
>=20=20
> +		timer12: timer@4ae20000 {
> +			compatible =3D "ti,omap5430-timer";
> +			reg =3D <0x4ae20000 0x80>;
> +			interrupts =3D <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +			ti,hwmods =3D "timer12";
> +			ti,timer-alwon;
> +			ti,timer-secure;
> +			status =3D "disabled";

according to Tony we should avoid using status at all for in-SoC
devices.

Tony, can you confirm I understood you correctly ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWExoRAAoJEIaOsuA1yqREhhMP/jfbzZ73NFiOGklE+aV4RsAj
fdvD82uaW4eGf9QbC5boQWDMbg6cu7MOiLdNDu2Pd0K5nRkrxQVh53Z8Sp6h4A0O
a7r2ZG82FGd8Nwg6zmavoyz9GXytW/8mWvbNFjxjFDCKb2SdX+7RE+aobfpCjex8
oFiLLCL15gcVh2ethmkvtNf7XFDKPQKmUj84Wp7IL/cVsh1DX9f+/XF3Z4FZ0SS8
3vwMpNLqwtCpEvQkqB62Y3wOWHBW4nwJlyXe4SnN4hXeGlh6fzLfhmERI0MDu7t3
vklAVrUPL8vBVaHkQhuy6VeTpVrBpO6UKJtRDm/1sjVkzcvMAFyxQ7NGgQzJ2PLY
ENFQGS6hBJes/zE/T5FDixKtWbDra9m6/Co3uAoFKrpFD3PlTf2G+TR1Z007i96F
QHn0vtTPKm4Cq49biaIh2O4be0kVtNjs4qpsbjxgdzhP9SZORDXylam+TmTV6iOi
da4+Dq5ppu9OETME//BgyoLjWcVlto1mpDiZ67M2hn5jvAyieb4xWQkoNJHzLeRX
SuneGAbzOc1yZ1tA3kOwvZJZgdIHLaTpGCWpB4J68FQMTBZtkpA6C/9a6zvtQWr1
GUFCSevGnqrUWsr3mFy5xoEn7A7ccB3VNiZSa3vWTxDUI0srGGgy7nsNg9/uKNNd
FZ4PucSDo5YVhmnRna3C
=DeJD
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
