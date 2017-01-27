From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: dwc3 gadget breaks on system suspend/resume
Date: Fri, 27 Jan 2017 16:46:43 +0200
Message-ID: <57fbf2b6-3811-3202-0e69-7cf82662d50f@ti.com>
References: <54bdc1b7-69ed-d580-fd17-3e7499ac1c27@ti.com>
 <87a8anjm5z.fsf@linux.intel.com>
 <a0cc2705-b1f5-7b6e-d73c-ff9b525eead2@ti.com>
 <e64bc4ee-1c71-d72c-cdc7-f5857f49a90e@ti.com>
 <87inp07fkx.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87inp07fkx.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 27/01/17 16:17, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> 
>> Felipe,
>>
>> On 19/01/17 14:16, Roger Quadros wrote:
>>> On 19/01/17 13:59, Felipe Balbi wrote:
>>>>
>>>> Hi,
>>>>
>>>> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>>>> Hi Felipe,
>>>>>
>>>>> We have system suspend resume working on dra7-evm in v4.10-rc but
>>>>> dwc3 gadget breaks after system suspend resume.
>>>>>
>>>>> Any hints how to fix it? Full backtrace below.
>>>>
>>>> from a quick look. END_TRANSFER is timing out, most likely. Tracepoints
>>>> should give better hints.
>>>>
>>>> We might have a bug in dwc3_gadget_suspend(). No idea what's really
>>>> going on.
>>>>
>>>>> Another message that looks worry-some is
>>>>> "[   61.495313] omap-dwc3 48880000.omap_dwc3_1: runtime PM trying to suspend device but active child"
>>>>
>>>> did you implement runtime PM on dwc3-omap.c? Look at dwc3-pci.c for reference.
>>>>
>>>>> If I unload gadget, then suspend/resume system then load gadget everything works fine.
>>>>
>>>> right, dwc3 UDC will already have been toredown. Unfortunately I can't
>>>> spend a lot of time on this, so you're gonna have to try to fix it and
>>>> provide a patch :-s Quite busy looking at some f_fs weirdness.
>>>
>>> No problem. I'll debug this issue.
>>
>> Bisected to bad commit 4eb3d981e7344ded9e5a8725ed934dd8f8056daf "usb: dwc3: core: simplify suspend/resume operations".
> 
> $ git show 4eb3d981e7344ded9e5a8725ed934dd8f8056daf
> fatal: bad object 4eb3d981e7344ded9e5a8725ed934dd8f8056daf
> 
> That commit to me is:
> 
> commit 51f5d49ad6f011ee380b866ea617fd90584189a2
> Author: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Date:   Mon May 16 10:52:58 2016 +0300
> 
>     usb: dwc3: core: simplify suspend/resume operations
>     
>     now that we have re-factored dwc3_core_init() and
>     dwc3_core_exit() we can use them for suspend/resume
>     operations.
>     
>     This will help us avoid some common mistakes when
>     patching code when we have duplicated pieces of code
>     doing the same thing.
>     
>     Signed-off-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> Can you please try actual mainline and not some tree where you
> cherry-picked patches on top? ;-)
> 
Sorry about the wrong commit ID.
I reset my tree to 51f5d49ad6f011ee380b866ea617fd90584189a2 and can reproduce the issue.
The previous commit c499ff71ff2a281366c6ec7a904c547d806cbcd1 is fine.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
