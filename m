From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/11] ARM: OMAP: Move omap-pm-noop.c local to
 mach-omap2
Date: Wed, 7 Nov 2012 14:18:20 -0800
Message-ID: <20121107221819.GQ6801@atomide.com>
References: <20121030234852.25936.12482.stgit@muffinssi.local>
 <20121030235255.25936.36727.stgit@muffinssi.local>
 <20121031205850.GO12739@atomide.com>
 <1654531.W5JISgHidu@avalon>
 <20121031231115.GG15766@atomide.com>
 <509ADB03.2050909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:16240 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753515Ab2KGWS0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 17:18:26 -0500
Content-Disposition: inline
In-Reply-To: <509ADB03.2050909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>

* Jon Hunter <jon-hunter@ti.com> [121107 14:06]:
> On 10/31/2012 06:11 PM, Tony Lindgren wrote:
> > 
> > When it's converted to be a device driver, it can do it
> > using runtime PM calls.
> 
> I am not sure if you are referring to runtime pm callbacks here, but if
> so I am not sure I follow. Drivers such as dmtimer and gpio that are
> using runtime pm are still dependent on OMAP specific APIs (such as
> omap_pm_get_dev_context_loss_count()) for determining if the context was
> lost between suspending and resuming the device. So I am not sure how
> runtime pm solves this.

Ah right.
 
> Speaking with Rob Herring, one solution for DT would be using bus
> notifiers to populate such function pointers when a device is added.
> Given that there are a few devices using this architecture specific API
> for context loss I am wondering if we can do something generic in
> omap_device.c for DT.

Sounds good to me.

Regards,

Tony
