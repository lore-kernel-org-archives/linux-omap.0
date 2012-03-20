From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 3/4] drivers: input: Fix OMAP_GPIO_IRQ with
 gpio_to_irq() in ams_delta_serio_exit()
Date: Tue, 20 Mar 2012 10:36:41 -0700
Message-ID: <20120320173641.GA6464@core.coreip.homeip.net>
References: <1332158817-26311-1-git-send-email-tarun.kanti@ti.com>
 <1332158817-26311-4-git-send-email-tarun.kanti@ti.com>
 <20120320165246.GH9859@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63897 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab2CTRgt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Mar 2012 13:36:49 -0400
Received: by dajr28 with SMTP id r28so292925daj.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 10:36:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120320165246.GH9859@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

On Tue, Mar 20, 2012 at 09:52:46AM -0700, Tony Lindgren wrote:
> Hi Dmitry,
> 
> * Tarun Kanti DebBarma <tarun.kanti@ti.com> [120319 05:09]:
> > Even though ams-delta-serio input driver uses gpio_to_irq() in all
> > relevent places to get irq number, the ams_delta_serio_exit() still
> > uses OMAP_GPIO_IRQ macro. Fix this.
> > 
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> 
> Care to ack this one? I'd like to apply all four as fixes
> at the end of the merge window so we can drop the old and
> now broken OMAP_GPIO_IRQ macro.

Sure.

Acked-by: Dmitry Torokhov <dtor@mail.ru>

Thanks.

-- 
Dmitry
