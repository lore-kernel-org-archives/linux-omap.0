From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH-v2.6.39] spi/omap_mcspi: Fix broken last word xfer
Date: Wed, 23 Mar 2011 15:05:42 -0600
Message-ID: <20110323210542.GA18421@ponder.secretlab.ca>
References: <1300717650-28953-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36566 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933290Ab1CWVFq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Mar 2011 17:05:46 -0400
Received: by iyb26 with SMTP id 26so8954958iyb.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Mar 2011 14:05:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300717650-28953-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, Michael Jones <michael.jones@matrix-vision.de>

On Mon, Mar 21, 2011 at 04:27:30PM +0200, Jarkko Nikula wrote:
> Commit adef658 "spi/omap_mcspi: catch xfers of non-multiple SPI word size"
> broke the transmission of last word in cases where access is multiple of
> word size and word size is 16 or 32 bits.
> 
> Fix this by replacing the test "c > (word_len>>3)" in do-while loops with
> "c >= 'pointer increment size'". This ensures that the last word is
> transmitted in above case and still allow to break the loop and prevent
> variable c underflow in cases where word size != 'pointer increment size'.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Michael Jones <michael.jones@matrix-vision.de>

Applied, thanks.

g.

> ---
> I noticed the issue with wl1251 WLAN driver on Nokia N900 using today's
> vanilla head a44f99c7efdb88fa41128065c9a9445c19894e34.
> ---
>  drivers/spi/omap2_mcspi.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index 3a5ed06..6f86ba0 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -517,7 +517,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
>  				dev_vdbg(&spi->dev, "read-%d %02x\n",
>  						word_len, *(rx - 1));
>  			}
> -		} while (c > (word_len>>3));
> +		} while (c);
>  	} else if (word_len <= 16) {
>  		u16		*rx;
>  		const u16	*tx;
> @@ -564,7 +564,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
>  				dev_vdbg(&spi->dev, "read-%d %04x\n",
>  						word_len, *(rx - 1));
>  			}
> -		} while (c > (word_len>>3));
> +		} while (c >= 2);
>  	} else if (word_len <= 32) {
>  		u32		*rx;
>  		const u32	*tx;
> @@ -611,7 +611,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
>  				dev_vdbg(&spi->dev, "read-%d %08x\n",
>  						word_len, *(rx - 1));
>  			}
> -		} while (c > (word_len>>3));
> +		} while (c >= 4);
>  	}
>  
>  	/* for TX_ONLY mode, be sure all words have shifted out */
> -- 
> 1.7.4.1
> 
