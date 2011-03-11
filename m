From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH 1/2] Watchdog: omap_wdt: add fine grain runtime-pm
Date: Fri, 11 Mar 2011 07:37:27 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B066579@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1299754448-24888-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1299754448-24888-2-git-send-email-kalle.jokiniemi@nokia.com>
 <alpine.DEB.2.00.1103100600390.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:49477 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425Ab1CKHig convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Mar 2011 02:38:36 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: khilman@ti.com, b-cousson@ti.com, tony@atomide.com, linux-omap@vger.kernel.org

Hi,

> -----Original Message-----
> From: Jokiniemi Kalle (Nokia-MS/Tampere)
> 
> I did that already, no luck... If we want to make it work without the runtime-
> pm patch, then we need to switch the wdtimer2 to force idle mode. If you're
> uncomfortable with the idlemode priority patch, maybe we do some quirk
> flag that enables force idle mode for modules that have it.

Never mind that, I see this is going in already...

Thanks everyone for helping out with this one. I'll backport this to MeeGo  N900 kernel, so we'll get working cpu idle there ;)

- Kalle

