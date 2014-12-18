From: Jyri Sarha <jsarha@ti.com>
Subject: Re: OMAP 4430 SDP: rather sick with recent kernels
Date: Thu, 18 Dec 2014 15:12:10 +0200
Message-ID: <5492D2AA.6090701@ti.com>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk> <20141217172333.GE23854@atomide.com> <20141217185155.GI11502@n2100.arm.linux.org.uk> <5491F0B6.4090904@ti.com> <20141218101618.GJ11502@n2100.arm.linux.org.uk> <0625abeb83cd4ed88fdb38754b6a3086@EMAIL.axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53026 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981AbaLRNMv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Dec 2014 08:12:51 -0500
In-Reply-To: <0625abeb83cd4ed88fdb38754b6a3086@EMAIL.axentia.se>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 12/18/2014 01:48 PM, Peter Rosin wrote:
> Russel King wrote:
> *snip*
>> Now, we have this call to snd_soc_of_parse_audio_routing(), which
>> allocates some memory, copies the old routes into it, and then adds
>> to them from DT.  That explains why the pointer and number of routes
>> are different - there's 19 routes in omap4-sdp.dts - 17 + 19 = 36.
>> So that doesn't work - but importantly, it does point towards a
>> possible culpret - snd_soc_of_parse_audio_routing().
>>
>> This is obvious when you stop and think about what it's doing, this is
>> truely where this bug lies, and it /is/ in generic ASoC code.
>>
>> The problem is that this function doesn't consider the implications of
>> deferred probing.  Let's see what happens if we defer, and re-do the
>> ABE initialisation, including calling this function:
>>
>> 17 + 19 = 36. - first probe
>> 17 + 19 + 19 = 55. - second probe
>>
>> Oh - that works in terms of the number, and it would also explain why
>> the table has been screwed - because the second time we memcpy(), we're
>> memcpy()ing from data which was allocated via devm_kzalloc(), and thus
>> would have been freed after the first failed probe.
>>
>> Mark - this is a core ASoC problem.
>
> Sorry about this, I wasn't even aware of deferred probing when I wrote
> f8781db8aeb1. From my point of view, it is certainly possible to solve this
> in the card driver which needs to add card dapm routes instead. So, a
> revert is fine by me, if no better solution comes up.
>

Looks to me that for this feature we would need a separate function, 
something like:
int snd_soc_of_parse_audio_routing_append(struct snd_soc_card *card,
				   	const char *propname);

even if the implementation behind would be the same. But I guess it is 
little late for new designs at this phase.

Best regards,
Jyri


