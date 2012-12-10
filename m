From: Felipe Balbi <balbi@ti.com>
Subject: Re: AM335x BeagleBone SPI Issues
Date: Mon, 10 Dec 2012 20:35:00 +0200
Message-ID: <20121210183500.GB14303@arwen.pp.htv.fi>
References: <50C5E23D.5040605@communistcode.co.uk>
 <20121210135337.GA10219@arwen.pp.htv.fi>
 <50C5F6A8.5060701@communistcode.co.uk>
 <20121210145947.GK11038@arwen.pp.htv.fi>
 <50C5FD73.1000408@communistcode.co.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48510 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958Ab2LJSmK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Dec 2012 13:42:10 -0500
Content-Disposition: inline
In-Reply-To: <50C5FD73.1000408@communistcode.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jack Mitchell <ml@communistcode.co.uk>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>

--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 10, 2012 at 03:19:15PM +0000, Jack Mitchell wrote:
> On 10/12/12 14:59, Felipe Balbi wrote:
> >Hi,
> >
> >On Mon, Dec 10, 2012 at 02:50:16PM +0000, Jack Mitchell wrote:
> >>>On Mon, Dec 10, 2012 at 01:23:09PM +0000, Jack Mitchell wrote:
> >>>>Hi,
> >>>>
> >>>>I am currently having issues with the SPI driver on the beaglebone
> >>>>using the 3.7-rc8 kernel[1]. I have probed the SPI pins and I have
> >>>>found that writing works however reading doesn't. When using DMA the
> >>>>program seems to lock hard and no data is sent on the bus. I am
> >>>>testing the bus using spidev and the spidev_test[2] application,
> >>>>however I first came across spi issues with a custom spi driver which
> >>>>stopped working when I transitioned from 3.2-psp to 3.7-rc8.
> >>>>
> >>>>The current output I am seeing from the spidev_test program is just a
> >>>>series of 0x00 data, which looks to me like no data is getting in at
> >>>>all. The spidev_test program is not using DMA as the buffer size is
> >>>>too low, so I forced the dma on when buffer size is > 1 and the
> >>>>program hangs hard with the system still responding to other
> >>>>commands.I have briged the pins 18 and 21 on the BeagleBone P9
> >>>>header.
> >>>>
> >>>>Has anyone seen issues like this, or if not if someone could please
> >>>>test the latest 3.7-rc8 from [1] and let me know if it works for them
> >>>>and the issue is at my end.
> >>>>
> >>>>To get spidev working with devicetree I applied the patch from [3]
> >>>>and changed the dtb as in the patch pasted below.
> >>>>
> >>>>[1] https://github.com/beagleboard/kernel/tree/3.7
> >>>>[2] http://lxr.linux.no/#linux+v3.6.9/Documentation/spi/spidev_test.c
> >>>>[3] http://www.mail-archive.com/spi-devel-general@lists.sourceforge.n=
et/msg09958.html
> >>>do you have any debugging output from that driver ? It would be cool to
> >>>see if DMA is at least being kicked properly for small transfers.
> >>When I run the spidev program with dma for transfers > 1, the program
> >>hangs and the only output in dmesg is:
> >>
> >>[   12.613952] libphy: 4a101000.mdio:00 - Link is Up - 100/Full <----
> >>Last line from initial log in [2]
> >>[   47.669202] spidev spi1.0: setup: speed 24000000, sample leading
> >>edge, clk normal
> >>[   47.669246] spidev spi1.0: setup mode 0, 8 bits/w, 24000000 Hz max -=
-> 0
> >>[   47.669260] spidev spi1.0: spi mode 00
> >>[   47.669283] spidev spi1.0: setup: speed 24000000, sample leading
> >>edge, clk normal
> >>[   47.669300] spidev spi1.0: setup mode 0, 16 bits/w, 24000000 Hz max =
--> 0
> >>[   47.669312] spidev spi1.0: 16 bits per word
> >>[   47.669330] spidev spi1.0: setup: speed 24000000, sample leading
> >>edge, clk normal
> >>[   47.669347] spidev spi1.0: setup mode 0, 16 bits/w, 24000000 Hz max =
--> 0
> >>[   47.669358] spidev spi1.0: 24000000 Hz (max)
> >>[   47.673811] spidev spi1.0: setup: speed 24000000, sample leading
> >>edge, clk normal
> >>
> >>The initial dmesg statup log is at [2].
> >can you apply the debugging patch below to spi driver and show me the
> >output again ?
> >
> >Note that I'm allowing DMA for as small as 1-byte transfers (as you
> >needed) and I'm also disabling DMA Request line before calling
> >complete() as I think the current way could race, but likely wouldn't
> >cause issues. Anyway, please show me the output.
> >
> >diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi=
=2Ec
> >index 3542fdc..d2b1af2 100644
> >--- a/drivers/spi/spi-omap2-mcspi.c
> >+++ b/drivers/spi/spi-omap2-mcspi.c
> >@@ -108,7 +108,7 @@ struct omap2_mcspi_dma {
> >  /* use PIO for small transfers, avoiding DMA setup/teardown overhead a=
nd
> >   * cache operations; better heuristics consider wordsize and bitrate.
> >   */
> >-#define DMA_MIN_BYTES			160
> >+#define DMA_MIN_BYTES			1
> >  /*
> >@@ -298,10 +298,11 @@ static void omap2_mcspi_rx_callback(void *data)
> >  	struct omap2_mcspi *mcspi =3D spi_master_get_devdata(spi->master);
> >  	struct omap2_mcspi_dma *mcspi_dma =3D &mcspi->dma_channels[spi->chip_=
select];
> >-	complete(&mcspi_dma->dma_rx_completion);
> >-
> >  	/* We must disable the DMA RX request */
> >+	dev_info(&spi->dev, "Disabling RX Request Line\n");
> >  	omap2_mcspi_set_dma_req(spi, 1, 0);
> >+
> >+	complete(&mcspi_dma->dma_rx_completion);
> >  }
> >  static void omap2_mcspi_tx_callback(void *data)
> >@@ -310,10 +311,11 @@ static void omap2_mcspi_tx_callback(void *data)
> >  	struct omap2_mcspi *mcspi =3D spi_master_get_devdata(spi->master);
> >  	struct omap2_mcspi_dma *mcspi_dma =3D &mcspi->dma_channels[spi->chip_=
select];
> >-	complete(&mcspi_dma->dma_tx_completion);
> >-
> >  	/* We must disable the DMA TX request */
> >+	dev_info(&spi->dev, "Disabling TX Request Line\n");
> >  	omap2_mcspi_set_dma_req(spi, 0, 0);
> >+
> >+	complete(&mcspi_dma->dma_tx_completion);
> >  }
> >  static void omap2_mcspi_tx_dma(struct spi_device *spi,
> >@@ -328,6 +330,7 @@ static void omap2_mcspi_tx_dma(struct spi_device *sp=
i,
> >  	void __iomem		*chstat_reg;
> >  	struct omap2_mcspi_cs	*cs =3D spi->controller_state;
> >+	dev_info(&spi->dev, "kicking TX DMA\n");
> >  	mcspi =3D spi_master_get_devdata(spi->master);
> >  	mcspi_dma =3D &mcspi->dma_channels[spi->chip_select];
> >  	count =3D xfer->len;
> >@@ -359,7 +362,9 @@ static void omap2_mcspi_tx_dma(struct spi_device *sp=
i,
> >  	dma_async_issue_pending(mcspi_dma->dma_tx);
> >  	omap2_mcspi_set_dma_req(spi, 0, 1);
> >+	dev_info(&spi->dev, "Waiting for TX Completion\n");
> >  	wait_for_completion(&mcspi_dma->dma_tx_completion);
> >+	dev_info(&spi->dev, "TX Completed\n");
> >  	dma_unmap_single(mcspi->dev, xfer->tx_dma, count,
> >  			 DMA_TO_DEVICE);
> >@@ -392,6 +397,7 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct sp=
i_transfer *xfer,
> >  	word_len =3D cs->word_len;
> >  	l =3D mcspi_cached_chconf0(spi);
> >+	dev_info(&spi->dev, "kicking RX DMA\n");
> >  	if (word_len <=3D 8)
> >  		element_count =3D count;
> >  	else if (word_len <=3D 16)
> >@@ -428,7 +434,9 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct sp=
i_transfer *xfer,
> >  	dma_async_issue_pending(mcspi_dma->dma_rx);
> >  	omap2_mcspi_set_dma_req(spi, 1, 1);
> >+	dev_info(&spi->dev, "Waiting for RX Completion\n");
> >  	wait_for_completion(&mcspi_dma->dma_rx_completion);
> >+	dev_info(&spi->dev, "RX Completed\n");
> >  	dma_unmap_single(mcspi->dev, xfer->rx_dma, count,
> >  			 DMA_FROM_DEVICE);
> >  	omap2_mcspi_set_enable(spi, 0);
> >
> >>>It would also be nice to have a clear picture of what "custom spi
> >>>driver" you're talking about.
> >>The custom SPI driver is for connecting and reading registers from an
> >>in house FPGA design and can be found at [1]. It's fairly rudimentary
> >>and also in the development stages, I'm very new to Linux kernel
> >>programming so please take that into account :)
> >no problem ;-)
> >
> >>However it did work flawlessly with 3.2-psp.
> >yeah, it could be some regression introduced somewhere, or just a bugfix
> >which was done on 3.2-psp and was missed upstream... annoying when those
> >happen :-p
> >
>=20
> Your patch didn't apply cleanly but I hacked it in and got the following:
>=20
> [   40.434566] spidev spi1.0: setup: speed 24000000, sample leading
> edge, clk normal
> [   40.434609] spidev spi1.0: setup mode 0, 8 bits/w, 24000000 Hz max -->=
 0
> [   40.434622] spidev spi1.0: spi mode 00
> [   40.434645] spidev spi1.0: setup: speed 24000000, sample leading
> edge, clk normal
> [   40.434661] spidev spi1.0: setup mode 0, 16 bits/w, 24000000 Hz max --=
> 0
> [   40.434673] spidev spi1.0: 16 bits per word
> [   40.434692] spidev spi1.0: setup: speed 24000000, sample leading
> edge, clk normal
> [   40.434708] spidev spi1.0: setup mode 0, 16 bits/w, 24000000 Hz max --=
> 0
> [   40.434720] spidev spi1.0: 24000000 Hz (max)
> [   40.439300] spidev spi1.0: setup: speed 24000000, sample leading
> edge, clk normal
> [   40.439397] spidev spi1.0: kicking TX DMA
> [   40.443797] spidev spi1.0: Waiting for TX Completion

so TX dma never completes... perhaps all you need is Shubhro's commit
reordering TX and RX calls ??

commit e47a682ace0cd56eb8e09b806c2b0f034b491520
Author: Shubhrajyoti D <shubhrajyoti@ti.com>
Date:   Tue Nov 6 14:30:19 2012 +0530

    spi: omap2-mcspi: Reorder the wait_for_completion for tx
   =20
    The commit  d7b4394e[Cleanup the omap2_mcspi_txrx_dma function]
    changed the wait_for_completion order. Move the wait so that the
    rx doesnot wait for the tx to complete.
   =20
    Reported-and-tested-by: S=F8rensen, Stefan <Sorensen@polycom.com>
    Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 3542fdc..b1a651e 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -323,18 +323,13 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma  *mcspi_dma;
 	unsigned int		count;
-	u8			* rx;
 	const u8		* tx;
-	void __iomem		*chstat_reg;
-	struct omap2_mcspi_cs	*cs =3D spi->controller_state;
=20
 	mcspi =3D spi_master_get_devdata(spi->master);
 	mcspi_dma =3D &mcspi->dma_channels[spi->chip_select];
 	count =3D xfer->len;
=20
-	rx =3D xfer->rx_buf;
 	tx =3D xfer->tx_buf;
-	chstat_reg =3D cs->base + OMAP2_MCSPI_CHSTAT0;
=20
 	if (mcspi_dma->dma_tx) {
 		struct dma_async_tx_descriptor *tx;
@@ -359,19 +354,6 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
 	dma_async_issue_pending(mcspi_dma->dma_tx);
 	omap2_mcspi_set_dma_req(spi, 0, 1);
=20
-	wait_for_completion(&mcspi_dma->dma_tx_completion);
-	dma_unmap_single(mcspi->dev, xfer->tx_dma, count,
-			 DMA_TO_DEVICE);
-
-	/* for TX_ONLY mode, be sure all words have shifted out */
-	if (rx =3D=3D NULL) {
-		if (mcspi_wait_for_reg_bit(chstat_reg,
-					OMAP2_MCSPI_CHSTAT_TXS) < 0)
-			dev_err(&spi->dev, "TXS timed out\n");
-		else if (mcspi_wait_for_reg_bit(chstat_reg,
-					OMAP2_MCSPI_CHSTAT_EOT) < 0)
-			dev_err(&spi->dev, "EOT timed out\n");
-	}
 }
=20
 static unsigned
@@ -492,6 +474,7 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi=
_transfer *xfer)
 	struct dma_slave_config	cfg;
 	enum dma_slave_buswidth width;
 	unsigned es;
