From: Kevin Hilman <khilman@ti.com>
Subject: Re: MFD USB host: prevents CORE retention in idle
Date: Tue, 05 Jun 2012 10:50:31 -0700
Message-ID: <4FCE46E7.60702@ti.com>
References: <87zk8yxx9l.fsf@ti.com> <4FBD7FDC.9050307@ti.com> <CAP05o4KNnrKdmgJ=Ky=MS4pwEoEErH+Agkm2EwN1i1UDb-CbPQ@mail.gmail.com> <871um9wlzx.fsf@ti.com> <878vghut1u.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:52953 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755532Ab2FERud (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jun 2012 13:50:33 -0400
Received: by dalh21 with SMTP id h21so7304553dal.34
        for <linux-omap@vger.kernel.org>; Tue, 05 Jun 2012 10:50:32 -0700 (PDT)
In-Reply-To: <878vghut1u.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>, Felipe Balbi <balbi@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Keshava, Felipe,

ping.  This problem is still preventing CORE retention in mainline.

On 05/24/2012 03:13 PM, Kevin Hilman wrote:
> Kevin Hilman<khilman@ti.com>  writes:
>
>> "Munegowda, Keshava"<keshava_mgowda@ti.com>  writes:
>>
>>> On Thu, May 24, 2012 at 5:55 AM, Kevin Hilman<khilman@ti.com>  wrote:
>>>> On 05/23/2012 05:01 PM, Kevin Hilman wrote:
>>>>>
>>>>> Hi Keshava,
>>>>>
>>>>> Using current l-o master, I noticed that CORE was not hitting retention
>>>>> in idle on my 3530/Overo.  CORE hits retention on suspend just fine.
>>>>>
>>>>> Debugging this, I found that usbtll_fck was still enabled during idle,
>>>>> thus preventing CORE from hitting retention.
>>>>>
>>>>> To test, I disabled USB host (CONFIG_MFD_OMAP_USB_HOST=n in .config) and
>>>>> was then started seeing CORE hit retention in idle again.
>>>>>
>>>>> I have nothing plugged into the USB host port on this board, so I
>>>>> would've expected that runtime PM would've kicked in and shutdown this
>>>>> clock.
>>>>>
>>>>> Any ideas what's going on here?  Is this expected behavior?
>>>>>
>>>>
>>>> If it helps, attached is a bootlog after enabling debug for
>>>> mfd/omap-usb-host.c as well.  Notice there's a couple of clock-related
>>>> warnings from this driver as well.  Not sure if they're relevant:
>>>>
>>>> usbhs_omap: alias fck already exists
>>>> usbhs_omap usbhs_omap: xclk60mhsp2_ck set parentfailed error:-22
>>>
>>> these clocks were specific to omap4 and it should not cause any
>>> problem to omap3 boards.
>>
>> OK, they seem unrelated to this CORE retention problem, but the warnings
>> should still be understood and fixed.
>>
>>> I will try to reproduce this on 3430 sdp to explore further.
>>
>> Thanks for looking.  Note that I only saw this problem on my 3530
>> platforms (Overo, OMAP3EVM.)  My 3430/n900 doesn't support USBHS host
>> AFAICT, so didn't test there.
>
> After realizing that the same IP should exist on 3430/n900, I copied
> some board file support for USBHS host from overo into the n900 board
> file in order to test on 3430/n900.
>
> Problem exists on n900 too.
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
