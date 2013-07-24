From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 00/33] ARM: OMAP: clock conversion to DT
Date: Wed, 24 Jul 2013 17:29:43 +0300
Message-ID: <51EFE4D7.10800@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <51EFE1D4.8090307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48896 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252Ab3GXOaK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jul 2013 10:30:10 -0400
In-Reply-To: <51EFE1D4.8090307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

On 07/24/2013 05:16 PM, Roger Quadros wrote:
> On 07/23/2013 10:19 AM, Tero Kristo wrote:
>> Hi,
>>
>> Changes compared to previous version:
>>
>> - Clock init files moved from mach-omap2/ to drivers/clk/omap/
>> - AM33xx support added [patches 15-20]
>> - OMAP3 support added [patches 21-29]
>> - DRA7 APLL support added (thanks Keerthy) [patches 30-33]
>>
>> Test branch on top of 3.11-rc1 available here:
>>
>> git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
>> branch: mainline-3.11-rc1-omap-dt-clks
>>
>> Testing done:
>>
>> - boot + suspend tested on OMAP3 beagle C4 (omap3530)
>> - boot + suspend tested on OMAP4 panda ES (omap4460)
>> - boot tested on beagle bone (am335x)
>>
>> A boot test was also executed for DRA7 and OMAP5 on a separate branch
>> (mainline does not have OMAP5 / DRA7 support so far.)
>
> Thanks to your hints, I was able to get this to work with 3.11-rc1 on omap5 uevm
> using the following 3 patches. Please include them in your series. Thanks.

Your patches don't apply cleanly to mainline currently, as the omap5 
base support is still not merged. I deliberately left out the full omap5 
integration because of that. Lets see how and when the integration 
proceeds, but I can track your patches meanwhile.

-Tero
