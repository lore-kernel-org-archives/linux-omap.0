From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP4 PM: To correct voltages in MPU OPP Table
Date: Thu, 06 Jan 2011 09:46:41 -0600
Message-ID: <4D25E3E1.70901@ti.com>
References: <1294295222-20035-1-git-send-email-shweta.gulati@ti.com> <4D25B3D2.4030802@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F62E@dbde02.ent.ti.com> <4D25D8B8.1020808@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F63A@dbde02.ent.ti.com> <4D25DD67.4030403@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F647@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:50635 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753388Ab1AFPqp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 10:46:45 -0500
Received: by gwb17 with SMTP id 17so8473016gwb.2
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 07:46:45 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F647@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "Gulati, Shweta" <shweta.gulati@ti.com>, l-o <linux-omap@vger.kernel.org>

Gopinath, Thara had written, on 01/06/2011 09:26 AM, the following:
> 
>>> -----Original Message-----
>>> From: Menon, Nishanth
>>> Sent: Thursday, January 06, 2011 8:49 PM
>>> To: Gopinath, Thara
>>> Cc: Gulati, Shweta; l-o
>>> Subject: Re: [PATCH] OMAP4 PM: To correct voltages in MPU OPP Table
>>>
>>> Gopinath, Thara had written, on 01/06/2011 09:09 AM, the following:
>>> [..]
>>>>>>> Actually no. The latest voltage layer pushed uses these voltages.
>>> Also
>>>>>> Arrgh... another reason to avoid messy duplicate tables!!
>>>> Oh there is a patch in my bag where we use a single macro for each
>>> voltage
>>>> across the voltage and opp layer!! Not yet posted because I am waiting
>>> for
>>>> voltage layer to be merged.
>>> I think I would find that patch interesting - Just fyi, the SR series is
>>> already in omap-for-linus branch and slated for .38-rc1, so feel free to
>>> post additional changes.
> 
> Yes I will post it.
> 
>>>>>>> We have been having this setting in the internal android code base
>>> for
>>>>>>> some time now without anybody having issues. So till the new voltages
>>>>>>> are conveyed officially, these remain the official voltage.
>>>>>> Funny,
>>>>>> how many versions of "internal" code bases are present?
>>>>>>
>>>>>> http://dev.omapzoom.org/?p=santosh/kernel-omap4-
>>>>>> base.git;a=blob;f=arch/arm/mach-
>>>>>> omap2/opp44xx_data.c;h=252e3d0cb6050a64f390b9311c1c4977d74f762a
>>>> What are you complaining about here? I thought Shweta's patch
>>>> was making the mpu entries in the opp table similar to the
>>>> ones in the link above. Anything I am missing?
>>> Yes, I am lost as to what the official voltage at PMIC level is for each
>>> OPP for OMAP4 is now :(! there are half a dozen trees out there - Ubuntu
>>> kernel, generic linux tree, android kernel tree etc - so the claim of
>>> one tree containing official table is kinda interesting as one wonders
>>> what one gets with other trees ;).
> 
> Are you sure all these tree do not have the same voltage values for mpu rail
> on OMAP4? Because as far as I am aware I am the one who has been writing this code and I have never used any other values. So then it is kind of
> interesting!

I take this back. Apologies, I missed your point and had been lazy to 
research earlier - looking at the code yet again,  I decided to look up 
official documentation :) and I finally get it - I was wrong to depend 
on some internal tree code base :(

Just FYI I looked at the public DM:
http://focus.ti.com/pdfs/wtbu/SWPS041B_FinalEPDF_12_22_2010.pdf
it pointed to the operating conditions Addendum which I only found in TI 
internal site (unfortunately).

As per this max voltages are (MPU domain)
300000000 - 976mV (nom 930mV)
600000000 - 1.155 (nom 1.1V)
800000000 - 1.323 (nom 1.26 which is coded in)
1008000000 - Nom is 1.35V (we have put that in)

Keep in mind that the voltage we put in the table is the PMIC voltage 
and the DM addendum states nominal voltage at OMAP ball level(you need 
to read (1) footnote to get the secret ;) ). What we need is to add 
additional voltage to provide at PMIC ball leve for typical board 
characteristics (this is pointed by the "Max voltage" in the addendum) 
and we allow SR to adjust to optimal voltage for that device on that board.

So the right table (if you are changing the values should be to switch 
to Max ones). I am ok on changing the voltages now that I have official 
documentation to back the change :).

-- 
Regards,
Nishanth Menon
