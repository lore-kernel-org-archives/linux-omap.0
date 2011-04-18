From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [RFC PATCH v2] Consolidate SRAM support
Date: Mon, 18 Apr 2011 17:31:31 +0800
Message-ID: <BANLkTimKvRbrrm7sxcYRpRe+FMH-kTNoiQ@mail.gmail.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<20110418085259.GA26044@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48720 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab1DRJbc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 05:31:32 -0400
Received: by ywj3 with SMTP id 3so1192266ywj.19
        for <linux-omap@vger.kernel.org>; Mon, 18 Apr 2011 02:31:31 -0700 (PDT)
In-Reply-To: <20110418085259.GA26044@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Apr 18, 2011 at 4:52 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This is the second revision of this patch. =A0I've not moved it out o=
f
> ARM yet as I haven't had a positive response from SH yet.
>
> It's now called pv_pool (for phys/virt pool) rather than sram_pool,
> and I've included MXC's iram support in this. =A0Hopefully, if OMAP c=
an
> remove the FB stuff from SRAM we can clean the OMAP bits up a little
> more. =A0Neither have I sorted out the last reference to omap_sram_ce=
il.
> Some comments from OMAP people on what's going on there would be good=
=2E
>
> On Fri, Apr 15, 2011 at 02:06:07PM +0100, Russell King - ARM Linux wr=
ote:
>> This is work in progress.
>>
>> We have two SoCs using SRAM, both with their own allocation systems,
>> and both with their own ways of copying functions into the SRAM.
>>
>> Let's unify this before we have additional SoCs re-implementing this
>> obviously common functionality themselves.
>>
>> Unfortunately, we end up with code growth through doing this, but th=
at
>> will become a win when we have another SoC using this (which I know
>> there's at least one in the pipeline).
>>
>> One of the considerations here is that we can easily convert sram-po=
ol.c
>> to hook into device tree stuff, which can tell the sram allocator:
>> =A0 =A0 =A0 - physical address of sram
>> =A0 =A0 =A0 - size of sram
>> =A0 =A0 =A0 - allocation granularity
>> and then we just need to ensure that it is appropriately mapped.
>>
>> This uses the physical address, and unlike Davinci's dma address usa=
ge,
>> it always wants to have the physical address, and will always return
>> the corresponding physical address when passed that pointer.
>>
>> OMAP could probably do with some more work to make the omapfb and ot=
her
>> allocations use the sram allocator, rather than hooking in before th=
e
>> sram allocator is initialized - and then further cleanups so that we
>> have an initialization function which just does
>>
>> sram_create(phys, size)
>> =A0 =A0 =A0 virt =3D map sram(phys, size)
>> =A0 =A0 =A0 create sram pool(virt, phys, size, min_alloc_order)
>>
>> Another question is whether we should allow multiple SRAM pools or n=
ot -
>> this code does allow multiple pools, but so far we only have one poo=
l
>> per SoC. =A0Overdesign? =A0Maybe, but it prevents SoCs wanting to du=
plicate
>> it if they want to partition the SRAM, or have peripheral-local SRAM=
s.
>>
Multiple SRAM pool does exist in Marvell MMP2 silicon. So it won't be
overdesign.

>> Lastly, uio_pruss should probably take the SRAM pool pointer via
>> platform data so that it doesn't have to include Davinci specific
>> includes.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
