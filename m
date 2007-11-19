From: "Nazim Khan" <nazim.asad@gmail.com>
Subject: Re: [Question] Always got STALL in MUSB Host driver
Date: Mon, 19 Nov 2007 12:19:53 +0530
Message-ID: <ef9503490711182249j7045249fi2a5bff49707f0627@mail.gmail.com>
References: <1195123737.3698.24.camel@roc-desktop>
	<200711151043.46220.david-b@pacbell.net>
	<ef9503490711182208yee319c6rf80245426d9ce1d9@mail.gmail.com>
	<200711182234.16066.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <200711182234.16066.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Currently I am trying to get the DMA Mode (cppi dma) working in High Speed.
The driver works for sometime and then the Tx channel get snapped.
I am working on 2.6.18 Davinci kernel and tried to see the updates on
musb driver in 2.6.23 driver of both (omap and davinci). On davinci I
don't see much changes except the musb
driver falling in kernel coding convention.

Unfortunately I also don't USB analyzer to really heck out what
exactly happening there.

----------------- Error Log ------------------------
<4>eth1: Tx timed out.
<4>We are going to usb_kill_urb @ kevent
<0>Calling cppi_channel_abort
<7>musb_cleanup_urb 2374: abort TX1 DMA for urb c2dbb380 --> 0
<7>__musb_giveback 310: complete c2dbb380 (-2), dev2 ep1out, 1543/1543
<3>Tx status: -2error in tx submit urb: -1Clear Tx Busy
<4>error in tx submit urb: -1Clear Tx Busy
<6>NETDEV WATCHDOG: eth1: transmit timed out
____________________________________

regards,
Nazim

On Nov 19, 2007 12:04 PM, David Brownell <david-b@pacbell.net> wrote:
> On Sunday 18 November 2007, Nazim Khan wrote:
> > Hi Dave,
> >
> > Was that in DMA mode or PIO Mode?
>
> Probably PIO, since that's usually the first stage of
> debugging given a choice of modes.
>
> I vaguely recall it was one of those two modes, but
> don't recall which one.  If it was DMA, I sure don't
> recall which of the several DMA engine wass involved.  ;)
>
> - Dave
>
>
>
> > regards,
> > Nazim
> >
> > On Nov 16, 2007 12:13 AM, David Brownell <david-b@pacbell.net> wrote:
> > > On Thursday 15 November 2007, Tony Lindgren wrote:
> > > > Hmm, I never got double buffering to reliably work on tusb as far as I
> > > > remember. I guess Dave got it working on DaVinci, so maybe he has some
> > > > pointers.
> > >
> > > It's been some time since I tried that.  What I vaguely recall
> > > is that it worked on the peripheral side, but on the host side
> > > there was a issue if for example both sides (tx, rx) of a given
> > > FIFO tried to do things at the same time.
> > >
> > > The driver code has improved a lot since I saw those failures,
> > > so I wouldn't trust those memories to indicate anything specific
> > > about current behavior.
> > >
> > > - Dave
> > >
> >
>
