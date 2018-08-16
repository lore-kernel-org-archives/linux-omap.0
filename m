From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v3 5/7] mtd: rawnand: ams-delta: Set port direction when
 needed
Date: Thu, 16 Aug 2018 09:30:52 +0200
Message-ID: <20180816093052.2bcbf004@bbrezillon>
References: <20180806222918.12644-1-jmkrzyszt@gmail.com>
        <20180813223448.21316-1-jmkrzyszt@gmail.com>
        <20180813223448.21316-6-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180813223448.21316-6-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 14 Aug 2018 00:34:46 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> In its current shape, the driver sets data port direction before each
> byte read/write operation, even during multi-byte transfers.  Improve
> performance of the driver by setting the port direction only when
> needed.
> 
> This optimisation will become particularly important as soon as
> planned conversion of the driver to GPIO API for data I/O will be
> implemented.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  drivers/mtd/nand/raw/ams-delta.c | 59 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 47 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
> index 09d6901fc94d..5f9180fe4f8b 100644
> --- a/drivers/mtd/nand/raw/ams-delta.c
> +++ b/drivers/mtd/nand/raw/ams-delta.c
> @@ -45,6 +45,7 @@ struct ams_delta_nand {
>  	struct gpio_desc	*gpiod_ale;
>  	struct gpio_desc	*gpiod_cle;
>  	void __iomem		*io_base;
> +	bool			data_in;
>  };
>  
>  /*
> @@ -72,50 +73,83 @@ static const struct mtd_partition partition_info[] = {
>  	  .size		=  3 * SZ_256K },
>  };
>  
> -static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
> +static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
>  {
>  	struct nand_chip *this = mtd_to_nand(mtd);
>  	struct ams_delta_nand *priv = nand_get_controller_data(this);
> -	void __iomem *io_base = priv->io_base;
>  
> -	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
>  	writew(byte, this->IO_ADDR_W);
> +
>  	gpiod_set_value(priv->gpiod_nwe, 0);
>  	ndelay(40);
>  	gpiod_set_value(priv->gpiod_nwe, 1);
>  }
>  
> -static u_char ams_delta_read_byte(struct mtd_info *mtd)
> +static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
>  {
> -	u_char res;
>  	struct nand_chip *this = mtd_to_nand(mtd);
>  	struct ams_delta_nand *priv = nand_get_controller_data(this);
>  	void __iomem *io_base = priv->io_base;
>  
> +	if (priv->data_in) {
> +		writew(0, io_base + OMAP_MPUIO_IO_CNTL);
> +		priv->data_in = false;
> +	}
> +
> +	ams_delta_write_next_byte(mtd, byte);
> +}

I'm not a big fan of this {read,write}_byte/next_byte() approach.

Can't we do something like:

static void ams_delta_io_write(struct ams_delta_nand *priv, u8 data)
{
	writew(byte, priv->nand_chip.IO_ADDR_W);
  	gpiod_set_value(priv->gpiod_nwe, 0);
  	ndelay(40);
  	gpiod_set_value(priv->gpiod_nwe, 1);
}

static u8 ams_delta_io_read(struct ams_delta_nand *priv)
{
	u8 res;

  	gpiod_set_value(priv->gpiod_nre, 0);
  	ndelay(40);
	res = readw(priv->nand_chip.IO_ADDR_R);
 	gpiod_set_value(priv->gpiod_nre, 1);
 
 	return res;
}

static void ams_delta_set_io_dir(struct ams_delta_nand *priv, bool in)
{
	if (in == priv->data_in)
		return;

	writew(in ? ~0 : 0, priv->io_base + OMAP_MPUIO_IO_CNTL);
	priv->data_in = in;
}

static void ams_delta_write_buf(struct mtd_info *mtd, const u8 *buf,
				int len)
{
	struct nand_chip *this = mtd_to_nand(mtd);
	struct ams_delta_nand *priv = nand_get_controller_data(this);
	int i;

	ams_delta_set_io_dir(priv, false);

	for (i =0; i < len; i++)
		ams_delta_io_write(priv, buf[i]);
}

static void ams_delta_write_byte(struct mtd_info *mtd, u8 byte)
{
	ams_delta_write_buf(mtd, &byte, 1);
}

static void ams_delta_read_buf(struct mtd_info *mtd, u8 *buf, int len)
{
	struct nand_chip *this = mtd_to_nand(mtd);
	struct ams_delta_nand *priv = nand_get_controller_data(this);
	int i;

	ams_delta_set_io_dir(priv, true);

	for (i = 0; i < len; i++)
		buf[i] = ams_delta_io_read(priv);
}

static u8 ams_delta_read_byte(struct mtd_info *mtd)
{
	u8 res;

	ams_delta_read_buf(mtd, &res, 1);

	return res;
}
