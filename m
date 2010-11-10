From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v3 10/13] OMAP: DMA: Convert DMA library into DMA
 platform Driver
Date: Wed, 10 Nov 2010 22:53:16 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7D81@dbde02.ent.ti.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-11-git-send-email-manjugk@ti.com>
	<8739rakubj.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CC0@dbde02.ent.ti.com>
 <87sjz9cfkv.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58857 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757117Ab0KJRXY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 12:23:24 -0500
In-Reply-To: <87sjz9cfkv.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Wednesday, November 10, 2010 9:54 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Cousson, Benoit; 
> Shilimkar, Santosh
> Subject: Re: [PATCH v3 10/13] OMAP: DMA: Convert DMA library 
> into DMA platform Driver
> 
[...]
> >> > +#define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* 
> >> REVISIT: Is this 32 + 2? */
> >> > +
> >> 
> >> There are no users of this in this patch, all users are removed.
> >
> > This macro is used in hwmod data base. Do you mean hard coding this
> > value in hwmod db and remove header?
> 
> What I mean is that from a reviewers perspective of this patch, you
> added a new #define that is not used anywhere in this patch.  
> a #define
> should be added along with any users of it.

No. This macro is used in omap2+ hwmod db through plat/dma.h which includes
mach/dma.h

> 
> That being said, the number of channels of the DMA IP sounds like
> something that should indeed be associated with the hwmod as it is a
> fixed HW feature.
If so, I can remove this  macro and hard code in hwmod db.

-Manjunath