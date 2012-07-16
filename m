From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH RESEND V3 0/3] Watchdog: OMAP3: bootstatus fix and
 changes for the current watchdog framework
Date: Mon, 16 Jul 2012 13:10:13 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA6DFAE@DBDE01.ent.ti.com>
References: <1342338246-29101-1-git-send-email-zumeng.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52150 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808Ab2GPNLC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jul 2012 09:11:02 -0400
In-Reply-To: <1342338246-29101-1-git-send-email-zumeng.chen@windriver.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zumeng Chen <zumeng.chen@windriver.com>, "Hilman, Kevin" <khilman@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Cc: "wim@iguana.be" <wim@iguana.be>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sun, Jul 15, 2012 at 13:14:03, Zumeng Chen wrote:
> Hello,
> 
> The following patches based on the 3.5-rc6 from Wim, which
> focus on:
> 
> 1. bootstatus fix for omap3,
> 
> 2. omap-wdt framework update cater for the current framework
>    as Shubhrajyoti comments mentioned.
> 
> V3 changes:
> 
> 1. New comments updated as Kevin mentioned in the third patch;
> 2. 3530evm works well,
>    AM33xx seems work well with the following changes:
> 	+   if (cpu_is_am335x())
> 	+       return omap2_prm_read_mod_reg(AM33XX_PRM_DEVICE_MOD,
> 	+           AM33XX_PRM_RSTST_OFFSET) & 0x7f;
>    But since some definitions not ready for am33xx, so I don't
>    give the patch, if they have been updated, feel free to take these. 
> 

Did you test it on any of AM33xx platform? If you use linux-omap/master pr 
linux-next branch as a baseline you should have basic things (except hwmod 
data) available.

I will test it and send a patch for this on your behalf (if you are ok with 
it).


Note: Change in convention, cpu_is_am335x() => soc_is_am335x()

Thanks,
Vaibhav


