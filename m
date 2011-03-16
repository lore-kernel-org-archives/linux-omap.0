From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC][PATCH 0/3] OMAP PM: Voltage layer clean up
Date: Wed, 16 Mar 2011 06:48:35 +0530
Message-ID: <4D800FEB.9010809@ti.com>
References: <1300199622-32500-1-git-send-email-vishwanath.bs@ti.com> <AANLkTinO0XWcDO18Kv-pVL=QUTq2X5ffF5XRLw6_POOQ@mail.gmail.com> <704e43df1ea426a676115cd34b93649e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:52056 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750981Ab1CPBSn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Mar 2011 21:18:43 -0400
Received: by mail-vx0-f172.google.com with SMTP id 33so1640250vxg.17
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 18:18:42 -0700 (PDT)
In-Reply-To: <704e43df1ea426a676115cd34b93649e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

Vishwanath Sripathy wrote, on 03/15/2011 09:36 PM:
>> -----Original Message-----
>> From: Menon, Nishanth [mailto:nm@ti.com]
>> Sent: Tuesday, March 15, 2011 8:38 PM
>> To: Vishwanath BS
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [RFC][PATCH 0/3] OMAP PM: Voltage layer clean up
>>
>> On Tue, Mar 15, 2011 at 20:03, Vishwanath BS
>> <vishwanath.bs@ti.com>  wrote:
>>>
>>> This patch series attempts to do some more clean up on OMAP Voltage
>> layer on top
>>> of the clean up done by Paul as part of
>>> https://patchwork.kernel.org/patch/591421/
>>>
>>> These patches are generated against latest omap-for-linus branch on
>> Tony's tree
>>> (commit id: 05f689400ea5fa3d71af82f910c8b140f87ad1f3) and tested
>> on OMAP ZOOM3
>>> and OMAP4430 SDP with Smartreflex enabled.
>>>
>>> Vishwanath BS (3):
>>>   OMAP PM: Seggregate Voltage layer parameters
>>>   OMAP PM: Add support for bypassing VP/VC in Voltage layer
>>>   OMAP PM: Add Board specific parameters for OMAP Volatge layer
>>
>> I dont really see why I need to keep fixing your $subjects, but here
>> again,
>> all $subjects, OMAP3+: PM: makes more sense
> This is not OMAP3 specific. It applies to OMAP4 as well.
which is why i recommended OMAP3+ and not OMAP3

>>
>>>
>>>   arch/arm/mach-omap2/board-4430sdp.c           |   52 +++++++
>>
>> Curious if Panda and other OMAP3 platforms where considered.
> That's TODO as per my Patch3 commit log.
would've been nice to see that info in 0/3

[..]
-- 
Regards,
Nishanth Menon
