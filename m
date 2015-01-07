From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Wed, 7 Jan 2015 09:44:07 -0600
Message-ID: <54AD5447.2070601@ti.com>
References: <20150105230228.GO4081@atomide.com> <20150106080025.GA6752@amd> <20150106165903.GF4025@atomide.com> <20150107095703.GA15925@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50863 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753199AbbAGPoZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Jan 2015 10:44:25 -0500
In-Reply-To: <20150107095703.GA15925@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, =?windows-1252?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>

On 01/07/2015 03:57 AM, Pavel Machek wrote:
> On Tue 2015-01-06 08:59:03, Tony Lindgren wrote:
>> * Pavel Machek <pavel@ucw.cz> [150106 00:03]:
>>> On Mon 2015-01-05 15:02:29, Tony Lindgren wrote:
>>>> Revert "ARM: dts: Disable smc91x on n900 until bootloader
>>>> dependency is removed". We've now fixed the issues that
>>>> caused problems with uninitialized hardware depending on
>>>> the bootloader version. Mostly things got fixed with
>>>> the following commits:
>>>>
>>>> 9a894953a97b ("ARM: dts: Fix bootloader version dependencies by muxing n900 smc91x pins")
>>>> 7d2911c43815 ("net: smc91x: Fix gpios for device tree based booting")
>>>>
>>>> Note that this only affects the early development boards
>>>> with Ethernet that we still have in a few automated boot
>>>> test systems.
>>>>
>>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>>
>>> Normally, the early development boards should have separate dts file
>>> (then include common parts), no?
>>
>> In this case it won't matter. The GPMC hardware is there, the probe
>> just fails if no smsc91x is found.
>>  
>>> Could you at least add a note to the dts file what is it? Because I
>>> always thought it is a bug.
>>
>> Sure, updated patch below. Can somebody please test boot it on
>> a production n900 too to make sure it no longer causes issues?
> 
> Actually... how do you manage your n900 to boot? Does it also boot
> from 0xffff?
> 
> I believe I'm hitting dtb size limit (again), and 3.19-rc3 does not boot
> unless I somehow make dtb smaller... like the patch below.
> 
> ---
> 
> make dtb smaller so that it boots.

I am using chained boot (NOLO->u-boot->kernel (zImage +dtb
concatenated) on a real n900

I have the same issue as well. using omap2plus_defconfig.
I was able to bisect next tags as follows: next-20141128 worked,
next-20141201 stopped booting and the change was new dts addition,
removing the dts addition helped next-20141201 boot as well.

Current state:

https://github.com/nmenon/kernel-test-logs/blob/next-20150107/omap2plus_defconfig/n900.txt#L447

https://github.com/nmenon/kernel-test-logs/blob/v3.19-rc3/omap2plus_defconfig/n900.txt#L448


I had complained originally here:
http://marc.info/?t=141946203100001&r=1&w=2 Apologies on not following
up on the thread, got distracted.


-- 
Regards,
Nishanth Menon
