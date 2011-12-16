From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: hwmod: Look for hwmod/module level context
 lost count if supported
Date: Fri, 16 Dec 2011 18:11:08 +0530
Message-ID: <4EEB3C64.30008@ti.com>
References: <1320317665-6381-1-git-send-email-rnayak@ti.com> <1320317665-6381-4-git-send-email-rnayak@ti.com> <4ED52007.8010804@ti.com> <4ED85835.7080108@ti.com> <alpine.DEB.2.00.1112160414530.12660@utopia.booyaka.com> <4EEB36E5.8020504@ti.com> <alpine.DEB.2.00.1112160538200.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:45109 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759034Ab1LPMlP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 07:41:15 -0500
Received: by mail-yx0-f173.google.com with SMTP id m6so2459344yen.18
        for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 04:41:14 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1112160538200.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Friday 16 December 2011 06:08 PM, Paul Walmsley wrote:
> On Fri, 16 Dec 2011, Rajendra Nayak wrote:
>
>> On Friday 16 December 2011 04:46 PM, Paul Walmsley wrote:
>>>
>>> Hi Rajendra,
>>>
>>> I've combined your patches down to one patch and changed the logic a
>>> little bit.  It looks to me that the update and clear context registers
>>> can be done in one step, since an IP block shouldn't lose context when
>>> it's enabled.  But maybe I'm missing something?
>>
>> Thanks for the patch. The changes look fine and I also did a quick
>> test on an internal tree which supports core OSWR and it seems to
>> work fine too.
>
> Great, thanks.  Will wait on this one until you have a chance to tinker
> with it during the 3.4 time frame.

Sure, will work some more on this and maybe re-submit it with open 
switch RET support on OMAP4 when it would really be useful and can
also be tested to work well.

thanks,
Rajendra
>
>
> - Paul

