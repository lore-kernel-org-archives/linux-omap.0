From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] fix NULL pointer with MUSB and DMA on ISO ep
Date: Thu, 15 Nov 2007 12:51:32 -0800
Message-ID: <20071115205132.GH20686@atomide.com>
References: <200711011540.49801.hyau@mvista.com>
	<200711020936.33644.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200711020936.33644.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [071102 09:37]:
> On Thursday 01 November 2007, Hunyue Yau wrote:
> > Hi,
> > 
> > The MUSB driver fails to pass a proper buffer pointer to
> > musb_write_fifo if DMA is enabled and it is an ISO endpoint. 
> > This removes the check that was preventing a proper buffer
> > pointer from being passed. 
> > 
> > Tested with a bluetooth headset and USB bluetooth dongle
> > using SCO audio on the 2430SDP.
> > 
> > -- Hunyue 
> > ---------------------------------------------------------------------------------
> > Description:
> >     For the case of an isochonous endpoint, musb_write_fifo may be 
> >     called with a NULL buffer from musb_host_tx if DMA is enabled.
> >     Remove DMA check and always supply a valid buffer as long as 
> >     the URB contains a valid buffer.
> > 
> > Signed-off-by: Hunyue Yau <hyau@mvista.com>
> > 
> > diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> > index e488ac7..a7fe072 100644
> > --- a/drivers/usb/musb/musb_host.c
> > +++ b/drivers/usb/musb/musb_host.c
> > @@ -1258,7 +1258,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
> >  			d->actual_length = qh->segsize;
> >  			if (++qh->iso_idx >= urb->number_of_packets) {
> >  				done = true;
> > -			} else if (!dma) {
> > +			} else {
> 
> ... looks right.  ACK.
> 
> >  				d++;
> >  				buf = urb->transfer_buffer + d->offset;
> >  				wLength = d->length;
> > 

Pushing today.

Tony
