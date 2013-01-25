From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] spi: spi-omap2-mcspi.c: fix coding style
Date: Fri, 25 Jan 2013 09:58:58 +0200
Message-ID: <20130125095858.32e70b983abb349f6c1c4340@bitmer.com>
References: <1359030538-2866-1-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:51126 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272Ab3AYH7I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Jan 2013 02:59:08 -0500
In-Reply-To: <1359030538-2866-1-git-send-email-matthias.bgg@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: grant.likely@secretlab.ca, tony@atomide.com, broonie@opensource.wolfsonmicro.com, zonque@gmail.com, gregkh@linuxfoundation.org, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, trivial@kernel.org

Hi

On Thu, 24 Jan 2013 13:28:58 +0100
Matthias Brugger <matthias.bgg@gmail.com> wrote:

> This patch fixes some indentation errors.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/spi/spi-omap2-mcspi.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
...
> @@ -1052,8 +1052,8 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
>  		}
>  		if (t->speed_hz && t->speed_hz < (OMAP2_MCSPI_MAX_FREQ >> 15)) {
>  			dev_dbg(mcspi->dev, "speed_hz %d below minimum %d Hz\n",
> -				t->speed_hz,
> -				OMAP2_MCSPI_MAX_FREQ >> 15);
> +					t->speed_hz,
> +					OMAP2_MCSPI_MAX_FREQ >> 15);

I have some mixed feelings from these changes and looking at the driver currently. Above change makes the readability a step backward but the driver has already these so in that sense your change makes the style more consistent.

I can see three options with this patch: take your patch as it, do nothing or do larger style 'spring cleanup'.

I'm personally somewhere take as it or do nothing. If style is not terribly wrong I personally favor smaller style fixes when those lines are changing anyway.

In case maintainer takes this you could add:

Reviewed-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

-- 
Jarkko
