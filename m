From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH RESEND v4 1/4] omap3: nand: prefetch in irq mode support
Date: Mon, 20 Sep 2010 19:01:16 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0316062730@dbde02.ent.ti.com>
References: <1284624059-1741-1-git-send-email-s-ghorai@ti.com>
 <1284624059-1741-2-git-send-email-s-ghorai@ti.com>
 <20100917175504.GG29610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45774 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754620Ab0ITNbZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Sep 2010 09:31:25 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Tony,

> -----Original Message-----
> From: Ghorai, Sukumar
> Sent: Saturday, September 18, 2010 11:55 PM
> To: 'Tony Lindgren'
> Cc: 'linux-omap@vger.kernel.org'; 'linux-mtd@lists.infradead.org'; 'linux-
> arm-kernel@lists.infradead.org'
> Subject: RE: [PATCH RESEND v4 1/4] omap3: nand: prefetch in irq mode
> support
> 
> Tony,
> 
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Friday, September 17, 2010 11:25 PM
> > To: Ghorai, Sukumar
> > Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org; linux-
> arm-
> > kernel@lists.infradead.org; Vimal Singh
> > Subject: Re: [PATCH RESEND v4 1/4] omap3: nand: prefetch in irq mode
> > support
> >
> > * Sukumar Ghorai <s-ghorai@ti.com> [100916 00:53]:
> > > This patch enable prefetch-irq mode for NAND.
> > >
> > > --- a/drivers/mtd/nand/omap2.c
> > > +++ b/drivers/mtd/nand/omap2.c
> > > @@ -467,6 +485,152 @@ static void omap_write_buf_dma_pref(struct
> > mtd_info *mtd,
> > >  		omap_nand_dma_transfer(mtd, (u_char *) buf, len, 0x1);
> > >  }
> > >
> > > +/*
> > > + * omap_nand_irq - GMPC irq handler
> > > + * @this_irq: gpmc irq number
> > > + * @dev: omap_nand_info structure pointer is passed here
> > > + */
> > > +static irqreturn_t omap_nand_irq(int this_irq, void *dev)
> > > +{
> > > +	struct omap_nand_info *info = (struct omap_nand_info *) dev;
> > > +	u32 bytes;
> > > +	u32 irq_stat;
> > > +
> > > +	irq_stat = gpmc_read_status(GPMC_GET_IRQ_STATUS);
> > > +	bytes = gpmc_read_status(GPMC_PREFETCH_FIFO_CNT);
> > > +	bytes = bytes  & 0xFFFC; /* io in multiple of 4 bytes */
> > > +	if (info->iomode == OMAP_NAND_IO_WRITE) { /* checks for write io */
> > > +		if (irq_stat & 0x2)
> > > +			goto done;
> > > +
> > > +		if (info->buf_len & (info->buf_len < bytes))
> > > +			bytes = info->buf_len;
> > > +		else if (!info->buf_len)
> > > +			bytes = 0;
> > > +		iowrite32_rep(info->nand.IO_ADDR_W,
> > > +						(u32 *)info->buf, bytes >> 2);
> > > +		info->buf = info->buf + bytes;
> > > +		info->buf_len -= bytes;
> > > +
> > > +	} else {
> > > +		ioread32_rep(info->nand.IO_ADDR_R,
> > > +						(u32 *)info->buf, bytes >> 2);
> > > +		info->buf = info->buf + bytes;
> > > +
> > > +		if (irq_stat & 0x2)
> > > +			goto done;
> > > +	}
> > > +	gpmc_cs_configure(info->gpmc_cs, GPMC_SET_IRQ_STATUS, irq_stat);
> > > +	irq_stat = gpmc_read_status(GPMC_GET_IRQ_STATUS);
> > > +
> > > +	return IRQ_HANDLED;
> > > +
> > > +done:
> > > +	complete(&info->comp);
> > > +	/* disable irq */
> > > +	gpmc_cs_configure(info->gpmc_cs, GPMC_ENABLE_IRQ, 0);
> > > +
> > > +	/* clear status */
> > > +	gpmc_cs_configure(info->gpmc_cs, GPMC_SET_IRQ_STATUS, irq_stat);
> > > +	irq_stat = gpmc_read_status(GPMC_GET_IRQ_STATUS);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> >
> > This handler should be in gpmc.c as it may be needed for other GPMC
> > connected devices on the same system. You can use chained irq handlers
> > to allow all the drivers to use the interrupt then.
> 
> [Ghorai]
> You mean as this function used the gpmc-irq number in nand file, so
> handler should move to gpmc.c file?
> 	1. For that we need to add one io-struct (to keep io buffer status)
> in gpmc.c;
> 
> 	2. Also need help how to sync between gpmc.c/omap_nand_irq() and
> omap2.c/omap_write_buf_irq_pref(), men how read/write function know that
> work done in interrupt-context? Or you prefer to move the complete IO
> function (omap_read/write_buf_irq_pref) to gpmc.c?
> 
> 	3. gpmc does not now about the read and write address that's
> applicable for NAND. So how to pass the IO address from omap2.c to gpmc.c,
> interrupt handler?
> 
> 
> So, please let me know your suggestion again such that I can post this
> time itself. Otherwise again it will miss from coming release, this was
> posted/reviewed for last release too. And suggest to void repeating of
> missing release window again.

[Ghorai] Please reply with your 2nd suggestion.
> 
> >
> > Regards,
> >
> > Tony
