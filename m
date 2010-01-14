From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] USB: musb: allow unaligned memory data transfers
Date: Thu, 14 Jan 2010 19:23:09 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E2EB52D@dbde02.ent.ti.com>
References: <1263310937-7249-1-git-send-email-vikram.pandita@ti.com>
 <20100114112354.GG19526@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB031E2EB521@dbde02.ent.ti.com>
 <4B4F20DE.6040001@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B4F20DE.6040001-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Cc: "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Mankad, Maulik Ojas" <x0082077-l0cyMroinI0@public.gmane.org>, "Patra, Nilkesh" <nilkesh.patra-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Sergei Shtylyov wrote:
> Gadiyar, Anand wrote:
> 
> >> From: Felipe Balbi wrote:
> >>     
> >>> +	/* On MUSB:RTL1.8 and above, DMA has to be word aligned */
> >>> +	if ((dma_addr % 4) &&
> >>> +		(musb->hwvers >= MUSB_HWVERS_1800)) {
> >>>       
> >> is it only inventra dma that suffers from this ? If not, we could move 
> >> this check before even calling the dma routine.
> >>     
> >
> > Yes, it's only the integrated Inventra DMA that behaves like this.
> >
> > Anyway, I don't think newer versions of the IP are being used by
> > anyone without the Inventra DMA. The older versions though are
> > sometimes used with external DMA controllers.
> 
>    DA8xx/OMAP-L1x  has MUSB version 1.800 and external, CPPI 4.1 DMA 
> controller.
> 

Ah, okay. Thanks for the info - I did not know this.

- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
