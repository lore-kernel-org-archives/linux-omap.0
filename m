From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 3/3] musb: AM35x: Workaround for fifo read issue
Date: Tue, 18 May 2010 15:41:20 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E5355EF@dbde02.ent.ti.com>
References: <1274093235-7616-1-git-send-email-ajay.gupta@ti.com>
 <1274093235-7616-2-git-send-email-ajay.gupta@ti.com>
 <1274093235-7616-3-git-send-email-ajay.gupta@ti.com>
 <4BF26511.2060705@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BF26511.2060705-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> Ajay Kumar Gupta wrote:
> 
> > AM35x supports only 32bit read operations so we need to have
> > workaround for 8bit and 16bit read operations.
> 
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> > ---
> > Patch created against linus'tree + all musb patches in Greg's queue
> > Changes from v2:
> > 	- fixed multipline comment style
> >  drivers/usb/musb/am3517.c    |   31 +++++++++++++++++++++++++++++++
> >  drivers/usb/musb/musb_core.c |    2 ++
> >  2 files changed, 33 insertions(+), 0 deletions(-)
> 
> > diff --git a/drivers/usb/musb/am3517.c b/drivers/usb/musb/am3517.c
> > index b74e664..c68c784 100644
> > --- a/drivers/usb/musb/am3517.c
> > +++ b/drivers/usb/musb/am3517.c
> > @@ -515,3 +515,34 @@ void musb_platform_restore_context(struct
> musb_context_registers
> >  	phy_on();
> >  }
> >  #endif
> > +
> > +/* AM35x supports only 32bit read operation */
> > +void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
> > +{
> > +	void __iomem *fifo = hw_ep->fifo;
> > +	u32		val;
> > +	int		i;
> > +
> > +	/* Read for 32bit-aligned destination address */
> > +	if ((likely((0x03 & (unsigned long) dst) == 0)) && len >= 4) {
> 
>     You don't need to put likely() in parens.

Ok.

> 
> > +		readsl(fifo, dst, len >> 2);
> > +		dst += (len & ~0x03);
> 
>     You don't need parens here as well.

Ok.

> 
> > +		len &= 0x03;
> > +	}
> > +	/*
> > +	 * Now read the rest 1 to 3 bytes or complete length if
> > +	 * unaligned address.
> > +	 */
> > +	if (len > 4) {
> > +		for (i = 0; i < (len >> 2); i++) {
> > +			val = musb_readl(fifo, 0);
> > +			memcpy(dst, &val, 4);
> 
>     Can't you do away with memcpy() here?
Are you asking for change below?

*(u32 *)dst = musb_readl(fifo, 0);

-Ajay
> 
> > +			dst += 4;
> > +		}
> > +		len %= 4;
> > +	}
> > +	if (len > 0) {
> > +		val = musb_readl(fifo, 0);
> > +		memcpy(dst, &val, len);
> > +	}
> > +}
> 
> WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
