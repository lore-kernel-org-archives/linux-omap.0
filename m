From: Dave Hylands <dhylands@gmail.com>
Subject: Re: Regressions for older OMAP3503 silicon
Date: Wed, 5 Oct 2011 23:29:58 -0700
Message-ID: <CABi1daE0ko+ZOYjifrwd1cnTeoD67SaHrBVhEmL6OP-m5UCB5g@mail.gmail.com>
References: <CABi1daE-7OdgL5BqaLrB+X64-cf+kQMyXv9eSZOE79bRt+fMPw@mail.gmail.com>
	<20111005162618.GA6324@atomide.com>
	<CAGDS+nkHCmt0+Z82fSX3+bRLy4RR-_4vegb0tGUwD5u_ttnMSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33963 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935243Ab1JFG37 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 02:29:59 -0400
Received: by wyg34 with SMTP id 34so2450636wyg.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Oct 2011 23:29:58 -0700 (PDT)
In-Reply-To: <CAGDS+nkHCmt0+Z82fSX3+bRLy4RR-_4vegb0tGUwD5u_ttnMSw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi guys,

On Wed, Oct 5, 2011 at 11:19 AM, Steve Sakoman <sakoman@gmail.com> wrote:
> On Wed, Oct 5, 2011 at 9:26 AM, Tony Lindgren <tony@atomide.com> wrote:
>> * Dave Hylands <dhylands@gmail.com> [111004 23:41]:
>
>>> I then also had to modify drivers/mmc/card/block.c and initializing
>>> disable_multi to 1 in the mmc_blk_issue_rw_rq function to get rid of
>>> the following messages for every I/O request.
>>>
>>> mmcblk0: retrying using single block read
>>> mmcblk0: retrying using single block read
>>> mmcblk0: retrying using single block read
>>> mmcblk0: retrying using single block read
>>>
>>> (since this revision of the silicon doesn't support multi-block MMC reads).
>>
>> ..but this one is usually a problem muxing the MMC data lines.
>>
>> Are you sure this revision only supports one data line?
>
> No, I think you misunderstood the issue!
>
> The issue is that multi-block mmc reads are broken and the code falls
> back to single block reads but prints a warning each time.
>
> Looking for a definitive source for this errata with Google I find:
>
> "According to the TI docs, multiple block read transfer
> does not work correctly in CPU revisions 2.1 and earlier (TI advisory
> 2.1.1.128)."
>
> So the correct fix is probably to use multi-block reads only on
> revisions post 2.1.

And uboot does a very specific check for the silicon revision and only
does single block reads.
http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/mmc/omap_hsmmc.c;h=5d4cf51104a7936377dc27a2f18e8240ada9a24a;hb=HEAD#l497
(look at line 497)

-- 
Dave Hylands
Shuswap, BC, Canada
http://www.davehylands.com
