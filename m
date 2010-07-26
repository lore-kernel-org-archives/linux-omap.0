From: "Taneja, Archit" <archit@ti.com>
Subject: RE: DSS2: DSI: Check for TX FIFO emptiness when sending long packets
Date: Mon, 26 Jul 2010 16:48:02 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305FAB129@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870305FAB05B@dbde02.ent.ti.com>
 <1280139608.2427.27.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44567 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754413Ab0GZLSI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jul 2010 07:18:08 -0400
In-Reply-To: <1280139608.2427.27.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com] 
> Sent: Monday, July 26, 2010 3:50 PM
> To: Taneja, Archit
> Cc: linux-omap@vger.kernel.org
> Subject: Re: DSS2: DSI: Check for TX FIFO emptiness when 
> sending long packets
> 
> On Mon, 2010-07-26 at 11:28 +0200, ext Taneja, Archit wrote:
> > Hi,
> > 
> > I had a little query. We check for TX FIFO not full before 
> sending a 
> > short packet in dsi_vc_send_short(), but we don't have a 
> similar check 
> > in dsi_vc_send_long() before writing to the long packet header.
> > 
> > There is a check of the static fifo size of the channel and 
> the length 
> > of data we are pushing, but that does not reflect the state 
> of the TX 
> > FIFO at that point of time.
> > 
> > Do you think we should have a check using DSI_TX_FIFO_VC_EMPTINESS 
> > before writing to the long packet header?
> 
> Yes, I think we should check that. Otherwise the transfer 
> will break with DSI_VC_IRQ_FIFO_TX_OVF interrupt, although I 
> think the lcd driver doesn't currently see this in any way.

Yes, the maximum number of bytes we send to taal panel using this
fucntion is 5 bytes, hence it is quite unlikely to get a fifo overflow.

> Although I'm not sure which would be better, return an error (EBUSY?
> EWOULDBLOCK?) if the FIFO cannot hold the whole message, or 
> block until the FIFO can hold the whole message...
>  Tomi
> 

I am not sure about this, it can be probably aligned with what is done in
update_screen_l4(). I didn't exaclty get why you block till
fifo_stalls > 0xfffff and if we can have a similar reasoning for send_long?

It would be great though if we can make dsi_vc_send_long() configurable enough
to be actually used in dsi_update_screen_l4(), because they both have enough
common code beween them.

Thanks,

Archit






