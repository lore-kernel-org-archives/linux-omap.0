From: Archit Taneja <a0393947@ti.com>
Subject: Re: OMAP34xx
Date: Thu, 5 Apr 2012 14:04:41 +0530
Message-ID: <4F7D5921.2050401@ti.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205125626.GA11372@n2100.arm.linux.org.uk> <20120205143824.GA12577@n2100.arm.linux.org.uk> <4F336D3A.2060302@ti.com> <20120209223400.GE19159@n2100.arm.linux.org.uk> <4F34B89F.1050904@ti.com> <20120405082442.GA25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56069 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255Ab2DEIfT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Apr 2012 04:35:19 -0400
In-Reply-To: <20120405082442.GA25053@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Hi,

On Thursday 05 April 2012 01:54 PM, Russell King - ARM Linux wrote:
> On Fri, Feb 10, 2012 at 11:56:39AM +0530, Archit Taneja wrote:
>> On Friday 10 February 2012 04:04 AM, Russell King - ARM Linux wrote:
>>> On Thu, Feb 09, 2012 at 12:22:42PM +0530, Archit Taneja wrote:
>>>> Hi,
>>>>
>>>> On Sunday 05 February 2012 08:08 PM, Russell King - ARM Linux wrote:
>>>>> Okay, so this requires backlight support, and TAAL selected, so that sorts
>>>>> that error, but causes others:
>>>>>
>>>>> taal display0: taal panel revision e3.83.7d
>>>>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>>>>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>>>>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>>>>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>>>>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>>>>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>>>>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>>>>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>>>>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>>>>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>>>>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>>>>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>>>>
>>>> This happens when the flex cable connected to the display is faulty or
>>>> loose.
>>>
>>> Well, I don't know - it works with ES1 and an old kernel just fine.
>>>
>>
>> Okay, I'll look into this more.
>
> Any news on this?  I see no progress on this in mainline kernels:
>
> http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=112
>
> Yet I can still boot the kernel with the originally provided kernel
> and CPU and it all works fine.
>
> Has anyone else tried to get the LCD panels working on the 4430SDP?

We figured out the culprit patch, reverting this prevents the issue:

commit 46f8c3c7e95c0d30d95911e7975ddc4f93b3e237
Author: Archit Taneja <archit@ti.com>
Date:   Fri Oct 7 03:08:44 2011 -0600

     ARM: OMAP: ctrl: Fix CONTROL_DSIPHY register fields

     Fix the shift and mask macros for DSIx_PPID fields in 
CONTROL_DSIPHY. The
     OMAP4430 Public TRM vV has these fields mentioned correctly.

     Signed-off-by: Archit Taneja <archit@ti.com>
     Acked-by: Benoit Cousson <b-cousson@ti.com>
     Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
     Signed-off-by: Paul Walmsley <paul@pwsan.com>


This was added to be in sync with the register definitions in newer 
OMAP4 TRMs. But it turns out that the newer TRMs might be actually 
messing up the register fields in question.

The DSIx_PPID register fields are responsible for the pull up/down of 
the DSI lanes. Some SDP versions may already have enough pull up to make 
the panels work, and others might not. We get the contention errors on 
these SDP boards as we don't configure the lanes as pull up.

We were trying to verify from the TRM maintainers if this was a TRM 
mistake, if so, reverting the patch would be the right way to go. We 
haven't got a response, so I'll probe the voltage of DSI lanes on a 
board which gives these errors so that we have enough proof.

Archit

>

