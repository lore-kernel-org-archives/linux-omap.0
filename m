From: Greg KH <gregkh@suse.de>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Thu, 26 Jan 2012 11:16:04 -0800
Message-ID: <20120126191604.GA15516@suse.de>
References: <13274430881471@kroah.org>
 <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
 <20120126042155.GA3185@suse.de>
 <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: govindraj.raja@ti.com, khilman@ti.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 25, 2012 at 09:31:53PM -0700, Paul Walmsley wrote:
> On Wed, 25 Jan 2012, Greg KH wrote:
> 
> > On Wed, Jan 25, 2012 at 08:02:09PM -0700, Paul Walmsley wrote:
> > > On Tue, 24 Jan 2012, gregkh@suse.de wrote:
> > > > 
> > > > This is a note to let you know that I've just added the patch titled
> > > > 
> > > >     tty: serial: OMAP: ensure FIFO levels are set correctly in non-DMA
> > > > 
> > > > to my tty git tree which can be found at
> > > >     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> > > > in the tty-linus branch.
> > > 
> > > If it's not too late, I was wondering if you could drop this patch and the 
> > > subsequent one ("tty: serial: OMAP: transmit FIFO threshold interrupts 
> > > don't wake the"), in favor of the second version of this series that was 
> > > just posted at
> > > 
> > >    http://marc.info/?l=linux-arm-kernel&m=132754676814391&w=2
> > > 
> > > If it is too late, we'll deal with it in 3.4.
> > 
> > What is wrong with the patches that I applied?
> 
> A new workaround is used that reduces the number of interrupts to normal.  
> The commit messages are improved since we have a better idea of what was 
> wrong.  There is also a new patch (patch 3) for a power management 
> regression in the driver.
>  
> > How about a fix-up patch on top of what I have applied instead of whole 
> > new ones?
> 
> That's fine, if that's your preference.  It will be several patches, 
> though.  And about 75% of the previous series would be reverted, since a 
> different workaround would be used.
> 
> Let me know if that is indeed what you'd like.

Ok, I've just reverted both of these patches for now, please send new
ones when you have them.

thanks,

greg k-h
