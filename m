From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: next boot: 34 pass, 5 fail (next-20140122)
Date: Thu, 23 Jan 2014 09:14:16 +0100
Message-ID: <52E0CF58.5040109@epfl.ch>
References: <52e06652.c103450a.79d7.6517@mx.google.com> <CAGa+x86=gKh11g1pzLqxdimeCxuZ478+ZAxd9GjO-m7Aa8L2fg@mail.gmail.com> <52E0B569.8000809@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:56259 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609AbaAWIOW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jan 2014 03:14:22 -0500
In-Reply-To: <52E0B569.8000809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@linaro.org>, kernel-build-reports@lists.linaro.org, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Mike Turquette <mturquette@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Ash Charles <ash@gumstix.com>

Hello,

On 01/23/2014 07:23 AM, Tero Kristo wrote:
> On 01/23/2014 03:35 AM, Kevin Hilman wrote:
>> On Wed, Jan 22, 2014 at 4:46 PM, Kevin's boot bot <khilman@linaro.org>
>> wrote:
>>> Automated DT boot report for various ARM defconfigs.
>>>
>>>
>>> Tree/Branch: next
>>> Git describe: next-20140122
>>> Failed boot tests (console logs at the end)
>>> ===========================================
>>>          omap3-tobi,3730storm:     FAIL:    omap2plus_defconfig
>> [...]
>>>          omap3-tobi,3730storm:     FAIL:    multi_v7_defconfig
>>
>> These OMAP3 failures are new regressions.  Full failure boot log
>> attached.
>> Bisected down to:
>>
>> cfa9667d4ac9da8b3ba2269f934ecd69ae504d39 is the first bad commit
>> commit cfa9667d4ac9da8b3ba2269f934ecd69ae504d39
>> Author: Tero Kristo <t-kristo@ti.com>
>> Date:   Tue Oct 22 11:53:02 2013 +0300
>>
>>      ARM: OMAP2+: io: use new clock init API
>>
>>      clk_init is now separated to a common function which gets called
>> for all
>>      SoC:s, which initializes the DT clocks and calls the SoC specific
>> clock init.
>>
>>      Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>      Acked-by: Tony Lindgren <tony@atomide.com>
>>      Signed-off-by: Mike Turquette <mturquette@linaro.org>
>>
>> Kevin
>>
> 
> Hi,
> 
> I think this is because the tobi board is including wrong omap3-soc.dtsi
> file (omap34xx.dtsi) through omap3-overo.dtsi.
> 
> The board should include omap36xx.dtsi at least based on the boot log:
> 
> [    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
> 

The problem is that the Overo (processor card on the Tobi extension
board) can have a variety of processor depending on the exact model:

- OMAP 35xx (1st generation: Air, Earth, Fire, Sand, Tide, Water, FE)
- OMAP 3730
- AM/DM 37xx

omap3-overo.dtsi includes omap34xx.dtsi to be compatible with the first
generation.


omap34xx.dtsi
     |
     -> omap3-overo.dtsi (processor card)
                |
                -> omap3-tobi.dtsi (expansion board)


What is the fundamental incompatibility here? If we have to specifically
include omap36xx for newer Overo, it will become hard to maintain as it
will double the number of Overo / expansion boards possibilities.

Regards,

Florian
