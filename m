From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 05/25] OMAP4: Use WARN_ON() instead of BUG_ON() with graceful
 exit
Date: Mon, 05 Sep 2011 16:12:02 +0530
Message-ID: <4E64A77A.10400@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com> <1315144466-9395-6-git-send-email-santosh.shilimkar@ti.com> <4E64A040.4000801@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:43112 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751871Ab1IEKmJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 06:42:09 -0400
Received: by mail-yi0-f47.google.com with SMTP id 28so2947295yia.6
        for <linux-omap@vger.kernel.org>; Mon, 05 Sep 2011 03:42:08 -0700 (PDT)
In-Reply-To: <4E64A040.4000801@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

On Monday 05 September 2011 03:41 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 04-09-2011 17:54, Santosh Shilimkar wrote:
>
>> OMAP4 L2X0 initialisation code uses BUG_ON() for the ioremap()
>> failure scenarios.
>
>> Use WARN_ON() instead and allow graceful function exits.
>
>> This was suggsted by Kevin Hilman<khilman@ti.com> during
>> OMAP4 PM code review.
>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>> ---
>> arch/arm/mach-omap2/omap4-common.c | 3 ++-
>> 1 files changed, 2 insertions(+), 1 deletions(-)
>
>> diff --git a/arch/arm/mach-omap2/omap4-common.c
>> b/arch/arm/mach-omap2/omap4-common.c
>> index 4791370..4904025 100644
>> --- a/arch/arm/mach-omap2/omap4-common.c
>> +++ b/arch/arm/mach-omap2/omap4-common.c
>> @@ -121,7 +121,8 @@ static int __init omap_l2_cache_init(void)
>>
>> /* Static mapping, never released */
>> l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
>> - BUG_ON(!l2cache_base);
>> + if (WARN_ON(!l2cache_base))
>> + return -ENODEV;
>
> Rather ENOMEM...
>
Nope. Even though it's related to memory, it's
a memory controller so DEV is right.

Regards
Santosh
