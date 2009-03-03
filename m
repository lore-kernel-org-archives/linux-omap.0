From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [UPDATE][PATCH 2/2][OMAPZOOM] DSPBRIDGE: Change address resources
	to void __iomem *Hi
Date: Tue, 3 Mar 2009 20:12:21 +0200
Message-ID: <94a0d4530903031012h5f034530y23140fdcbf0d49f7@mail.gmail.com>
References: <269694c00903020500g3eaa4466x281d07a1bb7e2b7a@mail.gmail.com>
	 <94a0d4530903020528w1e3f2d4bo56e80b572fc3e923@mail.gmail.com>
	 <20090303051524.GJ11864@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:59389 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbZCCSMZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 13:12:25 -0500
Received: by fxm24 with SMTP id 24so2555438fxm.37
        for <linux-omap@vger.kernel.org>; Tue, 03 Mar 2009 10:12:22 -0800 (PST)
In-Reply-To: <20090303051524.GJ11864@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ameya Palande <2ameya@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Mar 3, 2009 at 7:15 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Felipe Contreras <felipe.contreras@gmail.com> [090302 05:28]:
>> On Mon, Mar 2, 2009 at 3:00 PM, Ameya Palande <2ameya@gmail.com> wrote:
>> > I got following errors while applying this patch again the bridge patches
>> > accumulated at:
>> > http://gitorious.org/projects/tidspbridge2/repos/mainline/logs/tidspbridge
>>
>> Tony: What happened to the dspbridge branch? IIRC you mentioned you
>> created a branch in l-o.
>
> Sorry, my fault. At some point I stopped fetching from Hiroshi's repo as
> the fetch was always getting the whole pack. I still need to check that
> the unnecessary pack objects don't stay around in linux-omap tree after
> fetch. Hmm, maybe I'm running git prune and git repack -d -l before
> doing the fetch..
>
> Anyways, I've pushed the tidspbridge branch there manually now.

Thanks :)

-- 
Felipe Contreras
