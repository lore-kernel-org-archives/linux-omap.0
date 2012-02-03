From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
	in non-DMA" added to tty tree
Date: Fri, 3 Feb 2012 12:20:53 +0000
Message-ID: <20120203122053.GF1275@n2100.arm.linux.org.uk>
References: <13274430881471@kroah.org> <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com> <20120126042155.GA3185@suse.de> <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com> <20120126191604.GA15516@suse.de> <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com> <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <CAAL8m4ztuB-kJvLGd=8PqPCLFcvPW9AQcdcFQ+e03vDT240vog@mail.gmail.com> <20120203230720.28666cc6@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59236 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab2BCMV2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Feb 2012 07:21:28 -0500
Content-Disposition: inline
In-Reply-To: <20120203230720.28666cc6@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Govindraj <govindraj.ti@gmail.com>, khilman@ti.com, Paul Walmsley <paul@pwsan.com>, greg@kroah.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 03, 2012 at 11:07:20PM +1100, NeilBrown wrote:
> However what it really shows me is that I was misunderstanding the code
> (If I spent the time to verify every conclusion that I jumped to, I'd never
> get anywhere :-( ).  Better clarify that now.
> 
> So this function - serial_omap_tx_empty() is called to test if the
> tx queue is empty.

Not just the queue.  The documentation for that function is accurate:

  tx_empty(port)
        This function tests whether the transmitter fifo and shifter
        for the port described by 'port' is empty.  If it is empty,
        this function should return TIOCSER_TEMT, otherwise return 0.
        If the port does not support this operation, then it should
        return TIOCSER_TEMT.

So, if this is returning TIOCSER_TEMT while there's still a transmission
in progress, then it's buggy.

> So when I
> 
>    cat somefile
> 
> to the serial console, most of the file comes out fine.  But after 'cat'
> finishes and returns to the shell - while some chars are still in the FIFO - 
> the shell does an 'stty' ioctl to make sure the settings are still OK.
> This ioctl calls serial_omap_tx_empty which calls pm_resume_put() which
> immediately suspends the uart, which seems to stop some clock - even though
> we think it shouldn't.

If there's an on-going transmission, why is the runtime PM count zero,
meaning that the UART can sleep at the point where serial_omap_tx_empty()
is being called - and obviously there's still characters in the FIFO?

I guess this is highlighting a problem with doing runtime PM with
serial ports: you don't know when the port has _actually_ finished
sending its final character, which is even more of a problem if the
port does hardware CTS flow control itself.

It seems that runtime PM should be checking whether the TX FIFO is empty
before shutting the port down - and that probably means a hook into the
idle stuff.

Note though, that serial_omap_tx_empty() can be called via ioctl from
userspace, so this function would still need the runtime callbacks in
it so that the register is readable at _any_ time that the port is open.
