From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [RFC PATCH v2 08/12] mtd: rawnand: ams-delta: Simplify pointer
 resolution on read/write
Date: Tue, 7 Aug 2018 19:02:56 +0200
Message-ID: <20180807190256.092b2364@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
        <20180806222918.12644-1-jmkrzyszt@gmail.com>
        <20180806222918.12644-9-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806222918.12644-9-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue,  7 Aug 2018 00:29:14 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Simplify data read/write sub-functions by changing their APIs so they
> accept driver private structure pointer instead of mtd_info.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

Can you move that one earlier in the series so that it can be applied
even if we're still discussing the GPIO bitmap changes?

> ---
>  drivers/mtd/nand/raw/ams-delta.c | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
> index d02c48c013e8..30c461138195 100644
> --- a/drivers/mtd/nand/raw/ams-delta.c
> +++ b/drivers/mtd/nand/raw/ams-delta.c
> @@ -76,10 +76,8 @@ static void ams_delta_write_commit(struct ams_delta_nand *priv)
>  	gpiod_set_value(priv->gpiod_nwe, 1);
>  }
>  
> -static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
> +static void ams_delta_write_next_byte(struct ams_delta_nand *priv, u_char byte)
>  {
> -	struct nand_chip *this = mtd_to_nand(mtd);
> -	struct ams_delta_nand *priv = nand_get_controller_data(this);
>  	struct gpio_descs *data_gpiods = priv->data_gpiods;
>  	unsigned long bits = byte;
>  	int i, value_array[data_gpiods->ndescs];
> @@ -93,10 +91,8 @@ static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
>  	ams_delta_write_commit(priv);
>  }
>  
> -static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
> +static void ams_delta_write_first_byte(struct ams_delta_nand *priv, u_char byte)
>  {
> -	struct nand_chip *this = mtd_to_nand(mtd);
> -	struct ams_delta_nand *priv = nand_get_controller_data(this);
>  	struct gpio_descs *data_gpiods = priv->data_gpiods;
>  	unsigned long bits = byte;
>  	int i;
> @@ -108,10 +104,8 @@ static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
>  	ams_delta_write_commit(priv);
>  }
>  
> -static u_char ams_delta_read_next_byte(struct mtd_info *mtd)
> +static u_char ams_delta_read_next_byte(struct ams_delta_nand *priv)
>  {
> -	struct nand_chip *this = mtd_to_nand(mtd);
> -	struct ams_delta_nand *priv = nand_get_controller_data(this);
>  	struct gpio_descs *data_gpiods = priv->data_gpiods;
>  	unsigned long bits = 0;
>  	int i, value_array[data_gpiods->ndescs];
> @@ -131,38 +125,48 @@ static u_char ams_delta_read_next_byte(struct mtd_info *mtd)
>  	return bits;
>  }
>  
> -static u_char ams_delta_read_byte(struct mtd_info *mtd)
> +static u_char ams_delta_read_first_byte(struct ams_delta_nand *priv)
>  {
> -	struct nand_chip *this = mtd_to_nand(mtd);
> -	struct ams_delta_nand *priv = nand_get_controller_data(this);
>  	struct gpio_descs *data_gpiods = priv->data_gpiods;
>  	int i;
>  
>  	for (i = 0; i < data_gpiods->ndescs; i++)
>  		gpiod_direction_input(data_gpiods->desc[i]);
>  
> -	return ams_delta_read_next_byte(mtd);
> +	return ams_delta_read_next_byte(priv);
> +}
> +
> +static u_char ams_delta_read_byte(struct mtd_info *mtd)
> +{
> +	struct nand_chip *this = mtd_to_nand(mtd);
> +	struct ams_delta_nand *priv = nand_get_controller_data(this);
> +
> +	return ams_delta_read_first_byte(priv);
>  }
>  
>  static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
>  				int len)
>  {
> +	struct nand_chip *this = mtd_to_nand(mtd);
> +	struct ams_delta_nand *priv = nand_get_controller_data(this);
>  	int i;
>  
>  	if (len > 0)
> -		ams_delta_write_byte(mtd, buf[0]);
> +		ams_delta_write_first_byte(priv, buf[0]);
>  	for (i = 1; i < len; i++)
> -		ams_delta_write_next_byte(mtd, buf[i]);
> +		ams_delta_write_next_byte(priv, buf[i]);
>  }
>  
>  static void ams_delta_read_buf(struct mtd_info *mtd, u_char *buf, int len)
>  {
> +	struct nand_chip *this = mtd_to_nand(mtd);
> +	struct ams_delta_nand *priv = nand_get_controller_data(this);
>  	int i;
>  
>  	if (len > 0)
> -		buf[0] = ams_delta_read_byte(mtd);
> +		buf[0] = ams_delta_read_first_byte(priv);
>  	for (i = 1; i < len; i++)
> -		buf[i] = ams_delta_read_next_byte(mtd);
> +		buf[i] = ams_delta_read_next_byte(priv);
>  }
>  
>  /*
> @@ -186,7 +190,7 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
>  	}
>  
>  	if (cmd != NAND_CMD_NONE)
> -		ams_delta_write_byte(mtd, cmd);
> +		ams_delta_write_first_byte(priv, cmd);
>  }
>  
>  static int ams_delta_nand_ready(struct mtd_info *mtd)
