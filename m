From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 05/25] OMAP4: Use WARN_ON() instead of BUG_ON() with
	graceful exit
Date: Mon, 5 Sep 2011 11:47:55 +0100
Message-ID: <20110905104755.GC6918@n2100.arm.linux.org.uk>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com> <1315144466-9395-6-git-send-email-santosh.shilimkar@ti.com> <4E64A040.4000801@ru.mvista.com> <4E64A77A.10400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57314 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab1IEKsI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 06:48:08 -0400
Content-Disposition: inline
In-Reply-To: <4E64A77A.10400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-omap@vger.kernel.org, khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

On Mon, Sep 05, 2011 at 04:12:02PM +0530, Santosh wrote:
> On Monday 05 September 2011 03:41 PM, Sergei Shtylyov wrote:
>> Hello.
>>
>> On 04-09-2011 17:54, Santosh Shilimkar wrote:
>>
>>> OMAP4 L2X0 initialisation code uses BUG_ON() for the ioremap()
>>> failure scenarios.
>>
>>> Use WARN_ON() instead and allow graceful function exits.
>>
>>> This was suggsted by Kevin Hilman<khilman@ti.com> during
>>> OMAP4 PM code review.
>>
>>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> Cc: Kevin Hilman<khilman@ti.com>
>>> ---
>>> arch/arm/mach-omap2/omap4-common.c | 3 ++-
>>> 1 files changed, 2 insertions(+), 1 deletions(-)
>>
>>> diff --git a/arch/arm/mach-omap2/omap4-common.c
>>> b/arch/arm/mach-omap2/omap4-common.c
>>> index 4791370..4904025 100644
>>> --- a/arch/arm/mach-omap2/omap4-common.c
>>> +++ b/arch/arm/mach-omap2/omap4-common.c
>>> @@ -121,7 +121,8 @@ static int __init omap_l2_cache_init(void)
>>>
>>> /* Static mapping, never released */
>>> l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
>>> - BUG_ON(!l2cache_base);
>>> + if (WARN_ON(!l2cache_base))
>>> + return -ENODEV;
>>
>> Rather ENOMEM...
>>
> Nope. Even though it's related to memory, it's
> a memory controller so DEV is right.

No it's not.  The most likely reason ioremap() fails is because:

1. it's run out of memory for the metadata or page tables.
2. you passed it an invalid memory type (unlikely, you're using ioremap
   which uses a fixed known good type).
3. the address was >4GB but was not section aligned (also unlikely).

Therefore, the error code should be "out of memory" not "no such device".
