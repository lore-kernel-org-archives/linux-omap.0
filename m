From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: Update omap3_defconfig to work with SMP_ON_UP
Date: Wed, 15 Sep 2010 16:15:00 -0700
Message-ID: <20100915231500.GK4174@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100906104413.GD20903@n2100.arm.linux.org.uk>
 <20100914185907.GG8647@atomide.com>
 <20100914190314.GH8647@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F7DB@dbde02.ent.ti.com>
 <20100914202743.GK8647@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F9E1@dbde02.ent.ti.com>
 <20100915161126.GS8647@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD25FF3B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63248 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666Ab0IOXPS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 19:15:18 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25FF3B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100915 11:18]:
> > 
> Here is the patch which fixes most of the omap4 issues with common
> Omap3_defconfig. 

Good to hear, thanks!
 
> To enable local Timers for es1.0, I made some progress but looks like 
> it needs more changes in generic code. Will have a look at it tomorrow.

OK
 
> The patch is on top of the patches being discussed here. It's boot-tested 
> with single image on OMAP3 and OMAP4 SMP.

Looks good to me.

Tony
