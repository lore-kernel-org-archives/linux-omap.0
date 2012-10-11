From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 00/24] OMAP serial driver flow control fixes, and
	preparation for DMA engine conversion
Date: Thu, 11 Oct 2012 10:54:43 +0100
Message-ID: <20121011095443.GH28061@n2100.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk> <507427DA.6020409@ti.com> <87mwzuxjtc.fsf@deeprootsystems.com> <507694CF.3020204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <507694CF.3020204@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Sourav <sourav.poddar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 11, 2012 at 03:13:43PM +0530, Sourav wrote:
>
> Hi Kevin,
> On Wednesday 10 October 2012 11:59 PM, Kevin Hilman wrote:
>> Hi Sourav,
>>
>> Sourav <sourav.poddar@ti.com> writes:
>>
>> [...]
>>
>>> Boot Tested this patch series against v3.6 tag(applied cleanly) on
>>> panda board and
>>> PM tested(hitting off in Idle and suspend) on omap3630 based beagle board.
>>>
>>> Note, I also tested the patches against the current master but only
>>> after rebasing, since the current master includes serial patches from
>>> Felipe Balbi[1].
>>> [1] https://lkml.org/lkml/2012/8/24/139
>>>
>>> Tested-by: Sourav Poddar <sourav.poddar@ti.com>
>> Did you test flow control after off-mode transitons?
>>
>> Russell indicated that the context save/restore is not saving important
>> bits related to HW flow control, so I suspect some more testing,
>> specifically of flow control after off-mode is needed.
>>
>> Kevin
> The testing done was without any flow control enabled.

So, as the patch set is about fixing the flow control stuff, would
you say that your testing without flow control enabled has much value?

> I will try to figure out how to do a hardware flow control testing
> and see the status after the off mode.

It's software flow control which isn't properly restored...
