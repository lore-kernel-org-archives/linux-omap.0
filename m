From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v2 12/18] GPIO: OMAP: Clean omap_gpio_mod_init function
Date: Mon, 27 Jun 2011 16:18:51 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037BC15847@dbde02.ent.ti.com>
References: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
	<1308111806-29152-3-git-send-email-tarun.kanti@ti.com>
 <87fwn9mzu0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40559 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757709Ab1F0KtC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 06:49:02 -0400
In-Reply-To: <87fwn9mzu0.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

Kevin,
[...]
> >
> > With register offsets now defined for respective OMAP versions we can
> get rid
> > of cpu_class_* checks. In addition, organized common initialization for
> the
> > different OMAP silicon versions.
> >
> > Signed-off-by: Charulatha V <charu@ti.com>
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> 
> Since the SYSCONFIG register settings are OMAP1-only and init-time only,
> they could be done in the OMAP1-specific init functions.
BTW, I needed some more clarifications here...
The omap_gpio_mod_init() is called only once from _probe().
So, does it make sense to have a separate init function?
If yes, I have to call __init omap1_gpio_mod_init() from _probe() again.
This is because I need the bank information supplied to it.
Let me know if this is a fair understanding. Thanks.
--
Tarun

> 
> Also, this could be quite a bit more compact by not duplicating code for
> both bank widths.  Instead, create some local function pointers for 16
> or 32-bit register access, and assign them based on bank width.
> 
> Kevin
> 
[...]
