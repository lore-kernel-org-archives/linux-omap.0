From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH-V2 0/4] ARM: OMAP2+: am33xx: Add clocktree and hwmod data
Date: Tue, 05 Jun 2012 19:01:56 +0530
Message-ID: <4FCE0A4C.5040307@ti.com>
References: <1338285402-11306-1-git-send-email-hvaibhav@ti.com> <20120605075952.GJ12766@atomide.com> <79CD15C6BA57404B839C016229A409A83EA41629@DBDE01.ent.ti.com> <20120605082628.GM12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:43114 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934202Ab2FENck (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jun 2012 09:32:40 -0400
Received: by obbwd20 with SMTP id wd20so12116555obb.18
        for <linux-omap@vger.kernel.org>; Tue, 05 Jun 2012 06:32:02 -0700 (PDT)
In-Reply-To: <20120605082628.GM12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

>>>
>>> Considering that we have the RFC patches available for common
>>> clk fwk, we should probably avoid the extra churn and have this
>>> use the common clk fwk instead. Of course that is assuming the
>>> common clk fwk patches will be mergeable soonish.
>>>
>>
>> Tony,
>>
>> I am not quite sure how much time it will take to merge common clock changes
>> from Rajendra, since it is still in RFC stage and may take couple merge

I am certainly hoping it does not take couple of merge windows and plan 
to get it in good shape for 3.6.

>> windows. I would recommend to merge clock-tree and hwmod patches atleast to
>> the linux-next, so that it gets validated for some time and we atleast would
>> be able to boot the BeagleBone (community board) from linux-next/master.
>> People can start further development using this on BeagleBone platform.
>>
>> Based on common-clock migration activity on OMAP, we can certainly make
>> decision on pushing it to Mainline (Linus's) tree. And also I will start
>> basing AM33XX clocktree on Rajendra's patches, so that it will get merged at
>> the same time.
>
> OK that sounds fair to me. Let's see what Paul and Rajendra say, it's
> really up to them to make the call. We need minimize the extra load for
> Paul and Rajendra here as it's already a big effort.
>


