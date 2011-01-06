From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH] OMAP4 PM: To correct voltages in MPU OPP Table
Date: Thu, 6 Jan 2011 20:22:54 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F62E@dbde02.ent.ti.com>
References: <1294295222-20035-1-git-send-email-shweta.gulati@ti.com>
 <4D25B3D2.4030802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45787 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753079Ab1AFOxD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 09:53:03 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p06EqxjK027557
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 6 Jan 2011 08:53:02 -0600
In-Reply-To: <4D25B3D2.4030802@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>>-----Original Message-----
>>From: Menon, Nishanth
>>Sent: Thursday, January 06, 2011 5:52 PM
>>To: Gulati, Shweta
>>Cc: linux-omap@vger.kernel.org; Gopinath, Thara
>>Subject: Re: [PATCH] OMAP4 PM: To correct voltages in MPU OPP Table
>>
>>it is pretty unfortunate that I have to NAK this patch in the public ML
>>as well.
>>
>>shweta.gulati@ti.com wrote, on 01/06/2011 12:27 AM:
>>> From: Shweta Gulati<shweta.gulati@ti.com>
>>>
>>> There is a mismatch in voltages specified in OPP table of MPU
>>> and voltage specified in voltage table 'omap44xx_vdd_mpu_volt_data'
>>> This Patch corrects MPU OPP Table as
>>> well as enable OPP-Turbo and OPP-SB  for MPU by default.
>>>
>>> Signed-off-by: Thara Gopinath<thara@ti.com>
>>> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
>>> ---
>>> The patch is generated on top of Kevin's PM branch. It's needed for SR
>>> functionality on the current pm branch. Have tested SR with this patch
>>> with different OPP configurations from boot loader.
>>>
>>>   arch/arm/mach-omap2/opp4xxx_data.c |    8 ++++----
>>>   1 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-
>>omap2/opp4xxx_data.c
>>> index a11fa56..4f35361 100644
>>> --- a/arch/arm/mach-omap2/opp4xxx_data.c
>>> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
>>> @@ -25,13 +25,13 @@
>>>
>>>   static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
>>>   	/* MPU OPP1 - OPP50 */
>>> -	OPP_INITIALIZER("mpu", true, 300000000, 1100000),
>>> +	OPP_INITIALIZER("mpu", true, 300000000, 930000),
>>>   	/* MPU OPP2 - OPP100 */
>>> -	OPP_INITIALIZER("mpu", true, 600000000, 1200000),
>>> +	OPP_INITIALIZER("mpu", true, 600000000, 1100000),
>>
>>
>>Did we finalize on the nominal voltages yet?
>>
>>As of yesterday's discussion, we were still debating about the actual
>>voltage at OMAP ball level, while there is a secondary voltage called
>>cap voltage - we have been discussing on this for some time. I suggest
>>strongly that we dont touch this for the time being (the voltage in
>>mainline is slightly higher - let it be so till the h/w folks finalize
>>things).

Actually no. The latest voltage layer pushed uses these voltages. Also
We have been having this setting in the internal android code base for
some time now without anybody having issues. So till the new voltages
are conveyed officially, these remain the official voltage.

>>
>>>   	/* MPU OPP3 - OPP-Turbo */
>>> -	OPP_INITIALIZER("mpu", false, 800000000, 1260000),
>>> +	OPP_INITIALIZER("mpu", true, 800000000, 1260000),
>>I disagree.  This is not $subject. Also - not all boards will be capable
>>of supporting all higher frequencies rt? - remember the 3630 experience?
>>is'nt it wiser to enable it based on board capabilities - e.g. similar
>>to the patch I did for beagle XM yesterday - we wont be able to enable
>>higher frequencies on SDP3630 as we have not guarenteed with PDN
>>analysis that it is ok.
I am not sure about this for OMAP4. Have you come across a board
where these OPPs cannot be supported? We have been enabling these
OPPs internally now for quite some time across all OMAP4 boards.
But still if you guys are paranoid about boards breaking, I am ok
With keeping these OPPs disabled by default. But then anybody running
the mainline code with a 800Mhz or 1GHz x-loader, will see a couple
of warns in the kernel code.

Regards
Thara

>>
>>>   	/* MPU OPP4 - OPP-SB */
>>> -	OPP_INITIALIZER("mpu", false, 1008000000, 1350000),
>>> +	OPP_INITIALIZER("mpu", true, 1008000000, 1350000),
>>>   	/* L3 OPP1 - OPP50 */
>>>   	OPP_INITIALIZER("l3_main_1", true, 100000000, 930000),
>>>   	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
>>
>>
>>--
>>Regards,
>>Nishanth Menon
