From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: [PATCHv5 1/2] drivers: spi: Add qspi flash controller
Date: Sun, 28 Jul 2013 17:13:53 -0700
Message-ID: <CA+7tXiiQGfYN6sck3YQo8RinPad0e8bgW3J6rBc9sCq_J48fTg@mail.gmail.com>
References: <1374858922-14637-1-git-send-email-sourav.poddar@ti.com>
	<1374858922-14637-2-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:43360 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab3G2ANy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 20:13:54 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so7984265obq.21
        for <linux-omap@vger.kernel.org>; Sun, 28 Jul 2013 17:13:53 -0700 (PDT)
In-Reply-To: <1374858922-14637-2-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, linux-omap@vger.kernel.org, rnayak@ti.com, balbi@ti.com

On Fri, Jul 26, 2013 at 10:15 AM, Sourav Poddar <sourav.poddar@ti.com> wrote:
> +
> +static inline void ti_qspi_read_data(struct ti_qspi *qspi,
> +               unsigned long reg, int wlen, u8 **rxbuf)
> +{
> +       switch (wlen) {
> +       case 8:
> +               **rxbuf = readw(qspi->base + reg);
> +               dev_dbg(qspi->dev, "rx done, read %02x\n", *(*rxbuf-1));
> +               *rxbuf += 1;

You still have readw() paired with 8 bit length, readb() with 16, and
so on.  I do not think your 16 and 32 bit cases will even work.  Since
**rxbuf will always be an pointer to an 8-bit value, it will always
just use the lower 8 bits of the register.  You also always increment
the address by 1.  And the printout, which is the same in every case
so maybe you shouldn't duplicate it, isn't correct.  It will print out
the previous byte in the buffer.  It will possibly crash on the first
byte, since you will be reading before the beginning of the buffer.

You probably only tested this with 8 bit word length.  Since that has
readw(), it probably does not matter what
size is used for the read.

> +static int ti_qspi_setup(struct spi_device *spi)
> +{
> +
> +       clk_ctrl_reg = ti_qspi_read(qspi, QSPI_SPI_CLOCK_CNTRL_REG);
> +
> +       clk_ctrl_reg &= ~QSPI_CLK_EN;
> +
> +       /* disable SCLK */
> +       ti_qspi_write(qspi, clk_ctrl_reg, QSPI_SPI_CLOCK_CNTRL_REG);

This looks like to are still not taking into account that setup() can
be called while a transfer for another slave is in progress.

> +
> +       /* setup command reg */
> +       qspi->cmd = 0;
> +       qspi->cmd |= QSPI_EN_CS(spi->chip_select);
> +       qspi->cmd |= QSPI_FLEN(frame_length);
> +
> +       list_for_each_entry(t, &m->transfers, transfer_list) {
> +               qspi->cmd |= QSPI_WLEN(t->bits_per_word);
> +               qspi->cmd |= QSPI_WC_CMD_INT_EN;

Why is the QSPI_WC_CMD_INT_EN bit set inside the loop but the
QSPI_EN_CS() and QSPI_FLEN() bits are set outside the loop?

> +
> +       if (!of_property_read_u32(np, "ti,num-cs", &num_cs))
> +               master->num_chipselect = num_cs;

You are still not using standard "num-cs" property?
