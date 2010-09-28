From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 11/13 v3] serial: Add OMAP high-speed UART driver
Date: Tue, 28 Sep 2010 00:47:20 -0700
Message-ID: <20100928074720.GA12778@suse.de>
References: <43868.10.24.255.17.1285599049.squirrel@dbdmail.itg.ti.com> <87bp7ilu4f.fsf@deeprootsystems.com> <20100928075249.091ea0b2@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100928075249.091ea0b2@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Alan Cox <alan@linux.intel.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 28, 2010 at 07:52:49AM +0100, Alan Cox wrote:
> On Mon, 27 Sep 2010 15:05:52 -0700
> Kevin Hilman <khilman@deeprootsystems.com> wrote:
> 
> > "Govindraj.R" <govindraj.raja@ti.com> writes:
> > 
> > > This patch adds driver support for OMAP2/3/4 high speed UART.
> > 
> > Cc'ing Greg KH and Alan Cox for review of the the new serial driver in
> > this series.
> > 
> > Greg/Alan, this has been on linux-serial several times now with review
> > mostly from OMAP folks.  If this looks OK from your side, with your
> > ack(s) we can merge via the OMAP tree with the rest of the series
> > which is a major reorg/cleanup of the OMAP platform init for serial
> > drivers.
> 
> Looks fine to me

Same here, feel free to add:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

and add it to the omap tree.

thanks,

greg k-h
