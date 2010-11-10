From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 01/13] OMAP: DMA: Replace read/write macros with functions
Date: Wed, 10 Nov 2010 09:35:41 -0800
Message-ID: <87lj51axoy.fsf@deeprootsystems.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-2-git-send-email-manjugk@ti.com>
	<87y692mb4e.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CBD@dbde02.ent.ti.com>
	<877hgldv40.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7D7B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50612 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab0KJRfp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 12:35:45 -0500
Received: by ywh2 with SMTP id 2so60213ywh.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Nov 2010 09:35:45 -0800 (PST)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7D7B@dbde02.ent.ti.com>
	(Manjunath Kondaiah G.'s message of "Wed, 10 Nov 2010 22:46:04 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>> Sent: Wednesday, November 10, 2010 9:33 PM
>> To: G, Manjunath Kondaiah
>> Cc: linux-omap@vger.kernel.org; 
>> linux-arm-kernel@lists.infradead.org; Cousson, Benoit; 
>> Shilimkar, Santosh
>> Subject: Re: [PATCH v3 01/13] OMAP: DMA: Replace read/write 
>> macros with functions
>> 
>> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
>> 
>> [...]
>> 
>> >> > +		if (reg > OMAP1_CH_COMMON_START)
>> >> > +			__raw_writew(val, dma_base +
>> >> > +				(reg_map_omap1[reg] + 
>> 0x40 * lch));
>> >> > +		else
>> >> > +			__raw_writew(val, dma_base + 
>> >> reg_map_omap1[reg]);
>> >> > +	} else {
>> >> > +		if (reg > OMAP2_CH_COMMON_START)
>> >> > +			__raw_writel(val, dma_base +
>> >> > +				(reg_map_omap2[reg] + 
>> 0x60 * lch));
>> >> > +		else
>> >> > +			__raw_writel(val, dma_base + 
>> >> reg_map_omap2[reg]);
>> >> > +	}
>> >> > +}
>> >> 
>> >> The register base offset, register array and the stride (offset
>> >> between instances: 0x40 or 0x60) are detectable at init time, and
>> >> there's no reason to have conditional code for them.  IOW, they
>> >> should be init time constants.  Doing so would greatly simply these
>> >> functions.  In fact the CH_COMMON_START could also be an init time
>> >> constant as well.  So, given the following init_time constants:
>> >> dma_ch_common_start, dma_stride, reg_map, the above would 
>> be reduced
>> >> to something actually worth inlining, for example (not actually
>> >> tested):
>> >> 
>> >> static inline void dma_write(u32 val, int reg, int lch)
>> >> {
>> >>         u8 stride = (reg > dma_ch_common_start) ? dma_stride : 0;
>> >> 
>> >>         __raw_writel(val, dma_base + (reg_map[reg] + 
>> stride * lch));
>> >> }
>> >> 
>> >> Same applies to dma_read().
>> >
>> > Thanks for the suggestion. It is taken care along with 
>> Tony's comment
>> > for handling these read/write's between omap1 and omap2+.
>> >
>> > Here is code snippet for handling both omap1(includes 16 bit
>> > registers) and omap2+ 
>> >
>> > static inline void dma_write(u32 val, int reg, int lch)
>> > {
>> >         u8  stride;
>> >         u32 offset;
>> >
>> >         stride = (reg >= dma_common_ch_start) ? dma_stride : 0;
>> >         offset = reg_map[reg] + (stride * lch);
>> >
>> >         if (dma_stride  == 0x40) {
>> 
>> The use of hard-coded constants still isn't right here.    This is
>> bascally the same as a cpu_is_omap1 check.  After you separate out the
>> device files, I thought you had separate omap1 and omap2+ versions of
>> these, so I don't follow the need for this.
>
> This code will be moved to respective mach-omapx dma files and this 
> conditional check vanishes automatically in PATCH 10/13. Since this patch
> targets  replacing read/write macros with inline functions, no functionality
> changes(except change in logic for handling  16bit registers for omap1) 
> are done with new patch hence handling omap1 and omap2+ is 
> done this way.
>
> I hope having the conditional check in this interim patch is ok.

Personally, I would rather not have an intermediate step, but if it
makes the series smoother, I guess it's OK.

Kevin
