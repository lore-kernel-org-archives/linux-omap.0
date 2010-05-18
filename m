From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 3/3] musb: AM35x: Workaround for fifo read issue
Date: Tue, 18 May 2010 15:56:42 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E53560E@dbde02.ent.ti.com>
References: <1274093235-7616-1-git-send-email-ajay.gupta@ti.com>
 <1274093235-7616-2-git-send-email-ajay.gupta@ti.com>
 <1274093235-7616-3-git-send-email-ajay.gupta@ti.com>
 <4BF26511.2060705@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E7394044E5355EF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48635 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752655Ab0ERK0w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 06:26:52 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E5355EF@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

Hi,
> > Ajay Kumar Gupta wrote:
> >
> > > AM35x supports only 32bit read operations so we need to have
> > > workaround for 8bit and 16bit read operations.
> >
> > > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > > ---
> > > Patch created against linus'tree + all musb patches in Greg's queue
> > > Changes from v2:
> > > 	- fixed multipline comment style
> > >  drivers/usb/musb/am3517.c    |   31 +++++++++++++++++++++++++++++++
> > >  drivers/usb/musb/musb_core.c |    2 ++
> > >  2 files changed, 33 insertions(+), 0 deletions(-)
> >
> > > diff --git a/drivers/usb/musb/am3517.c b/drivers/usb/musb/am3517.c
> > > index b74e664..c68c784 100644
> > > --- a/drivers/usb/musb/am3517.c
> > > +++ b/drivers/usb/musb/am3517.c
> > > @@ -515,3 +515,34 @@ void musb_platform_restore_context(struct
> > musb_context_registers
> > >  	phy_on();
> > >  }
> > >  #endif
> > > +
> > > +/* AM35x supports only 32bit read operation */
> > > +void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
> > > +{
> > > +	void __iomem *fifo = hw_ep->fifo;
> > > +	u32		val;
> > > +	int		i;
> > > +
> > > +	/* Read for 32bit-aligned destination address */
> > > +	if ((likely((0x03 & (unsigned long) dst) == 0)) && len >= 4) {
> >
> >     You don't need to put likely() in parens.
> 
> Ok.
> 
> >
> > > +		readsl(fifo, dst, len >> 2);
> > > +		dst += (len & ~0x03);
> >
> >     You don't need parens here as well.
> 
> Ok.
> 
> >
> > > +		len &= 0x03;
> > > +	}
> > > +	/*
> > > +	 * Now read the rest 1 to 3 bytes or complete length if
> > > +	 * unaligned address.
> > > +	 */
> > > +	if (len > 4) {
> > > +		for (i = 0; i < (len >> 2); i++) {
> > > +			val = musb_readl(fifo, 0);
> > > +			memcpy(dst, &val, 4);
> >
> >     Can't you do away with memcpy() here?
> Are you asking for change below?
> *(u32 *)dst = musb_readl(fifo, 0);

This one is safe and works but the other memcpy (below one) would
not be safe to replace as the length would be 1 to 3 bytes.

-Ajay
> > > +			dst += 4;
> > > +		}
> > > +		len %= 4;
> > > +	}
> > > +	if (len > 0) {
> > > +		val = musb_readl(fifo, 0);
> > > +		memcpy(dst, &val, len);
> > > +	}
> > > +}
> >
> > WBR, Sergei
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
