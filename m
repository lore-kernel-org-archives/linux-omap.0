From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: dwc3 gadget breaks on system suspend/resume
Date: Mon, 30 Jan 2017 14:46:00 +0200
Message-ID: <a91c7564-5bfa-c77f-8fa2-1c1b0bcfd815@ti.com>
References: <54bdc1b7-69ed-d580-fd17-3e7499ac1c27@ti.com>
 <87a8anjm5z.fsf@linux.intel.com>
 <a0cc2705-b1f5-7b6e-d73c-ff9b525eead2@ti.com>
 <e64bc4ee-1c71-d72c-cdc7-f5857f49a90e@ti.com>
 <87inp07fkx.fsf@linux.intel.com>
 <57fbf2b6-3811-3202-0e69-7cf82662d50f@ti.com>
 <8760l07dfh.fsf@linux.intel.com> <87wpdg5wtx.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87wpdg5wtx.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 27/01/17 17:47, Felipe Balbi wrote:
> 
> Hi,
> 
> (hmm, I didn't receive your reply in my intel inbox, only
> gmail. Odd. Replying to myself here, but it should be on your reply,
> rater).
> 
> Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:
>>> The previous commit c499ff71ff2a281366c6ec7a904c547d806cbcd1 is fine.
>>
>> okay. Then let's try to figure out what's going on. A diff of regdump
>> before and after suspend/resume might start to give some clue about
>> what's going on. DWC3 tracepoints should help too. Care to get those?
>> BTW, is this dwc3 as host or peripheral?
> 
> You don't have any endpoints enabled:
> 
> -DALEPENA = 0x0000000f
> +DALEPENA = 0x00000000

Thanks for the hints.

This problem is because reason dwc3_gadget_run_stop() is timing out
during the suspend sequence and so dwc3_disconnect_gadget() and
__dwc3_gadget_stop() are not being called.

dwc3_suspend() does not consider dwc3_gadget_suspend()'s return value
and happily continues suspending the machine.

If I force dwc3_gadget_run_stop() to return 0 then everything works fine.

Any ideas why DWC3_DSTS_DEVCTRLHLT is not getting set?
I checked that DWC3_GEVNTCOUNT(0) is zero.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
