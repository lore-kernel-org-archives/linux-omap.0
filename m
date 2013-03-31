From: =?UTF-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?=
	<freemangordon@abv.bg>
Subject: Re: [PATCH] OMAP3 ROM Random Number Generator support
Date: Sun, 31 Mar 2013 15:05:42 +0300 (EEST)
Message-ID: <2059303614.30062.1364731542427.JavaMail.apache@mail83.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: tony@atomide.com, juha.yrjola@solidboot.com, linux@arm.linux.org.uk, mpm@selenic.com, herbert@gondor.apana.org.au, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

=20
Hi Pali,

Yep, the code looks almost identical, I guess with some tweaks all SMC =
code from that patch could be removed and instead used the one from SMC=
 PPA API.=20

What I don't get, is why one needs to disable/enable fiqs/irqs:

+static int call_sec_rom(u32 appl_id, u32 proc_id, u32 flag, ...)
+{
+	va_list ap;
+	u32 ret;
+	u32 val;
+
+	va_start(ap, flag);
+	val =3D *(u32 *) &ap;
+	local_irq_disable();
+	local_fiq_disable();
+	ret =3D omap3_rom_rng_call(appl_id, proc_id, flag,
+				 (u32) virt_to_phys((void *) val));
+	local_fiq_enable();
+	local_irq_enable();
+	va_end(ap);
+
+	return ret;
+}

Do you have any idea why is that needed? Any other code I've ever seen =
to call SM, does not disable fiqs/irqs, is RNG SMC somehow special? I k=
now this is Nokia's code, but still, if we can get some understanding..=
=2E

Regards,
Ivo

 >-------- =D0=9E=D1=80=D0=B8=D0=B3=D0=B8=D0=BD=D0=B0=D0=BB=D0=BD=D0=BE=
 =D0=BF=D0=B8=D1=81=D0=BC=D0=BE --------
 >=D0=9E=D1=82:  Pali Roh=C3=A1r=20
 >=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE: Re: [PATCH] OMAP3 ROM Ran=
dom Number Generator support
 >=D0=94=D0=BE: Tony Lindgren=20
 >=D0=98=D0=B7=D0=BF=D1=80=D0=B0=D1=82=D0=B5=D0=BD=D0=BE =D0=BD=D0=B0: =
=D0=9D=D0=B5=D0=B4=D0=B5=D0=BB=D1=8F, 2013, =D0=9C=D0=B0=D1=80=D1=82 31=
 12:28:12 EEST
 >
 >
 >On Thursday 28 March 2013 22:44:11 Tony Lindgren wrote:
 >> * Pali Roh=C3=A1r  [130328 10:58]:
 >> > Here is new version of patch:
 >> >=20
 >> > --- a/arch/arm/mach-omap2/devices.c
 >> > +++ b/arch/arm/mach-omap2/devices.c
 >> > @@ -486,6 +486,23 @@ static void omap_init_mcspi(void)
 >> >=20
 >> >  static inline void omap_init_mcspi(void) {}
 >> >  #endif
 >> >=20
 >> > +extern u32 *omap3_rom_rng_call(u32 id, u32 proc, u32 flags,
 >> > u32 va_ptr); +
 >> > +static struct platform_device omap3_rom_rng_device =3D {
 >> > +	.name		=3D &quot;omap3-rom-rng&quot;,
 >> > +	.id		=3D -1,
 >> > +	.dev	=3D {
 >> > +		.platform_data	=3D omap3_rom_rng_call,
 >> > +	},
 >> > +};
 >> > +
 >> > +static void omap_init_rom_rng(void)
 >> > +{
 >> > +	if (!cpu_is_omap34xx() || omap_type() =3D=3D
 >> > OMAP2_DEVICE_TYPE_GP) +		return;
 >> > +	platform_device_register(&amp;omap3_rom_rng_device);
 >> > +}
 >> > +
 >> >=20
 >> >  /**
 >> > =20
 >> >   * omap_init_rng - bind the RNG hwmod to the RNG
 >> >   omap_device *
 >>=20
 >> This driver probably only works on Nokia boards because of the
 >> different SMC call numbering. Until it's been verified on some
 >> other HS omap34xx, I'd probably register this only from the
 >> Nokia board-*.c file.
 >>=20
 >
 >Freemangordon, can you look at this smc and errara 430973 code if=20
 >they could be merged? Really omap3_rom_rng_call function looks=20
 >like n900 specific.
 >
 >Link: https://lkml.org/lkml/2013/3/28/398
 >
 >> > --- /dev/null
 >> > +++ b/drivers/char/hw_random/omap3-rom-rng.c
 >> > +static int omap3_rom_rng_probe(struct platform_device
 >> > *pdev) +{
 >> > +	printk(KERN_INFO &quot;%s: initializing&#92;n&quot;,
 >> > omap3_rom_rng_name); +
 >> > +	omap3_rom_rng_call =3D pdev->dev.platform_data;
 >> > +	if (!omap3_rom_rng_call) {
 >> > +		printk(KERN_ERR &quot;%s: omap3_rom_rng_call is NULL&#92;n&quo=
t;,
 >> > +		       omap3_rom_rng_name);
 >> > +		return -EINVAL;
 >> > +	}
 >> > +
 >> > +	setup_timer(&amp;idle_timer, omap3_rom_idle_rng, 0);
 >> > +	rng_clk =3D clk_get_sys(&quot;omap_rng&quot;, &quot;ick&quot;);
 >> > +	if (IS_ERR(rng_clk)) {
 >> > +		printk(KERN_ERR &quot;%s: unable to get RNG clock&#92;n&quot;,
 >> > +		       omap3_rom_rng_name);
 >> > +		return IS_ERR(rng_clk);
 >> > +	}
 >>=20
 >> You can use regular clk_get if you add the alias to
 >> struct omap_clk omap3xxx_clks table.
 >>=20
 >> Regards,
 >>=20
 >> Tony
 >
 >Tony, can you show me how?
 >
 >--=20
 >Pali Roh=C3=A1r
 >pali.rohar@gmail.com
 >
