From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v2 1/1] i2c:OMAP3:Errata workaround for spurious RDR
 event
Date: Mon, 22 Jun 2009 21:20:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906222113200.9637@utopia.booyaka.com>
References: <1245702865-4459-1-git-send-email-ubh@ti.com> <alpine.DEB.2.00.0906221915540.9637@utopia.booyaka.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B5259C55@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58908 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbZFWDUO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 23:20:14 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B5259C55@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "Hald, Ulrik Bech" <ubh@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Jagadeesh,

On Tue, 23 Jun 2009, Pakaravoor, Jagadeesh wrote:

> > > +			u8 stat2 = 0;
> > > +			stat2 = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> > > +			if (stat2 & OMAP_I2C_STAT_BB)
> > > +				return IRQ_HANDLED;
> > 
> > Why use stat2? Why not just test stat again?
> 
> Stat is read at the beginning of the ISR, what if BB bit gets 
> cleared/set a while later, not along with RDR, as a corner case?

If that is possible, then the comment in this patch needs to be changed:

> +                     /* 3430 I2C Errata 1.15
> +                      * RDR could be set when the bus is busy, then
> +                      * ignore the interrupt, and clear the bit.
> +                      */

This implies that the state of the BB bit is important when the RDR bit is 
set.  The closest sample we have for that is the contents of the 'stat' 
variable.

> If we keep it this way, re-reading the register; what could be the 
> potential problem?

It doesn't match the definition of the erratum as expressed in the 
comment.  Is it possible for the RDR bit to be erroneously set when BB = 
0?


- Paul
