From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 20/24] SERIAL: core: add xmit buffer allocation callbacks
Date: Sat, 6 Oct 2012 17:51:36 +0100
Message-ID: <20121006165136.GC28061@n2100.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk> <E1TKTlL-0002ni-MB@rmk-PC.arm.linux.org.uk> <20121006164956.2956375c@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47551 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463Ab2JFQxC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Oct 2012 12:53:02 -0400
Content-Disposition: inline
In-Reply-To: <20121006164956.2956375c@pyramind.ukuu.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org

On Sat, Oct 06, 2012 at 04:49:56PM +0100, Alan Cox wrote:
> On Sat, 06 Oct 2012 13:45:47 +0100
> Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > This allows drivers (such as OMAP serial) to allocate and free their
> > transmit buffers in a sane manner, rather than working around the
> > buffer allocation provided by serial_core.
> 
> I think this just illustrates how broken the serial_core layering is in
> that drivers can't treat it as a library but get constrained by it.
> 
> Fine for now and actually probably a useful hook to begin removing the
> circ buffers for the kernel generic kfifo and other work that needs doing
> eventually.

Yes, I was thinking about turning the 'default' buffer allocation into
a library call which drivers would set, but I felt that's just asking
for a big patch and problems with new drivers appearing.

We could transition it by providing a default buffer allocation call,
converting all the drivers, and then making that call mandatory.  That
probably would then give us a better path to convert to kfifo.

The view that serial_core should be a library is one that Ted mentioned
when I created serial_core originally - I disagreed at the time, and
I still believe it would've ended up being much more complex - and
hairy - to go that route at that time.  Maybe as things have moved
forward in the tty layer that's changed, but I've been out of tty stuff
for too long to properly comment.
