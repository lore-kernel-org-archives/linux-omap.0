From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 2/2] ARM: DRA7XX: Add support for DRA7XX only build
Date: Fri, 10 Jan 2014 18:32:09 +0200
Message-ID: <52D02089.2070609@ti.com>
References: <1389347850-22435-1-git-send-email-t-kristo@ti.com> <1389347850-22435-3-git-send-email-t-kristo@ti.com> <20140110161538.GI6665@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45808 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880AbaAJQcj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jan 2014 11:32:39 -0500
In-Reply-To: <20140110161538.GI6665@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org

On 01/10/2014 06:15 PM, Felipe Balbi wrote:
> On Fri, Jan 10, 2014 at 11:57:30AM +0200, Tero Kristo wrote:
>> SOC_DRA7XX was under wrong menu within Kconfig file, which prevented
>> DRA7XX only build. Fixed the kconfig options for this SoC as we are
>> there. voltage.c needs to be added to the DRA7XX build also, otherwise
>> DRA7XX only build will fail.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>
> one comment below, other than that:
>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
>
>> ---
>>   arch/arm/mach-omap2/Kconfig  |   18 ++++++++++--------
>>   arch/arm/mach-omap2/Makefile |    1 +
>>   2 files changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>> index dc21df1..e65948a 100644
>> --- a/arch/arm/mach-omap2/Kconfig
>> +++ b/arch/arm/mach-omap2/Kconfig
>> @@ -76,6 +76,16 @@ config SOC_AM43XX
>>   	select ARM_GIC
>>   	select MACH_OMAP_GENERIC
>>
>> +config SOC_DRA7XX
>> +	bool "TI DRA7XX"
>> +	depends on ARCH_MULTI_V7
>> +	select ARCH_OMAP2PLUS
>> +	select ARM_CPU_SUSPEND if PM
>> +	select ARM_GIC
>> +	select CPU_V7
>> +	select HAVE_SMP
>> +	select HAVE_ARM_ARCH_TIMER
>> +
>>   config ARCH_OMAP2PLUS
>>   	bool
>>   	select ARCH_HAS_BANDGAP
>> @@ -128,14 +138,6 @@ config SOC_HAS_REALTIME_COUNTER
>>   	depends on SOC_OMAP5 || SOC_DRA7XX
>>   	default y
>>
>> -config SOC_DRA7XX
>> -	bool "TI DRA7XX"
>> -	select ARM_ARCH_TIMER
>> -	select CPU_V7
>> -	select ARM_GIC
>> -	select HAVE_SMP
>> -	select COMMON_CLK
>
> seems like you lost COMMON_CLK when moving this up, was that on purpose?
>

Yes. It comes through ARCH_OMAP2PLUS which is now selected.

-Tero
