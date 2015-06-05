From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: next-20150604 build: 2 failures 37 warnings (next-20150604)
Date: Fri, 5 Jun 2015 19:49:00 +0900
Message-ID: <20150605104900.GA5346@kroah.com>
References: <E1Z0YIL-0008Ma-5O@optimist>
 <20150604170112.GM14071@sirena.org.uk>
 <20150604171004.GZ30984@atomide.com>
 <20150604172026.GA30984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150604172026.GA30984@atomide.com>
Sender: linux-next-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kernel-build-reports@lists.linaro.org, linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 04, 2015 at 10:20:26AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150604 10:11]:
> > * Mark Brown <broonie@kernel.org> [150604 10:03]:
> > > On Thu, Jun 04, 2015 at 05:47:05PM +0100, Build bot for Mark Brown wrote:
> > > 
> > > > 	arm-allmodconfig
> > > > ../drivers/tty/serial/8250/8250_omap.c:586:20: error: redefinition of 'omap8250_irq'
> > > 
> > > Current -next fails to build an ARM allmodconfig (and possibly other
> > > things) due to 9e91597f24234 and 9809889c708eb (serial: 8250_omap:
> > > provide complete custom startup & shutdown callbacks) which appear to be
> > > the same commit that's been applied twice somehow.  Not sure what's
> > > going on there...
> > 
> > Sounds like I'm using an old commit in one of my pending branches,
> > will check immediately.
> 
> Greg, there's now commit 9809889c708e in tty-linus and commit
> 9e91597f2423 in tty-next.

Yes, I can't go back and remove the one in tty-next, I'm guessing when
they are merged there is an issue.  I'll look into that after Linus
pulls in my tty-linus tree.

thanks,

greg k-h
