From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: X-loader / U-Boot query
Date: Thu, 08 Oct 2009 08:48:22 -0600
Message-ID: <4ACDFBB6.1080101@mlbassoc.com>
References: <4ACDE1DF.1010303@mlbassoc.com> <4ACDFB52.2080100@astc-design.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:56688 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758222AbZJHOtC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 10:49:02 -0400
In-Reply-To: <4ACDFB52.2080100@astc-design.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adam Machalek <adam.machalek@astc-design.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 10/08/2009 08:46 AM, Adam Machalek wrote:
> The problem is located in u-boot/cpu/arm_cortexa8/omap3/mem.c
>
> Function do_sdrc_init()
>
> There is an assumption that the RAM size on each CS is maximum of 128M.
> See this line:
>
> writel(RASWIDTH_13BITS | CASWIDTH_10BITS | ADDRMUXLEGACY |
> RAMSIZE_128 | BANKALLOCATION | B32NOT16 | B32NOT16 |
> DEEPPD | DDR_SDRAM, &sdrc_base->cs[cs].mcfg);

Thanks, I had already found this.  What I was _hoping_ was that
someone had already fixed this for the larger devices...

When I get it figured out, how/where do I pass the info so the
next guy doesn't get stuck here as well??

> Gary Thomas wrote:
>> I have a new board - OMAP 3530 with 512MB DRAM & NAND
>> I've build X-loader and U-Boot for it and it mostly comes
>> up. The sources I used (based on recommendations from the
>> BeagleBoard pages) were:
>> http://git.gitorious.org/x-load-omap3/mainline.git
>> git://git.denx.de/u-boot.git
>>
>> I had to make a small change to get it to recognize the
>> larger NAND FLASH device.
>>
>> The problem I have now is that it's only seeing 1/2 (256MB)
>> of the available DRAM.
>>
>> * Does anyone know how to get it to see all 512MB?
>> * Is there a better place to ask/discuss these questions?
>> A cursory look around did not point to anything fresh (most
>> of the web pages & Wikis I looked are are _years_ old)
>>
>> Thanks for any help/pointers
>>

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
