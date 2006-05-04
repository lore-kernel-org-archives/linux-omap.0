From: Paul Mundt <paul.mundt@nokia.com>
Subject: Re: [PATCH 2.6.17-rc3-omap] omap_uwire byteswap bugfix
Date: Thu, 4 May 2006 17:53:44 +0300
Message-ID: <20060504145344.GA21933@nokia.com>
References: <200605022215.49062.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200605022215.49062.david-b@pacbell.net>
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

On Tue, May 02, 2006 at 10:15:48PM -0700, David Brownell wrote:
> Also, reject LSB-first device modes; this controller doesn't support them.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> Index: osk/drivers/spi/omap_uwire.c
> ===================================================================
> --- osk.orig/drivers/spi/omap_uwire.c	2006-04-22 14:41:22.000000000 -0700
> +++ osk/drivers/spi/omap_uwire.c	2006-05-02 18:37:24.000000000 -0700
> @@ -320,6 +317,12 @@ static int uwire_setup(struct spi_device
>  		goto done;
>  	}
>  
> +	if (spi->mode & SPI_LSB_FIRST) {
> +		pr_debug("%s: lsb first?\n", spi->dev.bus_id);
> +		status = -EINVAL;
> +		goto done;
> +	}
> +
>  	/* mode 0..3, clock inverted separately;
>  	 * standard nCS signaling;
>  	 * don't treat DI=high as "not ready"

This breaks the build, SPI_LSB_FIRST isn't defined anywhere..

drivers/spi/omap_uwire.c: In function `uwire_setup':
drivers/spi/omap_uwire.c:320: error: `SPI_LSB_FIRST' undeclared (first use in this function)
drivers/spi/omap_uwire.c:320: error: (Each undeclared identifier is reported only once
drivers/spi/omap_uwire.c:320: error: for each function it appears in.)
make[2]: *** [drivers/spi/omap_uwire.o] Error 1
make[1]: *** [drivers/spi] Error 2
make: *** [drivers] Error 2

Looks like this is missing..

	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/spi-devices-can-require-lsb-first-encodings.patch

which isn't in Linus's tree either yet however.
