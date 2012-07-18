From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv4 7/8] ARM: OMAP: clockdomain: add support for preventing
 autodep delete
Date: Wed, 18 Jul 2012 14:34:13 +0530
Message-ID: <50067C0D.2040508@ti.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>	 <1342189185-5306-8-git-send-email-t-kristo@ti.com>	 <5003F453.9020903@ti.com> <1342536971.4672.82.camel@sokoban>	 <50066284.1030903@ti.com> <1342598720.4672.83.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:42463 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750939Ab2GRJEU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jul 2012 05:04:20 -0400
Received: by obqv19 with SMTP id v19so3136075obq.30
        for <linux-omap@vger.kernel.org>; Wed, 18 Jul 2012 02:04:19 -0700 (PDT)
In-Reply-To: <1342598720.4672.83.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Wednesday 18 July 2012 01:35 PM, Tero Kristo wrote:
> On Wed, 2012-07-18 at 12:45 +0530, Rajendra Nayak wrote:
>> On Tuesday 17 July 2012 08:26 PM, Tero Kristo wrote:
>>> Anyway, it also looks like this fix is no longer needed with the latest
>>> kernel, something has changed with the gpio code / or latencies and it
>>> doesn't crash anymore. Thus, it looks like patches 7&   8 can be dropped
>>> from this set for now. This is the behavior with beagleboard at least,
>>> if someone can verify this with some other omap3 hw that would be nice.
>>
>> I can test it on a omap3 SDP. What do you want me to test?
>
> Just try suspend + cpuidle with and without off-mode enabled and see if
> there are any problems. I've usually seen problems with off-mode myself.

So I just knocked off the last 2 patches from 'mainline-3.5-rc6-pwrdm-
changes-v4' and tested on my 3430 SDP.

I was able to hit RET and OFF in both suspend and cpuidle. Did not see
any issues.

>
> -Tero
>
>

