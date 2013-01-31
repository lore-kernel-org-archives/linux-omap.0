From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ARM: omap2: register cpufreq-cpu0 device for am33xx
Date: Thu, 31 Jan 2013 20:31:30 +0800
Message-ID: <20130131123128.GC2735@S2101-09.ap.freescale.net>
References: <1359556342-17020-1-git-send-email-shawn.guo@linaro.org>
 <331ABD5ECB02734CA317220B2BBEABC13EAF9DD9@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:16817
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751339Ab3AaMbh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Jan 2013 07:31:37 -0500
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EAF9DD9@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>

On Thu, Jan 31, 2013 at 09:40:43AM +0000, AnilKumar, Chimata wrote:
> On Wed, Jan 30, 2013 at 20:02:22, Shawn Guo wrote:
> > The cpufreq-cpu0 driver changes to instantiate use platform_driver
> > mechanism.  The patch is an am33xx platform level adaptation for it.
> 
> Tested-by: AnilKumar Ch <anilkumar@ti.com>
> 
Thanks, AnilKumar.

> Hi Shawn,
> 
> I have tested your patch on AM335x-EVM, no issues observed.
> 
> I think, better post v3 version which contains this patch
> and cpu0-cpufreq driver changes.
> 
> Or
> 
> Post v3 of cpufreq-cpu0 driver changes. 
> 
Sorry for forgetting copying you guys.  It's been posted as below.

http://www.spinics.net/lists/arm-kernel/msg221209.html

Shawn

