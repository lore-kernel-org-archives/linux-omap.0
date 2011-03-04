From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] OMAP: DSS2: Add support for LG Philips LB035Q02
 panel
Date: Fri, 4 Mar 2011 17:41:02 +0200
Message-ID: <1299253262.2053.15.camel@deskari>
References: <1299195980-17057-1-git-send-email-steve@sakoman.com>
	 <1299195980-17057-2-git-send-email-steve@sakoman.com>
	 <1299225323.2196.20.camel@deskari>
	 <AANLkTinTUtC_XDgCe79Aju4rdsDYHDWa9N682PDDEL5C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43063 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759747Ab1CDPlI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Mar 2011 10:41:08 -0500
In-Reply-To: <AANLkTinTUtC_XDgCe79Aju4rdsDYHDWa9N682PDDEL5C@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2011-03-04 at 09:29 -0600, Steve Sakoman wrote:
> On Thu, Mar 3, 2011 at 11:55 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

<snip>

> > This wouldn't work with two panel devices. If you think the case where
> > you have to panels, meaning two spi devices and two dss devices. You
> > first register the spi driver, which would call probe for both of the
> > spi devices. The first spi probe call would registers the dss driver,
> > which would call probe for both of the dss devices. At this point only
> > the first spi device would have been probed...
> >
> > This is a bit tricky, and I'm not sure if there's any ready-made
> > solution for this. But what we need is a way to link a spesific spi
> > device to a specific dss device in the board file.
> >
> > Then this panel module would register both dss driver and spi driver in
> > the module_init(), and after both dss and spi probe has been called for
> > the particular dss+spi device pair, the actual display driver would
> > start.
> >
> > So this needs some work, and also some careful checks in, for example,
> > panel_enable, because nothing says that the spi device is ready when
> > panel_enable is called.
> 
> Well, on Overo it would not be possible to add more than one Palo35,
> but I see your point in theory.

Yes, I think the only possible scenario on OMAP currently is OMAP4 with
two DSI displays.

> Do you want me to try to address this in this initial submission, or
> is it something we can revisit in a subsequent "fix-it" patch for all
> panels with SPI init?

If you have extra time and a good solution, then of course I want you to
address it =). But most likely we'll just revisit it later. It's not
critical now and we may also have to look at how DSS manages the panel
drivers.

 Tomi


