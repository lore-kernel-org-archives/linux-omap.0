From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/2] MUSB DMA_INTR register may sometimes read zero when
 infact there
Date: Fri, 4 Dec 2009 02:28:52 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309C863B1@dbde02.ent.ti.com>
References: <1259871921-19346-1-git-send-email-vikram.pandita@ti.com>,<FCCFB4CDC6E5564B9182F639FC35608702FAA0C569@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FAA0C569-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Pandita, Vikram wrote:

<snip>

> >
> >+      if (!int_hsdma) {
> >+              DBG(2, "spurious DMA irq\n");
> >+
> >+              for (bchannel = 0; bchannel < MUSB_HSDMA_CHANNELS; bchannel++) {
> >+                      musb_channel = (struct musb_dma_channel *)
> >+                                      &(controller->channel[bchannel]);
> >+                      channel = &musb_channel->channel;
> >+                      if (channel->status == MUSB_DMA_STATUS_BUSY) {
> >+                              csr = musb_readw(mbase,
> >+                                      MUSB_HSDMA_CHANNEL_OFFSET(bchannel,
> >+                                                      MUSB_HSDMA_COUNT));
> 
>         csr is a misnomer. It should be called count.
>         Also I recommend to add a function:
>         musb_read_hsdma_count() in "musbhsdma.h" just like the write
> counterpart and use here.
> 

Good catch. Yes, will fix. That was copy-pasted from the lines
that follow, and I'll fix that as well.


> >+                              if (csr == 0)
>         Should this not be if (csr != 0) only then you mark that dma
> channel as generated the interrupt?
> 

Nope. DMA_COUNT is a register that is programmed with the number of
bytes to transfer and counts down from there. So when we get a
DMA interrupt but cannot identify from DMA_INTR which channel raised
the interrupt, we rely on the DMA_COUNT being zero for the channels
that raised the interrupt.


> >+                                      int_hsdma |= (1 << bchannel);
> >+                      }
> >+              }
> >+
> >+              DBG(2, "int_hsdma = 0x%x\n", int_hsdma);
> >+
> >+              if (!int_hsdma)
> >+                      goto done;
> >+      }
> >+
> >       for (bchannel = 0; bchannel < MUSB_HSDMA_CHANNELS; bchannel++) {
> >               if (int_hsdma & (1 << bchannel)) {
> >                       musb_channel = (struct musb_dma_channel *)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
