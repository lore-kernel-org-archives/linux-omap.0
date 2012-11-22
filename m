From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH v4 10/11] ARM: dts: AM33XX: Add PWM backlight DT data to
 am335x-evm
Date: Thu, 22 Nov 2012 22:11:47 +0100
Message-ID: <20121122211147.GI16716@avionic-0098.adnet.avionic-design.de>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-11-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3675697065647372592=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1353503469-18634-11-git-send-email-avinashphilip-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, vaibhav.bedia-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============3675697065647372592==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G3juXO9GfR42w+sw"
Content-Disposition: inline


--G3juXO9GfR42w+sw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 21, 2012 at 06:41:07PM +0530, Philip, Avinash wrote:
[...]
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index 9f65f17..4178ba4 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -44,6 +44,12 @@
>  				0x154 0x27	/* spi0_d0.gpio0_3, INPUT | MODE7 */
>  			>;
>  		};
> +
> +		ecap0_pins: backlight_pins {
> +			pinctrl-single,pins = <
> +				0x164 0x0	/* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
> +			>;

This looks kind of funky, but I see the rest of the file uses similar
formatting, so I guess it's okay.

> @@ -158,6 +174,13 @@
>  			gpio-key,wakeup;
>  		};
>  	};
> +
> +	backlight {
> +		compatible	= "pwm-backlight";

Maybe you don't want a tab between "compatible" and "=", but a space
instead.

Other than that, looks good:

Reviewed-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>

--G3juXO9GfR42w+sw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQrpUTAAoJEN0jrNd/PrOhIGMQAIBi9n7xA6obUrKlYLDKFdBe
t983odhwp0g+V7xp0qTRgTITCLdwYtjhHxb4hnQBUw222ZZzTh9xv+XCdd1JpLGp
vO9UVY2M2l6YLfIcDfRhjvjnmyvpsxAQ5ADMsVs1KTmJtBO221u7CZVJQVzfdHKh
CJ1DlEv/qkoSUkiUKjBw/+Eu4grwLOuBbbzBBxzoSf154jZM7HhOX2XVWzR8wkGG
pNq7daPfPuq5XIpkcR1/gl3sINb9A3wbIMTNm7Tg7DoZB4ihCjEAOUpHCiGK42ns
3XLZkXfsaL5D0KRhFsqJUHQcRG/7+HWJy3ByVHJK7X2lH6W1DSroFXjWuKllRzr7
Pm22CVK1CdSPOo88IuomRxI/5TOMetX1BONpMWzNMF5FkyvFTD/l8gsxut5EmO7Q
+QB5HOhR2s8SqioRHTuuIeBujhDkYEsuOzd5Cyi5FPsdF824aNfv4jgRAFMLZg4k
2l2V3+aXF/U6/ITwjUbNNqT/8VvD7qFPjl4ha5Sw02FMSCh/Bj4gzIWvU9IcAFY6
7/2LmOAazxS3mdjHNy31whbaPG8jp47Kr2sVrPovAWAN4lPG4TyL8Gy561zDTeR0
6bp0hSf7gZd6Wzn9i1yn7EIjOS5gK1K1mFjX0+72MfYcWtf10i+sqnlFaE78lAYQ
TMmWWcc3hw5UtFVL4JlR
=XTbD
-----END PGP SIGNATURE-----

--G3juXO9GfR42w+sw--

--===============3675697065647372592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============3675697065647372592==--
