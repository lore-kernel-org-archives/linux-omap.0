From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP3: PM: Adding T2 enabling of smartreflex
Date: Wed, 05 Jan 2011 09:15:32 -0800
Message-ID: <87zkrfz2yz.fsf@ti.com>
References: <1293782878-9756-1-git-send-email-thara@ti.com>
	<87ipy45lr3.fsf@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0373D2F0E6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:60503 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751796Ab1AERPq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 12:15:46 -0500
Received: by mail-yx0-f178.google.com with SMTP id 42so6492112yxe.9
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 09:15:45 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F0E6@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Wed, 5 Jan 2011 16:21:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Menon, Nishanth" <nm@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

>>>-----Original Message-----
>>>From: Hilman, Kevin
>>>Sent: Wednesday, January 05, 2011 4:18 AM
>>>To: Gopinath, Thara
>>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>>Vishwanath; Sawant, Anand; Menon, Nishanth
>>>Subject: Re: [PATCH] OMAP3: PM: Adding T2 enabling of smartreflex
>>>
>>>Thara Gopinath <thara@ti.com> writes:
>>>
>>>> The smartreflex bit on twl4030 needs to be enabled by default
>>>irrespective
>>>> of whether smartreflex module is enabled on the OMAP side or not.
>>>> This is because without this bit enabled the voltage scaling through
>>>> vp forceupdate does not function properly on OMAP3.
>>>
>>>Based on Nishanth's comments, the abofe statements need a little more
>>>justification.
>>>
>>>What is probably needed is some default setting (possibly this one) but
>>>with the possibility of board code to disable this if needed.
>
> Yes. If we need to support the other means of voltage scaling, we
> definitely need to override this bit from board files. I am not so
> convinced that we need to support them though. IMHO, this patch can
> still go in with change in the comment and if needed, there can be
> another patch with an API in omap_twl.c allowing overriding/
> enabling-disabling of sr - i2c bit on the T2 side.

I'm OK with this.

Kevin



