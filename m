From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH 2/2] OMAP3: wdtimer: Fix CORE idle transition
Date: Mon, 14 Mar 2011 10:34:18 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B067824@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1299759058-26342-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1299759058-26342-3-git-send-email-kalle.jokiniemi@nokia.com>
 <alpine.DEB.2.00.1103100752370.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:16961 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602Ab1CNKen convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 06:34:43 -0400
In-Reply-To: <alpine.DEB.2.00.1103100752370.15132@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be, khilman@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, jhnikula@gmail.com, ilkka.koskinen@nokia.com, b-cousson@ti.com

Hi Paul,

> -----Original Message-----
> From: ext Paul Walmsley [mailto:paul@pwsan.com]
> Sent: 10. maaliskuuta 2011 16:53
> > From: Paul Walmsley <paul@pwsan.com>
> >
> > The HW superwised smart idle for wdtimer in OMAP3 prevents CORE
> power
> > domain idle transitions. Disable it by swithing to SW supervised
> > transitions.
> >
> > This could be a hardware bug in the OMAP3 wdtimer2 block.
> >
> > Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> 
> I've queued this one for 2.6.39, since it seems pretty clear that target smart-
> idle mode doesn't work with this IP block.

What about the 1/2 patch? Is that going in, and to which kernel version (our integrator would like to put in a note when we can remove the back ported patch)

- Kalle

> 
> Probably we'll need to do the same thing for OMAP2420/2430, but I'm not
> going to touch those right now, since we're so close to the merge window.
> 
> 
> - Paul