+	void __iomem		*chstat_reg;
=20
 	mcspi =3D spi_master_get_devdata(spi->master);
 	mcspi_dma =3D &mcspi->dma_channels[spi->chip_select];
@@ -526,8 +509,24 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct sp=
i_transfer *xfer)
 		omap2_mcspi_tx_dma(spi, xfer, cfg);
=20
 	if (rx !=3D NULL)
-		return omap2_mcspi_rx_dma(spi, xfer, cfg, es);
-
+		count =3D omap2_mcspi_rx_dma(spi, xfer, cfg, es);
+
+	if (tx !=3D NULL) {
+		chstat_reg =3D cs->base + OMAP2_MCSPI_CHSTAT0;
+		wait_for_completion(&mcspi_dma->dma_tx_completion);
+		dma_unmap_single(mcspi->dev, xfer->tx_dma, xfer->len,
+				 DMA_TO_DEVICE);
+
+		/* for TX_ONLY mode, be sure all words have shifted out */
+		if (rx =3D=3D NULL) {
+			if (mcspi_wait_for_reg_bit(chstat_reg,
+						OMAP2_MCSPI_CHSTAT_TXS) < 0)
+				dev_err(&spi->dev, "TXS timed out\n");
+			else if (mcspi_wait_for_reg_bit(chstat_reg,
+						OMAP2_MCSPI_CHSTAT_EOT) < 0)
+				dev_err(&spi->dev, "EOT timed out\n");
+		}
+	}
 	return count;
 }
