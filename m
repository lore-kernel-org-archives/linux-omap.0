From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] SPI: rename bitbang_transfer_setup
Date: Fri, 12 May 2006 04:57:59 -0700
Message-ID: <20060512115758.GJ18115@atomide.com>
References: <1147433868.9837.20.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1147433868.9837.20.camel@mammoth.research.nokia.com>
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

* Imre Deak <imre.deak@nokia.com> [060512 04:39]:
> [ As the previous, this is in Greg's queue ]
> 
> Renamed bitbang_transfer_setup to follow convention of other exported symbols
> from spi-bitbang.  Exported spi_bitbang_setup_transfer to allow users of
> spi-bitbang to use the function in their own setup_transfer.

Pushing today.

Tony
