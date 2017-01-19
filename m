From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: dwc3 gadget breaks on system suspend/resume
Date: Thu, 19 Jan 2017 14:16:25 +0200
Message-ID: <a0cc2705-b1f5-7b6e-d73c-ff9b525eead2@ti.com>
References: <54bdc1b7-69ed-d580-fd17-3e7499ac1c27@ti.com>
 <87a8anjm5z.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87a8anjm5z.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 19/01/17 13:59, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>> Hi Felipe,
>>
>> We have system suspend resume working on dra7-evm in v4.10-rc but
>> dwc3 gadget breaks after system suspend resume.
>>
>> Any hints how to fix it? Full backtrace below.
> 
> from a quick look. END_TRANSFER is timing out, most likely. Tracepoints
> should give better hints.
> 
> We might have a bug in dwc3_gadget_suspend(). No idea what's really
> going on.
> 
>> Another message that looks worry-some is
>> "[   61.495313] omap-dwc3 48880000.omap_dwc3_1: runtime PM trying to suspend device but active child"
> 
> did you implement runtime PM on dwc3-omap.c? Look at dwc3-pci.c for reference.
> 
>> If I unload gadget, then suspend/resume system then load gadget everything works fine.
> 
> right, dwc3 UDC will already have been toredown. Unfortunately I can't
> spend a lot of time on this, so you're gonna have to try to fix it and
> provide a patch :-s Quite busy looking at some f_fs weirdness.

No problem. I'll debug this issue.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
