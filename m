From: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Subject: Re: [PATCH 08/23] mtd: rawnand: Pass a nand_chip object to
 ecc->read_xxx() hooks
Date: Sat, 18 Aug 2018 10:30:13 +0200
Message-ID: <c08c6ecf720cc6b242094246b2f296c3@agner.ch>
References: <20180817160922.6224-1-boris.brezillon@bootlin.com>
 <20180817160922.6224-9-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180817160922.6224-9-boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, Gregory Clement <gregory.clement-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lukasz Majewski <lukma-ynQEQJNshbs@public.gmane.org>, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Boris,

On 17.08.2018 18:09, Boris Brezillon wrote:
> Let's make the raw NAND API consistent by patching all helpers and
> hooks to take a nand_chip object instead of an mtd_info one or
> remove the mtd_info object when both are passed.
> 
> Let's tackle all ecc->read_xxx() hooks at once.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/mtd/nand/raw/atmel/nand-controller.c  | 12 ++---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c      | 21 ++++----
>  drivers/mtd/nand/raw/cafe_nand.c              | 10 ++--
>  drivers/mtd/nand/raw/denali.c                 | 17 +++---
>  drivers/mtd/nand/raw/docg4.c                  | 20 ++++----
>  drivers/mtd/nand/raw/fsl_elbc_nand.c          |  5 +-
>  drivers/mtd/nand/raw/fsl_ifc_nand.c           |  5 +-
>  drivers/mtd/nand/raw/fsmc_nand.c              |  6 +--
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c    | 23 ++++-----
>  drivers/mtd/nand/raw/hisi504_nand.c           |  9 ++--
>  drivers/mtd/nand/raw/lpc32xx_mlc.c            | 10 ++--
>  drivers/mtd/nand/raw/lpc32xx_slc.c            | 14 ++---
>  drivers/mtd/nand/raw/marvell_nand.c           | 30 +++++------
>  drivers/mtd/nand/raw/mtk_nand.c               | 23 +++++----
>  drivers/mtd/nand/raw/mxc_nand.c               | 11 ++--
>  drivers/mtd/nand/raw/nand_base.c              | 74 +++++++++++++--------------
>  drivers/mtd/nand/raw/nand_micron.c            |  6 +--
>  drivers/mtd/nand/raw/omap2.c                  |  6 +--
>  drivers/mtd/nand/raw/qcom_nandc.c             | 11 ++--
>  drivers/mtd/nand/raw/r852.c                   |  5 +-
>  drivers/mtd/nand/raw/sh_flctl.c               |  6 ++-
>  drivers/mtd/nand/raw/sunxi_nand.c             | 26 +++++-----
>  drivers/mtd/nand/raw/tango_nand.c             | 16 +++---
>  drivers/mtd/nand/raw/tegra_nand.c             | 15 +++---
>  drivers/mtd/nand/raw/vf610_nfc.c              | 18 +++----
>  drivers/staging/mt29f_spinand/mt29f_spinand.c |  5 +-
>  include/linux/mtd/rawnand.h                   | 30 +++++------
>  27 files changed, 216 insertions(+), 218 deletions(-)
> 
[...]
> diff --git a/drivers/mtd/nand/raw/tegra_nand.c
> b/drivers/mtd/nand/raw/tegra_nand.c
> index 5dcee20e2a8c..bcc3a2888c4f 100644
> --- a/drivers/mtd/nand/raw/tegra_nand.c
> +++ b/drivers/mtd/nand/raw/tegra_nand.c
> @@ -615,10 +615,10 @@ static int tegra_nand_page_xfer(struct mtd_info
> *mtd, struct nand_chip *chip,
>  	return ret;
>  }
>  
> -static int tegra_nand_read_page_raw(struct mtd_info *mtd,
> -				    struct nand_chip *chip, u8 *buf,
> +static int tegra_nand_read_page_raw(struct nand_chip *chip, u8 *buf,
>  				    int oob_required, int page)
>  {
> +	struct mtd_info *mtd = nand_to_mtd(chip);
>  	void *oob_buf = oob_required ? chip->oob_poi : NULL;
>  
>  	return tegra_nand_page_xfer(mtd, chip, buf, oob_buf,

Since mtd is only required to pass it to tegra_nand_page_xfer, it would
be better to change tegra_nand_page_xfer to only take chip.

--
Stefan

> @@ -635,9 +635,10 @@ static int tegra_nand_write_page_raw(struct mtd_info *mtd,
>  				     mtd->oobsize, page, false);
>  }
>  
> -static int tegra_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
> -			       int page)
> +static int tegra_nand_read_oob(struct nand_chip *chip, int page)
>  {
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +
>  	return tegra_nand_page_xfer(mtd, chip, NULL, chip->oob_poi,
>  				    mtd->oobsize, page, true);
>  }
> @@ -649,10 +650,10 @@ static int tegra_nand_write_oob(struct mtd_info
> *mtd, struct nand_chip *chip,
>  				    mtd->oobsize, page, false);
>  }
>  
> -static int tegra_nand_read_page_hwecc(struct mtd_info *mtd,
> -				      struct nand_chip *chip, u8 *buf,
> +static int tegra_nand_read_page_hwecc(struct nand_chip *chip, u8 *buf,
>  				      int oob_required, int page)
>  {
> +	struct mtd_info *mtd = nand_to_mtd(chip);
>  	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
>  	struct tegra_nand_chip *nand = to_tegra_chip(chip);
>  	void *oob_buf = oob_required ? chip->oob_poi : NULL;
> @@ -716,7 +717,7 @@ static int tegra_nand_read_page_hwecc(struct mtd_info *mtd,
>  		 * erased or if error correction just failed for all sub-
>  		 * pages.
>  		 */
> -		ret = tegra_nand_read_oob(mtd, chip, page);
> +		ret = tegra_nand_read_oob(chip, page);
>  		if (ret < 0)
>  			return ret;
>  
> diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
> index a73213c835a5..7cbcc41cea95 100644
> --- a/drivers/mtd/nand/raw/vf610_nfc.c
> +++ b/drivers/mtd/nand/raw/vf610_nfc.c
> @@ -557,9 +557,10 @@ static void vf610_nfc_fill_row(struct nand_chip
> *chip, int page, u32 *code,
>  	}
>  }
>  
> -static int vf610_nfc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
> -				uint8_t *buf, int oob_required, int page)
> +static int vf610_nfc_read_page(struct nand_chip *chip, uint8_t *buf,
> +			       int oob_required, int page)
>  {
> +	struct mtd_info *mtd = nand_to_mtd(chip);
>  	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
>  	int trfr_sz = mtd->writesize + mtd->oobsize;
>  	u32 row = 0, cmd1 = 0, cmd2 = 0, code = 0;
> @@ -643,15 +644,15 @@ static int vf610_nfc_write_page(struct mtd_info
> *mtd, struct nand_chip *chip,
>  	return 0;
>  }
>  
> -static int vf610_nfc_read_page_raw(struct mtd_info *mtd,
> -				   struct nand_chip *chip, u8 *buf,
> +static int vf610_nfc_read_page_raw(struct nand_chip *chip, u8 *buf,
>  				   int oob_required, int page)
>  {
> +	struct mtd_info *mtd = nand_to_mtd(chip);
>  	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
>  	int ret;
>  
>  	nfc->data_access = true;
> -	ret = nand_read_page_raw(mtd, chip, buf, oob_required, page);
> +	ret = nand_read_page_raw(chip, buf, oob_required, page);
>  	nfc->data_access = false;
>  
>  	return ret;
> @@ -677,14 +678,13 @@ static int vf610_nfc_write_page_raw(struct mtd_info *mtd,
>  	return nand_prog_page_end_op(chip);
>  }
>  
> -static int vf610_nfc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
> -			      int page)
> +static int vf610_nfc_read_oob(struct nand_chip *chip, int page)
>  {
> -	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
> +	struct vf610_nfc *nfc = mtd_to_nfc(nand_to_mtd(chip));
>  	int ret;
>  
>  	nfc->data_access = true;
> -	ret = nand_read_oob_std(mtd, chip, page);
> +	ret = nand_read_oob_std(chip, page);
>  	nfc->data_access = false;
>  
>  	return ret;
> diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c
> b/drivers/staging/mt29f_spinand/mt29f_spinand.c
> index b50788b2d1d9..0776d38d4498 100644
> --- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
> +++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
> @@ -643,14 +643,15 @@ static int spinand_write_page_hwecc(struct mtd_info *mtd,
>  	return nand_prog_page_op(chip, page, 0, p, eccsize * eccsteps);
>  }
>  
> -static int spinand_read_page_hwecc(struct mtd_info *mtd, struct
> nand_chip *chip,
> -				   u8 *buf, int oob_required, int page)
> +static int spinand_read_page_hwecc(struct nand_chip *chip, u8 *buf,
> +				   int oob_required, int page)
>  {
>  	int retval;
>  	u8 status;
>  	u8 *p = buf;
>  	int eccsize = chip->ecc.size;
>  	int eccsteps = chip->ecc.steps;
> +	struct mtd_info *mtd = nand_to_mtd(chip);
>  	struct spinand_info *info = nand_get_controller_data(chip);
>  
>  	enable_read_hw_ecc = 1;
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 24434310d126..a5f4a585f749 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -652,14 +652,14 @@ struct nand_ecc_ctrl {
>  			 uint8_t *ecc_code);
>  	int (*correct)(struct nand_chip *chip, uint8_t *dat, uint8_t *read_ecc,
>  		       uint8_t *calc_ecc);
> -	int (*read_page_raw)(struct mtd_info *mtd, struct nand_chip *chip,
> -			uint8_t *buf, int oob_required, int page);
> +	int (*read_page_raw)(struct nand_chip *chip, uint8_t *buf,
> +			     int oob_required, int page);
>  	int (*write_page_raw)(struct mtd_info *mtd, struct nand_chip *chip,
>  			const uint8_t *buf, int oob_required, int page);
> -	int (*read_page)(struct mtd_info *mtd, struct nand_chip *chip,
> -			uint8_t *buf, int oob_required, int page);
> -	int (*read_subpage)(struct mtd_info *mtd, struct nand_chip *chip,
> -			uint32_t offs, uint32_t len, uint8_t *buf, int page);
> +	int (*read_page)(struct nand_chip *chip, uint8_t *buf,
> +			 int oob_required, int page);
> +	int (*read_subpage)(struct nand_chip *chip, uint32_t offs,
> +			    uint32_t len, uint8_t *buf, int page);
>  	int (*write_subpage)(struct mtd_info *mtd, struct nand_chip *chip,
>  			uint32_t offset, uint32_t data_len,
>  			const uint8_t *data_buf, int oob_required, int page);
> @@ -667,9 +667,8 @@ struct nand_ecc_ctrl {
>  			const uint8_t *buf, int oob_required, int page);
>  	int (*write_oob_raw)(struct mtd_info *mtd, struct nand_chip *chip,
>  			int page);
> -	int (*read_oob_raw)(struct mtd_info *mtd, struct nand_chip *chip,
> -			int page);
> -	int (*read_oob)(struct mtd_info *mtd, struct nand_chip *chip, int page);
> +	int (*read_oob_raw)(struct nand_chip *chip, int page);
> +	int (*read_oob)(struct nand_chip *chip, int page);
>  	int (*write_oob)(struct mtd_info *mtd, struct nand_chip *chip,
>  			int page);
>  };
> @@ -1676,11 +1675,10 @@ int nand_write_oob_syndrome(struct mtd_info
> *mtd, struct nand_chip *chip,
>  			    int page);
>  
>  /* Default read_oob implementation */
> -int nand_read_oob_std(struct mtd_info *mtd, struct nand_chip *chip, int page);
> +int nand_read_oob_std(struct nand_chip *chip, int page);
>  
>  /* Default read_oob syndrome implementation */
> -int nand_read_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
> -			   int page);
> +int nand_read_oob_syndrome(struct nand_chip *chip, int page);
>  
>  /* Wrapper to use in order for controllers/vendors to GET/SET FEATURES */
>  int nand_get_features(struct nand_chip *chip, int addr, u8 *subfeature_param);
> @@ -1690,10 +1688,10 @@ int nand_get_set_features_notsupp(struct
> mtd_info *mtd, struct nand_chip *chip,
>  				  int addr, u8 *subfeature_param);
>  
>  /* Default read_page_raw implementation */
> -int nand_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
> -		       uint8_t *buf, int oob_required, int page);
> -int nand_read_page_raw_notsupp(struct mtd_info *mtd, struct nand_chip *chip,
> -			       u8 *buf, int oob_required, int page);
> +int nand_read_page_raw(struct nand_chip *chip, uint8_t *buf, int oob_required,
> +		       int page);
> +int nand_read_page_raw_notsupp(struct nand_chip *chip, u8 *buf,
> +			       int oob_required, int page);
>  
>  /* Default write_page_raw implementation */
>  int nand_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
