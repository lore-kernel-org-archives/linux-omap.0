From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2] adding back some features
Date: Mon, 15 Jun 2009 07:55:30 -0700
Message-ID: <87ski1a6n1.fsf@deeprootsystems.com>
References: <1244844693-24126-1-git-send-email-khilman@ti.deeprootsystems.com>
	<20090615080001.GC4474@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f187.google.com ([209.85.222.187]:57405 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbZFOOzb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 10:55:31 -0400
Received: by pzk17 with SMTP id 17so1996236pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 15 Jun 2009 07:55:34 -0700 (PDT)
In-Reply-To: <20090615080001.GC4474@atomide.com> (Tony Lindgren's message of "Mon\, 15 Jun 2009 01\:00\:02 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> Hi,
>
> * Kevin Hilman <khilman@deeprootsystems.com> [090612 15:13]:
>> Here's a couple patches to add-back some feature dropped in the
>> mainline sync.  These are needed for the PM branch among other things.
>> 
>> Applies to linux-omap master.
>> 
>> Kevin
>> 
>> Kalle Jokiniemi (1): OMAP3: DMA: Enable idlemodes for DMA OCP
>
> This we could justify getting into mainline as a fix, as otherwise
> some PM features won't work. Will add into omap-fixes.

Thanks.

>> Kevin Hilman (1):
>>   OMAP2/3: SoC IDs: add omap_type() for determining GP/EMU/HS
>
> Is there any reason to get this one into mainline early?

Well, the PM branch has a dependency, but also the recenetly submitted
qwatchdog driver has a dependency.

> If not, I suggest you keep this in your pm branch for next merge
> window that I can keep merging to l-o master as needed.
>
> However, if omap_type() is by other queues earlier, then I can
> add it into my upstream queue. If this blocks several queues
> from being rebased against mainline kernel, that alone might
> already be a good enough reason to get it in early.

I think it should go via your upstream queue.  I imagine some of the
other upcoming driver submissions from TI will have a dependency as
well since there is still some missing EMU/HS support ind drivers.

Kevin

>
> Regards,
>
> Tony
>
>  
>>  arch/arm/mach-omap2/id.c              |   22 ++++++++++++++++++++++
>>  arch/arm/plat-omap/dma.c              |   13 +++++++++++++
>>  arch/arm/plat-omap/include/mach/dma.h |   15 +++++++++++++++
>>  3 files changed, 50 insertions(+), 0 deletions(-)
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
