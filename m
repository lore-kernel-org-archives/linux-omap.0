From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 00/17] OMAP3: PM: Smartreflex and voltage revamp.
Date: Mon, 22 Mar 2010 17:50:08 +0100
Message-ID: <87y6hkjo73.fsf@deeprootsystems.com>
References: <1268903755-4151-1-git-send-email-thara@ti.com>
	<4BA27BCC.60404@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03220FBFA5@dbde02.ent.ti.com>
	<4BA78F95.8020700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42812 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab0CVQuO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 12:50:14 -0400
Received: by pva4 with SMTP id 4so2715489pva.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Mar 2010 09:50:13 -0700 (PDT)
In-Reply-To: <4BA78F95.8020700@ti.com> (Nishanth Menon's message of "Mon\, 22 Mar 2010 10\:41\:09 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

Nishanth Menon <nm@ti.com> writes:

> Gopinath, Thara had written, on 03/22/2010 09:39 AM, the following:
>>
>>>>
>>>> Gopinath, Thara had written, on 03/18/2010 04:15 AM, the following:
>>>> [..]
>>>>
>>>>> This patch series is based on Kevin's PM tree origin/pm-wip-opp branch
>>>>> and is dependent on the following patches not yet applied onto this branch.
>>>>>
>>>>> 	http://patchwork.kernel.org/patch/81504/
>>>>> 	http://patchwork.kernel.org/patch/81606/
>>>> The 2nd patch does not seem to apply anymore
>>>>
>>>> see [1] - no more sysc_flags as it was queued to .34-rcX?
>>
>> I do not understand this.. Second patch seems to apply for me on wip-opp branch off Kevin's tree
> did you check the link i posted below? this is from pm-wip-opp branch
> and it does not seem to have the sysc_flags in it.. 

I think you're looking at an old pm-wip-opp branch.  The 2nd patch
applies to current pm-wip-opp (albiet with some fuzz)

Kevin
