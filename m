From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] dmaengine: edma: Add dummy driver skeleton for edma3-tptc
Date: Wed, 4 Nov 2015 10:33:27 -0600
Message-ID: <87egg54td4.fsf@saruman.tx.rr.com>
References: <1446470500-27504-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5027201871459370169=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1446470500-27504-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, vinod.koul@intel.com, nsekhar@ti.com, olof@lixom.net
Cc: devicetree@vger.kernel.org, tony@atomide.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============5027201871459370169==
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Peter Ujfalusi <peter.ujfalusi@ti.com> writes:

> The eDMA3 TPTC does not need any software configuration, but it is a
> separate IP block in the SoC. In order the omap hwmod core to be able to
> handle the TPTC resources correctly in regards of PM we need to have a
> driver loaded for it.
> This patch will add a dummy driver skeleton without probe or remove
> callbacks provided.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reported-by: Olof Johansson <olof@lixom.net>

This fixes the problem I also reported on linux-omap [1]

Tested-by: Felipe Balbi <balbi@ti.com>

[1] http://marc.info/?l=3Dlinux-omap&m=3D144665429032014&w=3D2

> ---
> Hi,
>
> while it would have been possible to add the edma3-tptc compatible to be =
handled
> by the edma-tpcc driver (and when the device is tptc, do nothing) it would
> make the driver code a bit harder to follow.
> I think having separate structure for the tptc looks better and if we eve=
r need
> to have separate driver for the tptc it will be cleaner for us the separa=
te it.
>
> This patch alone w/o any hwmod flag changes will make sure that the edma-=
tptc is
> not powered down after the kernel is finished it's booting.
>
> Regards,
> Peter
>
>  drivers/dma/edma.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 31722d436a42..6b03e4e84e6b 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -269,6 +269,11 @@ static const struct of_device_id edma_of_ids[] =3D {
>  	{}
>  };
>=20=20
> +static const struct of_device_id edma_tptc_of_ids[] =3D {
> +	{ .compatible =3D "ti,edma3-tptc", },
> +	{}
> +};
> +
>  static inline unsigned int edma_read(struct edma_cc *ecc, int offset)
>  {
>  	return (unsigned int)__raw_readl(ecc->base + offset);
> @@ -2399,6 +2404,13 @@ static struct platform_driver edma_driver =3D {
>  	},
>  };
>=20=20
> +static struct platform_driver edma_tptc_driver =3D {
> +	.driver =3D {
> +		.name	=3D "edma3-tptc",
> +		.of_match_table =3D edma_tptc_of_ids,
> +	},
> +};
> +
>  bool edma_filter_fn(struct dma_chan *chan, void *param)
>  {
>  	bool match =3D false;
> @@ -2418,6 +2430,12 @@ EXPORT_SYMBOL(edma_filter_fn);
>=20=20
>  static int edma_init(void)
>  {
> +	int ret;
> +
> +	ret =3D platform_driver_register(&edma_tptc_driver);
> +	if (ret)
> +		return ret;
> +
>  	return platform_driver_register(&edma_driver);
>  }
>  subsys_initcall(edma_init);
> @@ -2425,6 +2443,7 @@ subsys_initcall(edma_init);
>  static void __exit edma_exit(void)
>  {
>  	platform_driver_unregister(&edma_driver);
> +	platform_driver_unregister(&edma_tptc_driver);
>  }
>  module_exit(edma_exit);
>=20=20
> --=20
> 2.6.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWOjNaAAoJEIaOsuA1yqRENBoQAKxxJVelnsMxz1tlTW6eAQLZ
RhKCjytOGwfnkkHKtZursv5Cp1SXlMovB6uG6GgxYF/ylFr1GVa9kHPFXwPPTnsx
E33Y24Pf1mvbZo6QtF1h/ARitAGC6mWQycdSMPk/VEFwYtduVzlYcgTkzuYVmg0M
V7yAVvZXsG+aJvQxXToHoe4hiO/mN5Pe1bWH1qhZLLz/OrQiaVJ8Qlv6iKoETU86
uomxRZxX9+b5zGC5yMMU+pknsPhXGwWXL2b9nqSfFeXqNbCHB1QK8ZeYEzlW06E6
XlSqX5jGudwbOA9RjSNcmdBJXaLIdOkVFEifVx2YNhpNwneabXtCcQMGO53D/1vg
5lKueZvC85kfpJmhoxBTzXHD1HnoFWyP6I9XanCeQdZaPKNRXgQ8Jna3YpGzIndT
mBYFlP2Hy29YigWcgrLMtaUL+oBm/+ka7h52rugQconSRf+7dRQIoA2TnEuerTx4
XDHntKiSZFpt+lRkTLjC6llnWJoZRA9nwF4GeNd8Ht3vEFAawo2McleooperL3gF
6B1XERLEpKg/fSbn1GQEQfOxrCTUrrjeUdLr+DgW9J2w4OWfp+/3EU8jFuXOLjXt
mYL681ZdjUNHP+ERe8AHzFH/O7rsS7Q9n2EXStZQSJ8iG2/VFcXkBUVVKf4Z07Um
ZezgZr8is5Am0Gjy3pMR
=4YKW
-----END PGP SIGNATURE-----
--=-=-=--


--===============5027201871459370169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5027201871459370169==--
