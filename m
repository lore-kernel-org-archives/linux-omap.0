From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 8/8] OMAP3 PM: Support to enable disable OSWR feature from pm debug fs
Date: Mon, 25 Jan 2010 11:55:59 -0800
Message-ID: <87hbqa5580.fsf@deeprootsystems.com>
References: <1264001442-20078-1-git-send-email-thara@ti.com>
	<1264001442-20078-2-git-send-email-thara@ti.com>
	<1264001442-20078-3-git-send-email-thara@ti.com>
	<1264001442-20078-4-git-send-email-thara@ti.com>
	<1264001442-20078-5-git-send-email-thara@ti.com>
	<1264001442-20078-6-git-send-email-thara@ti.com>
	<1264001442-20078-7-git-send-email-thara@ti.com>
	<1264001442-20078-8-git-send-email-thara@ti.com>
	<1264001442-20078-9-git-send-email-thara@ti.com>
	<87y6jpy7ms.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB031E3F128A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f173.google.com ([209.85.223.173]:41722 "EHLO
	mail-iw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab0AYT4I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jan 2010 14:56:08 -0500
Received: by iwn3 with SMTP id 3so1221005iwn.19
        for <linux-omap@vger.kernel.org>; Mon, 25 Jan 2010 11:56:07 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E3F128A@dbde02.ent.ti.com> (Thara Gopinath's message of "Sun\, 24 Jan 2010 09\:42\:08 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Gopinath, Thara" <thara@ti.com> writes:

>>>-----Original Message-----
>>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>Sent: Saturday, January 23, 2010 6:12 AM
>>>To: Gopinath, Thara
>>>Cc: linux-omap@vger.kernel.org
>>>Subject: Re: [PATCH 8/8] OMAP3 PM: Support to enable disable OSWR feature from pm debug fs
>>>
>>>Thara Gopinath <thara@ti.com> writes:
>>>
>>>> This patch adds enable_oswr flag in pm debug fs to enable
>>>> disable OSWR feature.
>>>> To enable this feature:
>>>> 	echo 1 > <path>/debug/pm_debug/enable_oswr
>>>> To disable this feature
>>>> 	echo 0 > <path>/debug/pm_debug/enable_oswr
>>>>
>>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>>
>>>I don't like this approach since it leads to incorrect CPUidle statistics.
>>>
>>>Sanjeev has proposed a different approach[1] (which I still need to
>>>review/merge) which just invalidates particular CPUidle states and
>>>then lets the CPUidle enter hook only pick a valid state.
>>>
>>>This then will work for the enable_off_mode support and the enable_oswr support
>>>as well as anything else we can dream up down the road.
>
> Hi Kevin,
>
> Yes I agree with you.. I did not implement this for OSWR as I did
> not see it in you pm branch. I thought let the first set of patches
> for OSWR be merged in and then when we change enable_off_mode we can
> change enable_oswr also. Is there an issue with this?

I would rather merge Sanjeev's patch first.  I just reviewed it and
asked him for a few minor fixes and then I'd like to merge it.

Kevin
