From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 05/33] CLK: omap: add DT duplicate clock registration
 mechanism
Date: Thu, 1 Aug 2013 10:24:38 -0500
Message-ID: <51FA7DB6.3060002@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <1374564028-11352-6-git-send-email-t-kristo@ti.com> <51F808A8.6000503@ti.com> <51F8E1F5.20706@ti.com> <51FA6FCA.3050900@ti.com> <51FA7C39.8090100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33465 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755365Ab3HAPZL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Aug 2013 11:25:11 -0400
In-Reply-To: <51FA7C39.8090100@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 08/01/2013 10:18 AM, Tero Kristo wrote:
> On 08/01/2013 05:25 PM, Nishanth Menon wrote:
>> On 07/31/2013 05:07 AM, Tero Kristo wrote:
>>> On 07/30/2013 09:40 PM, Nishanth Menon wrote:
>>>> On 07/23/2013 02:20 AM, Tero Kristo wrote:
[..]
>> if we can get rid of usage of omap_hwmod_get_main_clk by catching them
>> with [1], then we can force the drivers to pick up based on device node
>> clocks= property.
>>
>> It might be easier to fix 1 driver - timer, rather than introduce am33x,
>> omap4, omap5 dra7 specific "SoC clk driver".
>>
>> with that this entire patch becomes redundant.
>
> It is not that simple. Looking at the architectures this set supports, I
> see clock alias nodes at least for following drivers:
>
> - GPT timer
> - USB
> - DCAN
> - EMAC
> - VPFE
> - UART
> - SSI
> - DSS
> - security
> - MMC
> - MCBSP
> - MCSPI
>
> I am _not_ going to fix all of these during the initial phase. :P
>
> But yes, eventually these should go away.

How many of these are needed to boot? what functionality do we expect 
with the series -> we can constraint saying that remaining drivers 
should fix themselves the right way, else dont have the feature - 
example cpufreq- fix it the right way, or wont see the feature enabled.

introducing a "way out" for all of these just invites more guys to screw 
around claiming "it was done before - see here"..

lets just fix the darned basic ones, refuse to provide "way out" and let 
the others fix themselves.

-- 
Regards,
Nishanth Menon
