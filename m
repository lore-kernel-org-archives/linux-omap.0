From: Paul Walmsley <paul@pwsan.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Wed, 11 Jan 2012 06:32:07 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201110631050.31702@utopia.booyaka.com>
References: <WC20120109124643.880164@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51875 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757226Ab2AKNcI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jan 2012 08:32:08 -0500
In-Reply-To: <WC20120109124643.880164@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: linux-omap@vger.kernel.org

On Mon, 9 Jan 2012, Joe Woodward wrote:

> I'm running on a Gumstix Overo (OMAP3530) with an 24-bit LCD panel connected via the DPI interface (using the generic panel driver).
> 
> Entering standby used to work just fine on 3.0, but on 3.2 I get the following:
> 
> # echo mem > /sys/power/state

...

> [   24.466674] ------------[ cut here ]------------
> [   24.466857] WARNING: at drivers/video/omap2/dss/dss.c:713 0xc01350f8()

...

> At which point the screen either restarts, or sometimes flickers and I get the following:
> [   22.578796] omapdss DISPC error: SYNC_LOST on channel lcd, restarting the output with video overlays disabled
> [   23.391571] omapdss DISPC error: SYNC_LOST on channel lcd, restarting the output with video overlays disabled
> [   24.391571] omapdss DISPC error: SYNC_LOST on channel lcd, restarting the output with video overlays disabled
> 
> It normally recovers after doing this for a while...
> 
> Anyone have any ideas?

Consider cc'ing the DSS maintainers and linux-fbdev list:

OMAP DISPLAY SUBSYSTEM and FRAMEBUFFER SUPPORT (DSS2)
M:	Tomi Valkeinen <tomi.valkeinen@ti.com>
L:	linux-omap@vger.kernel.org
L:	linux-fbdev@vger.kernel.org
S:	Maintained
F:	drivers/video/omap2/
F:	Documentation/arm/OMAP/DSS


- Paul
