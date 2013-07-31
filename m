From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv7 1/2] drivers: spi: Add qspi flash controller
Date: Wed, 31 Jul 2013 12:20:08 +0300
Message-ID: <20130731092008.GC14517@radagast>
References: <1375249673-2585-1-git-send-email-sourav.poddar@ti.com>
 <1375249673-2585-2-git-send-email-sourav.poddar@ti.com>
 <20130731074952.GA14517@radagast>
 <51F8D49B.2090307@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36055 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905Ab3GaJU3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Jul 2013 05:20:29 -0400
Content-Disposition: inline
In-Reply-To: <51F8D49B.2090307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: balbi@ti.com, broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, linux-omap@vger.kernel.org, rnayak@ti.com

--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 31, 2013 at 02:40:51PM +0530, Sourav Poddar wrote:
> >>+#define	QSPI_FRAME_MAX			0xfff
> >Frame max is 4096, 0x1000, right ?
> Yes,
> this macro was used initially to fill the register bits, where 4095 =3D
> 4096 words.
> Will change it to now.

you can make this something like:

#define QSPI_FRAME(n)		(((n) - 1) & 0xfff)

> >>+static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
> >>+{
> >>+	const u8 *txbuf;
> >>+	int wlen, count, ret;
> >>+
> >>+	count =3D t->len;
> >>+	txbuf =3D t->tx_buf;
> >>+	wlen =3D t->bits_per_word;
> >>+
> >>+	while (count--) {
> >you're decrementing count by one, but in some cases you write 4 bytes or
> >2 bytes... This will blow up very soon. I can already see overflows
> >happening...
> we write 2 bytes and 4 bytes for 16 bits_per_word and 32 bits_per_word ca=
se.
> count is t->len, which is the total number of words to transfer. This

t->len is total number of bytes as you can see from the documentation in
the header:

* @len: size of rx and tx buffers (in bytes)

As I said before, please read the documentation.

> words can be of any length (1, 2 or 4) bytes. So, I think it should be
> decremented by 1 only.

this is wrong.

> >>+static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer=
 *t)
> >>+{
> >>+	int ret;
> >>+
> >>+	if (t->tx_buf) {
> >>+		ret =3D qspi_write_msg(qspi, t);
> >>+		if (ret) {
> >>+			dev_dbg(qspi->dev, "Error while writing\n");
> >>+			return -EINVAL;
> >why do you change the return value from qspi_write_msg() ?
> >
> I  was not sure about this, I thought I had signals an ETIMEOUT during
> timeout, So signal a invalid transfer here.
> Do you suggest keeping ETIMEOUT here also?

yeah, so we tell whoever called us that the transfer timed out. If you
return -EINVAL you're telling your clients they gave you an invalid
spi_transfer, which is not the case.

> >>+static int ti_qspi_start_transfer_one(struct spi_master *master,
> >>+		struct spi_message *m)
> >>+{
> >>+	struct ti_qspi *qspi =3D spi_master_get_devdata(master);
> >>+	struct spi_device *spi =3D m->spi;
> >>+	struct spi_transfer *t;
> >>+	int status =3D 0, ret;
> >>+	int frame_length;
> >>+
> >>+	/* setup device control reg */
> >>+	qspi->dc =3D 0;
> >>+
> >>+	if (spi->mode&  SPI_CPHA)
> >>+		qspi->dc |=3D QSPI_CKPHA(spi->chip_select);
> >>+	if (spi->mode&  SPI_CPOL)
> >>+		qspi->dc |=3D QSPI_CKPOL(spi->chip_select);
> >>+	if (spi->mode&  SPI_CS_HIGH)
> >>+		qspi->dc |=3D QSPI_CSPOL(spi->chip_select);
> >>+
> >>+	frame_length =3D (m->frame_length<<  3) / spi->bits_per_word;
> >>+
> >>+	frame_length =3D clamp(frame_length, 0, QSPI_FRAME_MAX);
> >>+
> >>+	/* setup command reg */
> >>+	qspi->cmd =3D 0;
> >>+	qspi->cmd |=3D QSPI_EN_CS(spi->chip_select);
> >>+	qspi->cmd |=3D QSPI_FLEN(frame_length);
> >>+	qspi->cmd |=3D QSPI_WC_CMD_INT_EN;
> >>+
> >>+	ti_qspi_write(qspi, QSPI_WC_INT_EN, QSPI_INTR_ENABLE_SET_REG);
> >>+
> >>+	list_for_each_entry(t,&m->transfers, transfer_list) {
> >no locking around list traversal ?
> >
> hmm..can put a spin_lock around "qspi_transfer_msg" ?

no dude, you need to protect the access to the list. So it needs to be
around list_for_each_entry().

> >>+static irqreturn_t ti_qspi_isr(int irq, void *dev_id)
> >>+{
> >>+	struct ti_qspi *qspi =3D dev_id;
> >>+	u16 stat;
> >>+
> >>+	irqreturn_t ret =3D IRQ_HANDLED;
> >>+
> >>+	spin_lock(&qspi->lock);
> >>+
> >>+	stat =3D ti_qspi_read(qspi, QSPI_INTR_STATUS_ENABLED_CLEAR);
> >>+
> >>+	if (!stat) {
> >>+		dev_dbg(qspi->dev, "No IRQ triggered\n");
> >>+		return IRQ_NONE;
> >leaving lock held.
> >
> Will add a unlock before returning.

there's a very nice C statement, goto, which you can use here.

> >>+static irqreturn_t ti_qspi_threaded_isr(int this_irq, void *dev_id)
> >>+{
> >>+	struct ti_qspi *qspi =3D dev_id;
> >>+	unsigned long flags;
> >>+
> >>+	spin_lock_irqsave(&qspi->lock, flags);
> >>+
> >>+	complete(&qspi->transfer_complete);
> >you need to check if your word completion is actually set. Don't assume
> >it's set because we might want to change the code later.
> >
> hmm..something like this.?
>   if (ti_qspi_read(qspi, QSPI_SPI_STATUS_REG) & WC)
>         complete(&qspi->transfer_complete);

I rather:

stat =3D ti_qspi_read(qspi, QSPI_SPI_STATUS_REG);

if (stat & WC)
	complete()

then, if we want to add frame interrupt handling later, we don't need to
read status register again. In fact, to avoid reading the status
register here, you could even cache the returned value you read in your
hardirq handler inside your qspi struct.

--=20
balbi

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR+NbIAAoJEIaOsuA1yqRE4/IP/jMZCvhdzOFVhnIFNlyYTsZM
LbgI9XcQx2Y0Xbqd8zYK/c9C8wOT5fEtNCS63Xm/2wHgz+8s2ewwrs6gbuUBvxfC
6Cc+KtwOq7Kyi7L/82QC7DMsSo2qu9kBHYyl65NAIAsuQM3sWeiAVkcYxhoPrH8P
g/8lB2vDYrjw/PAx2bvWK0Szjaze+hM9rF5PnzDI5oHFu9X6UUUPIpMDrRD4JOE4
Z6zgpgHQEEIkYf/kxHe+76IHDrsdUfLRLNu/c3zTv3eRJLQqZH/Fbf+G3l3+5vjN
iJlGuqqStEmDQPm3g9UzcZfqLzL5q4p9yTcnTIIGR62kpjRLVwlTPx8tTsXmbeB5
Lvei28iAJle0YU1UUh3HidEgesuuVpkbEa9aeJP06FJdTtgGPW/MTyzpLs6aNyKf
RoBB70ydmEf9PivK8eic/SzL8Ir1Mwz0nIeAG0kT0sfyY9khMtmkbO++QWmzP+cx
B5aVyh9Wjwt48Fdx37DZUFSBYuj3c5xemxrdDS/O0gGFzaljr5invnvRVVOGM5c8
LU2GH8EbPWGBTgWXgW9zQyQKBFScKijMA8CunGkFeTtPTCo7ZSlP11Ybzt7zdtAD
DRcAs/eDYbLga96obWZQ7UYQtBlAc3ZS6tDftB/dlZO5EEHEmGknfMm7raEVIGk3
C0YUgSh/2JNMN7ydLw69
=9TYU
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
