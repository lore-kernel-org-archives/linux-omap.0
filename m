From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] serial: OMAP: add RS485 support
Date: Tue, 13 Aug 2013 11:51:18 -0700
Message-ID: <20130813185118.GC8909@kroah.com>
References: <52079822.9020103@newflow.co.uk>
 <20130812225638.GA30919@kroah.com>
 <520A08FE.5070804@newflow.co.uk>
 <CAAwP0s1QyNjQb+0zhK_UeHraTW+R6Mefq1E4HyV-XJ4fV42w+g@mail.gmail.com>
 <520A1355.1050301@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <520A1355.1050301@newflow.co.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Mark Jackson <mpfj-list@newflow.co.uk>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-serial@vger.kernel.org, jslaby@suse.cz
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 13, 2013 at 12:07:01PM +0100, Mark Jackson wrote:
> On 13/08/13 11:54, Javier Martinez Canillas wrote:
> 
> <snip>
> 
> > 
> > Hi Mark,
> > 
> > I've seen several attempts to add RS485 support to the omap serial
> > driver and it is always nack-ed. There seems to be concerns about
> > controlling the RTS by software when RS485 is not supported by the
> > UART hardware. Please refer to [1] and [2] for more information.
> 
> Hmmmm ... okay, I guess I'll just have to maintain our own code (as
> did the OP in [1]).

I don't want to have that happen, that's just foolish.  I'd rather merge
it so that everyone can benifit, and so you don't have to spend extra
work maintaining this out-of-tree.

thanks,

greg k-h
