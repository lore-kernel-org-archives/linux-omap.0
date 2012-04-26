From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree
 data
Date: Thu, 26 Apr 2012 06:59:58 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FEBA6@DBDE01.ent.ti.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
 <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204260017540.30642@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42660 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985Ab2DZHAH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Apr 2012 03:00:07 -0400
In-Reply-To: <alpine.DEB.2.00.1204260017540.30642@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Apr 26, 2012 at 11:54:51, Paul Walmsley wrote:
> 
> Hi Vaibhav, Afzal, Vaibhav,
> 
> while working on clock33xx_data.c, it became clear that we would not be 
> able to remove the MODULEMODE leaf clocks for several IP blocks that share 
> driver code with other DaVinci chips.  This is because:
> 
> 1. the drivers for these IP blocks only use the clock framework, rather 
> than runtime PM;
> 
> and 
> 
> 2. the clk_get() calls in those drivers do not specify a con_id 
> parameter, which could cause problems with the clkdev clk_find()'s fuzzy 
> matching algorithm.
> 
> So perhaps your group can work on converting the drivers to use runtime 
> PM?  Discussing this with Kevin, it sounds like DaVinci doesn't have 
> runtime PM hooks implemented, but you can probably use OMAP1 as an example 
> of how to do it.
> 
> And then if clk_get() is still needed in the drivers, a specific con_id 
> should be supplied, such as "fck", which can also be supplied by the OMAP 
> codebase.
> 
> 

Honestly, I don't want to block AM33xx stuff getting into mainline due to 
missing feature in Davinci.

Also, since AM33xx is not fully supported in the mainline (from peripheral 
perspective), it really should not break anything as of now.

I am expecting, AM33xx core patches will get in by v3.5 and then while 
adding peripheral support we will take Davinci migration activity, and can
make sure that nothing breaks (for all Davinci, OMAP and AM33xx).

Thanks,
Vaibhav

