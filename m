From: "Bryan Wu" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [Question] MUSB: why not clear DMA interrupt in musbhsdma.c?
Date: Tue, 3 Jun 2008 11:15:30 +0800
Message-ID: <386072610806022015t654e46g92d184d949ad60ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi folks,

I am trying to enable the whole musb HS DMA code on Blackfin. But
found the is no place to clean the DMA interrupt flag in musbhsdma.c.
As a result, the irq always happens with the same DMA irq source. I
add some code to clear the DMA interrupt. Did I miss something here?

After enabling the musb HS DMA code for Blackfin, normal operation is
OK for mount/umount U-disks. But when I tried to write large file to
the U-DISK (such as 10Mbyte or 100Mbyte), speed is very slow and mush
slower than PIO mode, IMO.
Did you guy meet this issue before on OMAP?

Thanks
-Bryan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
