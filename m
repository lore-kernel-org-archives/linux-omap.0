From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v1 0/9] OMAP: DMA: hwmod and DMA as platform device
Date: Tue, 14 Dec 2010 16:18:09 -0800
Message-ID: <87ipyvriri.fsf@deeprootsystems.com>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
	<20101214231922.GC14990@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35257 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665Ab0LOASP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 19:18:15 -0500
Received: by yxt3 with SMTP id 3so736429yxt.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 16:18:13 -0800 (PST)
In-Reply-To: <20101214231922.GC14990@atomide.com> (Tony Lindgren's message of
	"Tue, 14 Dec 2010 15:19:23 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> * G, Manjunath Kondaiah <manjugk@ti.com> [101203 19:33]:
>> *************************************************************************
>> 
>> Test Report:
>> ************
>> Build:
>> omap2plus_defconfig    : Success
>> omap_osk_5912_defconfig: Success
>> 
>> Boot:
>> OMAP3530Beagle         : Success
>> OMAP4430Blaze(ES2.1)   : Success
>
> Can you please make sure that memory to memory DMA test
> runs OK on OSK5912?x
>
> AFAIK, Kevin tried it a few days ago and it hung.

Yes, it hung, but I didn't have time to debug the root cause until
today.

The reason is that the OMAP1 DMA IRQ numbers used in mach-omap1/dma.c
have no basis in reality. So doing a memory-to-memory transfer using
*all* channels results in spurious interrupts, then hangs.

Will post details in reply to the OMAP1 patch (7/9). 

Kevin
