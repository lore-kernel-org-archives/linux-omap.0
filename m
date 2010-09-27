From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 11/13 v3] serial: Add OMAP high-speed UART driver
Date: Mon, 27 Sep 2010 14:24:58 -0700
Message-ID: <20100927212458.GA28283@suse.de>
References: <43868.10.24.255.17.1285599049.squirrel@dbdmail.itg.ti.com> <878w2moqi5.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <878w2moqi5.fsf@deeprootsystems.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 27, 2010 at 01:55:46PM -0700, Kevin Hilman wrote:
> [resent with correct address for Greg, sorry for duplicates.]
> 
> Greg,
> 
> "Govindraj.R" <govindraj.raja@ti.com> writes:
> 
> > This patch adds driver support for OMAP2/3/4 high speed UART.
> 
> According to MAINTAINERS, you seem to be the one looking after the
> serial core.  Are you the one to ack/merge new drivers?

Yup, but Alan Cox is also a good person to get review from as well.

> With your ack, we can merge this through the OMAP tree along with the
> rest of the series that has OMAP-specific platform reorg and updates.
> 
> If you're not the right person, please let us know who would be the
> right person to ack/sign-off on this.

Cc both of us so we can review it please.

thanks,

greg k-h
