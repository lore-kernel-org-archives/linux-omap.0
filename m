From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH] OMAP4 PM: To correct voltages in MPU OPP Table
Date: Thu, 6 Jan 2011 20:56:20 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F647@dbde02.ent.ti.com>
References: <1294295222-20035-1-git-send-email-shweta.gulati@ti.com>
 <4D25B3D2.4030802@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F62E@dbde02.ent.ti.com>
 <4D25D8B8.1020808@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F63A@dbde02.ent.ti.com>
 <4D25DD67.4030403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46004 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab1AFP02 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 10:26:28 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p06FQPqG030175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 6 Jan 2011 09:26:27 -0600
In-Reply-To: <4D25DD67.4030403@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Gulati, Shweta" <shweta.gulati@ti.com>, l-o <linux-omap@vger.kernel.org>



>>-----Original Message-----
>>From: Menon, Nishanth
>>Sent: Thursday, January 06, 2011 8:49 PM
>>To: Gopinath, Thara
>>Cc: Gulati, Shweta; l-o
>>Subject: Re: [PATCH] OMAP4 PM: To correct voltages in MPU OPP Table
>>
>>Gopinath, Thara had written, on 01/06/2011 09:09 AM, the following:
>>[..]
>>>>>> Actually no. The latest voltage layer pushed uses these voltages.
>>Also
>>>>> Arrgh... another reason to avoid messy duplicate tables!!
>>>
>>> Oh there is a patch in my bag where we use a single macro for each
>>voltage
>>> across the voltage and opp layer!! Not yet posted because I am waiting
>>for
>>> voltage layer to be merged.
>>
>>I think I would find that patch interesting - Just fyi, the SR series is
>>already in omap-for-linus branch and slated for .38-rc1, so feel free to
>>post additional changes.

Yes I will post it.

>>
>>>>>> We have been having this setting in the internal android code base
>>for
>>>>>> some time now without anybody having issues. So till the new voltages
>>>>>> are conveyed officially, these remain the official voltage.
>>>>> Funny,
>>>>> how many versions of "internal" code bases are present?
>>>>>
>>>>> http://dev.omapzoom.org/?p=santosh/kernel-omap4-
>>>>> base.git;a=blob;f=arch/arm/mach-
>>>>> omap2/opp44xx_data.c;h=252e3d0cb6050a64f390b9311c1c4977d74f762a
>>>
>>> What are you complaining about here? I thought Shweta's patch
>>> was making the mpu entries in the opp table similar to the
>>> ones in the link above. Anything I am missing?
>>
>>Yes, I am lost as to what the official voltage at PMIC level is for each
>>OPP for OMAP4 is now :(! there are half a dozen trees out there - Ubuntu
>>kernel, generic linux tree, android kernel tree etc - so the claim of
>>one tree containing official table is kinda interesting as one wonders
>>what one gets with other trees ;).

Are you sure all these tree do not have the same voltage values for mpu rail
on OMAP4? Because as far as I am aware I am the one who has been writing this code and I have never used any other values. So then it is kind of
interesting!

>>
>>>>>>>>>   	/* MPU OPP3 - OPP-Turbo */
>>>>>>>>> -	OPP_INITIALIZER("mpu", false, 800000000, 1260000),
>>>>>>>>> +	OPP_INITIALIZER("mpu", true, 800000000, 1260000),
>>>>>>>> I disagree.  This is not $subject. Also - not all boards will be
>>>>> capable
>>>>>>>> of supporting all higher frequencies rt? - remember the 3630
>>>>> experience?
>>>>>>>> is'nt it wiser to enable it based on board capabilities - e.g.
>>similar
>>>>>>>> to the patch I did for beagle XM yesterday - we wont be able to
>>enable
>>>>>>>> higher frequencies on SDP3630 as we have not guarenteed with PDN
>>>>>>>> analysis that it is ok.
>>>>>> I am not sure about this for OMAP4. Have you come across a board
>>>>>> where these OPPs cannot be supported? We have been enabling these
>>>>>> OPPs internally now for quite some time across all OMAP4 boards.
>>>>> *all* as in how many? SDP/Blaze, Panda and....??? How many boards are
>>>>> available which is in production?
>>>
>>> All as in SDP, Blaze and Panda, today by default we boot up at 1 Ghz.
>>> I have not heard of anybody asking to lower the frequencies. If you are
>>> talking about any customer board, I am not the person to comment.
>>>
>>Right, so lets keep it disabled for the moment as it does not even match
>>$subject and violates the concept of a single patch doing a single thing
>>- enabling higher frequencies at this point of time is premature IMHO.

Ah! I am not debating the subject vs content issue here at all! You are
very much in the right regarding that. All I am asking is is there a
genuine issue in enabling the higher OPP's for mpu on OMAP4 today.

Regards
Thara
