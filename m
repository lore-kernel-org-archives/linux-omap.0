From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] SPI: add per transfer wordsize and speed parameter
Date: Fri, 12 May 2006 04:57:42 -0700
Message-ID: <20060512115741.GI18115@atomide.com>
References: <1147433591.9837.14.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1147433591.9837.14.camel@mammoth.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Imre Deak <imre.deak@nokia.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Imre Deak <imre.deak@nokia.com> [060512 04:35]:
> [ This is at the moment only in Greg's queue, but would be nice to
>   pre-merge it ]
> 
> Some protocols (like one for some bitmap displays) require different clock
> speed or word size settings for each transfer in an SPI message. This adds
> those parameters to struct spi_transfer.  They are to be used when they are
> nonzero; otherwise the defaults from spi_device are to be used.
> 
> The patch also adds a setup_transfer callback to spi_bitbang, uses it for
> messages that use those overrides, and implements it so that the pure
> bitbanging code can help resolve any questions about how it should work.

Pushing today.

Tony
