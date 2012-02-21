From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 0/3] omap hsmmc init cleanup and section warning fixes
 for v3.4 merge window
Date: Tue, 21 Feb 2012 10:49:18 +0530
Message-ID: <4F432956.6070601@ti.com>
References: <20120215182355.18884.18682.stgit@kaulin.local> <4F3E6323.9020101@ti.com> <20120217202125.GF18185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:42456 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750732Ab2BUFT0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 00:19:26 -0500
Received: by mail-tul01m020-f176.google.com with SMTP id wd18so11242889obb.21
        for <linux-omap@vger.kernel.org>; Mon, 20 Feb 2012 21:19:25 -0800 (PST)
In-Reply-To: <20120217202125.GF18185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Saturday 18 February 2012 01:51 AM, Tony Lindgren wrote:
> * Rajendra Nayak<rnayak@ti.com>  [120217 05:53]:
>> Tony,
>>
>> On Wednesday 15 February 2012 11:58 PM, Tony Lindgren wrote:
>>> Hi all,
>>>
>>> This series fixes up the issues noted by Russell on omap2_hsmmc_init()
>>> where if TWL PMIC is compiled as a module we can't keep a bunch of
>>> functions marked as __init like they should be. This series fixes
>>> the issues by splitting omap2_hsmmc_init() into two functions.
>>
>> I have a re-spin of this series ready with all the fixes I did
>> while testing the insmod/unbind/bind test suggested by Russell.
>> I could not figure out what branch your original patches were
>> based on. So let me know what branch of your tree you want me
>> to post this series on.
>
> I have them on mainline commit a269c2f5a5ad2b24a19fdd723363daf18394ec85.

I could not get them to apply on the above commit, but I was able to on
this mainline commit instead '4f8a428dac431e7bd09673b404769d87df948eef'.

Anyways, now that -rc4 is out I based my series on top of that.
