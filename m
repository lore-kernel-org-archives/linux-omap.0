From: Sudeep K N <sudeepholla.maillist@gmail.com>
Subject: Re: Exception while handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Sat, 15 Aug 2009 18:33:20 +0530
Message-ID: <366f00c80908150603m2b6f3235y7e47256adc11234a@mail.gmail.com>
References: <0680EC522D0CC943BC586913CF3768C00378FF3971@dbde02.ent.ti.com>
	 <20090807220016.GG31543@n2100.arm.linux.org.uk>
	 <0680EC522D0CC943BC586913CF3768C003790C5B3A@dbde02.ent.ti.com>
	 <20090808170300.GA23481@n2100.arm.linux.org.uk>
	 <0680EC522D0CC943BC586913CF3768C003790C64CF@dbde02.ent.ti.com>
	 <20090813173327.GA14872@n2100.arm.linux.org.uk>
	 <0680EC522D0CC943BC586913CF3768C003790C6586@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:50930 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603AbZHONDV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 09:03:21 -0400
Received: by ewy10 with SMTP id 10so2052667ewy.37
        for <linux-omap@vger.kernel.org>; Sat, 15 Aug 2009 06:03:22 -0700 (PDT)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003790C6586@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Khasim,

As far as I understand there are two options:
1. memmap

I had intially tried memmap=xxM$yyM to reserve xxM at yyM
This has some issue with 2.6.27 and fixed in later versions(not sure
of exact version) and I have not tried it.
As Russell has mentioned the new option ARCH_HAS_HOLES_MEMORYMODEL is
the part of that fix I believe.
The bug was particular to few architecture including ARM(details at
http://lkml.org/lkml/2009/5/5/64)
With this option its only resevered and you can still mmap that memory.

2. mem

As an alternate, I tried spliting the memory to the kernel similar to
what you have tried.
mem=88M@0x80000000 mem=128M@0x88000000
But if you see how this is parsed by the kernel, you will see that the
kernel doesnot create any virtual
address space for the hole you have created. In otherwords the kernel
is totally unware of that memory.
So you cannot mmap that hole.

This is my understanding and please correct if I am wrong.

-- 
Regards,
Sudeep
