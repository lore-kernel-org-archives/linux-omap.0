From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 10/16] mtd: onenand: omap2: Convert to use dmaengine
 for memcpy
Date: Wed, 15 Nov 2017 16:19:34 +0100
Message-ID: <20171115151933.6mfwmnwm2fxm7aes@earth>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111212331.46aisno37ckjc4up@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0271684143034959460=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171111212331.46aisno37ckjc4up@lenoch>
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


--===============0271684143034959460==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ft3dhqnuot65zpac"
Content-Disposition: inline


--ft3dhqnuot65zpac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 11, 2017 at 10:23:31PM +0100, Ladislav Michl wrote:
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
>=20
> Do not use the legacy and deprecated omap-dma interface for setting up the
> memcpy.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  Changes:
>  -v4: new patch
>=20
>  drivers/mtd/onenand/omap2.c | 80 +++++++++++++++++++++------------------=
------
>  1 file changed, 38 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index 36314124488d..c9ff67100ef4 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -32,6 +32,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/gpio.h>
> @@ -39,8 +40,6 @@
>  #include <asm/mach/flash.h>
>  #include <linux/platform_data/mtd-onenand-omap2.h>
> =20
> -#include <linux/omap-dma.h>
> -
>  #define DRIVER_NAME "omap2-onenand"
> =20
>  #define ONENAND_BUFRAM_SIZE	(1024 * 5)
> @@ -55,17 +54,15 @@ struct omap2_onenand {
>  	struct onenand_chip onenand;
>  	struct completion irq_done;
>  	struct completion dma_done;
> -	int dma_channel;
> +	struct dma_chan *dma_chan;
>  	int freq;
>  	int (*setup)(void __iomem *base, int *freq_ptr);
>  	u8 flags;
>  };
> =20
> -static void omap2_onenand_dma_cb(int lch, u16 ch_status, void *data)
> +static void omap2_onenand_dma_complete_func(void *completion)
>  {
> -	struct omap2_onenand *c =3D data;
> -
> -	complete(&c->dma_done);
> +	complete(completion);
>  }
> =20
>  static irqreturn_t omap2_onenand_interrupt(int irq, void *dev_id)
> @@ -292,23 +289,31 @@ static inline int omap2_onenand_dma_transfer(struct=
 omap2_onenand *c,
>  					     dma_addr_t src, dma_addr_t dst,
>  					     size_t count)
>  {
> -	int data_type =3D __ffs((src | dst | count));
> +	struct dma_async_tx_descriptor *tx;
> +	dma_cookie_t cookie;
> =20
> -	if (data_type > OMAP_DMA_DATA_TYPE_S32)
> -		data_type =3D OMAP_DMA_DATA_TYPE_S32;
> -
> -	omap_set_dma_transfer_params(c->dma_channel, data_type,
> -				     count / BIT(data_type), 1, 0, 0, 0);
> -	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> -				src, 0, 0);
> -	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> -				 dst, 0, 0);
> +	tx =3D dmaengine_prep_dma_memcpy(c->dma_chan, dst, src, count, 0);
> +	if (!tx) {
> +		dev_err(&c->pdev->dev, "Failed to prepare DMA memcpy\n");
> +		return -EIO;
> +	}
> =20
>  	reinit_completion(&c->dma_done);
> -	omap_start_dma(c->dma_channel);
> +
> +	tx->callback =3D omap2_onenand_dma_complete_func;
> +	tx->callback_param =3D &c->dma_done;
> +
> +	cookie =3D tx->tx_submit(tx);
> +	if (dma_submit_error(cookie)) {
> +		dev_err(&c->pdev->dev, "Failed to do DMA tx_submit\n");
> +		return -EIO;
> +	}
> +
> +	dma_async_issue_pending(c->dma_chan);
> +
>  	if (!wait_for_completion_io_timeout(&c->dma_done,
>  					    msecs_to_jiffies(20))) {
> -		omap_stop_dma(c->dma_channel);
> +		dmaengine_terminate_sync(c->dma_chan);
>  		return -ETIMEDOUT;
>  	}
> =20
> @@ -468,8 +473,7 @@ static int omap2_onenand_probe(struct platform_device=
 *pdev)
