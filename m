From: Afzal Mohammed <afzal@ti.com>
Subject: Re: [PATCH v2 00/13] ARM: OMAP2+: AM43x PRCM support
Date: Mon, 19 Aug 2013 12:06:55 +0530
Message-ID: <5211BD07.9090309@ti.com>
References: <cover.1375443858.git.afzal@ti.com> <20130813080159.GT7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60499 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976Ab3HSGhY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Aug 2013 02:37:24 -0400
In-Reply-To: <20130813080159.GT7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>

Hi Tony,

On Tuesday 13 August 2013 01:31 PM, Tony Lindgren wrote:

> Hi Paul & Benoit,
> 
> Does this series look OK to you guys to queue or ack?


Can you please consider queuing this series for the coming merge window
as we are getting closer to the merge window.

If Paul or Benoit has any comments on this, we can have patches to fix
it up on top of this as required or these patches be reverted in the
worst case.

Regards
Afzal

> 
> * Afzal Mohammed <afzal@ti.com> [130802 06:42]:
>> Hi,
>>
>> AM43x PRCM support (excluding clock tree) is being added with this
>> series. AM43x reuses most of the IP's from AM335x, as that is the
>> case, much of the AM335x hwmod data is reused.
>>
>> I am aware that this series adds around +1K lines to platform. We in
>> TI, here are making efforts to clean platform code gradually and keep
>> to minumum the code being added to support new SoC's. Please note that
>> this SoC support series has positive diffstat of just above 1K only.
>> This compared to last SoC that was supported in OMAP family during
>> last merge window is way less (this is only around 1/8th postive
>> diffstat of it). Clock data is not added in this series, instead
>> directly clock tree in DT with driver would be used, this is a work in
>> progress. And as seen from recent OMAP clock tree DT conversion
>> series, there are serious efforts ongoing to that end. Also we will
>> start working on moving hwmod away from platform folders. In addition,
>> recently there was a PRCM cleanup by Rajendra Nayak that removed near
>> to 11K lines.
>>
>> Considering the above facts, I request the maintainers to consider
>> this series for the next merge window.
>>
>> Currently there is no public TRM available for AM43x.
>>
>> Hwmod database of AM335x is reused by moving common elements to a new
>> array (most of AM335x IP's are present in AM43x) and keeping separate
>> arrays for elements that are specific only to either one of AM335x or
>> AM43x. And in the cases where relevant IP is present in both that has
>> difference in details like CLKCTRL register offsets, it is being
>> updated at runtime based on the SoC detected.
>>
>> Powerdomain & Clockdomain data has been added separately as it was not
>> giving much advantage reusing AM335x ones (runtime updates required
>> was getting too ugly). But as AM43x PRCM functionality is similar to
>> OMAP4, power domain, clock domain & hwmod operations are reused from
>> OMAP4.
>>
>> A single header file has been added to provide all AM43x PRCM defines.
>>
>> Here sequencewise, initially AM335x hwmod is modified to have it's
>> fields get updated at runtime (wherever element is shared and has
>> some difference with AM43x). Then power domain, clock domain for AM43x
>> is added and finally AM335x hwmod database is updated with AM43x
>> specifics.
>>
>> This series is being developed with additional clock tree changes that
>> are being DT'fied.
>>
>> Additional DTS changes (posted separate from this series) are also
>> required for hwmod to get register target address space as most of
>> AM335x hwmod address space details has been recently cleaned up and
>> moved to DTS.
>>
>> Regards
>> Afzal
>>
>> Afzal Mohammed (8):
>>   ARM: OMAP2+: hwmod: AM335x: prepare for AM43x reuse
>>   ARM: OMAP2+: hwmod: AMx3: runtime AM335x handling
>>   ARM: OMAP2+: hwmod: AMx3: remove common static fields
>>   ARM: OMAP2+: PRCM: AM43x definitions
>>   ARM: OMAP2+: hwmod: AMx3: runtime AM43x handling
>>   ARM: OMAP2+: hwmod: AM43x operations
>>   ARM: OMAP2+: AM43x: PRCM kbuild
>>   ARM: OMAP2+: hwmod: AM43x: new w.r.t AM335x
>>
>> Ambresh K (3):
>>   ARM: OMAP2+: PM: AM43x powerdomain data
>>   ARM: OMAP2+: CM: AM43x clockdomain data
>>   ARM: OMAP2+: AM43x PRCM init
>>
>> Ankur Kishore (1):
>>   ARM: OMAP2+: CM: cm_inst offset s16->u16
>>
>> Vaibhav Bedia (1):
>>   ARM: OMAP2+: CM: reintroduce SW_SLEEP for OMAP4
>>
>>  arch/arm/mach-omap2/Makefile                |    5 +-
>>  arch/arm/mach-omap2/clockdomain.h           |    4 +-
>>  arch/arm/mach-omap2/clockdomains43xx_data.c |  199 ++++++++
>>  arch/arm/mach-omap2/cm33xx.c                |   30 +-
>>  arch/arm/mach-omap2/cm33xx.h                |   28 +-
>>  arch/arm/mach-omap2/cminst44xx.c            |   58 ++-
>>  arch/arm/mach-omap2/cminst44xx.h            |   25 +-
>>  arch/arm/mach-omap2/io.c                    |    6 +
>>  arch/arm/mach-omap2/omap_hwmod.c            |    8 +
>>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c  |  691 +++++++++++++++++++++++----
>>  arch/arm/mach-omap2/powerdomain.h           |    1 +
>>  arch/arm/mach-omap2/powerdomains43xx_data.c |  145 ++++++
>>  arch/arm/mach-omap2/prcm43xx.h              |  141 ++++++
>>  13 files changed, 1198 insertions(+), 143 deletions(-)
>>  create mode 100644 arch/arm/mach-omap2/clockdomains43xx_data.c
>>  create mode 100644 arch/arm/mach-omap2/powerdomains43xx_data.c
>>  create mode 100644 arch/arm/mach-omap2/prcm43xx.h
>>
>> -- 
>> 1.7.9.5
>>

