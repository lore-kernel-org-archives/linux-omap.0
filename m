From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] PalmZ71 - OMAP310 Clocks
Date: Wed, 25 Oct 2006 21:07:35 +0300
Message-ID: <20061025180733.GJ4852@atomide.com>
References: <200610241719.59561.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200610241719.59561.marek.vasut@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Marek =?utf-8?B?VmHFoXV0?= <marek.vasut@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Marek Va=C5=A1ut <marek.vasut@gmail.com> [061024 18:22]:
> Hi,
> this patch enables some clock on omap310.

> diff -Naur linux-omap/arch/arm/mach-omap1/clock.h linux-omap-z71/arch/a=
rm/mach-omap1/clock.h
> --- linux-omap/arch/arm/mach-omap1/clock.h	2006-10-15 16:09:10.00000000=
0 +0200
> +++ linux-omap-z71/arch/arm/mach-omap1/clock.h	2006-10-20 21:56:49.0000=
00000 +0200
> @@ -282,7 +282,7 @@
>  static struct clk dsp_ck =3D {
>  	.name		=3D "dsp_ck",
>  	.parent		=3D &ck_dpll1,
> -	.flags		=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
> +	.flags		=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX =
|
>  			  RATE_CKCTL,
>  	.enable_reg	=3D (void __iomem *)ARM_CKCTL,
>  	.enable_bit	=3D EN_DSPCK,
> @@ -295,7 +295,7 @@
>  static struct clk dspmmu_ck =3D {
>  	.name		=3D "dspmmu_ck",
>  	.parent		=3D &ck_dpll1,
> -	.flags		=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
> +	.flags		=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX =
|
>  			  RATE_CKCTL | ALWAYS_ENABLED,
>  	.rate_offset	=3D CKCTL_DSPMMUDIV_OFFSET,
>  	.recalc		=3D &omap1_ckctl_recalc,
> @@ -306,7 +306,7 @@
>  static struct clk dspper_ck =3D {
>  	.name		=3D "dspper_ck",
>  	.parent		=3D &ck_dpll1,
> -	.flags		=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
> +	.flags		=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX =
|
>  			  RATE_CKCTL | VIRTUAL_IO_ADDRESS,
>  	.enable_reg	=3D (void __iomem *)DSP_IDLECT2,
>  	.enable_bit	=3D EN_PERCK,
> @@ -320,7 +320,7 @@
>  static struct clk dspxor_ck =3D {
>  	.name		=3D "dspxor_ck",
>  	.parent		=3D &ck_ref,
> -	.flags		=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
> +	.flags		=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX =
|
>  			  VIRTUAL_IO_ADDRESS,
>  	.enable_reg	=3D (void __iomem *)DSP_IDLECT2,
>  	.enable_bit	=3D EN_XORPCK,
> @@ -332,7 +332,7 @@
>  static struct clk dsptim_ck =3D {
>  	.name		=3D "dsptim_ck",
>  	.parent		=3D &ck_ref,
> -	.flags		=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
> +	.flags		=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX =
|
>  			  VIRTUAL_IO_ADDRESS,
>  	.enable_reg	=3D (void __iomem *)DSP_IDLECT2,
>  	.enable_bit	=3D EN_DSPTIMCK,
> @@ -374,7 +374,7 @@
> =20
>  static struct clk tipb_ck =3D {
>  	/* No-idle controlled by "tc_ck" */
> -	.name		=3D "tibp_ck",
> +	.name		=3D "tipb_ck",
>  	.parent		=3D &tc_ck.clk,
>  	.flags		=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
>  			  ALWAYS_ENABLED,
> @@ -733,7 +733,7 @@
>  static struct clk i2c_fck =3D {
>  	.name		=3D "i2c_fck",
>  	.id		=3D 1,
> -	.flags		=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
> +	.flags		=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX =
|
>  			  VIRTUAL_CLOCK | CLOCK_NO_IDLE_PARENT |
>  			  ALWAYS_ENABLED,
>  	.parent		=3D &armxor_ck.clk,

Hmm, I thought 310 did not have a DSP? Or is it only 710 that does not
have a DSP?

Tony
