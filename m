From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCHv3 3/6] arm: dts: add bandgap entry for OMAP443x devices
Date: Tue, 18 Jun 2013 16:14:15 -0400
Message-ID: <51C0BF97.6060900@ti.com>
References: <1370637968-23299-1-git-send-email-eduardo.valentin@ti.com>
 <1370637968-23299-4-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5011325765275957726=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1370637968-23299-4-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <eduardo.valentin@ti.com>, =?UTF-8?B?QmVub8OudCBDb3Vz?= =?UTF-8?B?c29u?= <b-cousson@ti.com>
Cc: linux@arm.linux.org.uk, linux-pm@vger.kernel.org, tony@atomide.com, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-kernel@vger.kernel.org, grant.likely@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============5011325765275957726==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2UBQQBEHXCETSXBHOKKUU"

------enig2UBQQBEHXCETSXBHOKKUU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Benoit,

On 07-06-2013 16:46, Eduardo Valentin wrote:
> This patch add the bandgap entry for OMAP4430 devices.
>=20
> Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-omap@vger.kernel.org
> Cc: devicetree-discuss@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

Could you please have a look on this one?

> ---
>  arch/arm/boot/dts/omap443x.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap44=
3x.dtsi
> index cccf39a..8d6c968 100644
> --- a/arch/arm/boot/dts/omap443x.dtsi
> +++ b/arch/arm/boot/dts/omap443x.dtsi
> @@ -24,4 +24,8 @@
>  			clock-latency =3D <300000>; /* From legacy driver */
>  		};
>  	};
> +	bandgap {
> +		reg =3D <0x4a002260 0x4 0x4a00232C 0x4>;
> +		compatible =3D "ti,omap4430-bandgap";
> +	};
>  };
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2UBQQBEHXCETSXBHOKKUU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHAv5cACgkQCXcVR3XQvP2ZZQD/eJHYitPEghv7Z8QjSSKBQL8m
UK2FxYUUGbrib2mo8WQBAIlJL1rQXKm1d3htEirsp1lcMvkM5Y/48HRUDetKH6PI
=ioy8
-----END PGP SIGNATURE-----

------enig2UBQQBEHXCETSXBHOKKUU--


--===============5011325765275957726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5011325765275957726==--
