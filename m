From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: dts: OMAP4+: Correct L3 interrupts
Date: Fri, 5 Apr 2013 13:55:33 +0530
Message-ID: <515E8A7D.8000401@ti.com>
References: <1365098790-9078-1-git-send-email-jon-hunter@ti.com> <515E6EAE.9000107@ti.com> <515E8677.40404@ti.com> <515E89BA.9010709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38239 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab3DEIXj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Apr 2013 04:23:39 -0400
In-Reply-To: <515E89BA.9010709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Friday 05 April 2013 01:52 PM, Benoit Cousson wrote:
> Santosh and Jon,
> 
> On 04/05/2013 10:08 AM, Benoit Cousson wrote:
>> On 04/05/2013 08:26 AM, Santosh Shilimkar wrote:
>>> On Thursday 04 April 2013 11:36 PM, Jon Hunter wrote:
>>>> The L3 interrupt numbers are incorrect for OMAP4+ and are conflicting
>>>> with some of the timer interrupts causing the allocation of timer
>>>> interrupts to fail.
>>>>
>>>> The problem is caused by adding 32 to the interrupt number for the L3
>>>> interrupts to account for per processor interrupts (PPI) and software
>>>> generated interrupts (SGI) which typically are mapped to the first 32
>>>> interrupts in the ARM GIC. This is not necessary because the first
>>>> parameter of the ARM GIC interrupt property specifies the GIC interrupt
>>>> type (ie. SGI, PPI, etc). Hence, fix the interrupt number fo the L3
>>>> interrupts by substracting 32.
>>>>
>>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>>> ---
>>>>
>>>> Please note that this problem is observed in Benoit's for_3.10/dts branch [1].
>>>>
>>>> [1] http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git
>>>>
>>> Thats correct. I overlooked the 32 addition part. This patch should
>>> also be pulled into Benoit's 3.10 tree.
>>
>> Done. I've just applied it. But I will probably merge it with the
>> original patch, because having a broken patch and the fix in the same
>> pull request does not look right.
> 
> Please find below the fixed version.
> 
Thanks Benoit. Patch looks fine to me.

Regards,
Santosh

