From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Sat, 16 Apr 2011 21:01:26 +0800
Message-ID: <BANLkTikJwFRenjwnws+4J2ep9G0Nv-9aXw@mail.gmail.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63118 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab1DPNB1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Apr 2011 09:01:27 -0400
Received: by gxk21 with SMTP id 21so1353182gxk.19
        for <linux-omap@vger.kernel.org>; Sat, 16 Apr 2011 06:01:26 -0700 (PDT)
In-Reply-To: <20110415130607.GM1611@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Apr 15, 2011 at 9:06 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This is work in progress.
>
> We have two SoCs using SRAM, both with their own allocation systems,
> and both with their own ways of copying functions into the SRAM.
>
> Let's unify this before we have additional SoCs re-implementing this
> obviously common functionality themselves.
>
> Unfortunately, we end up with code growth through doing this, but tha=
t
> will become a win when we have another SoC using this (which I know
> there's at least one in the pipeline).
>
> One of the considerations here is that we can easily convert sram-poo=
l.c
> to hook into device tree stuff, which can tell the sram allocator:
> =A0 =A0 =A0 =A0- physical address of sram
> =A0 =A0 =A0 =A0- size of sram
> =A0 =A0 =A0 =A0- allocation granularity
> and then we just need to ensure that it is appropriately mapped.
>
> This uses the physical address, and unlike Davinci's dma address usag=
e,
> it always wants to have the physical address, and will always return
> the corresponding physical address when passed that pointer.
>
> OMAP could probably do with some more work to make the omapfb and oth=
er
> allocations use the sram allocator, rather than hooking in before the
> sram allocator is initialized - and then further cleanups so that we
> have an initialization function which just does
>
> sram_create(phys, size)
> =A0 =A0 =A0 =A0virt =3D map sram(phys, size)
> =A0 =A0 =A0 =A0create sram pool(virt, phys, size, min_alloc_order)
>
> Another question is whether we should allow multiple SRAM pools or no=
t -
> this code does allow multiple pools, but so far we only have one pool
> per SoC. =A0Overdesign? =A0Maybe, but it prevents SoCs wanting to dup=
licate
> it if they want to partition the SRAM, or have peripheral-local SRAMs=
=2E
>
> Lastly, uio_pruss should probably take the SRAM pool pointer via
> platform data so that it doesn't have to include Davinci specific
> includes.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

This common sram driver is good for us. It can benefit us on DMA usage.
I just have one question on SRAM for storing instruction. We still need=
 to
copy code into SRAM and flush cache & TLB with this SRAM driver.

TCM driver can allocate code into SRAM section in link stage. It needs =
to
update link file and virtual memory layout. Is it worth to make SRAM dr=
iver
support this behavior? The case of using SRAM as memory for instruction
is switching frequency or entering/exiting low power mode in PXA silico=
ns.

Thanks
Haojian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
