From: Jyri Sarha <jsarha@ti.com>
Subject: Re: OMAP 4430 SDP: rather sick with recent kernels
Date: Wed, 17 Dec 2014 23:08:06 +0200
Message-ID: <5491F0B6.4090904@ti.com>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk> <20141217172333.GE23854@atomide.com> <20141217185155.GI11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46812 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbaLQVIm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Dec 2014 16:08:42 -0500
In-Reply-To: <20141217185155.GI11502@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Nishanth Menon <nm@ti.com>

On 12/17/2014 08:51 PM, Russell King - ARM Linux wrote:
> On Wed, Dec 17, 2014 at 09:23:33AM -0800, Tony Lindgren wrote:
>> Hi,
>>
>> * Russell King - ARM Linux <linux@arm.linux.org.uk> [141217 01:55]:
>>> Tony,
>>>
>>> As the IOMMU stuff was merged last night, which removed a really quite
>>> horrid conflict resolution, I updated my nightly build tree from its
>>> previous state last Thursday.
>>>
>>> Now, SDP4430 seems to be really quite broken.
>>
>> Sigh, things are just break left and right every merge window :(
>
> Some of these things were present before the merge window, so they're
> less of a concern.  The biggest problem though is the ABE ASoC stuff
> exploding, which prevents my test system getting anywhere near mounting
> its rootfs.
>
> It's fine in the "combined" case, because we end up totally dead as
> far as serial console goes, but the "omap4430" kernel boot test never
> ends because the kernel doesn't stop spewing "rcu_sched stall" messages.
>

I tried booting my 4460 Panda - which is the closest thing to 4430SDP 
that I've got - on next-20141217, but I could not get it to the point 
where the omap-abe-twl6040 probed. It probably is the problem you are 
talking about as the hang does not happen if I disable ASoC ABE all 
together, right?

I'll take a deeper look at it tomorrow, as Peter is not working ATM.

Best regards,
Jyri
