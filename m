From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap_uwire: Remove handling of SPI_LSB_FIRST
Date: Fri, 12 May 2006 04:57:20 -0700
Message-ID: <20060512115719.GH18115@atomide.com>
References: <1147432337.9837.5.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1147432337.9837.5.camel@mammoth.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Imre Deak <imre.deak@nokia.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Imre Deak <imre.deak@nokia.com> [060512 04:13]:
> omap_uwire: fix to build by removing handling of SPI_LSB_FIRST
> 
> The handling of the flag is included properly in an upcoming SPI
> patch by David Brownell.
> 
> Signed-off-by: Imre Deak <imre.deak@nokia.com>
> 
> ---
> 
>  drivers/spi/omap_uwire.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
> 
> e8fe4c03399c90c4119b985bda19da878a8ab476
> diff --git a/drivers/spi/omap_uwire.c b/drivers/spi/omap_uwire.c
> index 97a1846..39e8227 100644
> --- a/drivers/spi/omap_uwire.c
> +++ b/drivers/spi/omap_uwire.c
> @@ -317,12 +317,6 @@ static int uwire_setup(struct spi_device
>  		goto done;
>  	}
>  
> -	if (spi->mode & SPI_LSB_FIRST) {
> -		pr_debug("%s: lsb first?\n", spi->dev.bus_id);
> -		status = -EINVAL;
> -		goto done;
> -	}
> -
>  	/* mode 0..3, clock inverted separately;
>  	 * standard nCS signaling;
>  	 * don't treat DI=high as "not ready"
> -- 
> 1.2.3.g90cc1-dirty
> 
> 
> 

Pushing today.

Tony
