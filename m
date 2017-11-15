From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 11/16] mtd: onenand: omap2: Do not make delay for GPIO
 OMAP3 specific
Date: Wed, 15 Nov 2017 16:20:53 +0100
Message-ID: <20171115152052.u7yhtdqq3nz2uyoo@earth>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111212406.lgqpj57o4ckxbx4i@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6496111442576318056=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171111212406.lgqpj57o4ckxbx4i@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org


--===============6496111442576318056==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5znqb7blv444eosi"
Content-Disposition: inline


--5znqb7blv444eosi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 11, 2017 at 10:24:06PM +0100, Ladislav Michl wrote:
> Second commit in driver history (782b7a367d81: "[MTD] [OneNAND] OMAP3:
> add delay for GPIO") added quirk for waiting until GPIO line settle.
> As DMA was disabled for OMAP2 boards, chances are this problem was
> not OMAP3 specific and as it is just one register read, previous
> test for SoC type is approximately as expensive as read itself.
> Make delay unconditional, which allows removing SoC specific code
> alltogether.
>=20
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>  Changes:
>  -v3: new patch
>  -v4: none
>=20
>  drivers/mtd/onenand/omap2.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index c9ff67100ef4..e4857a41760d 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -57,7 +57,6 @@ struct omap2_onenand {
>  	struct dma_chan *dma_chan;
>  	int freq;
>  	int (*setup)(void __iomem *base, int *freq_ptr);
> -	u8 flags;
>  };
> =20
>  static void omap2_onenand_dma_complete_func(void *completion)
> @@ -148,9 +147,8 @@ static int omap2_onenand_wait(struct mtd_info *mtd, i=
nt state)
>  		if (!(syscfg & ONENAND_SYS_CFG1_IOBE)) {
>  			syscfg |=3D ONENAND_SYS_CFG1_IOBE;
>  			write_reg(c, syscfg, ONENAND_REG_SYS_CFG1);
> -			if (c->flags & ONENAND_IN_OMAP34XX)
> -				/* Add a delay to let GPIO settle */
> -				syscfg =3D read_reg(c, ONENAND_REG_SYS_CFG1);
> +			/* Add a delay to let GPIO settle */
> +			syscfg =3D read_reg(c, ONENAND_REG_SYS_CFG1);
>  		}
> =20
>  		reinit_completion(&c->irq_done);
> @@ -470,7 +468,6 @@ static int omap2_onenand_probe(struct platform_device=
 *pdev)
> =20
>  	init_completion(&c->irq_done);
>  	init_completion(&c->dma_done);
> -	c->flags =3D pdata->flags;
>  	c->gpmc_cs =3D pdata->cs;
>  	c->gpio_irq =3D pdata->gpio_irq;
>  	if (pdata->dma_channel < 0) {
> --=20
> 2.11.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--5znqb7blv444eosi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloMW1QACgkQ2O7X88g7
+poRDA//ZvbWmIeSz//1wmfdjKYZp2lhmjxcn6YC/y4z7xw88op9fOe6AVfJhbiN
zrrXtW8LrXVP+3B7TW1wVn2PasepHq+LDU8gl2cpSuTAUjJSs/PDGDAlTITiftpx
2hSh5iK6KxwoLg51oFOvS3UuDgaBenbzfiErgfKC20AESyK13v6SUuG0vh/sDli8
zGV5h6q5UmoYLMQP0ZM1mOCwqoaKxWX51tfU6McsDxlIYyGhXf/7TRzurt7DCVgC
IfRwkFbgIwOJM9aN5XF3/o+DTi+ebQUaE3qnOEavwYSeSMp367SLD5o3xfg69FaX
Ih84NJSJTMIbhbWPeN2IrOl4NrNkRT/J6UbjJNNxDEv6EvcDSt7zaHq7UtBBuMGY
+Smqwcp+cACJ8ZEij+NP4kmogl+koThfp8x/j4t1hEp0DI8aID86/SnWVV2I1pvl
mfBo2Ggwm5yC14yxzntwVZCvBdkDbiYsLfc7LpfHR10KRuzv+yVmSw7EUk6X7JYU
/eDYriTjtt1LYCodYaTLPwg7xj2pmq4tJEv7/ii5egFKc7vRgRAPRKdDgnwvJhZs
OW6xSpIr0HqcuOvzEusphAzGCepQYDqE7xrKmeF1u7deRpKI+OqWzJoyxMvBpTC9
/OHFtNgXLSLd2gcpLaN0+1zN3mnuAy7OfGp5WJOUjYeSbWelUZs=
=uq+9
-----END PGP SIGNATURE-----

--5znqb7blv444eosi--


--===============6496111442576318056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============6496111442576318056==--
