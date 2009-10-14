From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: RE: RE: Memory performance / Cache problem
Date: Wed, 14 Oct 2009 10:25:12 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B235EFA@dlee02.ent.ti.com>
References: <20091012083806.323990@gmx.net>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDE1FF2C@dbde02.ent.ti.com>
 <20091013081651.300080@gmx.net>
 <13B9B4C6EF24D648824FF11BE8967162039B235D5C@dlee02.ent.ti.com>
 <20091014144839.115530@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38823 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934514AbZJNP0B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 11:26:01 -0400
In-Reply-To: <20091014144839.115530@gmx.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "epsi@gmx.de" <epsi@gmx.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Premi, Sanjeev" <premi@ti.com>


> From: epsi@gmx.de [mailto:epsi@gmx.de]
> Sent: Wednesday, October 14, 2009 9:49 AM
> To: Woodruff, Richard; linux-omap@vger.kernel.org; Premi, Sanjeev
> Subject: Re: RE: RE: Memory performance / Cache problem
>
> Mem clock is both times 166MHz. I don't know whether are differences in cycle
> access and timing, but memclock is fine.

How did you physically verify this?

> Following Siarhei hints of initialize the buffers (around 1.2 MByte each)
> I get different results in 22kernel for use of
> malloc alone
> memcpy =   473.764, loop4 =   448.430, loop1 =   102.770, rand =    29.641
> calloc alone
> memcpy =   405.947, loop4 =   361.550, loop1 =    95.441, rand =    21.853
> malloc+memset:
> memcpy =   239.294, loop4 =   188.617, loop1 =    80.871, rand =     4.726
>
> In 31kernel all 3 measures are about the same (unfortunatly low) level of
> malloc+memset in 22.

Yes aligned buffers can make a difference.  But probably more so for small copies.  Of course you must touch the memory or mprotect() it so its faulted in, but indications are you have done this.

> I used a standard memcpy (think this is glib and hence not neonbased)?
> To be neonbased I guess it has to be recompiled?

The version of glibc in use can make a difference.  CodeSourcery in 2009 release added PLD's to mem operations.  This can give a good benefit.  It might be you have optimized library in one case and a non-optimized in another.

Regards,
Richard W.

