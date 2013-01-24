From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 3/3] spi: spi-omap2-mcspi.c: Toggle CS after each word
Date: Thu, 24 Jan 2013 09:38:32 +0200
Message-ID: <20130124093832.3eef9bda0195a405c8eb3d96@bitmer.com>
References: <1358964529-4905-1-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:51117 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076Ab3AXHin (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Jan 2013 02:38:43 -0500
In-Reply-To: <1358964529-4905-1-git-send-email-matthias.bgg@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, eballetbo@gmail.com, javier.martinez@collabora.co.uk, ezequiel.garcia@free-electrons.com, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

Hi

On Wed, 23 Jan 2013 19:08:49 +0100
Matthias Brugger <matthias.bgg@gmail.com> wrote:

> @@ -1020,7 +1038,7 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
>  }
>  
>  static int omap2_mcspi_transfer_one_message(struct spi_master *master,
> -						struct spi_message *m)
> +		struct spi_message *m)
>  {
>  	struct omap2_mcspi	*mcspi;
>  	struct spi_transfer	*t;
> @@ -1041,7 +1059,7 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
>  				|| (len && !(rx_buf || tx_buf))
>  				|| (t->bits_per_word &&
>  					(  t->bits_per_word < 4
> -					|| t->bits_per_word > 32))) {
> +					   || t->bits_per_word > 32))) {
>  			dev_dbg(mcspi->dev, "transfer: %d Hz, %d %s%s, %d bpw\n",
>  					t->speed_hz,
>  					len,

Just a sidenote but these indentation changes should go to another patch as they count about half of the lines.

-- 
Jarkko
