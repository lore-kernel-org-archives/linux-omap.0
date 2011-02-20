From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 02/19] omap3630: hwmod: sr: enable for higher ES
Date: Sun, 20 Feb 2011 10:56:19 +0530
Message-ID: <4D60A5FB.8080901@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com> <1298116918-30744-3-git-send-email-nm@ti.com> <cfec809cd80216111287ec9509b30250@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:54461 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750904Ab1BTF0c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 20 Feb 2011 00:26:32 -0500
Received: by yxs7 with SMTP id 7so2463612yxs.24
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 21:26:31 -0800 (PST)
In-Reply-To: <cfec809cd80216111287ec9509b30250@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

Vishwanath Sripathy wrote, on 02/19/2011 06:52 PM:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Nishanth Menon
>> Sent: Saturday, February 19, 2011 5:32 PM
>> To: linux-omap
>> Cc: Tony Lindgren; Kevin Hilman; Nishanth Menon
>> Subject: [PATCH 02/19] omap3630: hwmod: sr: enable for higher ES
>>
>> Enable hwmod entries for OMAP3630 for higher ES revisions as
>> well. This is to ensure that SR can be used in all revisions of
>> OMAP3630 as of this posting.
>>
>> Signed-off-by: Nishanth Menon<nm@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++++++--
>>   1 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> index ea1f49a..bbcbea6 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> @@ -1318,7 +1318,9 @@ static struct omap_hwmod
>> omap36xx_sr1_hwmod = {
>>   	},
>>   	.slaves		= omap3_sr1_slaves,
>>   	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
>> -	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
>> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1	|
>> +					CHIP_IS_OMAP3630ES1_1	|
>> +					CHIP_IS_OMAP3630ES1_2),
> What's the need of this?
> Here is the code snippet from id.c
> -----snip-----
> 	case 0xb891:
> 		/* Handle 36xx devices */
> 		omap_chip.oc |= CHIP_IS_OMAP3630ES1;
>
> 		switch(rev) {
> 		case 0: /* Take care of early samples */
> 			omap_revision = OMAP3630_REV_ES1_0;
> 			break;
> 		case 1:
> 			omap_revision = OMAP3630_REV_ES1_1;
> 			omap_chip.oc |= CHIP_IS_OMAP3630ES1_1;
> 			break;
> 		case 2:
> 		default:
> 			omap_revision =  OMAP3630_REV_ES1_2;
> 			omap_chip.oc |= CHIP_IS_OMAP3630ES1_2;
> 		}
> So it's clear that omap_chip.oc will have CHIP_IS_OMAP3630ES1 anyway on
> all ES versions.

Hmm... thanks for picking this up, but this is inconsistent and 
confusing implementation in id.c. So the way CHIP_IS_OMAP3630ES1 behaves 
is entirely different from CHIP_IS_OMAP3630ES1_1 or 
CHIP_IS_OMAP3630ES1_2 or any of the OMAP3430ES* which will only be set 
for the specific rev of the silicon.

I can post a patch later on to replace CHIP_IS_OMAP3630ES1 with 
CHIP_IS_OMAP3630ES_ALL which allows the code to be readable and make 
CHIP_IS_OMAP3630ES1 mean precisely what it should have meant like the 
rest of the ESs - only for ES1.0.


What do people think of this?

-- 
Regards,
Nishanth Menon
