From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 08/11] OMAP: DMA: Convert DMA library into DMA platform Driver
Date: Tue, 07 Sep 2010 15:45:29 -0700
Message-ID: <87aantgol2.fsf@deeprootsystems.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
	<1282647866-6918-9-git-send-email-manjugk@ti.com>
	<878w3iv4lw.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A91@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44583 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416Ab0IGWpc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 18:45:32 -0400
Received: by pvg2 with SMTP id 2so1939680pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Sep 2010 15:45:31 -0700 (PDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A91@dbde02.ent.ti.com>
	(Manjunath Kondaiah G.'s message of "Tue, 7 Sep 2010 17:17:42 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

[...]

>> > diff --git a/arch/arm/mach-omap1/include/mach/dma.h 
>> b/arch/arm/mach-omap1/include/mach/dma.h
>> > index d446cdd..1eb0d31 100644
>> > --- a/arch/arm/mach-omap1/include/mach/dma.h
>> > +++ b/arch/arm/mach-omap1/include/mach/dma.h
>> > @@ -77,4 +77,70 @@
>> >  #define OMAP1_DMA_CCR2(n)		(0x40 * (n) + 0x24)
>> >  #define OMAP1_DMA_LCH_CTRL(n)		(0x40 * (n) + 0x2a)
>> >  
>> > +/* Dummy defines to support multi omap code */
>> 
>> These should not be needed anymore as this is now an OMAP1-specific
>> header.
>
> Because it is OMAP1 specific header, there are common API's used between
> omap1 and omap2 plus in plat-omap/dma.c which needs these defines otherwise
> build will break for omap1 since these defines exists omap2 specific header
> Which is in respective mach directory.

OK, then the split you are proposing is not the right thing to do, or
more likely, the split was not taken far enough.

defines that are used in common code should be defined in a common
header, rather than duplicating them in both omap1 and omap2+ code.

When you find yourself putting OMAP1 defines in OMAP2+ code and vice
versa, it should be an indication that there is still some abstraction
missing in the split

Kevin
