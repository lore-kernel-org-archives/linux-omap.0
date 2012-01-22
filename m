From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: I2C: fix compilation when !CONFIG_OF
Date: Sun, 22 Jan 2012 17:59:22 +0100
Message-ID: <4F1C406A.6040503@ti.com>
References: <20120122105942.6508.82335.stgit@dusk> <20120122110232.6508.68451.stgit@dusk> <20120122154544.GW4223@ponder.secretlab.ca> <4F1C3412.4070106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55986 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961Ab2AVQ7d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Jan 2012 11:59:33 -0500
In-Reply-To: <4F1C3412.4070106@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>

On 1/22/2012 5:06 PM, Rob Herring wrote:
> On 01/22/2012 09:45 AM, Grant Likely wrote:
>> On Sun, Jan 22, 2012 at 04:02:33AM -0700, Paul Walmsley wrote:
>>> Commit 6145197be6cc0583fa1a2f4ec1079d366137061e ("i2c: OMAP: Add DT
>>> support for i2c controller") breaks compilation when CONFIG_OF is not
>>> defined:
>>>
>>>    CC      drivers/i2c/busses/i2c-omap.o
>>> drivers/i2c/busses/i2c-omap.c: In function 'omap_i2c_probe':
>>> drivers/i2c/busses/i2c-omap.c:1021:26: error: 'omap_i2c_of_match' undeclared (first use in this function)
>>> drivers/i2c/busses/i2c-omap.c:1021:26: note: each undeclared identifier is reported only once for each function it appears in
>>>
>>> Fix this by avoiding of_*() functions when !CONFIG_OF.
>>
>> To avoid #ifdef blocks, how about one of these fixes instead?
>> of_match_device resolves to a static inline NULL when CONFIG_OF is not
>> selected.
>>
>> g.
>>
>> ---
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index f713eac..c22e51f 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -979,6 +979,8 @@ static const struct of_device_id omap_i2c_of_match[] = {
>>   	{ },
>>   };
>>   MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
>> +#else
>> +#define omap_i2c_of_match NULL
>>   #endif
>
> Or just remove the existing ifdef. Isn't OMAP going to be completely
> converted to DT?
>
> I think building CONFIG_OF and !CONFIG_OF and running non-DT machines
> with OF enabled is going to be a constant source of breakage. We should
> move selecting CONFIG_OF up from boards/SOC config to family config
> (i.e. all OMAP).

Yep, I do agree, and even sent a patch for that.

http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-December/010541.html

But it looks like it was stuck in linux-omap dt branch and not pulled 
for 3.3. Maybe Tony can try to sent it during -rc phase.

That being said, this will be valid for OMAP2+ only and will still break 
OMAP1 platform :-(

Tony reported that 2 days ago, and I sent the fix for it.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg61520.html

It is now waiting for Ben's Acked-by.

Regards,
Benoit

