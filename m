From: Archit Taneja <a0393947@ti.com>
Subject: Re: Interesting L3 driver panic on v3.2-rc5 on 3530
Date: Tue, 20 Dec 2011 17:53:06 +0530
Message-ID: <4EF07E2A.7030201@ti.com>
References: <alpine.DEB.2.00.1112161859190.12660@utopia.booyaka.com> <loom.20111220T013434-130@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44500 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809Ab1LTMXd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Dec 2011 07:23:33 -0500
In-Reply-To: <loom.20111220T013434-130@post.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, "paul@pwsan.com" <paul@pwsan.com>

Hi Ilya,

On Tuesday 20 December 2011 06:09 AM, Ilya Yanok wrote:
> Hi Paul,
>
> Paul Walmsley<paul<at>  pwsan.com>  writes:
>> [    0.238494] Kernel BUG at c0033e34 [verbose debug info unavailable]
>> [    0.245025] Internal error: Oops - undefined instruction: 0 [#1] SMP
>> [    0.262390] PC is at omap3_l3_app_irq+0x108/0x12c
>
> I'm getting the same error on one of my AM3517 boards.
> L3_SI_FLAG_STATUS_0 register has bit 15 set that means Display SS IA burst
> timeout according to the RM.
>
> Regards, Ilya.

Do the bootloaders on these boards enable display?

There was a patch which got into the kernel in 3.2-rc4:

b923d40dd4211c4ef7d4efa2bd81b7ca1d8744c1
ARM: OMAP2PLUS: DSS: Ensure DSS works correctly if display is enabled in 
bootloader

This tries to disable any display outputs if enabled in bootloader. If 
this issue didn't happen before, we might want to look into this code.

Could you share what debug prints you get from the function 
omap_dss_reset() (its in arch/arm/mach-omap2/display.c)

Thanks,
Archit

>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

