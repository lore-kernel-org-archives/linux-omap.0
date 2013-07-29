From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv6 1/2] drivers: spi: Add qspi flash controller
Date: Mon, 29 Jul 2013 12:31:28 +0300
Message-ID: <20130729093128.GE23710@radagast>
References: <1375082550-30544-1-git-send-email-sourav.poddar@ti.com>
 <1375082550-30544-2-git-send-email-sourav.poddar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e5bfZ/T2xnjpUIbw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59173 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428Ab3G2Jbs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Jul 2013 05:31:48 -0400
Content-Disposition: inline
In-Reply-To: <1375082550-30544-2-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, linux-omap@vger.kernel.org, rnayak@ti.com, balbi@ti.com

--e5bfZ/T2xnjpUIbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 29, 2013 at 12:52:29PM +0530, Sourav Poddar wrote:
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> new file mode 100644
> index 0000000..51fe95f
> --- /dev/null
> +++ b/drivers/spi/spi-ti-qspi.c

[ snip ]

> +struct ti_qspi {
> +	spinlock_t              lock;           /* IRQ synchronization */
> +	struct spi_master	*master;
> +	void __iomem            *base;
> +	struct device           *dev;
> +	struct completion       transfer_complete;
> +	struct clk *fclk;
> +	struct ti_qspi_regs     ctx_reg;
> +	int device_type;

device_type isn't used

> +	u32 spi_max_frequency;
> +	u32 cmd;
> +	u32 dc;
> +};

you need to make a choice here ? Are you going to tabify the structure
or not ? You might also want to reorganize this structure to it looks
like below:

struct ti_qspi {
	struct completion	transfer_complete;

	/* IRQ synchronization */
	spinlock_t		lock;

	struct spi_master	*master;
	void __iomem		*base;
	struct clk		*fclk;
	struct device		*dev;

	struct ti_qspi_regs	ctx_reg;

	u32			spi_max_frequency;
	u32			cmd;
	u32			dc;
};

> +/* Status */
> +#define QSPI_WC				(1 << 1)
> +#define QSPI_BUSY			(1 << 0)
> +#define QSPI_WC_BUSY			(QSPI_WC | QSPI_BUSY)

WC_BUSY isn't used in this file. It looks unnecessary too.

> +#define QSPI_XFER_DONE			QSPI_WC

so transfer done is word completion ? Why do you need this ? It's not
even used in this source file.

