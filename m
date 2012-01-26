From: Greg KH <gregkh@suse.de>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Wed, 25 Jan 2012 20:21:55 -0800
Message-ID: <20120126042155.GA3185@suse.de>
References: <13274430881471@kroah.org>
 <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: govindraj.r@ti.com, khilman@ti.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 25, 2012 at 08:02:09PM -0700, Paul Walmsley wrote:
> cc lists
> 
> Hi Greg
> 
> On Tue, 24 Jan 2012, gregkh@suse.de wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     tty: serial: OMAP: ensure FIFO levels are set correctly in non-DMA
> > 
> > to my tty git tree which can be found at
> >     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> > in the tty-linus branch.
> 
> If it's not too late, I was wondering if you could drop this patch and the 
> subsequent one ("tty: serial: OMAP: transmit FIFO threshold interrupts 
> don't wake the"), in favor of the second version of this series that was 
> just posted at
> 
>    http://marc.info/?l=linux-arm-kernel&m=132754676814391&w=2
> 
> If it is too late, we'll deal with it in 3.4.

What is wrong with the patches that I applied?  How about a fix-up patch
on top of what I have applied instead of whole new ones?

greg k-h
