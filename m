From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: Re: Memory performance  / Cache problem
Date: Mon, 12 Oct 2009 11:35:15 +0300
Message-ID: <200910121135.15191.siarhei.siamashka@nokia.com>
References: <20091012075409.186580@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:62591 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbZJLIhA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 04:37:00 -0400
In-Reply-To: <20091012075409.186580@gmx.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext epsi@gmx.de" <epsi@gmx.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Monday 12 October 2009 10:54:09 ext epsi@gmx.de wrote:
> I found the memory performance of newer kernels are quit poor on an
> EVM-Omap3 board. It works with 2-6 times performance on the old 2.6.22
> kernel from TI's PSP.
>
> Possible reasons:
> - problem in config the kernel (did omap3_evm_defconfig)
> - problem in kernel
> - kernel expects some settings from uboot, which are not done there
>
> I have tried the 2.6.29rc3 (from TI's PSP) and the 2.6.31 from git-tree.
> Both behave quite simular:
>
> Transport in MByte:
>   memcpy =   204.073, loop4 =   183.212, loop1 =    81.693, rand =
> 4.534
>
> while the 22 kernel:
>  memcpy =   453.932, loop4 =   469.934, loop1 =   125.031, rand =
> 29.631
>
> Can someone give me help or can at least confirm that?

The numbers from 2.6.22 kernel look much better than anything I have ever
seen with OMAP3.

How are you doing benchmarking? Is source buffer properly initialized?

The point is that if you just happen to allocate a large buffer without
initializing it, it may end up having all the memory pages referencing to a
single zero page in physical memory. In this case reading from this buffer
will in fact be perfectly cached in L1 cache and memcpy would look fast.

If it is not the case, investigating how to boost memory performance in the
latest kernels is very interesting for sure.

-- 
Best regards,
Siarhei Siamashka
