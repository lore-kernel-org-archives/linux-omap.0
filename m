From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V5 3/3] ARM: OMAP: Make OMAP clocksource source
 selection using kernel param
Date: Thu, 26 Apr 2012 16:40:19 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FF819@DBDE01.ent.ti.com>
References: <1335362340-14960-1-git-send-email-hvaibhav@ti.com>
 <1335362340-14960-4-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204260904580.10308@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50153 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758021Ab2DZQk0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Apr 2012 12:40:26 -0400
In-Reply-To: <alpine.DEB.2.00.1204260904580.10308@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

On Thu, Apr 26, 2012 at 20:40:34, Paul Walmsley wrote:
> Hi
> 
> a question
> 
> On Wed, 25 Apr 2012, Vaibhav Hiremath wrote:
> 
<snip>
> > +
> > +	sync32k_ick = clk_get(NULL, "omap_32ksync_ick");
> > +	if (!IS_ERR(sync32k_ick))
> > +		clk_enable(sync32k_ick);
> 
> You've added hwmod data for this IP block, which is good.  This will 
> presumably cause the IP block to be idled on boot.  But you haven't 
> converted this code to use either the hwmod enable code -- just using 
> clk_get() isn't enough.  (Better would be to use a driver and the PM 
> runtime functions, of course, but maybe this runs too early?)
> 
> If the 32k sync timer is in OCP force-idle, then that might produce the 
> hangs you're seeing.
> 

I tried disabling all idle related flags in hwmod entry but no change in 
observation, kernel still hangs.

I even conformed the register content by connecting debugger, and it is set 
to No-idle state.

Thanks,
Vaibhav
