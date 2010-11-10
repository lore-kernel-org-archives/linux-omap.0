From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 10/13] OMAP: DMA: Convert DMA library into DMA platform Driver
Date: Wed, 10 Nov 2010 09:56:46 -0800
Message-ID: <878w11awpt.fsf@deeprootsystems.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-11-git-send-email-manjugk@ti.com>
	<8739rakubj.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CC0@dbde02.ent.ti.com>
	<87sjz9cfkv.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7D81@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59754 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab0KJR4v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 12:56:51 -0500
Received: by qyk12 with SMTP id 12so3294473qyk.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Nov 2010 09:56:51 -0800 (PST)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7D81@dbde02.ent.ti.com>
	(Manjunath Kondaiah G.'s message of "Wed, 10 Nov 2010 22:53:16 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

>> >> > +#define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* 
>> >> REVISIT: Is this 32 + 2? */
>> >> > +
>> >> 
>> >> There are no users of this in this patch, all users are removed.
>> >
>> > This macro is used in hwmod data base. Do you mean hard coding this
>> > value in hwmod db and remove header?
>> 
>> What I mean is that from a reviewers perspective of this patch, you
>> added a new #define that is not used anywhere in this patch.  
>> a #define
>> should be added along with any users of it.
>
> No. This macro is used in omap2+ hwmod db through plat/dma.h which includes
> mach/dma.h

Which is not part of this patch.

Again, as a general rule, don't introduce code (#defines, headers,
functions, anything) in a patch if it is not used.

>> 
>> That being said, the number of channels of the DMA IP sounds like
>> something that should indeed be associated with the hwmod as it is a
>> fixed HW feature.
>>
> If so, I can remove this  macro and hard code in hwmod db.

OK, good.

Kevin

