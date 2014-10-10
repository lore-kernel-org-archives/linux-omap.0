From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 11/12] ARM: dts: am33xx: update rtc node compatible
 property
Date: Fri, 10 Oct 2014 13:08:49 -0500
Message-ID: <20141010180849.GY31348@saruman>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-12-git-send-email-johan@kernel.org>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4010996649042013597=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1412881594-25678-12-git-send-email-johan@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Johan Hovold <johan@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Colin Foe-Parker <colin.foeparker@logicpd.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, j-keerthy@ti.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, t-kristo@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, linux-arm-kernel@lists.infradead.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-omap@vger.kernel.org

--===============4010996649042013597==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0rEjiS+nMGFQ7Kkj"
Content-Disposition: inline

--0rEjiS+nMGFQ7Kkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2014 at 09:06:33PM +0200, Johan Hovold wrote:
> Enable am33xx specific RTC features (e.g. PMIC control) by adding
> "ti,am3352-rtc" to the compatible property of the rtc node.
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/am33xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 3a0a161342ba..098e53602d5c 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -411,7 +411,7 @@
>  		};
> =20
>  		rtc: rtc@44e3e000 {
> -			compatible =3D "ti,da830-rtc";
> +			compatible =3D "ti,am3352-rtc", "ti,da830-rtc";
>  			reg =3D <0x44e3e000 0x1000>;
>  			interrupts =3D <75
>  				      76>;
> --=20
> 2.0.4
>=20

--=20
balbi

--0rEjiS+nMGFQ7Kkj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUOCCxAAoJEIaOsuA1yqREKIQP/1hlg2cIWRHlDxYhSvG+0lSd
eK2Gl+PwZNahLVM2AUKuPbwqkFfFphl/EbNy0C8DjUTT4ccatmyS1m0xOq3+ucli
OrZPdLslnEkz6SV08GfYfbyRHdQUdhAKhxdXm5/+xYYtU2TvTEOcZQHYMYxSuTfQ
OThGr7v9NwO9WqvhImtlAqqF9QU9dMC6athhMb6SsS1CKxxEek4yHityiIl4iedN
KKqTNuFTaRT+wDq3G7TkB14ZLKLqV4YUKF0VdXzx/p2JoZizY5ie8JTSBUKI8U0h
PFpQzfLWX9B3GikqMrU3j2QiRFfs3p5pPhukaY43Ovhv8xco/Ep5Mp6sz3a/B5iX
XZT0IayyAj/TTI3epxcwMyw86xI/y7GTXllrTcGqSCS4vR4sWoU9pSwrKmE2dIXO
5y2eQGkydglZm5Yy7a4vXYTUXVpsrxMHRjKD4oyzCBvppWjr74s8pYiSYaCkknyG
9sYkwIySoTbmMEv7Y3PFVJvOe9U1kIUzHfLy8cF8l1WEF0XBeyOW1h5n+oXugOnd
dl/5esgr+CKRBLyo/WLOrO4iNQ4dR6/5Un8lFJFmcDq+GsXkMJjBp3fffbHJNXTp
C2fINuabfS4YLgxpzgSRE2d62MdGbN4sjweHLCIV2e/AwZaPyq2wRmRy1EQgI/NF
QOiXwCQ2cPXbvP0GbwLL
=/b2k
-----END PGP SIGNATURE-----

--0rEjiS+nMGFQ7Kkj--


--===============4010996649042013597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4010996649042013597==--
