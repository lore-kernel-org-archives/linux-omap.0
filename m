From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC 1/5] OMAP: mux: Add support for control module split in
 several partitions
Date: Mon, 27 Sep 2010 22:03:15 +0200
Message-ID: <4CA0F883.3030302@ti.com>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com> <1285319748-28976-2-git-send-email-b-cousson@ti.com> <20100925002228.GP4211@atomide.com> <20100927154611.GT4211@atomide.com> <4CA0D33C.303@ti.com> <20100927173604.GY4211@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55285 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755947Ab0I0UDU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Sep 2010 16:03:20 -0400
In-Reply-To: <20100927173604.GY4211@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On 9/27/2010 7:36 PM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [100927 10:15]:
>>
>> OK for that one, that will save the extra id to store the partition
>> in each static data, but then you will still have to store it during
>> the init?
>
> For mux.c internal data, we can have an array of struct omap_mux_partition
> that contains the mux array for that partition:
>
> struct omap_mux_partition {
> 	void __iomem	*base;	/* Partition virt base */
> 	struct omap_mux	*mux;	/* Partition specific mux array */
> };
>
>>> ...
>>> For omap2 and 3, we just call omap_mux_init once with the mux_pbase
>>> as we currently already do. Then for omap4, we call omap_mux_init for
>>> each partition.
>>>
>>> We also need to change omap_mux_read/write to allow specifying the
>>> partition base address:
>>
>> Then you need somehow a partition information from somewhere.
>> I don't see how we can avoid the id at that point? We can store the
>> base address instead, but then every mux entries will have it.
>
> That should only need to be stored once for each partition in the
> struct omap_mux_partition?
>
>> The caller of the omap_mux_read still have to figure out what base
>> address it has to use.
>> That move the issue to the upper layer, but we still need that.
>
> For the mux.c internal code, we can search through the array
> of struct omap_mux_partition and the mux entries in each partition
> for signal name or GPIO number.
>
>>> All the other mux interface functions can stay the same, we just need
>>> to modify the mux.c code to look for signal names or GPIO number in
>>> each registered partition.
>>
>> OK, now I think I understand your point... Please ignore the
>> previous comments :-)
>>
>> You will guess the partition by trying each array at a time, and the
>> first one will win.
>>
>> That seems pretty good in fact.
>>
>> I just have to do it now...
>
> OK cool, let me know if I can help with something.

Thanks, but that should be fine for moment. I think I should have the 
updated version before the end of the week.

Just one clarification, I don't think we have to use two different 
macros in that case. The names are already unique across partition 
today, so we can use only macro like for previous OMAP.

I'm just glad I don't have to re-write these 231 entries per ES manually :-)

I'll give it a try, and keep you inform if I have any un-expected issue 
with that approach.

Thanks,
Benoit
