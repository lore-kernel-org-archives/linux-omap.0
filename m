From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device registration
Date: Thu, 16 Sep 2010 07:16:44 -0700
Message-ID: <87hbhphiyb.fsf@deeprootsystems.com>
References: <1282647866-6918-8-git-send-email-manjugk@ti.com>
	<87lj7iv8zv.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A8F@dbde02.ent.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94027843B8E7@dbde02.ent.ti.com>
	<20100914102407.GC7554@legolas.emea.dhcp.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94027843B9A8@dbde02.ent.ti.com>
	<20100914115711.GE7554@legolas.emea.dhcp.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94027843BAE5@dbde02.ent.ti.com>
	<20100915071116.GE3393@legolas.emea.dhcp.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94027843C3C3@dbde02.ent.ti.com>
	<20100916060329.GZ3393@legolas.emea.dhcp.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94027843C55C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35981 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245Ab0IPOQz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 10:16:55 -0400
Received: by pwi3 with SMTP id 3so415384pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Sep 2010 07:16:55 -0700 (PDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027843C55C@dbde02.ent.ti.com>
	(Manjunath Kondaiah G.'s message of "Thu, 16 Sep 2010 12:02:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

>> -----Original Message-----
>> From: Balbi, Felipe 
>> Sent: Thursday, September 16, 2010 11:33 AM
>> To: G, Manjunath Kondaiah
>> Cc: Balbi, Felipe; Kevin Hilman; linux-omap@vger.kernel.org; 
>> Cousson, Benoit; Shilimkar, Santosh
>> Subject: Re: [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device 
>> registration
>> 
>> Hi,
>> 
>> On Wed, Sep 15, 2010 at 10:40:08PM -0500, G, Manjunath Kondaiah wrote:
>> >In that case, the dma_read/dma_write macros will be splitted into:
>> >
>> >static inline void omap1_dma_write(...); static inline void 
>> >omap2_dma_write(...); static inline u32 omap1_dma_read(...); static 
>> >inline u32 omap2_dma_read(...);
>> >
>> >i.e., Two macro definitions will expand into four internal functions.
>> 
>> why do you need separate methods for omap1 and omap2 ??
>
> Current macro definition is:
>
> #define dma_read(reg)                                                   \
> ({                                                                      \
>         u32 __val;                                                      \
>         if (cpu_class_is_omap1())                                       \
>                 __val = __raw_readw(omap_dma_base + OMAP1_DMA_##reg);   \
>         else                                                            \
>                 __val = __raw_readl(omap_dma_base + OMAP_DMA4_##reg);   \
>         __val;                                                          \
> })
>
> Since we are expanding abbrevated register offsets into full macro, hence
> these macros should be used in respective read/write functions(omap1 and omap2plus).
>
> Any other better methods?

Yes.

This is a common problem and is handled in many OMAP drivers using
methods like Felipe described.

There are many examples, but a recent one is the i2c driver which has
different register map between omap2/3 and omap4.  Have a look
at drivers/i2c/busses/i2c-omap.c

Kevin
