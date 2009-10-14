From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: RE: Memory performance / Cache problem
Date: Wed, 14 Oct 2009 08:59:05 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B235D5C@dlee02.ent.ti.com>
References: <20091012083806.323990@gmx.net>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDE1FF2C@dbde02.ent.ti.com>
 <20091013081651.300080@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60920 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753464AbZJNN7o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 09:59:44 -0400
In-Reply-To: <20091013081651.300080@gmx.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "epsi@gmx.de" <epsi@gmx.de>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> There is no newer u-boot from TI available. There is a SDK 02.01.03.11
> but it contains the same uboot 2008.10 with the only addition of the second
> generation of EVM boards with another network chip.
>
> So I checked the uboot from git, but this doesn't support Microns NAND Flash
> anymore. It is just working with ONENAND.
>
> I found a patch which shows the L2 Cache status while kernel boot and
> implemented it : L2 Cache seems to be already enabled - so this is not the
> reason.
>
> So any other ideas?

Are you confident your memory bus isn't running at 1/2 speed?

I recall there was a couple day window during wtbu kernel upgrades where memory bus speed with pm was running 1/2 speed after kernel started up.  This was somewhat a side effect of constraints frame work and a regression in forward porting. It seems unlikely psp kernel would have shipped with this bug but its something to check. This would match your results.

If your memcpy() is neon based then I might be worried about l1neon-caching effects along with factors of (exlcusive-l1-l2-read-allocate cache + pld not being effective on l1 only l2).

Which memcpy test are you using? Something in lmbench or just one you wrote.  Generally results are a little hard to interpret with exclusive cache behavior in 3430's r1px core.  3630's r3p2 core gives more traditional results as exclusive feature has been removed by arm.

If you have the ability using Lauterbach + per file will allow internal space dump which will show all critical parameters during test.  It's a 1 minute check for someone who has done it before to ensure the few parameters needed are in line.  I can send an example off line of how to do capture.  I won't have time to expand on all relevant parameters.

Regards,
Richard W.

