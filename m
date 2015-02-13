From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 01/23] ARM: OMAP2+: clock: move clock provider infrastructure
 to clock driver
Date: Fri, 13 Feb 2015 17:06:52 +0200
Message-ID: <54DE130C.2080808@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com> <1417103514-17027-2-git-send-email-t-kristo@ti.com> <alpine.DEB.2.02.1501242142181.5450@utopia.booyaka.com> <54C61938.8000303@ti.com> <20150126154936.GC28663@atomide.com> <54C777CE.1070900@ti.com> <20150127165016.GJ28663@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40003 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbbBMPHQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2015 10:07:16 -0500
In-Reply-To: <20150127165016.GJ28663@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, nm@ti.com, linux-arm-kernel@lists.infradead.org

On 01/27/2015 06:50 PM, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [150127 03:37]:
>> On 26/01/15 17:49, Tony Lindgren wrote:
>>
>>>> I'm not sure if I miss something, but regmap_write does not protect from
>>>> problems if there are multiple users for the same registers. You need to
>>>> use regmap_update_bits() to get a protected read/write sequence, in
>>>> which you can change only the bits that you want to change.
>>>
>>> To me it seems that issue can be fixed by making all the code use regmap.
>>> AFAIK that should work for the legacy code too.
>>
>> Even if everybody uses regmap, doing
>>
>> v = regmap_read()
>> modify v
>> regmap_write(v)
>>
>> is racy. regmap_update_bits() has to be used to protect the read/write
>> sequence. Which may be somewhat challenging at times with some strange
>> registers, the like Roger Q encountered recently related to CAN.
>
> Yeah that's a good point.
>
> Regards,
>
> Tony
>

I have a v2 of this series ready now, which also moves control module 
completely to use syscon for register accesses. The move to regmap is 
done at later point though, not in this patch as Paul proposed, as the 
changes to the rest of the series were not posted.

The race handling needs to be done on driver level to use 
regmap_update_bits, my take on this is that we can post separate patches 
against the individual drivers, once the regmap/syscon conversion has 
been done. Mostly, the drivers do not touch same register anyway, so 
getting any conflicts should be pretty rare. Moreover, this set does not 
do anything for this anyway, if there are currently races with some 
users of control module, these will be there still.

-Tero
