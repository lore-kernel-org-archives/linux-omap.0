From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC 1/5] OMAP: mux: Add support for control module split in
 several partitions
Date: Mon, 27 Sep 2010 19:24:12 +0200
Message-ID: <4CA0D33C.303@ti.com>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com> <1285319748-28976-2-git-send-email-b-cousson@ti.com> <20100925002228.GP4211@atomide.com> <20100927154611.GT4211@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56025 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759893Ab0I0RYW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Sep 2010 13:24:22 -0400
In-Reply-To: <20100927154611.GT4211@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi Tony,

On 9/27/2010 5:46 PM, Tony Lindgren wrote:
> * Tony Lindgren<tony@atomide.com>  [100924 17:14]:
>>
>> * Benoit Cousson<b-cousson@ti.com>  [100924 02:07]:
>>
>> If we wanted to use only the offset in the data, we could initialize
>> the various sections separately. But then omapX_mux_init() would have
>> to know the partition number somehow..
>
> After thinking about this a bit more, to me it seems like this is
> the best way to go. Then there's no need to repeat the partition data
> for each entry. How about this:
>
> Earlier defines stay the same:
>
> #define OMAP3_MUX(mode0, mux_value)					\
> {									\
> 	.reg_offset	= (OMAP3_CONTROL_PADCONF_##mode0##_OFFSET),	\
> 	.value		= (mux_value),					\
> }
>
> Then for omap4, we need to add a separate board mux table for each
> partition:
>
> #define OMAP4_MUX_PARTXXX(mode0, mux_value)				\
> {									\
> 	.reg_offset	= (OMAP4_PART_XXX_PADCONF_##mode0##_OFFSET),	\
> 	.value		= (mux_value),					\
> }
>
> #define OMAP4_MUX_PARTYYY(mode0, mux_value)				\
> {									\
> 	.reg_offset	= (OMAP4_PARTYYY_PADCONF_##mode0##_OFFSET),	\
> 	.value		= (mux_value),					\
> }

OK for that one, that will save the extra id to store the partition in 
each static data, but then you will still have to store it during the init?

> ...
> For omap2 and 3, we just call omap_mux_init once with the mux_pbase
> as we currently already do. Then for omap4, we call omap_mux_init for
> each partition.
>
> We also need to change omap_mux_read/write to allow specifying the
> partition base address:

Then you need somehow a partition information from somewhere.
I don't see how we can avoid the id at that point? We can store the base 
address instead, but then every mux entries will have it.

The caller of the omap_mux_read still have to figure out what base 
address it has to use.
That move the issue to the upper layer, but we still need that.

>
> u16 omap_mux_read(void __iomem *base, u16 offset)
> {
> 	if (cpu_is_omap24xx())
> 		return __raw_readb(base + offset);
> 	else
> 		return __raw_readw(base + offset);
> }
>
> All the other mux interface functions can stay the same, we just need
> to modify the mux.c code to look for signal names or GPIO number in
> each registered partition.

OK, now I think I understand your point... Please ignore the previous 
comments :-)

You will guess the partition by trying each array at a time, and the 
first one will win.

That seems pretty good in fact.

I just have to do it now...

Thanks,
Benoit


