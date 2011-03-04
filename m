From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] OMAP: DSS2: Add support for LG Philips LB035Q02
 panel
Date: Fri, 4 Mar 2011 09:55:23 +0200
Message-ID: <1299225323.2196.20.camel@deskari>
References: <1299195980-17057-1-git-send-email-steve@sakoman.com>
	 <1299195980-17057-2-git-send-email-steve@sakoman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59783 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752896Ab1CDHz0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Mar 2011 02:55:26 -0500
In-Reply-To: <1299195980-17057-2-git-send-email-steve@sakoman.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <steve@sakoman.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thu, 2011-03-03 at 17:46 -0600, Steve Sakoman wrote:
> This patch adds support for the Gumstix Palo35 expansion board
> which utilizes the 320 x 240 pixel LG.Philips LB035Q02 LCD Panel
> 
> Signed-off-by: Steve Sakoman <steve@sakoman.com>

This looks about as good as the other panel drivers. Which means it
works for now but it does has faults =).

One thing to fix:

- There should be locking here. Check panel-taal.c. Mutexes around the
xxx_panel_enable() etc calls should do the thing.

And another thing to think about, but there's probably not a simple fix
for this right now:

This wouldn't work with two panel devices. If you think the case where
you have to panels, meaning two spi devices and two dss devices. You
first register the spi driver, which would call probe for both of the
spi devices. The first spi probe call would registers the dss driver,
which would call probe for both of the dss devices. At this point only
the first spi device would have been probed...

This is a bit tricky, and I'm not sure if there's any ready-made
solution for this. But what we need is a way to link a spesific spi
device to a specific dss device in the board file.

Then this panel module would register both dss driver and spi driver in
the module_init(), and after both dss and spi probe has been called for
the particular dss+spi device pair, the actual display driver would
start.

So this needs some work, and also some careful checks in, for example,
panel_enable, because nothing says that the spi device is ready when
panel_enable is called.

 Tomi


