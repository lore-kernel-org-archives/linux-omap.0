From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: RE: RE: RE: Memory performance / Cache problem
Date: Wed, 14 Oct 2009 12:36:38 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B23610D@dlee02.ent.ti.com>
References: <20091012083806.323990@gmx.net>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDE1FF2C@dbde02.ent.ti.com>
 <20091013081651.300080@gmx.net>
 <13B9B4C6EF24D648824FF11BE8967162039B235D5C@dlee02.ent.ti.com>
 <20091014144839.115530@gmx.net>
 <13B9B4C6EF24D648824FF11BE8967162039B235EFA@dlee02.ent.ti.com>
 <20091014172314.130150@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50675 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754107AbZJNRhY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 13:37:24 -0400
In-Reply-To: <20091014172314.130150@gmx.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "epsi@gmx.de" <epsi@gmx.de>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> From: epsi@gmx.de [mailto:epsi@gmx.de]
> Sent: Wednesday, October 14, 2009 12:23 PM
> To: Woodruff, Richard; Premi, Sanjeev; linux-omap@vger.kernel.org
> Subject: Re: RE: RE: RE: Memory performance / Cache problem

> > Yes aligned buffers can make a difference.  But probably more so for small
> > copies.  Of course you must touch the memory or mprotect() it so its
> > faulted in, but indications are you have done this.
>
> Mh, alignment (to an address) is done with malloc already. Probably you mean
> something different. I don't understand the difference. For me is
> malloc+memset=calloc.
> I'll send you the benchmark code, if you like.

Ok, if it compiles I could try on sdp3430 or sdp3630.

Alignment to a cache line is always best.  This is 64 bytes in A8.  Better yet, being 4K aligned is a good thing to reduce MMU effects.

> In both kernels I used the same rootfs (via NFS). Indeed I used CS2009q1 and
> its libs, but we are talking about factor 2..6. This must be something serious.

2009 pay version has optimized thrumb2 and arm mode libraries you download separately.  I don't recall if free/lite version integrated this.

> What is your feeling? Does the 22 something strange or are the newer kernels
> slower that they have to be.

There are a lot of differences between 22 kernel and current ones.  First things I'd check would be around MMU settings, special ARM cp15 memory control regs, then omap memory and clock settings.  Also some bad device could undercut you.  Always good to cat /proc/interrupts and make sure something isn't spewing.

> Would be interesting to see results on other Omap3 boards with both old an new
> kernels.

I've not noticed anything on sdp on somewhat recent kernels.

Regards,
Richard W.

