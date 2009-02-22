From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: SDIO broken in 2.6.29?
Date: Sat, 21 Feb 2009 22:04:53 -0800
Message-ID: <5e088bd90902212204y6d7bbfdi8c6ba251fbf852bd@mail.gmail.com>
References: <5e088bd90902192235n4104d8b1r80bfa6ff2be927d6@mail.gmail.com>
	 <20090220154910.GJ7414@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:34720 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbZBVGEz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Feb 2009 01:04:55 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2307776fgg.17
        for <linux-omap@vger.kernel.org>; Sat, 21 Feb 2009 22:04:53 -0800 (PST)
In-Reply-To: <20090220154910.GJ7414@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Feb 20, 2009 at 7:49 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Steve Sakoman <sakoman@gmail.com> [090219 22:38]:
>> Overo has a wifi chip on mmc2 that uses the libertas_sdio driver.
>> I've had my head down working in other areas and failed to noticed
>> that at some point in the 2.6.29 rc cycle SDIO stopped working.
>>
>> I'll start bisecting tomorrow morning, but thought I would ask first
>> to see if anyone else has noticed issues in this area.
>
> I wonder if it happened when we switched to the mainline version of
> omap_hsmmc.c?
>
> Anyways at least now most of the code is in the mainline :) So
> hopefully we can get that fix in too during the -rc cycle.

I've tried to reproduce Dave's reported success with recent kernels,
but have been unable to do so.

I haven't narrowed it down to a specific commit yet, but have verified
that the problem surfaces for me at the rc2 -> rc3 transition.

This is suspiciously near the time of the switch to the mainline
version of omap_hsmmc.c . . .

I'll keep digging.

Steve
