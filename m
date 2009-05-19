From: <Tero.Kristo@nokia.com>
Subject: RE: Smart Reflex pm patches causes a kernel panic
Date: Tue, 19 May 2009 14:20:50 +0200
Message-ID: <1F18D6510CF0474A8C9500565A7E41A20545136A1B@NOK-EUMSG-02.mgdnok.nokia.com>
References: <95B5E119-3C65-4739-A8BA-B66486850DD4@mac.com>
 <1F18D6510CF0474A8C9500565A7E41A205451369C0@NOK-EUMSG-02.mgdnok.nokia.com>
 <C9DC074E-8B56-4ED1-A74E-94664F325A31@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:44704 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbZESMVL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 08:21:11 -0400
In-Reply-To: <C9DC074E-8B56-4ED1-A74E-94664F325A31@mac.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: elvis.dowson@mac.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Elvis Dowson [mailto:elvis.dowson@mac.com] 
>Sent: 19 May, 2009 14:49
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: Linux OMAP Users
>Subject: Re: Smart Reflex pm patches causes a kernel panic
>
>Hi Tero,
>		Thanks for the reply. I'll try this out. I 
>don't think mpu_opps is defined for my board_overo.c file. I 
>guess I should look at the board_sdp3430.c as an example for this?

Yes, take a look at it. You are basically missing some parameters in a call to omap2_init_common_hw(), at least the version I am looking at here has a few NULL pointers passed. The rate tables (mpu + l3) should be posted as parameters in that.

-Tero

>
>Thanks and do let me know!
>
>Best regards,
>
>Elvis
>
>
>On May 19, 2009, at 3:41 PM, Tero.Kristo@nokia.com wrote:
>
>> Hi Elvis,
>>
>> I think I saw something similar last week, and it was caused by not 
>> having CONFIG_OMAP_PM_SRF enabled. The actual culprit is the marked 
>> line in sr_configure_vp():
>>
>>                vpconfig = PRM_VP1_CONFIG_ERROROFFSET |
>>                        PRM_VP1_CONFIG_ERRORGAIN |
>>                        PRM_VP1_CONFIG_TIMEOUTEN |
>>>>>                        
>>>>> mpu_opps[resource_get_level("vdd1_opp")].vsel <<
>>                        OMAP3430_INITVOLTAGE_SHIFT;
>>
>> SR2 has similar code a bit later.
>>
>> You will also get a failure if mpu_opps[] and/or l3_opps[] is not 
>> defined at all in your board files, this null pointer 
>exception would 
>> actually indicate a problem like that more likely.
>
>