=20

Shubhro, what do you think ? could this be the case ?

--=20
balbi

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQxitUAAoJEIaOsuA1yqREL3cP/3Q78ObN0WVIiVyFjkjAVOri
VQi/36GHoYkw1Inrkp3CL4CFg+D8pp91lf1SQSyelQa2nVxOG/TC6VSM0qYHcFnl
ae3OL+yu4/wv5JO1e3z8fCzVl1z7kT1rXrIq0IO6AElxHU9pUyNr6dhh43qGKtuG
8v4g+QdcrsuMnBC1NdbJjhjdHjtmZcW/IS2mTjUHUCJJvgYyrtv+S6VymDx48gnu
aWRaBJkSvgy/PLWUmArpDS8qrEBL+kQDRh/GSNZbshmy+3USXCmrnlWYvAmrk0w9
hNlb3eFqAYgDr7j8sPv8KCN2SC8VmSGWbe+kos76JXsgUo9XChc2NHzeIEb4Wr8R
mdvw1Bi97wBdELo+uuP6dBbtgyoUSg6upDz7KdQ4PY7O+DqoCqpE1PKxnMCfFWMx
Nu8z/gpF/hEx6L4O62bpEasmwJuByYj5NnyMZUCwbLD3f6SMbrwmU9fNhlFrk0sz
O4xqeUvMHjYEPkFbW247/5iU+5PswODivJZVnwvVnWHvmH4SWm47yqJvzCDJMpvd
9/es1gvrpjKRbZDcdosz6RnvC0KuiMSzanI/G293hU2yC0XVJh2cbweXCYPwTrXH
ePkeAE7+ABEP3eXz5LLIpwqioBAEjRWHHp3wXnfWyHZKnMgQ6nD51DsTEMQ2qk3g
+ZoYvOQ9Ak0nbFSb2fbO
=WyX2
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
