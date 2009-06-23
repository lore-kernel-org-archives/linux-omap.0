From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v2 1/1] i2c:OMAP3:Errata workaround for spurious RDR
 event
Date: Tue, 23 Jun 2009 12:05:28 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906231146550.6545@utopia.booyaka.com>
References: <1245702865-4459-1-git-send-email-ubh@ti.com> <alpine.DEB.2.00.0906221915540.9637@utopia.booyaka.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B5259C55@dbde02.ent.ti.com> <alpine.DEB.2.00.0906222113200.9637@utopia.booyaka.com>
 <00695C9C8F8B4448856F48142B4AA201BDA38C4A@dnce02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35108 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbZFWSF0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 14:05:26 -0400
In-Reply-To: <00695C9C8F8B4448856F48142B4AA201BDA38C4A@dnce02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hald, Ulrik Bech" <ubh@ti.com>
Cc: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Ulrik,

On Tue, 23 Jun 2009, Hald, Ulrik Bech wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Monday, June 22, 2009 10:20 PM
> > To: Pakaravoor, Jagadeesh
> > Cc: Hald, Ulrik Bech; linux-omap@vger.kernel.org
> > Subject: RE: [PATCH v2 1/1] i2c:OMAP3:Errata workaround for spurious RDR
> > event
> > 
> > Hello Jagadeesh,
> > 
> > On Tue, 23 Jun 2009, Pakaravoor, Jagadeesh wrote:
> > 
> > > > > +			u8 stat2 = 0;
> > > > > +			stat2 = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> > > > > +			if (stat2 & OMAP_I2C_STAT_BB)
> > > > > +				return IRQ_HANDLED;
> > > >
> > > > Why use stat2? Why not just test stat again?
> > >
> > > Stat is read at the beginning of the ISR, what if BB bit gets
> > > cleared/set a while later, not along with RDR, as a corner case?
> > 
> > If that is possible, then the comment in this patch needs to be changed:
> > 
> > > +                     /* 3430 I2C Errata 1.15
> > > +                      * RDR could be set when the bus is busy, then
> > > +                      * ignore the interrupt, and clear the bit.
> > > +                      */
> > 
> > This implies that the state of the BB bit is important when the RDR bit is
> > set.  The closest sample we have for that is the contents of the 'stat'
> > variable.
> > 
> If I understand it correctly, you're concerned that the wording of the 
> comment lets one think, that the state of the bus is critical at the 
> moment the RDR interrupt is set? I guess you're right about that, since 
> the wording could be a little misleading.

My concern is that the comment and the code seem to conflict.

> The point of the errata workaround is only to prevent handling of the 
> RDR interrupt, if the bus is busy at the time when the RDR is to be 
> handled. It doesn't matter if BB has been set/cleared before that.
> 
> So maybe, the wording of the comment should be:
> 
> /* 3430 I2C Errata 1.15, 2430 I2C Errata 1.67:
>  * RDR should not be handled when bus is busy */
> 
> ?

Yes, that is better.

> > > If we keep it this way, re-reading the register; what could be the
> > > potential problem?
> > 
> > It doesn't match the definition of the erratum as expressed in the
> > comment.  Is it possible for the RDR bit to be erroneously set when BB =
> > 0?
> 
> Yes, the nature of the errata is that the RDR interrupt could be 
> spurious. Although, if the bus is not busy and the RDR is set 
> erroneously (there are no bytes in the FIFO to be drained), then the 
> normal isr code would just leave and do nothing, which is what we also 
> need in the errata work around.

Okay.  So it looks like there is a unfixable race here.  Is it possible 
for BB to be 0 during the stat2 read, then for BB to go to 1 immediately 
afterwards?  Then the rest of the RDR handler would be entered.  If this 
is possible, what will the ISR do -- will it hang?

If this assessment of the problem is accurate, the stat2 read shrinks 
the race window, and then indeed seems useful.


- Paul
