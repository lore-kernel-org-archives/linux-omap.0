From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] musb: get rid of unneeded musb->config->dyn_fifo
Date: Tue, 15 Dec 2009 15:48:57 +0200
Message-ID: <20091215134857.GO3689@nokia.com>
References: <1260883909-26836-1-git-send-email-ajay.gupta@ti.com>
 <20091215133432.GN3689@nokia.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091215133432.GN3689-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: ext Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 15, 2009 at 02:34:32PM +0100, Balbi Felipe (Nokia-D/Helsinki) wrote:
>Hi,
>
>On Tue, Dec 15, 2009 at 02:31:46PM +0100, ext Ajay Kumar Gupta wrote:
>>diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
>>index d437556..c5f006e 100644
>>--- a/include/linux/usb/musb.h
>>+++ b/include/linux/usb/musb.h
>>@@ -30,7 +30,6 @@ struct musb_hdrc_eps_bits {
>> struct musb_hdrc_config {
>> 	/* MUSB configuration-specific details */
>> 	unsigned	multipoint:1;	/* multipoint device */
>>-	unsigned	dyn_fifo:1;	/* supports dynamic fifo sizing */
>> 	unsigned	soft_con:1;	/* soft connect required */
>> 	unsigned	utm_16:1;	/* utm data witdh is 16 bits */
>> 	unsigned	big_endian:1;	/* true if CPU uses big-endian */
>
>same problem as the other patch I sent:
>
>$ git grep -w dyn_fifo arch/
>arch/arm/mach-davinci/usb.c:    .dyn_fifo       = true,
>arch/arm/mach-omap2/usb-musb.c: .dyn_fifo       = 1,
>arch/blackfin/mach-bf527/boards/cm_bf527.c:     .dyn_fifo       = 0,
>arch/blackfin/mach-bf527/boards/ezbrd.c:        .dyn_fifo       = 0,
>arch/blackfin/mach-bf527/boards/ezkit.c:        .dyn_fifo       = 0,
>arch/blackfin/mach-bf548/boards/cm_bf548.c:     .dyn_fifo       = 0,
>arch/blackfin/mach-bf548/boards/ezkit.c:        .dyn_fifo       = 0,
>
>we have to agree who will carry the arch changes.

what we can do is mark that field as deprecated and give one major 
release for people to remove that from their boards, then we send a 
patch finally removing it.

I'm talking about:

diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index d437556..c3ca147 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -30,7 +30,7 @@ struct musb_hdrc_eps_bits {
  struct musb_hdrc_config {
         /* MUSB configuration-specific details */
         unsigned        multipoint:1;   /* multipoint device */
-       unsigned        dyn_fifo:1;     /* supports dynamic fifo sizing */
+       unsigned        dyn_fifo:1 __deprecated;        /* supports dynamic fifo sizing */
         unsigned        soft_con:1;     /* soft connect required */
         unsigned        utm_16:1;       /* utm data witdh is 16 bits */
         unsigned        big_endian:1;   /* true if CPU uses big-endian */

how do you feel about that ?

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
