From: Felipe Balbi <balbi@ti.com>
Subject: Re: AM335x BeagleBone SPI Issues
Date: Mon, 10 Dec 2012 16:59:47 +0200
Message-ID: <20121210145947.GK11038@arwen.pp.htv.fi>
References: <50C5E23D.5040605@communistcode.co.uk>
 <20121210135337.GA10219@arwen.pp.htv.fi>
 <50C5F6A8.5060701@communistcode.co.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SCOJXUq1iwCn05li"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42650 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab2LJPGz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Dec 2012 10:06:55 -0500
Content-Disposition: inline
In-Reply-To: <50C5F6A8.5060701@communistcode.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jack Mitchell <ml@communistcode.co.uk>
Cc: balbi@ti.com, linux-omap@vger.kernel.org

--SCOJXUq1iwCn05li
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 10, 2012 at 02:50:16PM +0000, Jack Mitchell wrote:
> >On Mon, Dec 10, 2012 at 01:23:09PM +0000, Jack Mitchell wrote:
> >>Hi,
> >>
> >>I am currently having issues with the SPI driver on the beaglebone
> >>using the 3.7-rc8 kernel[1]. I have probed the SPI pins and I have
> >>found that writing works however reading doesn't. When using DMA the
> >>program seems to lock hard and no data is sent on the bus. I am
> >>testing the bus using spidev and the spidev_test[2] application,
> >>however I first came across spi issues with a custom spi driver which
> >>stopped working when I transitioned from 3.2-psp to 3.7-rc8.
> >>
> >>The current output I am seeing from the spidev_test program is just a
> >>series of 0x00 data, which looks to me like no data is getting in at
> >>all. The spidev_test program is not using DMA as the buffer size is
> >>too low, so I forced the dma on when buffer size is > 1 and the
> >>program hangs hard with the system still responding to other
> >>commands.I have briged the pins 18 and 21 on the BeagleBone P9
> >>header.
> >>
> >>Has anyone seen issues like this, or if not if someone could please
> >>test the latest 3.7-rc8 from [1] and let me know if it works for them
> >>and the issue is at my end.
> >>
> >>To get spidev working with devicetree I applied the patch from [3]
> >>and changed the dtb as in the patch pasted below.
> >>
> >>[1] https://github.com/beagleboard/kernel/tree/3.7
> >>[2] http://lxr.linux.no/#linux+v3.6.9/Documentation/spi/spidev_test.c
> >>[3] http://www.mail-archive.com/spi-devel-general@lists.sourceforge.net=
/msg09958.html
> >do you have any debugging output from that driver ? It would be cool to
> >see if DMA is at least being kicked properly for small transfers.
>=20
> When I run the spidev program with dma for transfers > 1, the program
> hangs and the only output in dmesg is:
>=20
> [   12.613952] libphy: 4a101000.mdio:00 - Link is Up - 100/Full <----
> Last line from initial log in [2]
> [   47.669202] spidev spi1.0: setup: speed 24000000, sample leading
> edge, clk normal
> [   47.669246] spidev spi1.0: setup mode 0, 8 bits/w, 24000000 Hz max -->=
 0
> [   47.669260] spidev spi1.0: spi mode 00
> [   47.669283] spidev spi1.0: setup: speed 24000000, sample leading
> edge, clk normal
> [   47.669300] spidev spi1.0: setup mode 0, 16 bits/w, 24000000 Hz max --=
> 0
> [   47.669312] spidev spi1.0: 16 bits per word
> [   47.669330] spidev spi1.0: setup: speed 24000000, sample leading
> edge, clk normal
> [   47.669347] spidev spi1.0: setup mode 0, 16 bits/w, 24000000 Hz max --=
> 0
> [   47.669358] spidev spi1.0: 24000000 Hz (max)
> [   47.673811] spidev spi1.0: setup: speed 24000000, sample leading
> edge, clk normal
>=20
> The initial dmesg statup log is at [2].

can you apply the debugging patch below to spi driver and show me the
output again ?

Note that I'm allowing DMA for as small as 1-byte transfers (as you
needed) and I'm also disabling DMA Request line before calling
complete() as I think the current way could race, but likely wouldn't
cause issues. Anyway, please show me the output.

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 3542fdc..d2b1af2 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -108,7 +108,7 @@ struct omap2_mcspi_dma {
 /* use PIO for small transfers, avoiding DMA setup/teardown overhead and
  * cache operations; better heuristics consider wordsize and bitrate.
  */
-#define DMA_MIN_BYTES			160
+#define DMA_MIN_BYTES			1
=20
=20
 /*
@@ -298,10 +298,11 @@ static void omap2_mcspi_rx_callback(void *data)
 	struct omap2_mcspi *mcspi =3D spi_master_get_devdata(spi->master);
 	struct omap2_mcspi_dma *mcspi_dma =3D &mcspi->dma_channels[spi->chip_sele=
ct];
=20
-	complete(&mcspi_dma->dma_rx_completion);
-
 	/* We must disable the DMA RX request */
+	dev_info(&spi->dev, "Disabling RX Request Line\n");
 	omap2_mcspi_set_dma_req(spi, 1, 0);
+
+	complete(&mcspi_dma->dma_rx_completion);
 }
