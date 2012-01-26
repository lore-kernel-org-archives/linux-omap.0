From: Paul Walmsley <paul@pwsan.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Wed, 25 Jan 2012 20:02:09 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
References: <13274430881471@kroah.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <13274430881471@kroah.org>
Sender: linux-serial-owner@vger.kernel.org
To: gregkh@suse.de
Cc: govindraj.r@ti.com, khilman@ti.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

cc lists

Hi Greg

On Tue, 24 Jan 2012, gregkh@suse.de wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     tty: serial: OMAP: ensure FIFO levels are set correctly in non-DMA
> 
> to my tty git tree which can be found at
>     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> in the tty-linus branch.

If it's not too late, I was wondering if you could drop this patch and the 
subsequent one ("tty: serial: OMAP: transmit FIFO threshold interrupts 
don't wake the"), in favor of the second version of this series that was 
just posted at

   http://marc.info/?l=linux-arm-kernel&m=132754676814391&w=2

If it is too late, we'll deal with it in 3.4.

thanks,

- Paul
