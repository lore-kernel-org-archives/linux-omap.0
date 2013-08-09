From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCHv3 4/9] ARM: OMAP2+: AM33XX: Reserve memory to comply with
 EMIF spec
Date: Fri, 9 Aug 2013 11:25:20 -0500
Message-ID: <520517F0.1080500@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com> <1375811376-49985-5-git-send-email-d-gerlach@ti.com> <87fvukhwtv.fsf@kernel.org> <5203F21F.3010801@ti.com> <87vc3ggd8s.fsf@kernel.org> <5203FB55.6000300@ti.com> <87vc3eaogk.fsf@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38608 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934409Ab3HIQZp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Aug 2013 12:25:45 -0400
In-Reply-To: <87vc3eaogk.fsf@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>

On 08/09/2013 10:11 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
>> On Thursday 08 August 2013 04:05 PM, Kevin Hilman wrote:
>>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>>
>>>> On Thursday 08 August 2013 02:16 PM, Kevin Hilman wrote:
>>>>> Dave Gerlach <d-gerlach@ti.com> writes:
>>>>>
>>>>>> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>>>>>
>>>>>> SDRAM controller on AM33XX requires that a modification of certain
>>>>>> bit-fields in PWR_MGMT_CTRL register (ref. section 7.3.5.13 in
>>>>>> AM335x-Rev H) is followed by a dummy read access to SDRAM. This
>>>>>> scenario arises when entering a low power state like DeepSleep.
>>>>>> To ensure that the read is not from a cached region we reserve
>>>>>> some memory during bootup using the arm_memblock_steal() API.
>>>>>
>>>>> Hmm, sounds to me an awful lot like the existing omap_bus_sync() ?
>>>>>
>>>> All the credit of that awful omap_bus_sync() goes to me since
>>>> I introduced it. And I keep beating the hardware guys
>>>> who have not left a choice but to introduce the ugly work
>>>> around in software. ;-)
>>>
>>> Agreed, but what's even more awful than the current version is
>>> duplicating it in a slightly different way using yet another whole page
>>> mapping for a single read/write location.
>>>
>> The real issue is limitation of the kernel memory steal(memblock) API which
>> won't let you still less than 1 MB. It would have been ok for page allocation
>> because that is any way what you will get minimum on standard non-cached
>> allocations.
>
> All the more reason that the omap_bus_sync() should be refactored
> slightly in a way that would be reusable for AM33xx.
>
> Kevin
>

I will look in to doing it this way. I do not know if there was any 
specific reason for doing it the way it was done.

Dave

