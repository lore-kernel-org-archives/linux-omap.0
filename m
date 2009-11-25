From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [ANNOUNCE] PM branch updated to v2.6.32-rc8
Date: Wed, 25 Nov 2009 06:20:36 -0800
Message-ID: <87pr76n0sr.fsf@deeprootsystems.com>
References: <87638zvj24.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402543D7FBE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:47350 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934665AbZKYOUb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 09:20:31 -0500
Received: by pwi3 with SMTP id 3so4898449pwi.21
        for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2009 06:20:38 -0800 (PST)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402543D7FBE@dbde02.ent.ti.com> (Manjunath Kondaiah G.'s message of "Wed\, 25 Nov 2009 15\:04\:19 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> Hi Kevin,
> I see multiple commits for some of the patches with 2.6.32-rc8 latest code.
>
> Ex:
> #>gl | grep -i "Introduce zoom3 board support"
> 5f35fbe  omap3: zoom: Introduce zoom3 board support (3 days ago)
> 163cde1  omap3: zoom: Introduce zoom3 board support (7 days ago)
> 084bb37  omap: zoom3: introduce zoom3 board support (11 days ago)
> 3af1083  omap: zoom3: introduce zoom3 board support (11 days ago)
> 13ac7e7  omap: zoom3: introduce zoom3 board support (12 days ago)
> 9de2968  omap: zoom3: introduce zoom3 board support (13 days ago)
> #>
>
> There are some more patches like above.
>
> Is there any specific reason for having multiple commits?

First, these commits are not from the PM branch, but from l-o master
branch.

That being said, the reason for the multiple commits is because of the
new way Tony (re)builds the master branch from is various queues.

I suggest you look at l-o master using a tool like gitk so you can see
the various merge points.

Kevin

>
> -Manjunath 
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> Sent: Wednesday, November 25, 2009 12:37 AM
>> To: linux-omap@vger.kernel.org
>> Subject: [ANNOUNCE] PM branch updated to v2.6.32-rc8
>> 
>> FYI...
>> 
>> PM branch was rebased to today's linux-omap master branch (currently
>> v2.6.32-rc8)
>> 
>> As usual, the PM wiki[1] has all the details on using the PM 
>> branch as well
>> as some known issues.
>> 
>> Also note that starting with the official v2.6.32 release, I 
>> will be moving
>> from a continual rebase model to a "re-branch & rebuild" model similar
>> to how Tony is now managing l-o master.
>> 
>> Kevin
>> 
>> [1] http://elinux.org/OMAP_Power_Management
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
