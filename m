From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC v2 3/7] OMAP: mux: Add support for control module split
 in several partitions
Date: Thu, 11 Nov 2010 17:50:20 +0100
Message-ID: <4CDC1ECC.8080600@ti.com>
References: <1287526956-21853-1-git-send-email-b-cousson@ti.com> <1287526956-21853-4-git-send-email-b-cousson@ti.com> <20101111163547.GO9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57843 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab0KKQu0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Nov 2010 11:50:26 -0500
In-Reply-To: <20101111163547.GO9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On 11/11/2010 5:35 PM, Tony Lindgren wrote:
> * Benoit Cousson<b-cousson@ti.com>  [101019 15:14]:
>> --- a/arch/arm/mach-omap2/mux.h
>> +++ b/arch/arm/mach-omap2/mux.h
>> +
>> +/**
>> + * struct mux_partition - contain partition related information
>> + * @name: name of the current partition
>> + * @flags: flags specific to this partition
>> + * @phys: physical address
>> + * @size: partition size
>> + * @base: virtual address after ioremap
>> + * @muxmodes: list of nodes that belong to a partition
>> + * @node: list node for the partitions linked list
>> + */
>> +struct omap_mux_partition {
>> +	const char		*name;
>> +	u32			flags;
>> +	u32			phys;
>> +	u32			size;
>> +	void __iomem		*base;
>> +	struct list_head	muxmodes;
>> +	struct list_head	node;
>> +};
>
> With the omap_mux_parition..
>
>>   /**
>>    * struct omap_mux - data for omap mux register offset and it's value
>>    * @reg_offset:	mux register offset from the mux base
>>    * @gpio:	GPIO number
>> + * @id:		Partition identifier
>>    * @muxnames:	available signal modes for a ball
>>    */
>>   struct omap_mux {
>> @@ -82,6 +114,7 @@ struct omap_mux {
>>   	char	*muxnames[OMAP_MUX_NR_MODES];
>>   #ifdef CONFIG_DEBUG_FS
>>   	char	*balls[OMAP_MUX_NR_SIDES];
>> +	struct omap_mux_partition *partition;
>>   #endif
>>   #endif
>>   };
>> @@ -89,6 +122,7 @@ struct omap_mux {
>>   /**
>>    * struct omap_ball - data for balls on omap package
>>    * @reg_offset:	mux register offset from the mux base
>> + * @id:		Partition identifier
>>    * @balls:	available balls on the package
>>    */
>>   struct omap_ball {
>> @@ -100,6 +134,7 @@ struct omap_ball {
>>    * struct omap_board_mux - data for initializing mux registers
>>    * @reg_offset:	mux register offset from the mux base
>>    * @mux_value:	desired mux value to set
>> + * @id:		Partition identifier
>>    */
>>   struct omap_board_mux {
>>   	u16	reg_offset;
>
> ..I think the above changes are no longer needed.

Oops yep, I forgot to remove the @id in the kerneldoc.
I was about to send the next revision, maybe I should wait a little bit 
more.

Thanks,
Benoit

