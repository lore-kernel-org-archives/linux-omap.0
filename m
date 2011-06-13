From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: N900 USB fix (Was: Re: [PATCH/RFC 2/6] OMAP2+: PM: move runtime
 PM implementation to use device power domains)
Date: Mon, 13 Jun 2011 11:28:20 +0300
Message-ID: <20110613112820.9ccba4ee.jhnikula@gmail.com>
References: <1302134569-22825-1-git-send-email-khilman@ti.com>
	<1302134569-22825-3-git-send-email-khilman@ti.com>
	<4DF0D917.905@maxwell.research.nokia.com>
	<87boy73qrs.fsf@ti.com>
	<4DF1C075.9080401@maxwell.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43303 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998Ab1FMI1I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Jun 2011 04:27:08 -0400
Received: by eyx24 with SMTP id 24so1522458eyx.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Jun 2011 01:27:07 -0700 (PDT)
In-Reply-To: <4DF1C075.9080401@maxwell.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Felipe Balbi <balbi@ti.com>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>

On Fri, 10 Jun 2011 09:57:57 +0300
Sakari Ailus <sakari.ailus@maxwell.research.nokia.com> wrote:

> > A fix has been posted (and pull req sent to Tony.)  Can you try my
> > for_3.0/pm-fixes branch which fixes this problem?  It's available in my
> > git tree:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
> 
> Hi, Kevin!
> 
> Many thanks to you! :-) The patches indeed fix the problem. I seem to
> have used for_3.0/pm-fixes-2 branch, though. I guess that doesn't really
> matter. :-)
> 
I was struggling also with non-working musb on N900. I traced primary
breakage to the same commit than Sakari. On top of that commit the
Kevin's fix made it working but it didn't work on top of 3.0-rc2 while
beagle was ok.

I bisected another issue to commit 10299e2 ("ARM: RX-51: Enable isp1704
power on/off").

3.0-rc2 works if I enable the CONFIG_CHARGER_ISP1704=y but do we
actually need to drive the ISP1704 into reset in
board-rx51-peripherals.c: rx51_charger_init as it breaks the musb when
the ISP1704 driver is missing and otherwise rx51_charger_set_power
should take care of ISP1704 reset control when the driver is there?

-- 
Jarkko
