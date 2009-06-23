From: "Hald, Ulrik Bech" <ubh@ti.com>
Subject: RE: [PATCH v2 1/1] i2c:OMAP3:Errata workaround for spurious RDR
 event
Date: Tue, 23 Jun 2009 18:34:32 +0200
Message-ID: <00695C9C8F8B4448856F48142B4AA201BDA38C4A@dnce02.ent.ti.com>
References: <1245702865-4459-1-git-send-email-ubh@ti.com>
 <alpine.DEB.2.00.0906221915540.9637@utopia.booyaka.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B5259C55@dbde02.ent.ti.com>
 <alpine.DEB.2.00.0906222113200.9637@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44271 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbZFWQej convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 12:34:39 -0400
In-Reply-To: <alpine.DEB.2.00.0906222113200.9637@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Monday, June 22, 2009 10:20 PM
> To: Pakaravoor, Jagadeesh
> Cc: Hald, Ulrik Bech; linux-omap@vger.kernel.org
> Subject: RE: [PATCH v2 1/1] i2c:OMAP3:Errata workaround for spurious RDR
> event
> 
> Hello Jagadeesh,
> 
> On Tue, 23 Jun 2009, Pakaravoor, Jagadeesh wrote:
> 
> > > > +			u8 stat2 = 0;
> > > > +			stat2 = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> > > > +			if (stat2 & OMAP_I2C_STAT_BB)
> > > > +				return IRQ_HANDLED;
> > >
> > > Why use stat2? Why not just test stat again?
> >
> > Stat is read at the beginning of the ISR, what if BB bit gets
> > cleared/set a while later, not along with RDR, as a corner case?
> 
> If that is possible, then the comment in this patch needs to be changed:
> 
> > +                     /* 3430 I2C Errata 1.15
> > +                      * RDR could be set when the bus is busy, then
> > +                      * ignore the interrupt, and clear the bit.
> > +                      */
> 
> This implies that the state of the BB bit is important when the RDR bit is
> set.  The closest sample we have for that is the contents of the 'stat'
> variable.
> 
If I understand it correctly, you're concerned that the wording of the comment lets one think, that the state of the bus is critical at the moment the RDR interrupt is set? I guess you're right about that, since the wording could be a little misleading.

The point of the errata workaround is only to prevent handling of the RDR interrupt, if the bus is busy at the time when the RDR is to be handled. It doesn't matter if BB has been set/cleared before that.

So maybe, the wording of the comment should be:

/* 3430 I2C Errata 1.15, 2430 I2C Errata 1.67:
 * RDR should not be handled when bus is busy */

?

> > If we keep it this way, re-reading the register; what could be the
> > potential problem?
> 
> It doesn't match the definition of the erratum as expressed in the
> comment.  Is it possible for the RDR bit to be erroneously set when BB =
> 0?

Yes, the nature of the errata is that the RDR interrupt could be spurious. Although, if the bus is not busy and the RDR is set erroneously (there are no bytes in the FIFO to be drained), then the normal isr code would just leave and do nothing, which is what we also need in the errata work around.

> 
> 
> - Paul

/Ulrik