>  	c->flags =3D pdata->flags;
>  	c->gpmc_cs =3D pdata->cs;
>  	c->gpio_irq =3D pdata->gpio_irq;
> -	c->dma_channel =3D pdata->dma_channel;
> -	if (c->dma_channel < 0) {
> +	if (pdata->dma_channel < 0) {
>  		/* if -1, don't use DMA */
>  		c->gpio_irq =3D 0;
>  	}
> @@ -521,25 +525,17 @@ static int omap2_onenand_probe(struct platform_devi=
ce *pdev)
>  		goto err_release_gpio;
>  	}
> =20
> -	if (c->dma_channel >=3D 0) {
> -		r =3D omap_request_dma(0, pdev->dev.driver->name,
> -				     omap2_onenand_dma_cb, (void *) c,
> -				     &c->dma_channel);
> -		if (r =3D=3D 0) {
> -			omap_set_dma_write_mode(c->dma_channel,
> -						OMAP_DMA_WRITE_NON_POSTED);
> -			omap_set_dma_src_data_pack(c->dma_channel, 1);
> -			omap_set_dma_src_burst_mode(c->dma_channel,
> -						    OMAP_DMA_DATA_BURST_8);
> -			omap_set_dma_dest_data_pack(c->dma_channel, 1);
> -			omap_set_dma_dest_burst_mode(c->dma_channel,
> -						     OMAP_DMA_DATA_BURST_8);
> -		} else {
> +	if (pdata->dma_channel >=3D 0) {
> +		dma_cap_mask_t mask;
> +
> +		dma_cap_zero(mask);
> +		dma_cap_set(DMA_MEMCPY, mask);
> +
> +		c->dma_chan =3D dma_request_channel(mask, NULL, NULL);
> +		if (!c->dma_chan)
>  			dev_info(&pdev->dev,
>  				 "failed to allocate DMA for OneNAND, "
>  				 "using PIO instead\n");
> -			c->dma_channel =3D -1;
> -		}
>  	}
> =20
>  	dev_info(&pdev->dev, "initializing on CS%d, phys base 0x%08lx, virtual "
> @@ -553,7 +549,7 @@ static int omap2_onenand_probe(struct platform_device=
 *pdev)
>  	mtd_set_of_node(&c->mtd, pdata->of_node);
> =20
>  	this =3D &c->onenand;
> -	if (c->dma_channel >=3D 0) {
> +	if (c->dma_chan) {
>  		this->wait =3D omap2_onenand_wait;
>  		this->read_bufferram =3D omap2_onenand_read_bufferram;
>  		this->write_bufferram =3D omap2_onenand_write_bufferram;
> @@ -573,8 +569,8 @@ static int omap2_onenand_probe(struct platform_device=
 *pdev)
>  err_release_onenand:
>  	onenand_release(&c->mtd);
>  err_release_dma:
> -	if (c->dma_channel !=3D -1)
> -		omap_free_dma(c->dma_channel);
> +	if (c->dma_chan)
> +		dma_release_channel(c->dma_chan);
>  	if (c->gpio_irq)
>  		free_irq(gpio_to_irq(c->gpio_irq), c);
>  err_release_gpio:
> @@ -595,8 +591,8 @@ static int omap2_onenand_remove(struct platform_devic=
e *pdev)
>  	struct omap2_onenand *c =3D dev_get_drvdata(&pdev->dev);
> =20
>  	onenand_release(&c->mtd);
> -	if (c->dma_channel !=3D -1)
> -		omap_free_dma(c->dma_channel);
> +	if (c->dma_chan)
> +		dma_release_channel(c->dma_chan);
>  	omap2_onenand_shutdown(pdev);
>  	if (c->gpio_irq) {
>  		free_irq(gpio_to_irq(c->gpio_irq), c);
> --=20
> 2.11.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--ft3dhqnuot65zpac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloMWwIACgkQ2O7X88g7
+po3Vg//Qt06km+eZkvbhdf2SKoV3PUZzCZnZTqIEvVZwhnspvEjRghHVIj0VcUe
X31/CdZmY69LUWd/wAYsA3/DAGk0xfbKLJ5ebnFEr9hgUfl3ko7dfOrV5Aia4PSY
HNyIX+fL/TBbPdYU/TpMK8vVi/zLGpA3atgBXN3qsL8uAVGWGHxKH/oXwNoVACK4
/YsuJTQsncPsBbp4TgmfZNqCjh3de/Cbun9fGOysXkYvLWlJ/HAqfcBZCuMQFE81
40Uf9bJKKqX4VkCPxHOKA71OS2+aqCL+qxAnJax1ddB/z8WASACnU/8XcpiyEM7r
DcrN0cqIHWeWWZ3vZngOMf+oTqstRJ7iJw1OFU9dfVrXDZEYra9w40jRYDjjqswW
1b5gFcCHkKDECbwAPKvACZLGxp+zY98z+FhkPogPMQTWt4uLEIgrRnnOGTzZKcOW
PkPOPGMFgJ9Fwdy692vl0zD7qEruOCKRiXxp+cADe4RW0vGrQJSt4J0fzOCxkwPl
ZKOg6/DKmHm06DVMx8CTdtCyq7M90416myZZzRlfIAu5GKHAfssq7UWKl/2/sSGR
IZTj2GjJSU5z0hamrtshEUCgGQmqexwf6BtpCaSzsKhJwYh7q0QyTi4fdw9RTL2N
oFJjCy+7CT5F3yX4tPD0APYmHV9jWBLuITn1qcewi45tVC1+NP4=
=h9xk
-----END PGP SIGNATURE-----

--ft3dhqnuot65zpac--


--===============0271684143034959460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============0271684143034959460==--
