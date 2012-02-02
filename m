From: Paul Walmsley <paul@pwsan.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Thu, 2 Feb 2012 13:03:01 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
References: <13274430881471@kroah.org> <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com> <20120126042155.GA3185@suse.de> <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com> <20120126191604.GA15516@suse.de>
 <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>, greg@kroah.com
Cc: khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Greg,

On Thu, 26 Jan 2012, Paul Walmsley wrote:

> On Thu, 26 Jan 2012, Greg KH wrote:
> 
> > Ok, I've just reverted both of these patches for now, please send new
> > ones when you have them.
> 
> Thanks.  A pull request is at the bottom of this message.  The patches 
> are also available from the mailing list archives here:
> 
> http://marc.info/?l=linux-arm-kernel&m=132754676014389&w=2
> http://marc.info/?l=linux-arm-kernel&m=132754677914395&w=2
> http://marc.info/?l=linux-arm-kernel&m=132754676014388&w=2

Any comments on these? 


- Paul

> - Paul
> 
> The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:
> 
>   Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)
> 
> are available in the git repository at:
>   git://git.pwsan.com/linux-2.6 omap_serial_fixes_3.3rc
> 
> Paul Walmsley (3):
>       tty: serial: OMAP: use a 1-byte RX FIFO threshold in PIO mode
>       tty: serial: OMAP: block idle while the UART is transferring data in PIO mode
>       tty: serial: OMAP: wakeup latency constraint is in microseconds, not milliseconds
> 
>  arch/arm/mach-omap2/serial.c     |    8 ++++----
>  drivers/tty/serial/omap-serial.c |   30 +++++++++++++++++++++++++-----
>  2 files changed, 29 insertions(+), 9 deletions(-)
> 


- Paul
