From: "Mark A. Greer" <mgreer-luAo+O/VEmrlveNOaEYElw@public.gmane.org>
Subject: [PATCH] spi: omap2-mcspi: Configure hardware when slave driver changes mode
Date: Tue,  1 Jul 2014 20:28:32 -0700
Message-ID: <1404271712-669-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Mark A. Greer" <mgreer-luAo+O/VEmrlveNOaEYElw@public.gmane.org>, =?UTF-8?q?Stefan=20S=C3=B8rensen?= <stefan.sorensen-usnHOLptxrsHrNJx0XZkJA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Commit id 2bd16e3e23d9df41592c6b257c59b6860a9cc3ea
(spi: omap2-mcspi: Do not configure the controller
on each transfer unless needed) does its job too
well so omap2_mcspi_setup_transfer() isn't called
even when an SPI slave driver changes 'spi->mode'.
The result is that the mode requested by the SPI
slave driver never takes effect.

=46ix this by adding the 'mode' member to the
omap2_mcspi_cs structure which holds the mode
value that the hardware is configured for.
When the SPI slave driver changes 'spi->mode'
it will be different than the value of this new
member and the SPI master driver will know that
the hardware must be reconfigured (by calling
omap2_mcspi_setup_transfer()).

CC: Stefan S=C3=B8rensen <stefan.sorensen-usnHOLptxrsHrNJx0XZkJA@public.gmane.org>
Signed-off-by: Mark A. Greer <mgreer-luAo+O/VEmrlveNOaEYElw@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcsp=
i.c
index 4dc77df..68441fa 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -149,6 +149,7 @@ struct omap2_mcspi_cs {
 	void __iomem		*base;
 	unsigned long		phys;
 	int			word_len;
+	u16			mode;
 	struct list_head	node;
 	/* Context save and restore shadow register */
 	u32			chconf0, chctrl0;
@@ -926,6 +927,8 @@ static int omap2_mcspi_setup_transfer(struct spi_de=
vice *spi,
=20
 	mcspi_write_chconf0(spi, l);
=20
+	cs->mode =3D spi->mode;
+
 	dev_dbg(&spi->dev, "setup: speed %d, sample %s edge, clk %s\n",
 			speed_hz,
 			(spi->mode & SPI_CPHA) ? "trailing" : "leading",
@@ -998,6 +1001,7 @@ static int omap2_mcspi_setup(struct spi_device *sp=
i)
 			return -ENOMEM;
 		cs->base =3D mcspi->base + spi->chip_select * 0x14;
 		cs->phys =3D mcspi->phys + spi->chip_select * 0x14;
+		cs->mode =3D 0;
 		cs->chconf0 =3D 0;
 		cs->chctrl0 =3D 0;
 		spi->controller_state =3D cs;
@@ -1079,6 +1083,16 @@ static void omap2_mcspi_work(struct omap2_mcspi =
*mcspi, struct spi_message *m)
 	cs =3D spi->controller_state;
 	cd =3D spi->controller_data;
=20
+	/*
+	 * The slave driver could have changed spi->mode in which case
+	 * it will be different from cs->mode (the current hardware setup).
+	 * If so, set par_override (even though its not a parity issue) so
+	 * omap2_mcspi_setup_transfer will be called to configure the hardwar=
e
+	 * with the correct mode on the first iteration of the loop below.
+	 */
+	if (spi->mode !=3D cs->mode)
+		par_override =3D 1;
+
 	omap2_mcspi_set_enable(spi, 0);
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (t->tx_buf =3D=3D NULL && t->rx_buf =3D=3D NULL && t->len) {
--=20
1.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
