From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 0/2] I2C: OMAP: spurious IRQ fixes
Date: Tue, 12 May 2009 12:33:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905121139500.17514@utopia.booyaka.com>
References: <20090426042504.31316.68357.stgit@localhost.localdomain> <49F59D89.3030008@nokia.com> <alpine.DEB.2.00.0905071529070.17514@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162038BBF5056@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37289 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbZELSdT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 14:33:19 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038BBF5056@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@nokia.com>

On Tue, 12 May 2009, Woodruff, Richard wrote:

> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Paul Walmsley
> > A brief update for anyone following along on the list:
> >
> > Aaro sent me a test-case.  It seems that the receive overruns only affect
> > PM kernels.  They are caused by the MPU going to sleep while it waits for
> > an I2C interrupt.  It turns out that the current driver causes receive
> > overruns also; it just hides them.  The receive overruns are fairly
> > straightforward to deal with by setting an MPU wakeup latency constraint
> > during I2C operations.
> 
> What kind of latency is being seen by i2c in kernel snapshot you are using?
> Do you have an idea of what is tolerable given an I2C frequency?
> Is this error showing up in 100k/400k/HS mode?

The case that we observed was with I2C1 at 2.6MHz with the FIFO threshold 
at 4 bytes of an 8 byte FIFO, the driver default.

The maximum MPU wakeup latency to avoid overruns seems primarily a 
function of the I2C FIFO size, FIFO threshold, and I2C bus clock.  The 
OpenOffice spreadsheet used to compute this is here.  Comments and review
welcomed:

    http://www.pwsan.com/omap/i2c-wakeup-latency.ods

Crappy HTML version is here:

    http://www.pwsan.com/omap/i2c-wakeup-latency.html

It computed a 12 microsecond constraint for the above parameters.

> Sometimes a constraint is the only way but it does have cost.

Determining the actual cost of this constraint is an interesting problem.  
At first one would assume there would be a power consumption cost.  But it 
may be that allowing the MPU to go off while waiting for the interrupt 
consumes more power in the long run, since restarting takes time.

One thing that would help is if the Linux I2C interface had a way for 
applications to indicate that a transfer was not latency-sensitive. The 
cost of the constraint would probably depend on the I2C slave device's 
characteristics and the characteristics of the I2C application.

At least receive overruns are handled gracefully by the controller. 
Transmit FIFO underruns may be the more pressing problem.


- Paul
