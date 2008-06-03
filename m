From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [Question] MUSB: why not clear DMA interrupt in musbhsdma.c?
Date: Tue, 3 Jun 2008 09:57:31 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB022B9C81C1@dbde02.ent.ti.com>
References: <386072610806022015t654e46g92d184d949ad60ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <386072610806022015t654e46g92d184d949ad60ad-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> Hi folks,
>
> I am trying to enable the whole musb HS DMA code on Blackfin. But
> found the is no place to clean the DMA interrupt flag in musbhsdma.c.
> As a result, the irq always happens with the same DMA irq source. I
> add some code to clear the DMA interrupt. Did I miss something here?

The DMA interrupt register is cleared on a read. I don't think you need
to explicitly clear it.

>
> After enabling the musb HS DMA code for Blackfin, normal operation is
> OK for mount/umount U-disks. But when I tried to write large file to
> the U-DISK (such as 10Mbyte or 100Mbyte), speed is very slow and mush
> slower than PIO mode, IMO.
> Did you guy meet this issue before on OMAP?
>
> Thanks
> -Bryan

- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
