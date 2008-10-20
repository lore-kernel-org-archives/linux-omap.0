From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] i2c: omap: highspeed only over 1000mhz
Date: Mon, 20 Oct 2008 15:53:55 +0300
Message-ID: <20081020125355.GC31599@gandalf.research.nokia.com>
References: <1224277795-17143-1-git-send-email-felipe.balbi@nokia.com> <20081020102659.GA31599@gandalf.research.nokia.com> <48FC7CA9.4040102@gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31619 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbYJTMyj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Oct 2008 08:54:39 -0400
Content-Disposition: inline
In-Reply-To: <48FC7CA9.4040102@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <menon.nishanth@gmail.com>
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Tony Lindgren <tony@atomide.com>

On Mon, Oct 20, 2008 at 07:42:17AM -0500, ext Nishanth Menon wrote:
> Felipe,
> Felipe Balbi said the following on 10/20/2008 05:26 AM:
> > up to 1000khz it's Fast Mode+, not highspeed.
> >
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > ---
> >  drivers/i2c/busses/i2c-omap.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index a999606..53d6244 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -296,7 +296,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> >  		psc = psc - 1;
> >  
> >  		/* If configured for High Speed */
> > -		if (dev->speed > 400) {
> > +		if (dev->speed > 1000) {
> >   
> Ref: http://www.nxp.com/acrobat_download/literature/9398/39340011.pdf
> Page 4:
> "Serial, 8-bit oriented, bi-directional data transfers can be
> made at *up to* 100 kbit/s in the Standard-mode, *up to*
> 400 kbit/s in the Fast-mode, or *up to* 3.4 Mbit/s in the
> High-speed mode"
> 
> Why do say high speed is >1000khz?

http://www.standardics.nxp.com/support/documents/i2c/pdf/i2c.bus.specification.pdf

section 5.2:

"Fast-mode Plus (Fm+) devices offer an increase in I2C-bus transfer speeds and total bus
capacitance. Fm+ devices can transfer information at bit rates of up to 1 Mbit/s, yet they
remain fully downward compatible with Fast- or Standard-mode devices for bidirectional
communication in a mixed-speed bus system. The same serial bus protocol and data
format is maintained as with the Fast- or Standard-mode system. Fm+ devices also offer
increased drive current over Fast- or Standard-mode devices allowing them to drive
longer and/or more heavily loaded buses so that bus buffers do not need
to be used"

-- 
balbi