=20
 static void omap2_mcspi_tx_callback(void *data)
@@ -310,10 +311,11 @@ static void omap2_mcspi_tx_callback(void *data)
 	struct omap2_mcspi *mcspi =3D spi_master_get_devdata(spi->master);
 	struct omap2_mcspi_dma *mcspi_dma =3D &mcspi->dma_channels[spi->chip_sele=
ct];
=20
-	complete(&mcspi_dma->dma_tx_completion);
-
 	/* We must disable the DMA TX request */
+	dev_info(&spi->dev, "Disabling TX Request Line\n");
 	omap2_mcspi_set_dma_req(spi, 0, 0);
+
+	complete(&mcspi_dma->dma_tx_completion);
 }
=20
 static void omap2_mcspi_tx_dma(struct spi_device *spi,
@@ -328,6 +330,7 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
 	void __iomem		*chstat_reg;
 	struct omap2_mcspi_cs	*cs =3D spi->controller_state;
=20
+	dev_info(&spi->dev, "kicking TX DMA\n");
 	mcspi =3D spi_master_get_devdata(spi->master);
 	mcspi_dma =3D &mcspi->dma_channels[spi->chip_select];
 	count =3D xfer->len;
@@ -359,7 +362,9 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
 	dma_async_issue_pending(mcspi_dma->dma_tx);
 	omap2_mcspi_set_dma_req(spi, 0, 1);
=20
+	dev_info(&spi->dev, "Waiting for TX Completion\n");
 	wait_for_completion(&mcspi_dma->dma_tx_completion);
+	dev_info(&spi->dev, "TX Completed\n");
 	dma_unmap_single(mcspi->dev, xfer->tx_dma, count,
 			 DMA_TO_DEVICE);
=20
@@ -392,6 +397,7 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_t=
ransfer *xfer,
 	word_len =3D cs->word_len;
 	l =3D mcspi_cached_chconf0(spi);
=20
+	dev_info(&spi->dev, "kicking RX DMA\n");
 	if (word_len <=3D 8)
 		element_count =3D count;
 	else if (word_len <=3D 16)
@@ -428,7 +434,9 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_t=
ransfer *xfer,
 	dma_async_issue_pending(mcspi_dma->dma_rx);
 	omap2_mcspi_set_dma_req(spi, 1, 1);
=20
+	dev_info(&spi->dev, "Waiting for RX Completion\n");
 	wait_for_completion(&mcspi_dma->dma_rx_completion);
+	dev_info(&spi->dev, "RX Completed\n");
 	dma_unmap_single(mcspi->dev, xfer->rx_dma, count,
 			 DMA_FROM_DEVICE);
 	omap2_mcspi_set_enable(spi, 0);

> >It would also be nice to have a clear picture of what "custom spi
> >driver" you're talking about.
>=20
> The custom SPI driver is for connecting and reading registers from an
> in house FPGA design and can be found at [1]. It's fairly rudimentary
> and also in the development stages, I'm very new to Linux kernel
> programming so please take that into account :)

no problem ;-)

> However it did work flawlessly with 3.2-psp.

yeah, it could be some regression introduced somewhere, or just a bugfix
which was done on 3.2-psp and was missed upstream... annoying when those
happen :-p

--=20
balbi

--SCOJXUq1iwCn05li
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQxfjjAAoJEIaOsuA1yqREHdUQALLbifEYf8MqwqDhUgyQ8Lcc
RzijQvL77PNlJD2vuqB+S1hH6UhxCBl2QGwj6lA2tChdTtgVocBowj/U9Lrp53Mt
toe94P2SE5Thurcx/D2hIhce+L76YHo3PyJ6dPJ2mBL+Yo2OZ6Y9M7AGJiRhFhCK
RUjZ99tUWp8n4mz2nfG+N01NSH9/LKYo+LhwX/Pw/pbq9SQz7ieQOv+uFeyQyQ+a
kOPAz2z0fYnN+KFrG1FAIiVpGlQOB59Gby+t3moHK5WUny/y8jhLdmtbcWPDAbU/
5azL3FNBW2HrTSg/TOCe6upSZA6aQpjkTrWKmNOIj5O3erfHDqZJ7dCwyusD5U9+
5MOaclIeGySdnsbaqycJEtxmlk7nxL4HiF9gyRmMZuaiUeHoGr+VUHl0Sysessin
Su3/X+1/Nq4qtxn5805HOII47gR1nnxEFi2UlGjtzwFC7g77D5Jp5Nv7wSDiJei8
27MBS+dPmUFzDPl+aBP3TguxYZv5zwHvqBVx5/V8Cj7m9NRN6eM6wJel2mjLRfPW
hvnmZWF1hmQC6XCUL1XadTWn9zfubUL9qjf8TLEJDaGJt6mtbFwZhZW/eT+/EbV+
zU7g3aJOqcbvwQM4ZdQ5nqYWvbBVopcAxcD9h2DE87m/tLykl8Pv3yEgygmOuWg+
kuvfwNdtwYe7FzRY2xtY
=uIEz
-----END PGP SIGNATURE-----

--SCOJXUq1iwCn05li--
