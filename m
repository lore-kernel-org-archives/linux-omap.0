From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 0/2] OMAP3: wdtimer: Fix CORE idle
Date: Thu, 10 Mar 2011 15:48:46 -0800
Message-ID: <874o7afsf5.fsf@ti.com>
References: <1299759058-26342-1-git-send-email-kalle.jokiniemi@nokia.com>
	<20110310215503.GC1751@infomag.iguana.be>
	<alpine.DEB.2.00.1103101632580.19559@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:40862 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753849Ab1CJXsu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 18:48:50 -0500
In-Reply-To: <alpine.DEB.2.00.1103101632580.19559@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 10 Mar 2011 16:33:59 -0700 (MST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>, linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, jhnikula@gmail.com, ilkka.koskinen@nokia.com

Paul Walmsley <paul@pwsan.com> writes:

> Hi Wim, Kevin,
>
> On Thu, 10 Mar 2011, Wim Van Sebroeck wrote:
>
>> > These patches fix the issue where the wdtimer blocks CORE idle
>> > transitions on n900 (OMAP3). The root cause was that SMART idle
>> > mode in wdtimer did not allow the CORE idle transition to happen.
>> > 
>> > v2: updated commit message on patch 1/2, Cc'd Wim, and added
>> > comments to code about possible HW bug in wdtimer2.
>> > 
>> > Wim, please check patch number one and add your acked by.
>> > 
>> > I propose that we push these upstream via linux-omap-pm,
>> > as the patches deal with PM and need to be applied together
>> > to get the desired functionality.
>> > 
>> > Paul Walmsley (2):
>> >   Watchdog: omap_wdt: add fine grain runtime-pm
>> >   OMAP3: wdtimer: Fix CORE idle transition
>> > 
>> >  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 +
>> >  drivers/watchdog/omap_wdt.c                |   25 +++++++++++++++++++++++--
>> >  2 files changed, 24 insertions(+), 2 deletions(-)
>> 
>> Acked-by: Wim Van Sebroeck <wim@iguana.be>
>
> Thanks.
>  
>> linux-omap-pm is indeed the best tree for getting this upstream.
>
> Kevin, do you want to take the drivers/watchdog/omap_wdt.c patch?  The 
> first patch is queued in my branch currently.

Go ahead and merge with the first patch.

Acked-by: Kevin Hilman <khilman@ti.com>
