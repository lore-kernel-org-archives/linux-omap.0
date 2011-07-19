From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2] usb: musb: Enable DMA mode1 RX for USB-Mass-Storage
Date: Tue, 19 Jul 2011 11:52:41 +0530
Message-ID: <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4CFC000B@dbde03.ent.ti.com>
References: <1311033103-15854-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1311033103-15854-1-git-send-email-vikram.pandita-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sonasath, Moiz" <m-sonasath-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> From: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
> 
> This patch enables the DMA mode1 RX support.
> This feature is enabled based on the short_not_ok flag passed from
> gadget drivers.
> 
> This will result in a thruput performance gain of around
> 40% for USB mass-storage/mtp use cases.
> 
> Based on Original work by
> Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org> on 2.6.35 kernel
> 
> Change-Id: I9b3a7cae73b63e86128d2caf4cdd67ab77556e75
> Signed-off-by: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>

I think the change-id should not be included in upstream
submissions - it may not be useful to someone looking at
the changelog. So you probably should drop it.

Could you please retain my authorship and sign off from the
original patch, since I did pretty much all the original work
on writing this patch (and if I remember correctly several
attempts to get this merged upstream)? I don't see any
functional changes from my original patch.


- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
