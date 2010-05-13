From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 1/2] DSS2: Allow FB_OMAP2 to build without VRFB
Date: Thu, 13 May 2010 11:15:09 -0500
Message-ID: <4BEC258D.7030104@ti.com>
References: <1273764028-25822-1-git-send-email-svadivu@ti.com> <1273764028-25822-2-git-send-email-svadivu@ti.com> <EBB422FB-C763-4EBE-AAD3-02AE86D4FF05@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48532 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759223Ab0EMQPQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 May 2010 12:15:16 -0400
In-Reply-To: <EBB422FB-C763-4EBE-AAD3-02AE86D4FF05@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Koen Kooi had written, on 05/13/2010 11:00 AM, the following:
> Op 13 mei 2010, om 17:20 heeft Senthilvadivu Guruswamy het volgende geschreven:
> 
>> FB_OMAP2 can work without VRFB, but currently does not build. Fix this.
>>
>> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
>> ---
>> arch/arm/plat-omap/include/plat/vrfb.h |   16 ++++++++++++++++
>> 1 file changed, 16 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/vrfb.h b/arch/arm/plat-omap/include/plat/vrfb.h
>> index d8a03ce..3792bde 100644
>> --- a/arch/arm/plat-omap/include/plat/vrfb.h
>> +++ b/arch/arm/plat-omap/include/plat/vrfb.h
>> @@ -35,6 +35,7 @@ struct vrfb {
>> 	bool yuv_mode;
>> };
>>
>> +#ifdef CONFIG_OMAP2_VRFB
> 
> That is still a compiletime option, not a runtime check. You need something like if(is_omap3()), not #ifdef 
> 
having VRFB or tiler is a SOC feature - ideal detection should be in 
id.c using the FEATURES framework.

and the actual rotation handling should be handled with function 
pointers to use VRFB apis OR use tiler APIs (once it is available) to 
runtime use the right rotation/other features functions runtime..

-- 
Regards,
Nishanth Menon
