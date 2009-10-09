From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 : Fix McSPI RX Timeout
Date: Fri, 9 Oct 2009 12:25:59 -0700
Message-ID: <20091009192559.GR25892@atomide.com>
References: <1254811036-22666-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51783 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbZJIT0o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 15:26:44 -0400
Content-Disposition: inline
In-Reply-To: <1254811036-22666-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: manjugk@ti.com
Cc: linux-omap@vger.kernel.org

* manjugk@ti.com <manjugk@ti.com> [091005 23:42]:
> McSPI RX timeout issues are reported on some of the OMAP3 custom boards.
> 
> After verifying configuration sequence in TRM, there seems to be issue with 
> McSPI configuration sequence.
> 
> The steps to be followed for both TX and RX:
> 1. Configure OMAP2_MCSPI_CHCONF0 register with required settings such as
> TX/RX mode, word length, force chip select(if required).
> 2. Set MS bit to 0 in OMAP2_MCSPI_CHCTRL0 register to provide the clock.
> 3. Enable SPI channel in OMAP2_MCSPI_MODULCTRL
> 
> But, the sequence used in current code seems to be wrong. Here it is:
> 1. Set MS bit to 0 in OMAP2_MCSPI_CHCTRL0 register to provide the clock
> (This is done during bootup)
> 2. Enable SPI channel in OMAP2_MCSPI_MODULCTRL
> 3. Configure OMAP2_MCSPI_CHCONF0 register with required settings such as
> TX/RX mode, word length, force chip select(if required).
> 
> After correcting configuration sequence, the timeout seems to be not
> reproducible anymore.

Please resend this to the right lists one for merging:

$ grep -A7 "SPI SUBSYSTEM" MAINTAINERS 
SPI SUBSYSTEM
M:      David Brownell <dbrownell@users.sourceforge.net>
L:      spi-devel-general@lists.sourceforge.net
S:      Maintained
F:      Documentation/spi/
F:      drivers/spi/
F:      include/linux/spi/

Please also Cc linux-omap list too so people can easily keep track of it.

Regards,

Tony


> 
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> ---
>  drivers/spi/omap2_mcspi.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index ba1a872..846485c 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -802,7 +802,6 @@ static void omap2_mcspi_work(struct work_struct *work)
>  		spi = m->spi;
>  		cs = spi->controller_state;
>  
> -		omap2_mcspi_set_enable(spi, 1);
>  		list_for_each_entry(t, &m->transfers, transfer_list) {
>  			if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
>  				status = -EINVAL;
> @@ -830,6 +829,9 @@ static void omap2_mcspi_work(struct work_struct *work)
>  				chconf |= OMAP2_MCSPI_CHCONF_TRM_TX_ONLY;
>  			mcspi_write_chconf0(spi, chconf);
>  
> +			omap2_mcspi_set_master_mode(mcspi->master);
> +
> +			omap2_mcspi_set_enable(spi, 1);
>  			if (t->len) {
>  				unsigned	count;
>  
> -- 
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
