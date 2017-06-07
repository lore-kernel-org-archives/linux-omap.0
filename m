From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: Remove unused legacy code for device
 init
Date: Thu, 8 Jun 2017 00:27:11 +0200
Message-ID: <20170607222711.6kdhuvkymiseootn@earth>
References: <20170531225139.30723-1-tony@atomide.com>
 <20170531225139.30723-5-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3615729711519795241=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170531225139.30723-5-tony@atomide.com>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============3615729711519795241==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cmnmpnril66kvvcn"
Content-Disposition: inline


--cmnmpnril66kvvcn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 31, 2017 at 03:51:32PM -0700, Tony Lindgren wrote:
> [...]
> -
>  static inline void omap_init_sti(void) {}
> =20
> [...]
> @@ -190,49 +68,8 @@ int __init omap_init_vout(void) { return 0; }
> =20
>  static int __init omap2_init_devices(void)
>  {
> -	/* Enable dummy states for those platforms without pinctrl support */
> -	if (!of_have_populated_dt())
> -		pinctrl_provide_dummies();
> -
> -	/* If dtb is there, the devices will be created dynamically */
> -	if (!of_have_populated_dt()) {
> -		/*
> -		 * please keep these calls, and their implementations above,
> -		 * in alphabetical order so they're easier to sort through.
> -		 */
> -		omap_init_mcspi();
> -		omap_init_sham();
> -		omap_init_aes();
> -		omap_init_rng();
> -	}
>  	omap_init_sti();
> =20
>  	return 0;
>  }
>  omap_arch_initcall(omap2_init_devices);
> -
> [...]

I guess you can drop omap2_init_devices() completly?

-- Sebastian

--cmnmpnril66kvvcn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk4fbkACgkQ2O7X88g7
+pqZug/+KLHgaRV6RzoeqVPsEdhsJitAcTqLYW7KBcKfUgBXabh92weZF1r0JSgu
2tNnVrh8tQOCzpzz+8giws1V4ERVb9TPFa9EXafEz7p4IhqIWkY4ZiY/HRg+iZeK
UYHtNkKR1QiCpgluD7hI7tSD1yzGdi54BEYZkAsVzzUqsdxatw1pNkhGWqP5Ujp3
j26b3O0IqK13+QcpzQtY6ABXBcFTrlHUeoPNQOS1JYddirSbL2KnaUoJED9qiUnN
LQIo8T8k3cq4OGRowaqHdQ/2J2Y1z5DouGqOdI8R7EBXCFehqWJzh/VZRaF1OWVY
etICr5BtuoNaxnzXvFaaCgu51u33wBX/g7ZsIn6Ej5sHCuazSlGL+ZTvT66WaVkv
JTBestfFNOaQExAXdIJshAObv9UaJYPuEjHfkUgok61I5+73FUe5iy+NkSHECGDP
Vsu2V9ffy5gkkz00VPwtJAPJyex2PpAg/8eLghDBmgsuwqad/O0VKlkym3ErFxPt
U8iYn/RiZ/ta8M8F6nanyyT+yz5UegLnoew1QPXhpfqrpgpn8TGbzJMubTGIyna5
f6nu6EYvptjo5n4Yh7chTB7KbngdWCDcn19+hMQG6N5WzXN9wq5OTRBzyWv549bT
PFp4of95ZgANYS2d+B8fpq/UHJuE0+8iYfSmktfqRXK8wgTq/DQ=
=fD12
-----END PGP SIGNATURE-----

--cmnmpnril66kvvcn--


--===============3615729711519795241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3615729711519795241==--
