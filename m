From: "Hald, Ulrik Bech" <ubh@ti.com>
Subject: RE: [PATCH v2 1/1] i2c:OMAP3:Errata workaround for spurious RDR
 event
Date: Thu, 25 Jun 2009 20:44:36 +0200
Message-ID: <00695C9C8F8B4448856F48142B4AA201BDB1387D@dnce02.ent.ti.com>
References: <1245702865-4459-1-git-send-email-ubh@ti.com>
 <alpine.DEB.2.00.0906221915540.9637@utopia.booyaka.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B5259C55@dbde02.ent.ti.com>
 <alpine.DEB.2.00.0906222113200.9637@utopia.booyaka.com>
 <00695C9C8F8B4448856F48142B4AA201BDA38C4A@dnce02.ent.ti.com>
 <alpine.DEB.2.00.0906231146550.6545@utopia.booyaka.com>
 <7A436F7769CA33409C6B44B358BFFF0C0116011C19@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44344 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902AbZFYSom convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 14:44:42 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C0116011C19@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Menon, Nishanth
> Sent: Tuesday, June 23, 2009 3:27 PM
> To: Paul Walmsley; Hald, Ulrik Bech
> Cc: Pakaravoor, Jagadeesh; linux-omap@vger.kernel.org
> Subject: RE: [PATCH v2 1/1] i2c:OMAP3:Errata workaround for spurious RDR
> event
> 
> Paul, Ulrik,
> 
> Just adding my view to this discussion:
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Paul Walmsley
> > Sent: Tuesday, June 23, 2009 9:05 PM
> > To: Hald, Ulrik Bech
> > Cc: Pakaravoor, Jagadeesh; linux-omap@vger.kernel.org
> > Subject: RE: [PATCH v2 1/1] i2c:OMAP3:Errata workaround for spurious RDR
> > event
> > > >
> > > > > > > +			u8 stat2 = 0;
> > > > > > > +			stat2 = omap_i2c_read_reg(dev,
> OMAP_I2C_STAT_REG);
> > > > > > > +			if (stat2 & OMAP_I2C_STAT_BB)
> > > > > > > +				return IRQ_HANDLED;
> > > > > >
> > > > > > Why use stat2? Why not just test stat again?
> > > > >
> > > > > Stat is read at the beginning of the ISR, what if BB bit gets
> > > > > cleared/set a while later, not along with RDR, as a corner case?
> > > >
> > > > If that is possible, then the comment in this patch needs to be
> > changed:
> > > >
> > > > > +                     /* 3430 I2C Errata 1.15
> > > > > +                      * RDR could be set when the bus is busy,
> then
> > > > > +                      * ignore the interrupt, and clear the bit.
> > > > > +                      */
> > > >
> > > > This implies that the state of the BB bit is important when the RDR
> > bit is
> > > > set.  The closest sample we have for that is the contents of the
> > 'stat'
> > > > variable.
> > > >
> > > If I understand it correctly, you're concerned that the wording of the
> > > comment lets one think, that the state of the bus is critical at the
> > > moment the RDR interrupt is set? I guess you're right about that,
> since
> > > the wording could be a little misleading.
> >
> > My concern is that the comment and the code seem to conflict.
> >
> > > The point of the errata workaround is only to prevent handling of the
> > > RDR interrupt, if the bus is busy at the time when the RDR is to be
> > > handled. It doesn't matter if BB has been set/cleared before that.
> > >
> > > So maybe, the wording of the comment should be:
> > >
> > > /* 3430 I2C Errata 1.15, 2430 I2C Errata 1.67:
> > >  * RDR should not be handled when bus is busy */
> > >
> > > ?
> >
> > Yes, that is better.
> >
> > > > > If we keep it this way, re-reading the register; what could be the
> > > > > potential problem?
> > > >
> > > > It doesn't match the definition of the erratum as expressed in the
> > > > comment.  Is it possible for the RDR bit to be erroneously set when
> BB
> > =
> > > > 0?
> > >
> > > Yes, the nature of the errata is that the RDR interrupt could be
> > > spurious. Although, if the bus is not busy and the RDR is set
> > > erroneously (there are no bytes in the FIFO to be drained), then the
> > > normal isr code would just leave and do nothing, which is what we also
> > > need in the errata work around.
> >
> > Okay.  So it looks like there is a unfixable race here.  Is it possible
> > for BB to be 0 during the stat2 read, then for BB to go to 1 immediately
> > afterwards?  Then the rest of the RDR handler would be entered.  If this
> > is possible, what will the ISR do -- will it hang?
> >
> > If this assessment of the problem is accurate, the stat2 read shrinks
> > the race window, and then indeed seems useful.
> >
> >
> 
> a)       why would bus be busy? - answer bus is busy before a transaction
> starts - each transaction is an atomic operation. If someone goofs around
> with signal while a master is sending/receiving data, there is
> AL(Arbitration Lost).. not Bus busy.
> 
But couldn't the BB bit be set by the I2C controller to signal a new receive transaction has started, while the ISR is still in the process of handling the RDR interrupt?

Anyway, when I look at the code below where the patch is introduced:
..
			if (dev->fifo_size) {
				if (stat & OMAP_I2C_STAT_RRDY)
					num_bytes = dev->fifo_size;
				else
					num_bytes = omap_i2c_read_reg(dev,
							OMAP_I2C_BUFSTAT_REG);
			}
			while (num_bytes) {
				num_bytes--;
				w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
				if (dev->buf_len) {
					*dev->buf++ = w;
					dev->buf_len--;
					/* Data reg from 2430 is 8 bit wide */
					if (!cpu_is_omap2430() &&
							!cpu_is_omap34xx()) {
						if (dev->buf_len) {
							*dev->buf++ = w >> 8;
							dev->buf_len--;
						}
					}
				} else {
					if (stat & OMAP_I2C_STAT_RRDY)
						dev_err(dev->dev,
							"RRDY IRQ while no data"
								" requested\n");
					if (stat & OMAP_I2C_STAT_RDR)
						dev_err(dev->dev,
							"RDR IRQ while no data"
								" requested\n");
					break;
				}
			}
..

... is there really a need for the patch in the first place? The data extraction from the FIFO is handled the same way for both RDR and RRDY interrupts. The only difference is what num_bytes is set to. Sure, RDR could be set spuriously, but if we're handling it the same way as RRDY what's the problem?
If data is ready in the FIFO, we extract only what is there. If no data is ready, we simply leave. 

Please correct me if I am wrong..

> b)       Look at the flow in TRM figure 18-13 I2C Master Reciever Mode,
> interrupt mode -> where does BB get checked by the h/w? Not in the middle
> of the transaction..
> 
> Apologies if I am wrong, so am not entirely following the discussion
> here..
> 
> Regards,
> Nishanth Menon

/Ulrik
