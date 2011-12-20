From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: Interesting L3 driver panic on v3.2-rc5 on 3530
Date: Tue, 20 Dec 2011 23:15:38 +0400
Message-ID: <4EF0DEDA.8040401@emcraft.com>
References: <alpine.DEB.2.00.1112161859190.12660@utopia.booyaka.com> <loom.20111220T013434-130@post.gmane.org> <4EF07E2A.7030201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:46260 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab1LTTPH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Dec 2011 14:15:07 -0500
In-Reply-To: <4EF07E2A.7030201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, "paul@pwsan.com" <paul@pwsan.com>

Hi Archit,

On 20.12.2011 16:23, Archit Taneja wrote:
>>> [    0.238494] Kernel BUG at c0033e34 [verbose debug info unavailable]
>>> [    0.245025] Internal error: Oops - undefined instruction: 0 [#1] SMP
>>> [    0.262390] PC is at omap3_l3_app_irq+0x108/0x12c
>>
>> I'm getting the same error on one of my AM3517 boards.
>> L3_SI_FLAG_STATUS_0 register has bit 15 set that means Display SS IA
>> burst
>> timeout according to the RM.
>>
>> Regards, Ilya.
> 
> Do the bootloaders on these boards enable display?

Yes, U-Boot on the problematic board enables the display. Disabling
display support in U-Boot makes this problem go away.

> There was a patch which got into the kernel in 3.2-rc4:
> 
> b923d40dd4211c4ef7d4efa2bd81b7ca1d8744c1
> ARM: OMAP2PLUS: DSS: Ensure DSS works correctly if display is enabled in
> bootloader
> 
> This tries to disable any display outputs if enabled in bootloader. If
> this issue didn't happen before, we might want to look into this code.

Hm. I can't say reverting this patch solves the problem completely. It
seems to me that the bug triggers more rarely without this patch but I
can't say for sure: it might be just a coincedence.

> Could you share what debug prints you get from the function
> omap_dss_reset() (its in arch/arm/mach-omap2/display.c)

I can't see much debug output from this function/file. The only line is

dss_core: softreset done

and it's the same regardless of the bug was triggered or not.

Do you wish me to add some debugging output and present the results? It
would be great if you could say what data to dump.

Regards, Ilya.
