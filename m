From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 19/41] OMAPDSS: panel-dpi: Add DT support
Date: Tue, 8 Apr 2014 08:29:15 -0700
Message-ID: <20140408152914.GA11110@atomide.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <1390301833-24944-20-git-send-email-tomi.valkeinen@ti.com>
 <20140408001339.GA15842@atomide.com>
 <53438B45.2090209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:15980 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756369AbaDHP30 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Apr 2014 11:29:26 -0400
Content-Disposition: inline
In-Reply-To: <53438B45.2090209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140407 22:42]:
> On 08/04/14 03:13, Tony Lindgren wrote:
> > Tomi,
> > 
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [140121 03:01]:
> >> Add DT support for panel-dpi.
> > 
> > Looks like this patch did not get merged or am I missing
> > something?
> 
> Yes, I dropped it. None of the boards that I converted used panel-dpi.
> There was so much discussions about the display bindings, so I thought
> it's better to leave out all but the needed patches.

OK
 
> > As you probably are aware, we have at least these boards
> > needing it before we can remove the omap3 legacy support:
> > 
> > board-am3517evm.c
> > board-cm-t35.c
> > board-devkit8000.c
> > board-ldp.c
> > board-overo.c
> > 
> > We could probably set the display timings based on the
> > compatible flag in the driver if that's an issue?
> 
> The timings shouldn't be an issue. But there's the backlight GPIO,
> currently handled by panel-dpi, which should be removed from the panel.
> We should use gpio-backlight for that one.

Using gpio-backlight makes sense for sure.

FYI, in the case of the LDP there are four GPIOs to configure to
get things going:

gpio55		LCD RESET		panel-dpi?
gpio56		LCD QVGA		panel-dpi?
twl gpio7	LCD power		panel-dpi
twl gpio15	LCD backlight		gpio-backlight
 
> > And then board-omap3pandora.c also needs support for
> > panel_tpo_td043mtea1_platform_data.
> 
> Yep, there's still much to do for DSS DT support. Hopefully it will be
> easier now that the core support is there. I'll continue working on the
> remaining boards and panels. However, I don't have any of the remaining
> boards, so help is of course appreciated.

Yeah I can test at least the LDP here.

Regards,

Tony
