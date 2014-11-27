From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/23] ARM: OMAP2+: PRCM cleanups towards 3.19 / part2
Date: Thu, 27 Nov 2014 19:15:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1411271913040.1406@utopia.booyaka.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43106 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbaK0TPV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2014 14:15:21 -0500
In-Reply-To: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, nm@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, 27 Nov 2014, Tero Kristo wrote:

> Yet another PRCM cleanup set, towards making PRCM a separate driver.
> This set is most likely too late for 3.19, but hopefully it can make
> it to 3.20.

Yep too late for 3.19.

...

> Testing done:
> 

...

> omap3-beagle: boot, suspend (ret), suspend (off) (UART wakeup seems broken on 3.18-rc1 btw)

v3.18-rc1 UART wakeups worked here on both of the 35xx Beagles:

http://www.pwsan.com/omap/testlogs/test_v3.18-rc1/20141020095901/README.txt
http://www.pwsan.com/omap/testlogs/test_v3.18-rc1/20141020095901/pm/3530es3beagle/3530es3beagle_log.txt
http://www.pwsan.com/omap/testlogs/test_v3.18-rc1/20141020095901/pm/3530es31beagle/3530es31beagle_log.txt


- Paul
