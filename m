From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2.6.17-rc3-omap] omap_uwire byteswap bugfix
Date: Thu, 4 May 2006 08:18:43 -0700
Message-ID: <200605040818.44126.david-b@pacbell.net>
References: <200605022215.49062.david-b@pacbell.net>
	<20060504145344.GA21933@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060504145344.GA21933@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Mundt <paul.mundt@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thursday 04 May 2006 7:53 am, Paul Mundt wrote:

> > +	if (spi->mode & SPI_LSB_FIRST) {
> > +		pr_debug("%s: lsb first?\n", spi->dev.bus_id);
> > +		status = -EINVAL;
> > +		goto done;
> > +	}
> > +
> >  	/* mode 0..3, clock inverted separately;
> >  	 * standard nCS signaling;
> >  	 * don't treat DI=high as "not ready"
> 
> This breaks the build, SPI_LSB_FIRST isn't defined anywhere..
> ...
> Looks like this is missing..
> 
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/spi-devices-can-require-lsb-first-encodings.patch
> 
> which isn't in Linus's tree either yet however.

Whoops, yes.  My bad, sorry; it was in _my_ tree and I overlooked how it got there.
I thought maybe Juha had merged it.

Simplest fix would be to merge that patch from Greg's tree.

- Dave
