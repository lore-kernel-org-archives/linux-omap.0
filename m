From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 07/10] OMAP: PM: Add definitions for ETK pads and observability registers
Date: Tue, 18 Aug 2009 14:12:18 +0200
Message-ID: <878whhjp7h.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0306050AFF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:61399 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbZHRMMY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 08:12:24 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0306050AFF@dbde02.ent.ti.com> (Anand Gadiyar's message of "Sat\, 15 Aug 2009 10\:40\:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-arm@vger.kernel.org" <linux-arm@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

"Gadiyar, Anand" <gadiyar@ti.com> writes:

>> From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
>> 
>> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>>  arch/arm/plat-omap/include/mach/control.h |   47 +++++++++++++++++++++++++++-
>>  1 files changed, 45 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
>> index 8140dbc..81afe26 100644
>> --- a/arch/arm/plat-omap/include/mach/control.h
>> +++ b/arch/arm/plat-omap/include/mach/control.h
>> @@ -141,8 +141,51 @@
>>  #define OMAP343X_CONTROL_TEST_KEY_13	(OMAP2_CONTROL_GENERAL + 0x00fc)
>>  #define OMAP343X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
>>  #define OMAP343X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
>> -#define OMAP343X_CONTROL_PBIAS_LITE	(OMAP2_CONTROL_GENERAL + 0x02b0)
>> -#define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02b4)
>> +#define OMAP343X_CONTROL_DEBOBS(i)	(OMAP2_CONTROL_GENERAL + 0x01B0 \
>> +					+ ((i) >> 1) * 4 + (!(i & 1)) * 2)
>> +#define OMAP343X_CONTROL_PROG_IO0	(OMAP2_CONTROL_GENERAL + 0x01D4)
>> +#define OMAP343X_CONTROL_PROG_IO1	(OMAP2_CONTROL_GENERAL + 0x01D8)
>> +#define OMAP343X_CONTROL_DSS_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01E0)
>> +#define OMAP343X_CONTROL_CORE_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01E4)
>> +#define OMAP343X_CONTROL_PER_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01E8)
>> +#define OMAP343X_CONTROL_USBHOST_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01EC)
>> +#define OMAP343X_CONTROL_PBIAS_LITE	(OMAP2_CONTROL_GENERAL + 0x02B0)
>> +#define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02B4)
>> +#define OMAP343X_CONTROL_SRAMLDO4	(OMAP2_CONTROL_GENERAL + 0x02B8)
>> +#define OMAP343X_CONTROL_SRAMLDO5	(OMAP2_CONTROL_GENERAL + 0x02C0)
>> +#define OMAP343X_CONTROL_CSI		(OMAP2_CONTROL_GENERAL + 0x02C4)
>> +
>> +
>> +/* 34xx PADCONF register offsets */
>> +#define OMAP343X_PADCONF_ETK(i)	(OMAP2_CONTROL_PADCONFS + 0x5a8 + \
>> +						(i)*2)
>> +#define OMAP343X_PADCONF_ETK_CLK	OMAP343X_PADCONF_ETK(0)
>> +#define OMAP343X_PADCONF_ETK_CTL	OMAP343X_PADCONF_ETK(1)
>> +#define OMAP343X_PADCONF_ETK_D0		OMAP343X_PADCONF_ETK(2)
>> +#define OMAP343X_PADCONF_ETK_D1		OMAP343X_PADCONF_ETK(3)
>> +#define OMAP343X_PADCONF_ETK_D2		OMAP343X_PADCONF_ETK(4)
>> +#define OMAP343X_PADCONF_ETK_D3		OMAP343X_PADCONF_ETK(5)
>> +#define OMAP343X_PADCONF_ETK_D4		OMAP343X_PADCONF_ETK(6)
>> +#define OMAP343X_PADCONF_ETK_D5		OMAP343X_PADCONF_ETK(7)
>> +#define OMAP343X_PADCONF_ETK_D6		OMAP343X_PADCONF_ETK(8)
>> +#define OMAP343X_PADCONF_ETK_D7		OMAP343X_PADCONF_ETK(9)
>> +#define OMAP343X_PADCONF_ETK_D8		OMAP343X_PADCONF_ETK(10)
>> +#define OMAP343X_PADCONF_ETK_D9		OMAP343X_PADCONF_ETK(11)
>> +#define OMAP343X_PADCONF_ETK_D10	OMAP343X_PADCONF_ETK(12)
>> +#define OMAP343X_PADCONF_ETK_D11	OMAP343X_PADCONF_ETK(13)
>> +#define OMAP343X_PADCONF_ETK_D12	OMAP343X_PADCONF_ETK(14)
>> +#define OMAP343X_PADCONF_ETK_D13	OMAP343X_PADCONF_ETK(15)
>> +#define OMAP343X_PADCONF_ETK_D14	OMAP343X_PADCONF_ETK(16)
>> +#define OMAP343X_PADCONF_ETK_D15	OMAP343X_PADCONF_ETK(17)
>
> I'm not sure if we need to use only these pads. There is an alternative
> set of pad that bring out the debobs signals.

... and they can be added in a separate patch when needed.

Kevin
