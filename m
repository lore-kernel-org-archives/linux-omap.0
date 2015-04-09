From: Roger Quadros <rogerq@ti.com>
Subject: Re: [GIT PULL] OMAP-GPMC driver updates for v4.1
Date: Thu, 9 Apr 2015 12:35:22 +0300
Message-ID: <552647DA.20509@ti.com>
References: <550FEBC6.3000902@ti.com> <20150403180132.GJ23023@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44824 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932881AbbDIJfz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Apr 2015 05:35:55 -0400
In-Reply-To: <20150403180132.GJ23023@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On 03/04/15 21:01, Olof Johansson wrote:
> On Mon, Mar 23, 2015 at 12:32:38PM +0200, Roger Quadros wrote:
>> Hi Arnd, Hi Olof,
>>
>> Based on Tony's request I will be sending you pull requests for OMAP-GPMC driver
>> hence forth. I've sent this earlier on the 9th of March but had missed to copy Olof.
> 
> It was actually in my queue but I hadn't gotten to it yet. A few comments
> below.
> 
>> Please pull in these OMAP-GPMC driver fixes for v4.1.
>> Patches have been tested for GPMC-NAND on dra7-evm and omap3-beagle.
>>
>> Thanks.
>>
>> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
>>
>>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
>>
>> are available in the git repository at:
>>
>>   git@github.com:rogerq/linux.git tags/gpmc-omap-for-v4.1
>>
>> for you to fetch changes up to 4b613e9b4bbe94545a588a100e09006d827a7ebe:
>>
>>   ARM OMAP2+ GPMC: fix programming/showing reserved timing parameters (2015-03-06 12:55:32 +0200)
> 
> Merged into next/drivers

Thanks Olof.

> 
>> ----------------------------------------------------------------
>> OMAP-GPMC driver fixes for v4.1
>>
>> * Fixed WAITMONITORINGTIME programming to be based on
>> GPMC_CLK instead of GPMC_FCLK. The GPMC clock divider
>> programming is fixed for both synchronous and asynchronous
>> modes.
>> * Allow GPMC's children of default bus type to be populated in
>> the device tree.
>> * Improved DEBUG output data and format.
>> * Prevent writing 1 into reserved bits of GPMC_CONFIG7.
>>
>> ----------------------------------------------------------------
>> Robert ABEL (8):
>>       ARM OMAP2+ GPMC: don't undef DEBUG
>>       ARM OMAP2+ GPMC: add bus children
>>       ARM OMAP2+ GPMC: fix debug output alignment
>>       ARM OMAP2+ GPMC: change get_gpmc_timing_reg output for DTS
>>       ARM OMAP2+ GPMC: always program GPMCFCLKDIVIDER
>>       ARM OMAP2+ GPMC: calculate GPMCFCLKDIVIDER based on WAITMONITORINGTIME
>>       ARM OMAP2+ GPMC: fix WAITMONITORINGTIME divider bug
>>       ARM OMAP2+ GPMC: fix programming/showing reserved timing parameters
> 
> We prefix patches to arch/arm/* with ARM: <platform>:. For these, memory: gpmc:
> seems to be a better prefix going forward.

Noted.

> 
>> Semen Protsenko (2):
>>       ARM: OMAP2+: gpmc: Fix writing in gpmc_cs_set_memconf
>>       ARM: OMAP2+: gpmc: make gpmc_cs_get_name() static
>>
>>  arch/arm/mach-omap2/gpmc-nand.c    |  18 +++++----
>>  arch/arm/mach-omap2/gpmc-onenand.c |   4 +-
>>  arch/arm/mach-omap2/usb-tusb6010.c |   4 +-
>>  drivers/memory/omap-gpmc.c         | 358 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------
>>  include/linux/omap-gpmc.h          |   3 +-
> 
> Tip: If you have a 80-column terminal, or redirect the request-pull to
> a file, you dont' get these super long diffstat lines. :)

Got it. Thanks :).

cheers,
-roger

