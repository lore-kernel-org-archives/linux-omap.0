From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH, RFC 5/8] ARM: OMAP2+: am43: Kconfig
Date: Tue, 19 Feb 2013 12:56:33 +0200
Message-ID: <20130219105633.GN23197@arwen.pp.htv.fi>
References: <cover.1361186097.git.afzal@ti.com>
 <5951ba90110b97fb494743e1aedf26aaa92b97a9.1361186097.git.afzal@ti.com>
 <5123537B.8050709@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4529088965834286448=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5123537B.8050709-l0cyMroinI0@public.gmane.org>
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
To: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Syed Mohammed Khasim <khasim-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============4529088965834286448==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yK/6QRnH3Zanb0EF"
Content-Disposition: inline

--yK/6QRnH3Zanb0EF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2013 at 03:57:07PM +0530, Santosh Shilimkar wrote:
> On Monday 18 February 2013 05:08 PM, Afzal Mohammed wrote:
> >Add Kconfig option for AM43 family of SoC's, these are ARM Cortex A9
> >based (SMP configuration with 1 core).
> >
> >Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
> >---
> >  arch/arm/mach-omap2/Kconfig | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> >diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> >index 49ac3df..683fbaa 100644
> >--- a/arch/arm/mach-omap2/Kconfig
> >+++ b/arch/arm/mach-omap2/Kconfig
> >@@ -141,6 +141,17 @@ config SOC_AM33XX
> >  	select MULTI_IRQ_HANDLER
> >  	select COMMON_CLK
> >
> >+config SOC_AM43
> >+	bool "TI AM43"
> >+	depends on ARCH_OMAP2PLUS
> >+	default y
> >+	select CPU_V7
> >+	select HAVE_SMP
> You don't need this

actually, this is needed for CONFIG_SMP_ON_UP

--=20
balbi

--yK/6QRnH3Zanb0EF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRI1phAAoJEIaOsuA1yqREYwwQAKjMwrUzLNukfn2riXws4I8W
6fi16GEdNQmLSjy/F8R8zB7liN/2yYi3cB5Q1E+YRCqyHQjXb5l3wPKvCrrHsMH/
JCnP6BgbMBEKEEOqdjbFFOGexGvyS2ST757/hmifN8i1/zz1z1jJ1l3wprP+MBHe
uPqmym7KVuWtbfeTHygjHmRdQ5KPRN5D+5MpK1QL/Vmt6FzPl31xH0k2i01X0qOn
MGOj0EbeRnixhzaZSDg/N7Vts5wt3rLyoJII5nWVY7h0ZJgpcOsm+E7SGytPd5Ve
no3AoAcrT5hPuW2e5L1h63ftaaYwN6BqiZi/n0UxsbtmUaArgyRUMSCrnhIkb0Ps
u4CELAiqddTMFbYRLc3ms1bMMB1ye0X6YHeCCf9wCxxjYIYuV4T/EOurVFprp38A
PwOse7JcZneZ25v2zilF9rikE/RoC7JlGFyXPygatzUTtVbpULR2DUWQm1+yC8Y0
d+T1TGLhfLMJJ1xAKWw4tegA8kgIU+Ui6Sm/JWsDsvzmySLsc8CXcDaf8xSO7Sj4
rRCw0/X21P2QrQ9mjD0yA02ADNFC6KgiqSMUTMw+AzawmjxMH3n0fo3+22KpwBeH
t/wKSK40OQTqV+mtDVRwpHQ3EIx0Wt9cISTyhAFr0tdEr4zrmCGIbCCxBwTg6003
7XWntEvtBqd+K6eaDXM0
=GxrB
-----END PGP SIGNATURE-----

--yK/6QRnH3Zanb0EF--

--===============4529088965834286448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4529088965834286448==--
