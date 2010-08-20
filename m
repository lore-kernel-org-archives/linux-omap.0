From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] [PATCH 6/7] usb: ehci: Introduce
 CONFIG_USB_EHCI_HCD_OMAP3
Date: Fri, 20 Aug 2010 09:13:22 +0300
Message-ID: <20100820061322.GG15196@nokia.com>
References: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-4-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-5-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-6-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-7-git-send-email-keshava_mgowda@ti.com>
 <20100820054507.GE15196@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0324222B65@dbde02.ent.ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0324222B65-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "Balbi Felipe (Nokia-MS/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 20, 2010 at 07:59:16AM +0200, ext Gadiyar, Anand wrote:
>Felipe Balbi wrote:
>> On Thu, Aug 19, 2010 at 01:49:36AM +0200, ext Keshava Munegowda wrote:
>> >@@ -126,6 +126,14 @@ config USB_EHCI_MXC
>> > 	---help---
>> > 	  Variation of ARC USB block used in some Freescale chips.
>> >
>> >+config USB_EHCI_HCD_OMAP3
>> >+	bool "EHCI support for OMAP3 and later chips"
>> >+	depends on USB_EHCI_HCD && (ARCH_OMAP3 || ARCH_OMAP4)
>>
>> this line doesn't scale. When we have another omap release this will
>> become e.g. ARCH_OMAP3 || ARCH_OMAP4 || ARCH_OMAP5 || ARCH_OMAP6 etc
>> etc, so instead of depending on ARCH_OMAPX, depend only on ARCH_OMAP and
>> make the architecture select the USB_ARCH_HAS_EHCI like this:
>
>ARCH_OMAP includes OMAP1/2, and these chips do not have any EHCI controllers.
>
>Is this okay?

as long as noone selects USB_ARCH_HAS_EHCI for omap1/2 it's fine.

-- 
balbi

DefectiveByDesign.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
