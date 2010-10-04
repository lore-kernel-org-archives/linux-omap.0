From: Pramod <pramod.gurav@ti.com>
Subject: Re: beagle hangs in uart3 disabling clocks
Date: Mon, 4 Oct 2010 17:47:58 +0530
Message-ID: <4CA9C5F6.7060902@ti.com>
References: <AANLkTi=9T=5swvF2UcrfDAL8cpHOcfpOU3Fi1O50Z6Tm@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593023412B5A0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55122 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755429Ab0JDMRu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Oct 2010 08:17:50 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593023412B5A0@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Sanjeev,
>> I just tested pm branch of tony's linux-omap-2.6 tree, and found my
>> beagle will hang in uart3 disabling clocks, follows the log info:
>>
>>
> [snip]..[snip]
>
>>
>> Texas Instruments X-Loader 1.41
>> Starting OS Bootloader...
>>
>>
>> U-Boot 1.3.3 (Jul 10 2008 - 16:33:09)
>>
>> OMAP3530-GP rev 2, CPU-OPP2 L3-165MHz
>> OMAP3 Beagle Board + LPDDR/NAND
>> DRAM:  128 MB
>> NAND:
>
> Lei,
>
> Couldn't help noticing the version information for x-loader and
> u-boot. Both seem to be quite old...
>
> Could you try update both? May be, there is a dependency...
>
I am seeing the same issue with console on UART3 on zoom3 board. The 
bootloaders are older. Can you please share a link to latest bootloader 
which will have zoom3 support.

I am using L25_INC3.x android kernel. The board hangs as soon as it 
boots the kernel. Enabling the logs shows us that the hang occurs when 
UART3 clocks are being disabled in omap_hwmod.c as mentioned by Lei 
Ming. Has anyone observed this issue on any of omap boards?

> ~sanjeev
>
>>
