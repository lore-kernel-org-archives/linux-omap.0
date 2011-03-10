From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] OMAP3: wdtimer: Fix CORE idle transition
Date: Thu, 10 Mar 2011 07:52:55 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100752370.15132@utopia.booyaka.com>
References: <1299759058-26342-1-git-send-email-kalle.jokiniemi@nokia.com> <1299759058-26342-3-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33912 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab1CJOw4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 09:52:56 -0500
In-Reply-To: <1299759058-26342-3-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be, khilman@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, jhnikula@gmail.com, ilkka.koskinen@nokia.com, Benoit Cousson <b-cousson@ti.com>

On Thu, 10 Mar 2011, Kalle Jokiniemi wrote:

> From: Paul Walmsley <paul@pwsan.com>
> 
> The HW superwised smart idle for wdtimer in OMAP3 prevents
> CORE power domain idle transitions. Disable it by swithing
> to SW supervised transitions.
> 
> This could be a hardware bug in the OMAP3 wdtimer2 block.
> 
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>

I've queued this one for 2.6.39, since it seems pretty clear that
target smart-idle mode doesn't work with this IP block.

Probably we'll need to do the same thing for OMAP2420/2430, but I'm not   
going to touch those right now, since we're so close to the merge window.


- Paul
