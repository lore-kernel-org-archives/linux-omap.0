From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 29/33] CLK: omap: add omap3 clock init file
Date: Wed, 31 Jul 2013 18:10:32 +0300
Message-ID: <51F928E8.9020806@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <1374564028-11352-30-git-send-email-t-kristo@ti.com> <51F81FD7.2060707@ti.com> <20130731063512.GP7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37184 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759612Ab3GaPLR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Jul 2013 11:11:17 -0400
In-Reply-To: <20130731063512.GP7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, mturquette@linaro.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 07/31/2013 09:35 AM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [130730 13:26]:
>> On 07/23/2013 02:20 AM, Tero Kristo wrote:
>>> clk-3xxx.c now contains the clock init functionality for omap3, including
>>> DT clock registration and adding of static clkdev entries.
>>>
>>> This patch also splits the OMAP3 clock registration code under mach-omap2
>>> to use OMAP3 subtype specific clk init functions.
>>>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> ---
>>>   arch/arm/mach-omap2/Makefile          |    2 +-
>>>   arch/arm/mach-omap2/cclock3xxx_data.c | 3641 ---------------------------------
>>
>> Tony and a lot of people is not going to like removing support for
>> non-dt boot for OMAP3 before "it's time is due" ;)
>
> I think the only showstopper for that is that we need the
> pending pinctrl changes merged first to keep off-idle working.
> So the omap3 legacy code removal probably needs to wait until
> v3.13 merge window. For omap4 and am33xx we can do it now.
>
> Regards,
>
> Tony
>

I'll modify the series in such way that OMAP3 retains the legacy clock 
data within the kernel for now, and will use either DT or kernel data 
based on init type. Kernel data can then be removed when time is ripe 
for it.

-Tero
