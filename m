From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] omap2_mcspi: Flush posted writes
Date: Thu, 11 Mar 2010 14:40:43 -0800
Message-ID: <20100311224043.GS2900@atomide.com>
References: <1268216316-32552-1-git-send-email-roman.tereshonkov@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62574 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab0CKWjW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 17:39:22 -0500
Content-Disposition: inline
In-Reply-To: <1268216316-32552-1-git-send-email-roman.tereshonkov@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Cc: linux-omap@vger.kernel.org, scott@jumpnowtek.com, gadiyar@ti.com

* Roman Tereshonkov <roman.tereshonkov@nokia.com> [100310 02:16]:
> mcspi_write_chconf0 is used to control rx/tx triggering.
> Post-write flushing is needed to get the immediate effect.
> 
> Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
> ---
>  drivers/spi/omap2_mcspi.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index 715c518..35b31fe 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -203,6 +203,7 @@ static inline void mcspi_write_chconf0(const struct spi_device *spi, u32 val)
>  
>  	cs->chconf0 = val;
>  	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, val);
> +	mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
>  }
>  
>  static void omap2_mcspi_set_dma_req(const struct spi_device *spi,

Looks like good fixes, these should be resent to the
spi list and maintainers. See the MAINTAINERS file.

Regards,

Tony 
