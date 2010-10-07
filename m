From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 09/10] OMAP2/3: Convert write/read functions to raw
 read/write
Date: Thu, 7 Oct 2010 14:50:13 -0500
Message-ID: <4CAE2475.4090607@ti.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com> <1285063280-4057-10-git-send-email-manjugk@ti.com> <7A436F7769CA33409C6B44B358BFFF0C014F74831E@dlee02.ent.ti.com> <20101007185630.GA26435@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38916 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754794Ab0JGTuX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Oct 2010 15:50:23 -0400
In-Reply-To: <20101007185630.GA26435@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Russell King - ARM Linux had written, on 10/07/2010 01:56 PM, the following:
> On Thu, Oct 07, 2010 at 07:17:08AM -0500, Menon, Nishanth wrote:
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>> owner@vger.kernel.org] On Behalf Of G, Manjunath Kondaiah
>>> Sent: Tuesday, September 21, 2010 5:01 AM
>>> To: linux-omap@vger.kernel.org
>>> Cc: linux-arm-kernel@lists.infradead.org; linux-mtd@lists.infradead.org
>>> Subject: [PATCH v2 09/10] OMAP2/3: Convert write/read functions to raw
>>> read/write
>>>
>>> Following sparse warnings exists due to use of writel/w and readl/w
>>> functions.
>>>
>>> This patch fixes the sparse warnings by converting readl/w functions usage
>>> into
>>> __raw_readl/__raw_readw functions.
>> Apologies on bringing up an old topic here -> Is'nt it better to fix
>> readl/w or writel/w than replacing it with __raw_readl/w etc?
> 
> No.  If you're getting sparse warnings its because _you_ are using
> readl/writel wrongly.
> 
> They take a void __iomem pointer, not a u32, unsigned long, int, or
> even a void pointer.
void __iomem *p;
...

readl(p);

unrolls to:
({ u32 __v = ({ u32 __v = (( __u32)(__le32)(( __le32) ((void)0, 
*(volatile unsigned int *)((p))))); __v; }); __asm__ __volatile__ ("mcr 
p15,
, %0, c7, c10, 5" : : "r" (0) : "memory"); __v; });

({ u32 __v = ({ u32 __v

seems to be the obvious cause of sparse warnings such as that attempted 
to be fixed in [1]

  warning: symbol '__v' shadows an earlier one

my comment being that by moving {read,write}[wlb] to __raw versions dont 
solve the real issue of namespace here. fix should be in 
arch/arm/include/asm/io.h IMHO. so that there are no overlaps as this.

[1]http://marc.info/?l=linux-omap&m=128506333803725&w=2

-- 
Regards,
Nishanth Menon
