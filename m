From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 08/11] ARM: OMAP2+: Remove unused legacy code for PRM
Date: Thu, 20 Jul 2017 16:45:06 +0200
Message-ID: <20170720144506.rjar4dxih6ixavcp@earth>
References: <20170531225139.30723-1-tony@atomide.com>
 <20170531225139.30723-9-tony@atomide.com>
 <20170630104256.GG3730@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2550696680473109141=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170630104256.GG3730@atomide.com>
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


--===============2550696680473109141==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rdncs5n7wnfcz3yy"
Content-Disposition: inline


--rdncs5n7wnfcz3yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 30, 2017 at 03:42:56AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [170531 15:55]:
> > We are now booting all mach-omap2 in device tree only mode.
> > Any code that is only called in legacy boot mode where
> > of_have_populated_dt() is not set is safe to remove now.
> ...
>=20
> > diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44x=
x.c
> > --- a/arch/arm/mach-omap2/prm44xx.c
> > +++ b/arch/arm/mach-omap2/prm44xx.c
> ...
>=20
> > -static int omap44xx_prm_late_init(void)
> > -{
> > -	int irq_num;
> > -
> > -	if (!(prm_features & PRM_HAS_IO_WAKEUP))
> > -		return 0;
> > -
> > -	/* OMAP4+ is DT only now */
> > -	if (!of_have_populated_dt())
> > -		return 0;
>=20
> Turns out I misread the above and this code is still needed for omap4 PRM
> interrupts, so applying a partial revert below to fix it.

I just spent a couple of hours to tracing this and now saw, that you
already did so. Why was this not part of the pull request? :(

> 8< ----------------------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Fri, 30 Jun 2017 03:37:03 -0700
> Subject: [PATCH] ARM: OMAP4: Fix legacy code clean-up regression
>=20
> Commit 2a26d31b1bae ("ARM: OMAP2+: Remove unused legacy code for PRM")
> removed PRM platform init code that I thought is unused. Turns out omap4
> still needs this code, so let's do a partial revert to add it back.
>=20
> I probably missed this earlier as the comments used to say
> "OMAP4+ is DT only now" for !of_have_populated_dt() to exit early and
> missed the negative test. Let's not add those lines back as they are
> confusing and no longer needed as we only boot in device tree mode.

haha, I came up with *exactly* the same patch and then noticed
this mail when I checked for a Message-ID as reference :)

> Without things things can mysterious fail for i2c, for example LM75
> I2C temperature sensor can stop working as the PRM interrupts won't work.

Here is the demystification:

Without this fix omap4_pmx_core and omap4_pmx_wakeup will not
register themself as interrupt controller, due to missing parent
interrupt. This means, that any device referencing an interrupt
in one of those controllers will fail their probe routine with
-EPROBE_DEFER waiting for the interrupt controller to appear.
At least for i2c this happens directly in the core, even before
calling the driver's probe routine making this look quite
mysterious.

TLDR: Fix "wakeup-source;" using devices on omap4.

> Fixes: 2a26d31b1bae ("ARM: OMAP2+: Remove unused legacy code for PRM")
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>  arch/arm/mach-omap2/prm44xx.c | 55 +++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 55 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
> --- a/arch/arm/mach-omap2/prm44xx.c
> +++ b/arch/arm/mach-omap2/prm44xx.c
> @@ -337,6 +337,27 @@ static void omap44xx_prm_reconfigure_io_chain(void)
>  }
> =20
>  /**
> + * omap44xx_prm_enable_io_wakeup - enable wakeup events from I/O wakeup =
latches
> + *
> + * Activates the I/O wakeup event latches and allows events logged by
> + * those latches to signal a wakeup event to the PRCM.  For I/O wakeups
> + * to occur, WAKEUPENABLE bits must be set in the pad mux registers, and
> + * omap44xx_prm_reconfigure_io_chain() must be called.  No return value.
> + */
> +static void __init omap44xx_prm_enable_io_wakeup(void)
> +{
> +	s32 inst =3D omap4_prmst_get_prm_dev_inst();
> +
> +	if (inst =3D=3D PRM_INSTANCE_UNKNOWN)
> +		return;
> +
> +	omap4_prm_rmw_inst_reg_bits(OMAP4430_GLOBAL_WUEN_MASK,
> +				    OMAP4430_GLOBAL_WUEN_MASK,
> +				    inst,
> +				    omap4_prcm_irq_setup.pm_ctrl);
> +}
> +
> +/**
>   * omap44xx_prm_read_reset_sources - return the last SoC reset source
>   *
>   * Return a u32 representing the last reset sources of the SoC.  The
> @@ -668,6 +689,8 @@ struct pwrdm_ops omap4_pwrdm_operations =3D {
>  	.pwrdm_has_voltdm	=3D omap4_check_vcvp,
>  };
> =20
> +static int omap44xx_prm_late_init(void);
> +
>  /*
>   * XXX document
>   */
> @@ -675,6 +698,7 @@ static struct prm_ll_data omap44xx_prm_ll_data =3D {
>  	.read_reset_sources =3D &omap44xx_prm_read_reset_sources,
>  	.was_any_context_lost_old =3D &omap44xx_prm_was_any_context_lost_old,
>  	.clear_context_loss_flags_old =3D &omap44xx_prm_clear_context_loss_flag=
s_old,
> +	.late_init =3D &omap44xx_prm_late_init,
>  	.assert_hardreset	=3D omap4_prminst_assert_hardreset,
>  	.deassert_hardreset	=3D omap4_prminst_deassert_hardreset,
>  	.is_hardreset_asserted	=3D omap4_prminst_is_hardreset_asserted,
> @@ -711,6 +735,37 @@ int __init omap44xx_prm_init(const struct omap_prcm_=
init_data *data)
>  	return prm_register(&omap44xx_prm_ll_data);
>  }
> =20
> +static int omap44xx_prm_late_init(void)
> +{
> +	int irq_num;
> +
> +	if (!(prm_features & PRM_HAS_IO_WAKEUP))
> +		return 0;
> +
> +	irq_num =3D of_irq_get(prm_init_data->np, 0);
> +	/*
> +	 * Already have OMAP4 IRQ num. For all other platforms, we need
> +	 * IRQ numbers from DT
> +	 */
> +	if (irq_num < 0 && !(prm_init_data->flags & PRM_IRQ_DEFAULT)) {
> +		if (irq_num =3D=3D -EPROBE_DEFER)
> +			return irq_num;
> +
> +		/* Have nothing to do */
> +		return 0;
> +	}
> +
> +	/* Once OMAP4 DT is filled as well */
> +	if (irq_num >=3D 0) {
> +		omap4_prcm_irq_setup.irq =3D irq_num;
> +		omap4_prcm_irq_setup.xlate_irq =3D NULL;
> +	}
> +
> +	omap44xx_prm_enable_io_wakeup();
> +
> +	return omap_prcm_register_chain_handler(&omap4_prcm_irq_setup);
> +}
> +
>  static void __exit omap44xx_prm_exit(void)
>  {
>  	prm_unregister(&omap44xx_prm_ll_data);
> --=20
> 2.13.1
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--rdncs5n7wnfcz3yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllwwe8ACgkQ2O7X88g7
+pqEdg/+IxotaNCFW49LAY4lyatEJ6TQiOUA4YIwyqNdKUf8zwyjDR22kp2aHmZm
WkE88qL0V4TISW0TQcq1a0d/VOXExNBejw1978HhonubY7z9eRs04cL/XbouXx9O
ev0xspbDgmH0WLTBjAinnqXHgsWFWUrjdRRiej0T7gqEc99u95Hat2l6nyuPdV5x
RJnez1Gc6zqajTwud9wdWl4UjbxE8MnUcKgquNtCzl61MyD0lbaOHET+DebeflFP
9x7M5AiAbd1OVs29D1002KmmDMmOKRi35qtLPVBNDdSBNYdbuK8hZxQQygI4F5kp
LyoSBESjdWSqsrswV5Fokmb9EgFLjMm6NU9p2rU0LhhH781zFUxCCsKqr9fJKsiZ
s7KsJpofIZcaO0VlXRg6pxrGAa7kBvO2OhIK8upJ6AEKK6YEsJ39BlmMFL0HwHvN
M2SHlSNd/Tv8FzcxPYeZKFcTGiEsDcCPjgDJYgi4P/KcuJB006GC3ShbLWrWp32V
FADQOXWO6uIo+sm1w4XlI2rkGXxV3cttA0IUQUQRPoKajqB85zwSkegHF6pJ06hk
Iew9raXBfXHrDR1JeilHtK+XjWkWLsjUIWAMx3qgL/CjhhVXffaoGknBNZUldrHO
MXi4lIwXUziwhwLMKQt3O0H5HnG4TAfz05YAJUmaHfQ0m9Uh8kA=
=Dlk2
-----END PGP SIGNATURE-----

--rdncs5n7wnfcz3yy--


--===============2550696680473109141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2550696680473109141==--
