From: "Hald, Ulrik Bech" <ubh@ti.com>
Subject: RE: [PATCH 1/1] i2c:OMAP3:Errata workaround for spurious RDR event
Date: Mon, 22 Jun 2009 22:26:27 +0200
Message-ID: <00695C9C8F8B4448856F48142B4AA201BDA381EB@dnce02.ent.ti.com>
References: <1245702292-4383-1-git-send-email-ubh@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B5259C1F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42104 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986AbZFVU0c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 16:26:32 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5MKQUvg007423
	for <linux-omap@vger.kernel.org>; Mon, 22 Jun 2009 15:26:36 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n5MKQU3c028815
	for <linux-omap@vger.kernel.org>; Mon, 22 Jun 2009 15:26:30 -0500 (CDT)
Received: from DNCE73.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n5MKQTAi012394
	for <linux-omap@vger.kernel.org>; Mon, 22 Jun 2009 15:26:30 -0500 (CDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B5259C1F@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sorry about that Jagadeesh, your name should definitely be in there. I was too quick on the "send" trigger :(

BR
Ulrik Bech Hald

 

> -----Original Message-----
> From: Pakaravoor, Jagadeesh
> Sent: Monday, June 22, 2009 3:23 PM
> To: Hald, Ulrik Bech; linux-omap@vger.kernel.org
> Cc: Hald, Ulrik Bech
> Subject: RE: [PATCH 1/1] i2c:OMAP3:Errata workaround for spurious RDR
> event
> 
> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Ulrik Bech Hald
> > Sent: Monday, June 22, 2009 3:25 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Hald, Ulrik Bech
> > Subject: [PATCH 1/1] i2c:OMAP3:Errata workaround for spurious RDR event
> >
> > Under certain rare conditions, I2C_STAT[13].RDR bit may be set,
> > and the corresponding interrupt fire, even when there is no
> > data in the receive FIFO, or the I2C data transfer is still
> > ongoing. These spurious RDR events must be ignored by the
> > software.
> >
> > A check for OMAP_I2C_STAT_BB is introduced in the ISR to
> > prevent further processing of RDR interrupt, if the bus is busy.
> >
> > Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
> > ---
> >  drivers/i2c/busses/i2c-omap.c |    9 +++++++++
> >  1 files changed, 9 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-
> omap.c
> > index ece0125..88feea1 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -668,6 +668,15 @@ omap_i2c_isr(int this_irq, void *dev_id)
> >  			omap_i2c_complete_cmd(dev, err);
> >  		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
> >  			u8 num_bytes = 1;
> > +			/* 3430 I2C Errata 1.15
> > +			 * RDR could be set when the bus is busy, then
> > +			 * ignore the interrupt, and clear the bit.
> > +			 */
> > +			u8 stat2 = 0;
> > +			stat2 = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> > +			if (stat2 & OMAP_I2C_STAT_BB)
> > +				return IRQ_HANDLED;
> > +
> >  			if (dev->fifo_size) {
> >  				if (stat & OMAP_I2C_STAT_RRDY)
> >  					num_bytes = dev->fifo_size;
> > --
> > 1.5.4.3
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

