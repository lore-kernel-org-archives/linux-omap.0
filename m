From: "arun c" <arunedarath@mistralsolutions.com>
Subject: Re: About to tag v2.6.26-omap1, patch queue deleted, please check and repost
Date: Wed, 6 Aug 2008 19:21:20 +0530
Message-ID: <c656a4d20808060651r7a9fe904g943b1d07691e6df@mail.gmail.com>
References: <20080805143519.GS7193@atomide.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB02569B8A85@dbde02.ent.ti.com>
	 <489897CD.6040802@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:19708 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231AbYHFNvW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 09:51:22 -0400
Received: by ti-out-0910.google.com with SMTP id b6so981312tic.23
        for <linux-omap@vger.kernel.org>; Wed, 06 Aug 2008 06:51:20 -0700 (PDT)
In-Reply-To: <489897CD.6040802@googlemail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Aug 5, 2008 at 11:41 PM, Dirk Behme <dirk.behme@googlemail.com> wrote:
> Gadiyar, Anand wrote:
>>>
>>> Hi all,
>>>
>>> I've pushed all the patches I have in my omap inbox, except for
>>> the omap serial driver that I want to look more.
>>>
>>> I've tried to comment on the ones that did not get pushed, then
>>> erased everything from my omap inbox. Some drivers should get
>>> integrated via other mailing lists, and some debug patches can
>>> probably stay as debug patches, and some patches I probably
>>> have accidentally deleted :) And the PM patches I lost track of,
>>> so those should be reposted.
>>>
>>> So please check your patches, and repost your patches if something
>>> is left out. Also please check that things work for your board,
>>> let's try to tag v2.6.26-omap1 within next few days so we can
>>> move on again.
>>>
>>> Cheers,
>>>
>>> Tony
>>
>>
>> Boot tested on 3430SDP with the defconfig. Things work okay so far.
>
> Same with BeagleBoard.
>
> Dirk
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Hi all,

Boot tested on omap2evm with defconfig.
The printks from omapfb(irq errors) is stalling the console sometimes, otherwise
everything seems to be fine.

Regards,
Arun C
