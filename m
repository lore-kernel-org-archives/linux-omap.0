From: Imre Deak <imre.deak@solidboot.com>
Subject: Re: [patch linux-omap-git 2/2] omap2_mcspi fixes + cleanups
Date: Thu, 24 May 2007 12:21:53 +0300
Message-ID: <20070524092153.GA6276@bitbox>
References: <200705232046.12406.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200705232046.12406.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

a hint on one of the changes:

On Wed, May 23, 2007 at 08:46:12PM -0700, David Brownell wrote:
> McSPI functional updates:
>
> [...]
> 
>  - Remove bogus code which always dropped chipselect after the last RX_ONLY
>    word (rather than leaving it enabled).
> 
> [...]
>  
> @@ -371,7 +376,11 @@ static void omap2_mcspi_txrx_pio(struct 
>  	rx_reg		= base + OMAP2_MCSPI_RX0;
>  	chstat_reg	= base + OMAP2_MCSPI_CHSTAT0;
>  
> -	/* RX_ONLY mode needs dummy data in TX reg */
> +	/* RX_ONLY mode needs dummy data in TX reg.   If we were using
> +	 * TURBO mode (double buffered) we'd need to disable the channel
> +	 * before reading the penultimate word ... so TURBO wouldn't be an
> +	 * option except for the last transfer, else if cs_change is set.
> +	 */
>  	if (xfer->tx_buf == NULL)
>  		__raw_writel(0, tx_reg);
>  
> @@ -401,8 +410,6 @@ static void omap2_mcspi_txrx_pio(struct 
>  					dev_err(&spi->dev, "RXS timed out\n");
>  					goto out;
>  				}
> -				if (c == 0 && tx == NULL)
> -					omap2_mcspi_set_enable(spi, 0);
>  				*rx++ = __raw_readl(rx_reg);
>  #ifdef VERBOSE
>  				dev_dbg(&spi->dev, "read-%d %02x\n",

This was added to avoid having an extra read cycle in RX_ONLY mode after
the last word read. Consecutive read cycles are always triggered by
reading rx_reg.

Not sure if the extra read cycle can cause a problem for the slave
device.

--Imre