> +static inline void ti_qspi_read_data(struct ti_qspi *qspi,
> +		unsigned long reg, int wlen, u8 **rxbuf)
> +{
> +	switch (wlen) {
> +	case 8:
> +		**rxbuf =3D readb(qspi->base + reg);
> +		dev_dbg(qspi->dev, "rx done, read %02x\n", *(*rxbuf-1));

you're incrementing only after printing, do you really need the -1 here?

Also, I would change these into dev_vdbg(), it's quite unlikely someone
needs to track all reads to the data register and since you're not
printing the writes either, this looks even more like a case for
dev_vdbg()

> +		*rxbuf +=3D 1;
> +		break;
> +	case 16:
> +		**rxbuf =3D readw(qspi->base + reg);
> +		dev_dbg(qspi->dev, "rx done, read %02x\n", *(*rxbuf-1));

%04x and no -1 (also, if you needed to decrement, it would have to be
%-2).

> +		*rxbuf +=3D 2;
> +		break;
> +	case 32:
> +		**rxbuf =3D readl(qspi->base + reg);
> +		dev_dbg(qspi->dev, "rx done, read %02x\n", *(*rxbuf-1));

%04x

> +		*rxbuf +=3D 4;
> +	default:
> +		dev_dbg(qspi->dev, "word lenght out of range");

s/lenght/length

> +static int ti_qspi_setup(struct spi_device *spi)
> +{
> +	struct ti_qspi	*qspi =3D spi_master_get_devdata(spi->master);
> +	struct ti_qspi_regs *ctx_reg =3D &qspi->ctx_reg;
> +	int clk_div =3D 0, ret;
> +	u32 clk_ctrl_reg, clk_rate, clk_mask;
> +
> +	clk_rate =3D clk_get_rate(qspi->fclk);
> +
> +	if (!qspi->spi_max_frequency) {
> +		dev_err(qspi->dev, "spi max frequency not defined\n");
> +		return -EINVAL;

if you're returning here...

> +	} else {

this else is unneeded

> +		clk_div =3D DIV_ROUND_UP(clk_rate, qspi->spi_max_frequency) - 1;
> +	}
> +
> +	dev_dbg(qspi->dev, "%s: hz: %d, clock divider %d\n", __func__,
> +			qspi->spi_max_frequency, clk_div);
> +
> +	ret =3D pm_runtime_get_sync(qspi->dev);
> +	if (ret) {
> +		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
> +		return ret;
> +	}

after Mark's patch, is this really needed ?

> +	clk_ctrl_reg =3D ti_qspi_read(qspi, QSPI_SPI_CLOCK_CNTRL_REG);
> +
> +	clk_ctrl_reg &=3D ~QSPI_CLK_EN;
> +
> +	/* disable SCLK */
> +	if (!spi->master->busy)
> +		ti_qspi_write(qspi, clk_ctrl_reg, QSPI_SPI_CLOCK_CNTRL_REG);
> +	else
> +		dev_dbg(qspi->dev, "master busy doing other trasnfers\n");

if master is busy, shouldn't you return -EBUSY at this point ?

> +
> +	if (clk_div < 0) {
> +		dev_dbg(qspi->dev, "%s: clock divider < 0, using /1 divider\n",
> +				__func__);
> +		return -EINVAL;

you do a get_sync without a put_sync() here.

> +	}
> +
> +	if (clk_div > QSPI_CLK_DIV_MAX) {
> +		dev_dbg(qspi->dev, "%s: clock divider >%d , using /%d divider\n",
> +			__func__, QSPI_CLK_DIV_MAX, QSPI_CLK_DIV_MAX + 1);
> +		return -EINVAL;

no put_sync()

> +	}
> +
> +	/* enable SCLK */
> +	clk_mask =3D QSPI_CLK_EN | clk_div;
> +	ti_qspi_write(qspi, clk_mask, QSPI_SPI_CLOCK_CNTRL_REG);
> +	ctx_reg->clkctrl =3D clk_mask;
> +
> +	pm_runtime_mark_last_busy(qspi->dev);
> +	ret =3D pm_runtime_put_autosuspend(qspi->dev);
> +	if (ret < 0) {
> +		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ti_qspi_restore_ctx(struct ti_qspi *qspi)
> +{
> +	struct ti_qspi_regs *ctx_reg =3D &qspi->ctx_reg;
> +
> +	ti_qspi_write(qspi, ctx_reg->clkctrl, QSPI_SPI_CLOCK_CNTRL_REG);
> +}
> +
> +static void qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
> +{
> +	const u8 *txbuf;
> +	int wlen, count;
> +
> +	count =3D t->len;
> +	txbuf =3D t->tx_buf;
> +	wlen =3D t->bits_per_word;
> +
> +	while (count--) {
> +		dev_dbg(qspi->dev, "tx cmd %08x dc %08x data %02x\n",
> +			qspi->cmd | QSPI_WR_SNGL, qspi->dc, *txbuf);
> +		ti_qspi_write_data(qspi, *txbuf, QSPI_SPI_DATA_REG,
> +					wlen, &txbuf);
> +		ti_qspi_write(qspi, qspi->dc, QSPI_SPI_DC_REG);
> +		ti_qspi_write(qspi, qspi->cmd | QSPI_WR_SNGL,
> +			QSPI_SPI_CMD_REG);
> +		ti_qspi_write(qspi, QSPI_WC_INT_EN, QSPI_INTR_ENABLE_SET_REG);
> +		wait_for_completion(&qspi->transfer_complete);

you can't wait forever dude, wait_for_completion_timeout() and give it a
2 second timeout, then you can make this and qspi_read_msg() return
something so you can notify that the controller didn't transfer anything
in case your wait_for_completion_timeout() actually times out.

> +	}
> +}
> +
> +static void qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
> +{
> +	u8 *rxbuf;
> +	int wlen, count;
> +
> +	count =3D t->len;
> +	rxbuf =3D t->rx_buf;
> +	wlen =3D t->bits_per_word;
> +
> +	while (count--) {
> +		dev_dbg(qspi->dev, "rx cmd %08x dc %08x\n",
> +			qspi->cmd | QSPI_RD_SNGL, qspi->dc);
> +		ti_qspi_write(qspi, qspi->dc, QSPI_SPI_DC_REG);
> +		ti_qspi_write(qspi, qspi->cmd | QSPI_RD_SNGL,
> +			QSPI_SPI_CMD_REG);
> +		ti_qspi_write(qspi, QSPI_WC_INT_EN, QSPI_INTR_ENABLE_SET_REG);
> +		wait_for_completion(&qspi->transfer_complete);

wait_for_completion_timeout()

> +		ti_qspi_read_data(qspi, QSPI_SPI_DATA_REG, wlen, &rxbuf);
> +		dev_dbg(qspi->dev, "rx done, read %02x\n", *(rxbuf-1));
> +	}
> +}
> +
> +static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer *=
t)
> +{
> +	if (t->tx_buf)
> +		qspi_write_msg(qspi, t);
> +	if (t->rx_buf)
> +		qspi_read_msg(qspi, t);
> +
> +	return 0;
> +}
> +
> +static int ti_qspi_start_transfer_one(struct spi_master *master,
> +		struct spi_message *m)
> +{
> +	struct ti_qspi *qspi =3D spi_master_get_devdata(master);
> +	struct spi_device *spi =3D m->spi;
> +	struct spi_transfer *t;
> +	int status =3D 0, ret;
> +	int frame_length;
> +
> +	/* setup device control reg */
> +	qspi->dc =3D 0;
> +
> +	if (spi->mode & SPI_CPHA)
> +		qspi->dc |=3D QSPI_CKPHA(spi->chip_select);
> +	if (spi->mode & SPI_CPOL)
> +		qspi->dc |=3D QSPI_CKPOL(spi->chip_select);
> +	if (spi->mode & SPI_CS_HIGH)
> +		qspi->dc |=3D QSPI_CSPOL(spi->chip_select);
> +
> +	frame_length =3D (m->frame_length << 3) / spi->bits_per_word;

there's another way to optimize this. If you assume bits_per_word to
always be power of two you can:

	frame_length =3D (m->frame_length << 3) >> __ffs(spi->bits_per_word);

but that would need a comment stating that you're assuming bits_per_word
to always be a power of two. Not sure if this is a correct assumption.

> +	frame_length =3D clamp(frame_length, 0, QSPI_FRAME_MAX);
> +
> +	/* setup command reg */
> +	qspi->cmd =3D 0;
> +	qspi->cmd |=3D QSPI_EN_CS(spi->chip_select);
> +	qspi->cmd |=3D QSPI_FLEN(frame_length);
> +	qspi->cmd |=3D QSPI_WC_CMD_INT_EN;
> +
> +	list_for_each_entry(t, &m->transfers, transfer_list) {
> +		qspi->cmd |=3D QSPI_WLEN(t->bits_per_word);
> +
> +		ret =3D qspi_transfer_msg(qspi, t);
> +		if (ret) {
> +			dev_dbg(qspi->dev, "transfer message failed\n");
> +			return -EINVAL;
> +		}
> +
> +		m->actual_length +=3D t->len;
> +	}
> +
> +	m->status =3D status;
> +	spi_finalize_current_message(master);
> +
> +	ti_qspi_write(qspi, qspi->cmd | QSPI_INVAL, QSPI_SPI_CMD_REG);
> +
> +	return status;
> +}
> +
> +static irqreturn_t ti_qspi_isr(int irq, void *dev_id)
> +{
> +	struct ti_qspi *qspi =3D dev_id;
> +	u16 mask, stat;
> +
> +	irqreturn_t ret =3D IRQ_HANDLED;
> +
> +	spin_lock(&qspi->lock);
> +
> +	stat =3D ti_qspi_read(qspi, QSPI_INTR_STATUS_ENABLED_CLEAR);

since you're not reading the _RAW register, you don't need the mask
below, right ?

> +	mask =3D ti_qspi_read(qspi, QSPI_INTR_ENABLE_SET_REG);
> +
> +	if (!(stat & mask)) {
> +		dev_dbg(qspi->dev, "No IRQ triggered\n");
> +		ret =3D IRQ_NONE;
> +	}
> +
> +	ret =3D IRQ_WAKE_THREAD;

look at this code and tell me when will you *EVER* return IRQ_NONE. Dude
you're waking up the IRQ thread even when there are no IRQs to be
handled.

> +	spin_unlock(&qspi->lock);

You should, before releasing the lock, mask your IRQs, so that you can
get rid of IRQF_ONESHOT. Unmask them before returning from the IRQ
thread.

> +static int ti_qspi_probe(struct platform_device *pdev)
> +{
> +	struct  ti_qspi *qspi;
> +	struct spi_master *master;
> +	struct resource         *r;
> +	struct device_node *np =3D pdev->dev.of_node;
> +	u32 max_freq;
> +	int ret =3D 0, num_cs, irq;
> +
> +	master =3D spi_alloc_master(&pdev->dev, sizeof(*qspi));
> +	if (!master)
> +		return -ENOMEM;
> +
> +	master->mode_bits =3D SPI_CPOL | SPI_CPHA;
> +
> +	master->num_chipselect =3D 1;

again with the num_chipselect =3D 1 ? IIRC this controller has 4
chipselects, just read 24.5.1 on your TRM.

> +	master->bus_num =3D -1;
> +	master->flags =3D SPI_MASTER_HALF_DUPLEX;
> +	master->setup =3D ti_qspi_setup;
> +	master->auto_runtime_pm =3D true;
> +	master->transfer_one_message =3D ti_qspi_start_transfer_one;
> +	master->dev.of_node =3D pdev->dev.of_node;
> +	master->bits_per_word_mask =3D BIT(32 - 1) | BIT(16 - 1) | BIT(8 - 1);
> +
> +	if (!of_property_read_u32(np, "num-cs", &num_cs))
> +		master->num_chipselect =3D num_cs;

so you reinitialize here num_chipselect, then why do you initialize it
above ?

> +	platform_set_drvdata(pdev, master);
> +
> +	qspi =3D spi_master_get_devdata(master);
> +	qspi->master =3D master;
> +	qspi->dev =3D &pdev->dev;
> +
> +	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (r =3D=3D NULL) {
> +		ret =3D -ENODEV;
> +		goto free_master;
> +	}

you don't need to check the resource when using devm_ioremap_resource().

> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "no irq resource?\n");
> +		return irq;
> +	}
> +
> +	spin_lock_init(&qspi->lock);
> +
> +	qspi->base =3D devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(qspi->base)) {
> +		ret =3D PTR_ERR(qspi->base);
> +		goto free_master;
> +	}
> +
> +	ret =3D devm_request_threaded_irq(&pdev->dev, irq, ti_qspi_isr,
> +			ti_qspi_threaded_isr, IRQF_NO_SUSPEND | IRQF_ONESHOT,

why do you need IRQF_NO_SUSPEND ?

--=20
balbi

--e5bfZ/T2xnjpUIbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR9jZwAAoJEIaOsuA1yqREJWAP/i23+e5vMBHQDy4dVfcYdv9x
SNexWJSGqBK6XKbbsrzpMlk3nnvWU31OSNWcJ9Yz58YR1yrNtN+s5gY0lyQEeit4
xTJ3NEYPpfuFidkce99B4fmlsCZXDrRbrms7M8DJ9Ze/vt6Fx2Eb6b8NWo1q3k8Z
wUZ6ANalVQkHFZ83eY7QGhk9A8ECBDeLg+thLE1rUJc/LU8kMNjKoL1KU3+4FLdf
sfaECTzEG9cM8WSgzS7N+GGp9K9L6eqv402ceop+ZFroxfv3l3E5CtzksSZm1d9D
b1nxIi0u2r0xzh4NFf+EnTaYgql6UyORKAZtkhEnuYdO680VKwNTf4BQzsRVCNTs
m8seBA4CjijdI0i1WbdE+ZiwAZqSKu2APRPsojh818Er7uZvo/OXyKukSSIro/jm
yYe1T8gqPUKTjloHKdnVi8gTIR4YAvaU7uxtLB7VmsNmz/pVjnQVS4vYoo8eP3mv
bVHEhXJ8l9zHaGicmuIdOzd7v0eonkYyPELisSg5s6iAEQutRhU1DkSVV5GaVJwa
bKcjedoyo+dLUiq4JWRKFfJBoIuVCxmOQ5fQZLQ5Y/hazPl+7NpcJxgHAr+jtx3E
qxv1QegKGO06cEmxj7qX/hy6ICQiCIvwGTRIGlM38i7ivDUkV8O3kOHLKhhxlpZy
YSZrsTcQJevhF+xRGITc
=D2nC
-----END PGP SIGNATURE-----

--e5bfZ/T2xnjpUIbw--
