From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH-V3 3/3] ARM: OMAP2+: CLEANUP: Remove unnecessary ifdef
 around __omap2_set_globals
Date: Thu, 28 Jun 2012 17:41:39 +0200
Message-ID: <4FEC7B33.5030500@ti.com>
References: <1340895567-22766-1-git-send-email-hvaibhav@ti.com> <1340895567-22766-4-git-send-email-hvaibhav@ti.com> <4FEC72C2.7010106@ti.com> <79CD15C6BA57404B839C016229A409A83EA5D620@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37234 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754026Ab2F1PmK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 11:42:10 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA5D620@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

On 06/28/2012 05:39 PM, Hiremath, Vaibhav wrote:
> On Thu, Jun 28, 2012 at 20:35:38, Cousson, Benoit wrote:
>> Hi Vaibhav,
>>
>> One small comment.
>>
>> On 06/28/2012 04:59 PM, Vaibhav Hiremath wrote:
>>> The function __omap2_set_globals() can be common across all
>>> platforms/architectures, even in case of omap4, internally it
>>> calls same set of functions as in __omap2_set_globals() function
>>> (except for sdrc).
>>> This patch adds new config flag SOC_HAS_OMAP2_SDRC to handle sdrc,
>>> so that we can reuse same function across omap2/3/4...
>>>
>>> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Cc: Kevin Hilman <khilman@ti.com>
>>> Cc: Paul Walmsley <paul@pwsan.com>
>>>
>>> Changes from V1:
>>> 	- Added Makefile rule to build sdrc.c file for new
>>> 	  option SOC_HAS_OMAP2_SDRC (as per Kevin's comment).
>>> ---
>>>    arch/arm/mach-omap2/Kconfig  |    8 ++++++++
>>>    arch/arm/mach-omap2/Makefile |    3 ++-
>>>    arch/arm/mach-omap2/common.c |    8 +-------
>>>    arch/arm/mach-omap2/common.h |    5 +++++
>>>    4 files changed, 16 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>>> index 208b950..82d9d18 100644
>>> --- a/arch/arm/mach-omap2/Kconfig
>>> +++ b/arch/arm/mach-omap2/Kconfig
>>> @@ -21,12 +21,16 @@ config ARCH_OMAP2PLUS_TYPICAL
>>>    	help
>>>    	  Compile a kernel suitable for booting most boards
>>>
>>> +config SOC_HAS_OMAP2_SDRC
>>> +	bool "OMAP2 SDRAM Controller support"
>>> +
>>>    config ARCH_OMAP2
>>>    	bool "TI OMAP2"
>>>    	depends on ARCH_OMAP2PLUS
>>>    	default y
>>>    	select CPU_V6
>>>    	select MULTI_IRQ_HANDLER
>>> +	select SOC_HAS_OMAP2_SDRC
>>>
>>>    config ARCH_OMAP3
>>>    	bool "TI OMAP3"
>>> @@ -39,6 +43,7 @@ config ARCH_OMAP3
>>>    	select PM_OPP if PM
>>>    	select ARM_CPU_SUSPEND if PM
>>>    	select MULTI_IRQ_HANDLER
>>> +	select SOC_HAS_OMAP2_SDRC
>>>
>>>    config ARCH_OMAP4
>>>    	bool "TI OMAP4"
>>> @@ -66,16 +71,19 @@ config SOC_OMAP2420
>>>    	depends on ARCH_OMAP2
>>>    	default y
>>>    	select OMAP_DM_TIMER
>>> +	select SOC_HAS_OMAP2_SDRC
>>
>> OMAP4 does not have the SDRC but the EMIF like TI8XX.
>>
>
> Benoit,
>
> This selection is happening for SOC_OMAP2420 and not for OMAP4.

Hehe, indeed, I missed the context and was fooled by the config ARCH_OMAP4.

I don't have any comment then :-)

Benoit
