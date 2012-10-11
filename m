From: Sourav <sourav.poddar@ti.com>
Subject: Re: [RFC 00/24] OMAP serial driver flow control fixes, and preparation
 for DMA engine conversion
Date: Thu, 11 Oct 2012 15:51:00 +0530
Message-ID: <50769D8C.8030401@ti.com>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk> <507427DA.6020409@ti.com> <87mwzuxjtc.fsf@deeprootsystems.com> <507694CF.3020204@ti.com> <20121011095443.GH28061@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56400 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756635Ab2JKKVL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Oct 2012 06:21:11 -0400
In-Reply-To: <20121011095443.GH28061@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>

Hi Russell,
On Thursday 11 October 2012 03:24 PM, Russell King - ARM Linux wrote:
> On Thu, Oct 11, 2012 at 03:13:43PM +0530, Sourav wrote:
>> Hi Kevin,
>> On Wednesday 10 October 2012 11:59 PM, Kevin Hilman wrote:
>>> Hi Sourav,
>>>
>>> Sourav <sourav.poddar@ti.com> writes:
>>>
>>> [...]
>>>
>>>> Boot Tested this patch series against v3.6 tag(applied cleanly) on
>>>> panda board and
>>>> PM tested(hitting off in Idle and suspend) on omap3630 based beagle board.
>>>>
>>>> Note, I also tested the patches against the current master but only
>>>> after rebasing, since the current master includes serial patches from
>>>> Felipe Balbi[1].
>>>> [1] https://lkml.org/lkml/2012/8/24/139
>>>>
>>>> Tested-by: Sourav Poddar <sourav.poddar@ti.com>
>>> Did you test flow control after off-mode transitons?
>>>
>>> Russell indicated that the context save/restore is not saving important
>>> bits related to HW flow control, so I suspect some more testing,
>>> specifically of flow control after off-mode is needed.
>>>
>>> Kevin
>> The testing done was without any flow control enabled.
> So, as the patch set is about fixing the flow control stuff, would
> you say that your testing without flow control enabled has much value?
True. I missed that point while doing the testing. Sorry for that.
I further looked into it and saw some two options  in my minicom 
settings(Hardware Flow Control/ Software Flow Control) Which I am 
thinking are the ones used to enable the flow control ? and they are 
both set to NO.

I already enable software flow control and did the testing on beagle, 
where things are working fine
after off mode.
But if I enable hardware flow control, the teraterm does not allow me to 
load my fs and uImage from mmc.
If you have any pointers on how to test hardware flow control, I will 
like to do that on my beagle board.

Thanks,
Sourav



>> I will try to figure out how to do a hardware flow control testing
>> and see the status after the off mode.
> It's software flow control which isn't properly restored...

