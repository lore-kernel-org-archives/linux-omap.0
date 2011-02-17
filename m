From: Raghuveer Murthy <x0075817@ti.com>
Subject: Re: [3/4] OMAP: DSS2: Adding macro for DISPC_DIVISOR register
Date: Thu, 17 Feb 2011 12:47:54 +0530
Message-ID: <4D5CCBA2.80204@ti.com>
References: <1296742161-9395-4-git-send-email-raghuveer.murthy@ti.com> <1297870985.14556.14.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32939 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab1BQHRd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 02:17:33 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1H7HUqb032545
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 01:17:32 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1H7HSTD022576
	for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 12:47:29 +0530 (IST)
In-Reply-To: <1297870985.14556.14.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "Murthy, Raghuveer" <raghuveer.murthy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 16 February 2011 09:13 PM, Valkeinen, Tomi wrote:
> On Thu, 2011-02-03 at 14:09 +0000, Raghuveer Murthy wrote:
>> Added macro for DISPC_DIVISOR. This is different from DISPC_DIVISOR1 and
>> DISPC_DIVISOR2. OMAP4 supports all the above 3 registers.
>>
>> DISPC_DIVISOR1 and DISPC_DIVISOR2 registers are accessed through
>> DISPC_DIVISORo(ch) macro
>>
>> Signed-off-by: Raghuveer Murthy<raghuveer.murthy@ti.com>
>>
>> ---
>> drivers/video/omap2/dss/dispc.c |   11 +++++++++++
>>   1 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
>> index e52a413..6225d12 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -132,6 +132,17 @@ struct dispc_reg { u16 idx; };
>>
>>   #define DISPC_VID_PRELOAD(n)		DISPC_REG(0x230 + (n)*0x04)
>>
>> +/*
>> + * The OMAP4 DISPC_DIVISOR1 is backward compatible to OMAP3xxx DISPC_DIVISOR.
>> + * However DISPC_DIVISOR is also provided in OMAP4, to control DISPC_CORE_CLK.
>> + * This allows DISPC_CORE_CLK to be independent of logical clock dividers (lcd)
>> + * of LCD1 (primary) and LCD2 (secondary) displays.
>> + *
>> + * To derive pixel clocks for Primary and Secondary LCD channels, configure the
>> + * lcd and pcd in DISPC_DIVISOR1 and DISPC_DIVISOR2 respectively, using the
>> + * DISPC_DIVISORo(ch).
>> + */
>> +#define DISPC_DIVISOR			DISPC_REG(0x0804)
>>
>>   #define DISPC_IRQ_MASK_ERROR            (DISPC_IRQ_GFX_FIFO_UNDERFLOW | \
>>   					 DISPC_IRQ_OCP_ERR | \
>
> See my comment about comments in previous mail.
>
> I think you should merge this and the next patch. There's not much point
> in adding a single line define, which is not used (yet).
>
> How about the debug output from debug/omapdss/clk file? Does it print
> sensible things on OMAP4 after these patches?

Will verify this.
>
>   Tomi
>
>

Acknowledge the comments for patch 2/4 and 3/4. Will merge them and post 
a new series.

Regards,
Raghuveer
