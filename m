From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/3] staging: tidspbridge: remove memory consistency from
 TODO list
Date: Mon, 11 Oct 2010 14:16:54 +0300
Message-ID: <AANLkTikq80dM_93k2byPXDexzz3J+g3Wiva3ieBbXmmf@mail.gmail.com>
References: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com>
	<1286732440-28644-4-git-send-email-felipe.contreras@gmail.com>
	<201010111240.25759.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62336 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926Ab0JKLQ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 07:16:56 -0400
Received: by bwz15 with SMTP id 15so1591201bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 11 Oct 2010 04:16:54 -0700 (PDT)
In-Reply-To: <201010111240.25759.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>

On Mon, Oct 11, 2010 at 1:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 10 October 2010, Felipe Contreras wrote:
>> The mempool area is not handled by the kernel any more.
>
> But tidspbridge still uses ioremap to set up the mapping for RAM,
> even though it now is outside of the kernel linar mapping.

Which is what ioremap() complained about, and how Russell King
suggested to solve the issue.

> You should really only use ioremap on MMIO registers, nothing
> else. These registers are marked as __iomem pointers and can only
> be passed into functions that talk to the hardware like iowrite32
> or writel, but not used like memory.

>From what I can see parts of this memory are also used for readl/writel.

> Please have a look at "sparse", which will warn about address space
> violations among other things. The tidspbridge driver is full of them,
> and you should fix the code that sparse warns about, which will
> also show you all the places where ioremap is used incorrectly.

In one of my branches I moved ioremap() to arch/arm/mach-omap2/dsp.c
and if I use sparse there, it gives no warning.

I would prefer to map the memory some other way and make it
non-cacheable, but I don't know any other way. Then, if readl/writel
are still needed, only ioremap() that area. And finally, and
hopefully, do cache flushes instead of requiring consistent memory.

Cheers.

-- 
Felipe Contreras
