From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: Build broken on linus/master?
Date: Fri, 26 Oct 2012 14:29:28 +0530
Message-ID: <508A50F0.2030308@ti.com>
References: <B5906170F1614E41A8A28DE3B8D121433EBE9565@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33124 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757469Ab2JZI7t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 04:59:49 -0400
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EBE9565@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: shuah.khan@hp.com, m.szyprowski@samsung.com
Cc: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Friday 26 October 2012 01:18 PM, Bedia, Vaibhav wrote:
> Hi,
>
> Compiling the current linus/master (2ab3f29) using omap2plus_defconfig
> throws up the following error
>
> $make -j7 uImage
>    CHK     include/generated/uapi/linux/version.h
>    CHK     include/generated/utsrelease.h
> make[1]: `include/generated/mach-types.h' is up to date.
>    CC      arch/arm/kernel/asm-offsets.s
> In file included from include/linux/dma-mapping.h:76:0,
>                   from arch/arm/kernel/asm-offsets.c:15:
> /datalocal/kernel/arch/arm/include/asm/dma-mapping.h: In function 'dma_mapping_error':
> /datalocal/kernel/arch/arm/include/asm/dma-mapping.h:94:2: error: implicit declaration of function 'debug_dma_mapping_error'
> make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1
> make: *** [prepare0] Error 2
>
Looks like it might break build on all ARM machines. I just
noticed a patch adding debug_dma_mapping_error() for aarm64 arch.

Marek, Shuah,
Is kernel missing a patch which adds definition of
debug_dma_mapping_error() to linux/dma-debug.h ?

I can't seems to find this symbol in kernel grep.

Regards
Santosh
