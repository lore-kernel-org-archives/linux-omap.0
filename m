From: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Subject: Re: [PATCH] select NOP_USB_XCEIV for OMAP4
Date: Wed, 23 Jun 2010 23:12:48 +0200
Message-ID: <61951E1F-DEBF-450C-AF06-E0119DA3B33E@student.utwente.nl>
References: <1277318873-8260-1-git-send-email-x0132446@ti.com> <87k4ppqyk2.fsf@deeprootsystems.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87k4ppqyk2.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: David Anders <x0132446-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ajay.gupta-l0cyMroinI0@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


Op 23 jun 2010, om 22:33 heeft Kevin Hilman het volgende geschreven:

> David Anders <x0132446-l0cyMroinI0@public.gmane.org> writes:
> 
>> Add select statement to force selection of NOP_USB_XCEIV for OMAP4.
>> 
>> Signed-off-by: David Anders <x0132446-l0cyMroinI0@public.gmane.org>
>> ---
>> drivers/usb/musb/Kconfig |    1 +
>> 1 files changed, 1 insertions(+), 0 deletions(-)
>> 
>> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
>> index cfd38ed..e4624bc 100644
>> --- a/drivers/usb/musb/Kconfig
>> +++ b/drivers/usb/musb/Kconfig
>> @@ -11,6 +11,7 @@ config USB_MUSB_HDRC
>> 	depends on (USB || USB_GADGET)
>> 	depends on (ARM || (BF54x && !BF544) || (BF52x && !BF522 && !BF523))
>> 	select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM || BLACKFIN)
>> +	select NOP_USB_XCEIV if ARCH_OMAP4
>> 	select TWL4030_USB if MACH_OMAP_3430SDP
>> 	select USB_OTG_UTILS
>> 	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
> 
> Shouldn't this be a board-specific option, and not set for every
> OMAP4-based config?

If that's true, why do the  davinci and blackfin archs force it?

regards,

Koen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
