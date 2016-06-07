From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 2/2] spi: spi-ti-qspi: Add DMA support for QSPI mmap
 read
Date: Tue, 7 Jun 2016 12:17:13 +0300
Message-ID: <1d3484c6-6f9e-847c-3e22-9b1726700a37@ti.com>
References: <20160607081810.6640-1-vigneshr@ti.com>
 <20160607081810.6640-3-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160607081810.6640-3-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 06/07/16 11:18, Vignesh R wrote:
> Use mem-to-mem DMA to read from flash when reading in mmap mode. This
> gives improved read performance and reduces CPU load.
>=20
> With this patch the raw-read throughput is ~16MB/s on DRA74 EVM. And =
CPU
> load is <20%. UBIFS read ~13 MB/s.
>=20
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>=20
> v3: Cleanup code based on review comments for v2.
> v2: Handle kmap'd buffers of JFFS2 FS.
>=20
>  drivers/spi/spi-ti-qspi.c | 189 ++++++++++++++++++++++++++++++++++++=
++++++----
>  1 file changed, 176 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> index 29ea8d2f9824..1f6c59c29157 100644
> --- a/drivers/spi/spi-ti-qspi.c
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -33,6 +33,7 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> +#include <linux/highmem.h>
> =20
>  #include <linux/spi/spi.h>
> =20
> @@ -41,6 +42,8 @@ struct ti_qspi_regs {
>  };
> =20
>  struct ti_qspi {
> +	struct completion	transfer_complete;
> +
>  	/* list synchronization */
>  	struct mutex            list_lock;
> =20
> @@ -54,6 +57,9 @@ struct ti_qspi {
> =20
>  	struct ti_qspi_regs     ctx_reg;
> =20
> +	dma_addr_t		mmap_phys_base;
> +	struct dma_chan		*rx_chan;
> +
>  	u32 spi_max_frequency;
>  	u32 cmd;
>  	u32 dc;
> @@ -379,6 +385,72 @@ static int qspi_transfer_msg(struct ti_qspi *qsp=
i, struct spi_transfer *t,
>  	return 0;
>  }
> =20
> +static void ti_qspi_dma_callback(void *param)
> +{
> +	struct ti_qspi *qspi =3D param;
> +
> +	complete(&qspi->transfer_complete);
> +}
> +
> +static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma_addr_t dma_dst=
,
> +			    dma_addr_t dma_src, size_t len)
> +{
> +	struct dma_chan *chan =3D qspi->rx_chan;
> +	struct dma_device *dma_dev =3D chan->device;
> +	dma_cookie_t cookie;
> +	enum dma_ctrl_flags flags =3D DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> +	struct dma_async_tx_descriptor *tx;
> +	int ret;
> +
> +	tx =3D dma_dev->device_prep_dma_memcpy(chan, dma_dst, dma_src,
> +					     len, flags);
> +	if (!tx) {
> +		dev_err(qspi->dev, "device_prep_dma_memcpy error\n");
> +		return -EIO;
> +	}
> +
> +	tx->callback =3D ti_qspi_dma_callback;
> +	tx->callback_param =3D qspi;
> +	cookie =3D tx->tx_submit(tx);
> +
> +	ret =3D dma_submit_error(cookie);
> +	if (ret) {
> +		dev_err(qspi->dev, "dma_submit_error %d\n", cookie);
> +		return -EIO;
> +	}
> +
> +	dma_async_issue_pending(chan);
> +	ret =3D wait_for_completion_timeout(&qspi->transfer_complete,
> +					  msecs_to_jiffies(len));
> +	if (ret <=3D 0) {
> +		dmaengine_terminate_sync(chan);
> +		dev_err(qspi->dev, "DMA wait_for_completion_timeout\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ti_qspi_dma_xfer_sg(struct ti_qspi *qspi, struct sg_table=
 rx_sg,
> +			       loff_t from)
> +{
> +	struct scatterlist *sg;
> +	dma_addr_t dma_src =3D qspi->mmap_phys_base + from;
> +	dma_addr_t dma_dst;
> +	int i, len, ret;
> +
> +	for_each_sg(rx_sg.sgl, sg, rx_sg.nents, i) {
> +		dma_dst =3D sg_dma_address(sg);
> +		len =3D sg_dma_len(sg);
> +		ret =3D ti_qspi_dma_xfer(qspi, dma_dst, dma_src, len);
> +		if (ret)
> +			return ret;
> +		dma_src +=3D len;
> +	}
> +
> +	return 0;
> +}
> +
>  static void ti_qspi_enable_memory_map(struct spi_device *spi)
>  {
>  	struct ti_qspi  *qspi =3D spi_master_get_devdata(spi->master);
> @@ -426,7 +498,40 @@ static void ti_qspi_setup_mmap_read(struct spi_d=
evice *spi,
>  		      QSPI_SPI_SETUP_REG(spi->chip_select));
>  }
> =20
> -static int ti_qspi_spi_flash_read(struct  spi_device *spi,
> +#ifdef CONFIG_HIGHMEM
> +static int ti_qspi_map_buf(struct ti_qspi *qspi, void *buf,
> +			   unsigned int len, struct sg_table *sgt)
> +{
> +	unsigned int max_seg_size =3D
> +		dma_get_max_seg_size(qspi->rx_chan->device->dev);
> +	unsigned int desc_len =3D min_t(int, max_seg_size, PAGE_SIZE);
> +	int sgs =3D DIV_ROUND_UP(len + offset_in_page(buf), desc_len);
> +	struct page *vm_page;
> +	size_t min;
> +	int i, ret;
> +
> +	ret =3D sg_alloc_table(sgt, sgs, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	for (i =3D 0; i < sgs; i++) {
> +		min =3D min_t(size_t, len, desc_len -
> +			    offset_in_page(buf));
> +		vm_page =3D kmap_to_page(buf);
> +		if (!vm_page) {
> +			sg_free_table(sgt);
> +			return -ENOMEM;
> +		}
> +		sg_set_page(&sgt->sgl[i], vm_page, min,
> +			    offset_in_page(buf));
> +		buf +=3D min;
> +		len -=3D min;
> +	}
> +	return 0;
> +}
> +#endif
> +
> +static int ti_qspi_spi_flash_read(struct spi_device *spi,
>  				  struct spi_flash_read_message *msg)
>  {
>  	struct ti_qspi *qspi =3D spi_master_get_devdata(spi->master);
> @@ -437,9 +542,46 @@ static int ti_qspi_spi_flash_read(struct  spi_de=
vice *spi,
>  	if (!qspi->mmap_enabled)
>  		ti_qspi_enable_memory_map(spi);
>  	ti_qspi_setup_mmap_read(spi, msg);
> -	memcpy_fromio(msg->buf, qspi->mmap_base + msg->from, msg->len);
> +
> +	if (qspi->rx_chan) {
> +		struct device *dev =3D qspi->rx_chan->device->dev;
> +		void *buf =3D msg->buf;
> +		struct sg_table sgt;
> +
> +		if (msg->cur_msg_mapped) {
> +			ret =3D ti_qspi_dma_xfer_sg(qspi, msg->rx_sg, msg->from);
> +			if (ret)
> +				goto err_unlock;
> +#ifdef CONFIG_HIGHMEM
> +		} else if ((unsigned long)buf >=3D PKMAP_BASE &&
> +				(unsigned long)buf < (PKMAP_BASE +
> +					(LAST_PKMAP * PAGE_SIZE))) {
> +			/* Generate sg_table for kmap buffers */
> +			ret =3D ti_qspi_map_buf(qspi, buf, msg->len, &sgt);
> +			if (ret)
> +				goto err_unlock;
> +			ret =3D dma_map_sg(dev, sgt.sgl, sgt.nents,
> +					 DMA_FROM_DEVICE);
> +			if (!ret) {
> +				ret =3D -ENOMEM;
> +				goto err_unlock;
> +			}
> +			ret =3D ti_qspi_dma_xfer_sg(qspi, sgt, msg->from);
> +			dma_unmap_sg(dev, sgt.sgl, sgt.orig_nents,
> +				     DMA_FROM_DEVICE);
> +			sg_free_table(&sgt);
> +#endif
> +		} else {
> +			dev_err(qspi->dev, "Invalid address for DMA\n");
> +			ret =3D -EIO;
> +			goto err_unlock;
> +		}
> +	} else {
> +		memcpy_fromio(msg->buf, qspi->mmap_base + msg->from, msg->len);
> +	}
>  	msg->retlen =3D msg->len;
> =20
> +err_unlock:
>  	mutex_unlock(&qspi->list_lock);
> =20
>  	return ret;
> @@ -536,6 +678,7 @@ static int ti_qspi_probe(struct platform_device *=
pdev)
>  	struct device_node *np =3D pdev->dev.of_node;
>  	u32 max_freq;
>  	int ret =3D 0, num_cs, irq;
> +	dma_cap_mask_t mask;
> =20
>  	master =3D spi_alloc_master(&pdev->dev, sizeof(*qspi));
>  	if (!master)
> @@ -550,6 +693,7 @@ static int ti_qspi_probe(struct platform_device *=
pdev)
>  	master->dev.of_node =3D pdev->dev.of_node;
>  	master->bits_per_word_mask =3D SPI_BPW_MASK(32) | SPI_BPW_MASK(16) =
|
>  				     SPI_BPW_MASK(8);
> +	master->spi_flash_read =3D ti_qspi_spi_flash_read;
> =20
>  	if (!of_property_read_u32(np, "num-cs", &num_cs))
>  		master->num_chipselect =3D num_cs;
> @@ -592,17 +736,6 @@ static int ti_qspi_probe(struct platform_device =
*pdev)
>  		goto free_master;
>  	}
> =20
> -	if (res_mmap) {
> -		qspi->mmap_base =3D devm_ioremap_resource(&pdev->dev,
> -							res_mmap);
> -		master->spi_flash_read =3D ti_qspi_spi_flash_read;
> -		if (IS_ERR(qspi->mmap_base)) {
> -			dev_err(&pdev->dev,
> -				"falling back to PIO mode\n");
> -			master->spi_flash_read =3D NULL;
> -		}
> -	}
> -	qspi->mmap_enabled =3D false;
> =20
>  	if (of_property_read_bool(np, "syscon-chipselects")) {
>  		qspi->ctrl_base =3D
> @@ -637,6 +770,33 @@ static int ti_qspi_probe(struct platform_device =
*pdev)
>  	if (ret)
>  		goto free_master;
> =20
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_MEMCPY, mask);
> +
> +	qspi->rx_chan =3D dma_request_channel(mask, NULL, NULL);

dma_request_channel is deprecated, please use the:
dma_request_chan_by_mask()

> +	if (!qspi->rx_chan) {
> +		dev_err(qspi->dev,
> +			"No Rx DMA available, trying mmap mode\n");
> +		ret =3D 0;
> +		goto no_dma;
> +	}
> +	master->dma_rx =3D qspi->rx_chan;
> +	init_completion(&qspi->transfer_complete);
> +	if (res_mmap)
> +		qspi->mmap_phys_base =3D (dma_addr_t)res_mmap->start;
> +
> +no_dma:
> +	if (!qspi->rx_chan && res_mmap) {
> +		qspi->mmap_base =3D devm_ioremap_resource(&pdev->dev, res_mmap);
> +		if (IS_ERR(qspi->mmap_base)) {
> +			dev_info(&pdev->dev,
> +				 "mmap failed with error %ld using PIO mode\n",
> +				 PTR_ERR(qspi->mmap_base));
> +			qspi->mmap_base =3D NULL;
> +			master->spi_flash_read =3D NULL;
> +		}
> +	}
> +	qspi->mmap_enabled =3D false;
>  	return 0;
> =20
>  free_master:
> @@ -656,6 +816,9 @@ static int ti_qspi_remove(struct platform_device =
*pdev)
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> =20
> +	if (qspi->rx_chan)
> +		dma_release_channel(qspi->rx_chan);
> +
>  	return 0;
>  }
> =20
>=20


--=20
P=E9ter
