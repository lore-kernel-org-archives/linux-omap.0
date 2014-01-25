From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v1 2/2] mtd: nand: omap: fix ecclayout to be in sync with
 u-boot NAND driver
Date: Sat, 25 Jan 2014 00:57:19 -0800
Message-ID: <20140125085719.GC3162@norris-Latitude-E6410>
References: <1386925978-23705-1-git-send-email-pekon@ti.com>
 <1386925978-23705-3-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:57189 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbaAYI5Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Jan 2014 03:57:24 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so3997209pdj.15
        for <linux-omap@vger.kernel.org>; Sat, 25 Jan 2014 00:57:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386925978-23705-3-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, Scott Wood <scottwood@freescale.com>, Tom Rini <trini@ti.com>, u-boot@lists.denx.de, linux-mtd@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>, Enric Balletbo Serra <eballetbo@iseebcn.com>, Stefan Roese <sr@denx.de>, Javier Martinez Canillas <javier@dowhile0.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Igor Grinberg <grinberg@compulab.co.il>, Michael Trimarchi <michael@amarulasolutions.com>, r.meier@siemens.com, r-woodruff2@ti.com, Nikita Kiryanov <nikita@compulab.co.il>, jp.francois@cynove.com, ivan.djelic@parrot.com, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, avinashphilipk@gmail.com, balbi@ti.com

On Fri, Dec 13, 2013 at 02:42:58PM +0530, Pekon Gupta wrote:
> @@ -1851,7 +1854,13 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		ecclayout->eccbytes		= nand_chip->ecc.bytes *
>  							(mtd->writesize /
>  							nand_chip->ecc.size);
> -		ecclayout->eccpos[0]		= BADBLOCK_MARKER_LENGTH;
> +		oob_index			= BADBLOCK_MARKER_LENGTH;
> +		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++) {
> +			if ((i % nand_chip->ecc.bytes) || (i == 0))
> +				ecclayout->eccpos[i] = oob_index;
> +			else
> +				ecclayout->eccpos[i] = ++oob_index;

This if-else structure, with a combined assignment and increment kind of
obscures the logic of what you're really trying to do. Could this be
better as follows?

		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++) {
			ecclayout->eccpos[i] = oob_index;
			if (((i + 1) % nand_chip->ecc.bytes) == 0)
				oob_index++;
		}

> +		}
>  		/* software bch library is used for locating errors */
>  		nand_chip->ecc.priv		= nand_bch_init(mtd,
>  							nand_chip->ecc.size,

Brian
