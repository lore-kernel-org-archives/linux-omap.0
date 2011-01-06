From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP4 PM: To correct voltages in MPU OPP Table
Date: Thu, 06 Jan 2011 08:59:04 -0600
Message-ID: <4D25D8B8.1020808@ti.com>
References: <1294295222-20035-1-git-send-email-shweta.gulati@ti.com> <4D25B3D2.4030802@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F62E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:55277 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752785Ab1AFO7K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 09:59:10 -0500
Received: by gya6 with SMTP id 6so6812520gya.11
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 06:59:09 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F62E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "Gulati, Shweta" <shweta.gulati@ti.com>, l-o <linux-omap@vger.kernel.org>

Gopinath, Thara had written, on 01/06/2011 08:52 AM, the following:
> 
>>> -----Original Message-----
>>> From: Menon, Nishanth
>>> Sent: Thursday, January 06, 2011 5:52 PM
>>> To: Gulati, Shweta
>>> Cc: linux-omap@vger.kernel.org; Gopinath, Thara
>>> Subject: Re: [PATCH] OMAP4 PM: To correct voltages in MPU OPP Table
>>>
>>> it is pretty unfortunate that I have to NAK this patch in the public ML
>>> as well.
>>>
>>> shweta.gulati@ti.com wrote, on 01/06/2011 12:27 AM:
>>>> From: Shweta Gulati<shweta.gulati@ti.com>
>>>>
>>>> There is a mismatch in voltages specified in OPP table of MPU
>>>> and voltage specified in voltage table 'omap44xx_vdd_mpu_volt_data'
>>>> This Patch corrects MPU OPP Table as
>>>> well as enable OPP-Turbo and OPP-SB  for MPU by default.
>>>>
>>>> Signed-off-by: Thara Gopinath<thara@ti.com>
>>>> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
>>>> ---
>>>> The patch is generated on top of Kevin's PM branch. It's needed for SR
>>>> functionality on the current pm branch. Have tested SR with this patch
>>>> with different OPP configurations from boot loader.
>>>>
>>>>   arch/arm/mach-omap2/opp4xxx_data.c |    8 ++++----
>>>>   1 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-
>>> omap2/opp4xxx_data.c
>>>> index a11fa56..4f35361 100644
>>>> --- a/arch/arm/mach-omap2/opp4xxx_data.c
>>>> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
>>>> @@ -25,13 +25,13 @@
>>>>
>>>>   static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
>>>>   	/* MPU OPP1 - OPP50 */
>>>> -	OPP_INITIALIZER("mpu", true, 300000000, 1100000),
>>>> +	OPP_INITIALIZER("mpu", true, 300000000, 930000),
>>>>   	/* MPU OPP2 - OPP100 */
>>>> -	OPP_INITIALIZER("mpu", true, 600000000, 1200000),
>>>> +	OPP_INITIALIZER("mpu", true, 600000000, 1100000),
>>>
>>> Did we finalize on the nominal voltages yet?
>>>
>>> As of yesterday's discussion, we were still debating about the actual
>>> voltage at OMAP ball level, while there is a secondary voltage called
>>> cap voltage - we have been discussing on this for some time. I suggest
>>> strongly that we dont touch this for the time being (the voltage in
>>> mainline is slightly higher - let it be so till the h/w folks finalize
>>> things).
> 
> Actually no. The latest voltage layer pushed uses these voltages. Also
Arrgh... another reason to avoid messy duplicate tables!!
> We have been having this setting in the internal android code base for
> some time now without anybody having issues. So till the new voltages
> are conveyed officially, these remain the official voltage.
Funny,
how many versions of "internal" code bases are present?

http://dev.omapzoom.org/?p=santosh/kernel-omap4-base.git;a=blob;f=arch/arm/mach-omap2/opp44xx_data.c;h=252e3d0cb6050a64f390b9311c1c4977d74f762a


> 
>>>>   	/* MPU OPP3 - OPP-Turbo */
>>>> -	OPP_INITIALIZER("mpu", false, 800000000, 1260000),
>>>> +	OPP_INITIALIZER("mpu", true, 800000000, 1260000),
>>> I disagree.  This is not $subject. Also - not all boards will be capable
>>> of supporting all higher frequencies rt? - remember the 3630 experience?
>>> is'nt it wiser to enable it based on board capabilities - e.g. similar
>>> to the patch I did for beagle XM yesterday - we wont be able to enable
>>> higher frequencies on SDP3630 as we have not guarenteed with PDN
>>> analysis that it is ok.
> I am not sure about this for OMAP4. Have you come across a board
> where these OPPs cannot be supported? We have been enabling these
> OPPs internally now for quite some time across all OMAP4 boards.
*all* as in how many? SDP/Blaze, Panda and....??? How many boards are 
available which is in production?

> But still if you guys are paranoid about boards breaking, I am ok
> With keeping these OPPs disabled by default. But then anybody running
> the mainline code with a 800Mhz or 1GHz x-loader, will see a couple
> of warns in the kernel code.
You do have the option of enabling the frequency for specific boards 
like SDP/Blaze (e.g. if you have h/w team's signoff that these can do 
high frequencies - and I think they do).

-- 
Regards,
Nishanth Menon
