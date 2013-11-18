From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/5] ARM: OMAP2+: Add DT init code for DPI displays and
 make omap3 LDP to use it
Date: Mon, 18 Nov 2013 10:19:34 -0800
Message-ID: <20131118181934.GN10317@atomide.com>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <1384562167-14725-4-git-send-email-tony@atomide.com>
 <528A10CC.7070908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16579 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab3KRSTh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Nov 2013 13:19:37 -0500
Content-Disposition: inline
In-Reply-To: <528A10CC.7070908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131118 05:07]:
> On 2013-11-16 02:36, Tony Lindgren wrote:
> > In order to make the remaining omap3 boards usable with device
> > tree, we need to initialize the DPI based displays using pdata
> > until we have the DSS bindings in place.
> > 
> > At least board-am3517evm.c, board-cm-t35.c, board-devkit8000.c,
> > board-ldp.c and board-overo.c all use fairly similar DPI setup,
> > so let's add generic code for it. And let's make omap3 LDP to
> > use it and also initialize the ads7846 until we have a binding
> > for it.
> > 
> > Note that at least LDP needs the TWL bug fix posted as
> > "gpio: twl4030: Fix regression for twl gpio output" for the
> > LCD backlight to power.
> 
> Looks fine to me.
> 
> Is it possible to keep this, and other similar DSS patches, in a
> separate branch, that could be dropped if needed? I'm kind of hoping I
> would get the DSS DT finished for the next merge window (but I've said
> that before, so...).

OK let's keep the DSS pdata quirks separate for now. How about we set
-rc3 as a deadline for deciding which way to go for the DSS DT bindings
for v3.14?

BTW, Russell posted some interesting comments on LAKML this weekend
on binding together driver components if that helps.

Regards,

Tony
