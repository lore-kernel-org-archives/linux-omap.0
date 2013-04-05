From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 2/4] ARM: OMAP4+: PM: Consolidate OMAP4 PM code to
 re-use it for OMAP5
Date: Fri, 5 Apr 2013 16:21:50 +0300
Message-ID: <20130405132150.GN11464@arwen.pp.htv.fi>
References: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com>
 <1365166743-5940-3-git-send-email-santosh.shilimkar@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0370674121315128808=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1365166743-5940-3-git-send-email-santosh.shilimkar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: khilman@deeprootsystems.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============0370674121315128808==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jozmn01XJZjDjM3N"
Content-Disposition: inline

--jozmn01XJZjDjM3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2013 at 06:29:01PM +0530, Santosh Shilimkar wrote:
> OMAP5 has backward compatible PRCM block and it's programming
> model is mostly similar to OMAP4. Same is going to be maintained
> for future OMAP4 based SOCs. Hence consolidate the OMAP4 power
> management code so that it can be re-used on OMAP5 and later devices.
>=20
> While at it, update the kernel-doc for omap4_pm_init().
>=20
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile                       |    9 +--
>  arch/arm/mach-omap2/{pm44xx.c =3D> pm_omap4plus.c}   |   58 ++++++++++++=
++++----
>  .../mach-omap2/{sleep44xx.S =3D> sleep_omap4plus.S}  |    0
>  3 files changed, 53 insertions(+), 14 deletions(-)
>  rename arch/arm/mach-omap2/{pm44xx.c =3D> pm_omap4plus.c} (83%)
>  rename arch/arm/mach-omap2/{sleep44xx.S =3D> sleep_omap4plus.S} (100%)
>=20
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index b068b7f..3e59895 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -35,14 +35,14 @@ obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)	+=3D sdrc.o
>  obj-$(CONFIG_SMP)			+=3D omap-smp.o omap-headsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU)		+=3D omap-hotplug.o
>  omap-4-5-common				=3D  omap4-common.o omap-wakeupgen.o \
> -					   sleep44xx.o
> +					   sleep_omap4plus.o
>  obj-$(CONFIG_ARCH_OMAP4)		+=3D $(omap-4-5-common)
>  obj-$(CONFIG_SOC_OMAP5)			+=3D $(omap-4-5-common)
> =20
>  plus_sec :=3D $(call as-instr,.arch_extension sec,+sec)
>  AFLAGS_omap-headsmp.o			:=3D-Wa,-march=3Darmv7-a$(plus_sec)
>  AFLAGS_omap-smc.o			:=3D-Wa,-march=3Darmv7-a$(plus_sec)
> -AFLAGS_sleep44xx.o			:=3D-Wa,-march=3Darmv7-a$(plus_sec)
> +AFLAGS_sleep_omap4plus.o		:=3D-Wa,-march=3Darmv7-a$(plus_sec)
> =20
>  # Functions loaded to SRAM
>  obj-$(CONFIG_SOC_OMAP2420)		+=3D sram242x.o
> @@ -80,11 +80,12 @@ endif
>  obj-$(CONFIG_OMAP_PM_NOOP)		+=3D omap-pm-noop.o
> =20
>  ifeq ($(CONFIG_PM),y)
> +omap4plus-common-pm			=3D omap-mpuss-lowpower.o pm_omap4plus.o
>  obj-$(CONFIG_ARCH_OMAP2)		+=3D pm24xx.o
>  obj-$(CONFIG_ARCH_OMAP2)		+=3D sleep24xx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+=3D pm34xx.o sleep34xx.o
> -obj-$(CONFIG_ARCH_OMAP4)		+=3D pm44xx.o omap-mpuss-lowpower.o
> -obj-$(CONFIG_SOC_OMAP5)			+=3D omap-mpuss-lowpower.o
> +obj-$(CONFIG_ARCH_OMAP4)		+=3D $(omap4plus-common-pm)
> +obj-$(CONFIG_SOC_OMAP5)			+=3D $(omap4plus-common-pm)
>  obj-$(CONFIG_PM_DEBUG)			+=3D pm-debug.o
> =20
>  obj-$(CONFIG_POWER_AVS_OMAP)		+=3D sr_device.o
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm_omap4p=
lus.c
> similarity index 83%
> rename from arch/arm/mach-omap2/pm44xx.c
> rename to arch/arm/mach-omap2/pm_omap4plus.c
> index 5ba6d88..228deca 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm_omap4plus.c
> @@ -1,7 +1,7 @@
>  /*
> - * OMAP4 Power Management Routines
> + * OMAP4+ Power Management Routines
>   *
> - * Copyright (C) 2010-2011 Texas Instruments, Inc.
> + * Copyright (C) 2010-2013 Texas Instruments, Inc.
>   * Rajendra Nayak <rnayak@ti.com>
>   * Santosh Shilimkar <santosh.shilimkar@ti.com>
>   *
> @@ -135,16 +135,16 @@ static void omap_default_idle(void)
>  }
> =20
>  /**
> - * omap4_pm_init - Init routine for OMAP4 PM
> + * omap4_init_static_deps - Add OMAP4 static dependencies
>   *
> - * Initializes all powerdomain and clockdomain target states
> - * and all PRCM settings.
> + * Add needed static clockdomain dependencies on OMAP4 devices.
> + * Return: 0 on success or 'err' on failures
>   */
> -int __init omap4_pm_init(void)
> +static inline int omap4_init_static_deps(void)

you can let compiler inline this if it chooses to, right ?? Otherwise,
if you really want to make sure this will be inlined, you could(should?)
be using __always_inline.

--=20
balbi

--jozmn01XJZjDjM3N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXs/uAAoJEIaOsuA1yqREXXgP/3wZkeQT8qDqJdT+20qCgieO
S7PJP5yIANmmxuZRRjcOchHmDczxNAHK1+/eTF2hJQjtodD7w8D4dDTWkefhTpw0
mzqIUPAvfdrjOlumOJ8iO+LuQm/f17FTYL+fYXWppKQTe7OlNm6GwqGGEgERFz2Z
ET34PBWowDxIZAMBbX60YBNdegqsyEyUzoXSMkOW+l3HpXNiE/n9xBqwz4DjRQg5
tE+GwXHl0bXmi4WinAbwwsmlzh28MjwJxy6cDFkgu0zvMyHK4GY2yIEfL403FnXF
iAmT6K4yeDT7mgKsbaNPuXxpVkII2PcrOtYwgvdC8YZ67Rj5LpFlor9CwmG0X5vp
HAyfJ5W6Sl1JVTULmAuD4D/OlCZlkBac+Tz1DqjExO+ZGyWzGveaUPSJWguP/IJb
phqOpra4uTYmVHViNQe7iAxeVtM92oXaQMy3gWNGmTfBj4OtpVThcZLq5Rh2DCRr
KUg65YfADH5fOgV2qdykvtH6eA4Yv2bt3WTaUivhBOCWapi3AWKyTHNVSZPDNdc6
kUyqVdP7WAC4OgjZd/MYB+Y3NKEmpo22xCqCTBgZ9NXTImoAn0QN5osEkLq1AtDM
mpmHuZS/mKfdO7AxDhwfaAB3e2fyQhDi4NZ4w5peUB310l9IxwvYOAEvizS75QkH
iIOrYztkRfOIYFEcDXIY
=AVKA
-----END PGP SIGNATURE-----

--jozmn01XJZjDjM3N--


--===============0370674121315128808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0370674121315128808==--
