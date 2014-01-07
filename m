From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv12 00/49] ARM: TI SoC clock DT conversion
Date: Tue, 7 Jan 2014 10:36:17 -0600
Message-ID: <52CC2D01.7010001@ti.com>
References: <1387557274-22583-1-git-send-email-t-kristo@ti.com> <52CB72B3.6070709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50624 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515AbaAGQgn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Jan 2014 11:36:43 -0500
In-Reply-To: <52CB72B3.6070709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 01/06/2014 09:21 PM, Nishanth Menon wrote:
> Hi Tero,
> On 12/20/2013 10:34 AM, Tero Kristo wrote:
>> Hopefully final post of this series. At least this is going to be the last
>> post this year as I will be going to x-mas vacation and won't be back before
>> Jan 2nd. This time I just sent the patches that have changes in them,
>> the missing ones are exactly the same as in v11.
>>
> 
> There are still a few issues that I see
> [...]
> 
>> Branches available at https://github.com/t-kristo/linux-pm.git:
>> - branch: 3.13-rc4-dt-clks-v12 : contains everything, shall me merged last
>> - branch: 3.13-rc4-dt-clks-v12-for-mike : drivers/clk changes
>> - branch: 3.13-rc4-dt-clks-v11-for-benoit : DT data only (from v11, no changes)
> 
> For easy maintainer merging, you may want to make this as three branches:
> 
> 1. for-mike based on
> git://git.linaro.org/people/mturquette/linux.git clk-next
> 
> 2. for-benoit based on
> git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
> for_3.14/dts
> 
> 3. for-tony based on
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
> omap-for-v3.14/board-removal or on a clean k.org tag
> 
> 4. A testing branch for the rest of us which consolidates all of these
> together.
> 
> Testing with a rebase of 3.13-rc4-dt-clks-v12 to v3.13-rc7:
> 
> Here is my test platforms and logs (boot only - omap2plus_defconfig +
> common_clk_debug - all boots to sd card based filesystem):
> 
> AM335x Family:
> 
> AM335x-EVMSK:
>         http://pastebin.mozilla.org/3955459
> AM335x-EVM:
>         http://pastebin.mozilla.org/3955460
> AM335x-BeagleBone Black:
>         http://pastebin.mozilla.org/3955476
> 
> OMAP3 family:
> OMAP3430: SDP3430:
>         http://pastebin.mozilla.org/3955475
> AM3517-evm: (requires a bootargs fix - remote board - no regressions seen)
>         http://pastebin.mozilla.org/3955461
> AM3517-CraneBoard:
>         http://pastebin.mozilla.org/3955477
> OMAP3630/DM3730 BeagleBoard-XM:
>         http://pastebin.mozilla.org/3955474
> AM37xx-evm:
>         http://pastebin.mozilla.org/3955472
> 
> OMAP4 Family:
> OMAP4460: PandaBoard-ES:
>         http://pastebin.mozilla.org/3955478
> 	NOTE: trace_clk_div_ck seems orphan clock here?
> 
> OMAP5 Family:
> OMAP5432: OMAP5uEVM:
>         http://pastebin.mozilla.org/3955479
> 
> DRA7 Family:
> 
> DRA7: DRA7-evm:
>         http://pastebin.mozilla.org/3955480

one more missing test platform:

AM43xx-epos platform: (needed a few out of tree patches to test on TI
internal engineering samples):
	http://pastebin.mozilla.org/3960056


> 
> 
> Patch autoverification report: http://pastebin.mozilla.org/3955695
> 
> The following issues need fixes I suppose:
> * CHECK: spinlock_t definition without comment
> 	[PATCH 03/49] clk: divider: add support for registering divider
> 	[PATCH 04/49] clk: mux: add support for registering mux clock from
> 	[PATCH 05/49] clk: gate: add support for registering gate clock from
> 
> * [PATCH 23/49] CLK: TI: DRA7: Add APLL support
> 	"parent_names = kzalloc(sizeof(char *) * init->num_parents, GFP_KERNEL);"
> 	* kzalloc without check for NULL
> 	* will also be good to add some kerneldoc documentation (same with
> interface.c)
> * WARNING: static const char * array should probably be static const
> char * const
> 	[PATCH 25/49] CLK: TI: add am33xx clock init file
> 	[PATCH 27/49] CLK: TI: add omap3 clock init file
> * [PATCH 40/49] ARM: OMAP2+: clock: use driver API instead of direct
> 	adds a new kernel doc warning "Warning(arch/arm/mach-omap2/clock.c:
> No description found for parameter 'clk'"
> * [PATCH 44/49] ARM: OMAP2+: io: use new clock init API
> 	introduces warning for
> 		"arch/arm/mach-omap2/io.c: warning: symbol 'omap_clk_soc_init' was
> not declared. Should it be static?"
> 	which seems squashed with "[PATCH 45/49] ARM: OMAP4: remove old clock
> data and link in new"
> 	will be good to have it not appear in patch 44 itself.
> 
> 
> Also pending is OMAP5 only build failure that Felipe reported and does
> not seem fixed in V12 as well:
> http://marc.info/?l=linux-arm-kernel&m=138757010619274&w=2
> and
> http://marc.info/?l=linux-arm-kernel&m=138755595914796&w=2
> 


-- 
Regards,
Nishanth Menon
