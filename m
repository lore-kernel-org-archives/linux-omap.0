From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V5 3/3] ARM: OMAP: Make OMAP clocksource source
 selection using kernel param
Date: Fri, 27 Apr 2012 05:31:07 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA000B5@DBDE01.ent.ti.com>
References: <1335362340-14960-1-git-send-email-hvaibhav@ti.com>
 <1335362340-14960-4-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204260904580.10308@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9FF819@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204261330010.10308@utopia.booyaka.com>
 <alpine.DEB.2.00.1204261636340.10308@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56254 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab2D0FbS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 01:31:18 -0400
In-Reply-To: <alpine.DEB.2.00.1204261636340.10308@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

On Fri, Apr 27, 2012 at 04:08:07, Paul Walmsley wrote:
> On Thu, 26 Apr 2012, Paul Walmsley wrote:
> 
> > Okay, thanks for testing.  Please do update this patch to use 
> > omap_hwmod_enable(), etc.; see for example omap_dm_timer_init_one().
> 
> And, just to be explicit, the ioremap(), clk_get(), and clk_enable() 
> should no longer be needed for OMAP2+, once you add the 
> omap_hwmod_enable().
> 

What about OMAP1 architecture? Will it work? 

Thanks,
Vaibhav

