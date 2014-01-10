From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] ARM: DRA7XX: Add support for DRA7XX only build
Date: Fri, 10 Jan 2014 10:15:38 -0600
Message-ID: <20140110161538.GI6665@saruman.home>
References: <1389347850-22435-1-git-send-email-t-kristo@ti.com>
 <1389347850-22435-3-git-send-email-t-kristo@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7029902391567197511=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1389347850-22435-3-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============7029902391567197511==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="poJSiGMzRSvrLGLs"
Content-Disposition: inline

--poJSiGMzRSvrLGLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2014 at 11:57:30AM +0200, Tero Kristo wrote:
> SOC_DRA7XX was under wrong menu within Kconfig file, which prevented
> DRA7XX only build. Fixed the kconfig options for this SoC as we are
> there. voltage.c needs to be added to the DRA7XX build also, otherwise
> DRA7XX only build will fail.
>=20
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

one comment below, other than that:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/Kconfig  |   18 ++++++++++--------
>  arch/arm/mach-omap2/Makefile |    1 +
>  2 files changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index dc21df1..e65948a 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -76,6 +76,16 @@ config SOC_AM43XX
>  	select ARM_GIC
>  	select MACH_OMAP_GENERIC
> =20
> +config SOC_DRA7XX
> +	bool "TI DRA7XX"
> +	depends on ARCH_MULTI_V7
> +	select ARCH_OMAP2PLUS
> +	select ARM_CPU_SUSPEND if PM
> +	select ARM_GIC
> +	select CPU_V7
> +	select HAVE_SMP
> +	select HAVE_ARM_ARCH_TIMER
> +
>  config ARCH_OMAP2PLUS
>  	bool
>  	select ARCH_HAS_BANDGAP
> @@ -128,14 +138,6 @@ config SOC_HAS_REALTIME_COUNTER
>  	depends on SOC_OMAP5 || SOC_DRA7XX
>  	default y
> =20
> -config SOC_DRA7XX
> -	bool "TI DRA7XX"
> -	select ARM_ARCH_TIMER
> -	select CPU_V7
> -	select ARM_GIC
> -	select HAVE_SMP
> -	select COMMON_CLK

seems like you lost COMMON_CLK when moving this up, was that on purpose?

--=20
balbi

--poJSiGMzRSvrLGLs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS0ByqAAoJEIaOsuA1yqREow8P/RRBHYm1FF3qovmrNt1TGq3O
mOfEwTf/AEyNLluvn0ruYVWN+XD3gU0jitdJqRDUJxjDwbtIFQvQyFSCia7FfsGV
/546jdlAbEqzipqXBA9Cc9AQoTXZeVWAFeVJulO05UINKeFJH9qsJwfL5SoRDlmx
/+ApJOI82xW9Xrgy2v3BTVHaEpvqpSbhIJ8T78FO/CjIqxm82/da4h2nCt1THBz4
EVfvR5Qb05o8s8nTreAIUU5d7TYxmnWjXd6ZNSNTGSH/NqK/plAjadHe2l8+67YE
GPrMsqKSaEb8MMrESxYJ/urmN6FPVbzRCzUXmjJUUWQkDGQ/hL7a0XhensopL6M/
rjE8O5sjATui6HobiYyArNzt8Y0eHX45BHTaBzCJ9DzkKDVJ2A2K8X+/AbHO6peW
v4vDALrGQWixUp72n3aZ6yN8X55jDDLhgEL5ud1cG2m0RiL7zO2R9mebLvrYzS9K
TouQuecxI/riceC34BQwsvXxPMCnmxzpDm1qjScSmdzOXM0Opx67qr+yhbmUq2i1
nKO56GH74yMeEih8YM3akaWtoO+CcyFvEI1YhfJJvHqX/aySVQW6aX3Y716uhWDJ
TGc7jBOk1ZeGefQQ6ZHo/gIFRpOg6nAmbRtTbgigPdZ/vkaAr0YGmh4Pt8POKvrm
pMu/WNmPn5txzNPY/VR2
=UC67
-----END PGP SIGNATURE-----

--poJSiGMzRSvrLGLs--


--===============7029902391567197511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7029902391567197511==--
