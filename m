From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC] possible removal of omap-serial
Date: Thu, 20 Mar 2014 19:36:46 -0700
Message-ID: <20140321023646.GB17404@kroah.com>
References: <20140320235210.GB26964@saruman.home>
 <20140321001228.GA18131@kroah.com>
 <20140321013557.GB29691@saruman.home>
 <20140321013729.GC29691@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:38237 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965355AbaCUCfX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2014 22:35:23 -0400
Content-Disposition: inline
In-Reply-To: <20140321013729.GC29691@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-serial@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Thu, Mar 20, 2014 at 08:37:29PM -0500, Felipe Balbi wrote:
> On Thu, Mar 20, 2014 at 08:35:57PM -0500, Felipe Balbi wrote:
> > Hi,
> > 
> > On Thu, Mar 20, 2014 at 05:12:28PM -0700, Greg KH wrote:
> > > On Thu, Mar 20, 2014 at 06:52:10PM -0500, Felipe Balbi wrote:
> > > > Hi folks,
> > > > 
> > > > I've been toying with the idea of removing
> > > > drivers/tty/serial/omap-serial.c since that's, to put it bluntly, an
> > > > ungly copy of 8250 driver.
> > > > 
> > > > The original concern was wrt suspend/resume but I think it'd be a far
> > > > better approach to implement runtime PM in 8250 and write a rather small
> > > > 8250-omap.c glue (much like 8250-acorn.c or 8250-dw.c) just to get the
> > > > OMAP-specific details out of the way.
> > > > 
> > > > The question I have is: omap-serial.c calls the serial devnodes ttyO\d,
> > > > instead of ttyS\d so removing omap-serial.c would have a direct impact
> > > > in userland. I wonder if it's an acceptable "regression" considering
> > > > we'd be able to reuse 8250 gaining proper Flow Control support, proper
> > > > DMA support, years and years of bug-fixes, etc.
> > > 
> > > Breaking device node names is a contentious issue for serial ports, I
> > > don't think you can do that :(
> > 
> > would an upstream udev rule creating a symbolic link from ttyO to ttyS
> > be enough ?
> > 
> > I didn't test this yet but I guess this is enough (?)
> > 
> > KERNEL=="ttyO[0-9]", GROUP="dialout", SYMLINK+="ttyS"
> 
> or actually it should be to other way around, ttyS would be the real
> device:
> 
> KERNEL=="ttyS[0-9]", GROUP="dialout", SYMLINK+="ttyO"

As udev rules don't ship with the kernel, this might be tough to do :(

Might be easier to make the 8250 driver handle different "names" like
Alan said.

greg k-h

