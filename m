From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP4 PM: To correct voltages in MPU OPP Table
Date: Thu, 06 Jan 2011 09:19:03 -0600
Message-ID: <4D25DD67.4030403@ti.com>
References: <1294295222-20035-1-git-send-email-shweta.gulati@ti.com> <4D25B3D2.4030802@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F62E@dbde02.ent.ti.com> <4D25D8B8.1020808@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F63A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:54002 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753001Ab1AFPTH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 10:19:07 -0500
Received: by mail-yx0-f176.google.com with SMTP id 8so6950684yxm.21
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 07:19:06 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F63A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "Gulati, Shweta" <shweta.gulati@ti.com>, l-o <linux-omap@vger.kernel.org>

Gopinath, Thara had written, on 01/06/2011 09:09 AM, the following:
[..]
>>>> Actually no. The latest voltage layer pushed uses these voltages. Also
>>> Arrgh... another reason to avoid messy duplicate tables!!
> 
> Oh there is a patch in my bag where we use a single macro for each voltage
> across the voltage and opp layer!! Not yet posted because I am waiting for
> voltage layer to be merged.

I think I would find that patch interesting - Just fyi, the SR series is 
already in omap-for-linus branch and slated for .38-rc1, so feel free to 
post additional changes.

>>>> We have been having this setting in the internal android code base for
>>>> some time now without anybody having issues. So till the new voltages
>>>> are conveyed officially, these remain the official voltage.
>>> Funny,
>>> how many versions of "internal" code bases are present?
>>>
>>> http://dev.omapzoom.org/?p=santosh/kernel-omap4-
>>> base.git;a=blob;f=arch/arm/mach-
>>> omap2/opp44xx_data.c;h=252e3d0cb6050a64f390b9311c1c4977d74f762a
> 
> What are you complaining about here? I thought Shweta's patch
> was making the mpu entries in the opp table similar to the
> ones in the link above. Anything I am missing?

Yes, I am lost as to what the official voltage at PMIC level is for each 
OPP for OMAP4 is now :(! there are half a dozen trees out there - Ubuntu 
kernel, generic linux tree, android kernel tree etc - so the claim of 
one tree containing official table is kinda interesting as one wonders 
what one gets with other trees ;).

>>>>>>>   	/* MPU OPP3 - OPP-Turbo */
>>>>>>> -	OPP_INITIALIZER("mpu", false, 800000000, 1260000),
>>>>>>> +	OPP_INITIALIZER("mpu", true, 800000000, 1260000),
>>>>>> I disagree.  This is not $subject. Also - not all boards will be
>>> capable
>>>>>> of supporting all higher frequencies rt? - remember the 3630
>>> experience?
>>>>>> is'nt it wiser to enable it based on board capabilities - e.g. similar
>>>>>> to the patch I did for beagle XM yesterday - we wont be able to enable
>>>>>> higher frequencies on SDP3630 as we have not guarenteed with PDN
>>>>>> analysis that it is ok.
>>>> I am not sure about this for OMAP4. Have you come across a board
>>>> where these OPPs cannot be supported? We have been enabling these
>>>> OPPs internally now for quite some time across all OMAP4 boards.
>>> *all* as in how many? SDP/Blaze, Panda and....??? How many boards are
>>> available which is in production?
> 
> All as in SDP, Blaze and Panda, today by default we boot up at 1 Ghz.
> I have not heard of anybody asking to lower the frequencies. If you are
> talking about any customer board, I am not the person to comment.
> 
Right, so lets keep it disabled for the moment as it does not even match 
$subject and violates the concept of a single patch doing a single thing 
- enabling higher frequencies at this point of time is premature IMHO.

-- 
Regards,
Nishanth Menon
