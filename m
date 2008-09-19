From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/5] watchdog: move omap_wdt.h to include/linux/watchdog
Date: Fri, 19 Sep 2008 13:52:20 +0100
Message-ID: <20080919135220.1e52e32d@lxorguk.ukuu.org.uk>
References: <1221820359-8943-1-git-send-email-felipe.balbi@nokia.com>
	<1221820359-8943-2-git-send-email-felipe.balbi@nokia.com>
	<1221820359-8943-3-git-send-email-felipe.balbi@nokia.com>
	<1221820359-8943-4-git-send-email-felipe.balbi@nokia.com>
	<1221820359-8943-5-git-send-email-felipe.balbi@nokia.com>
	<20080919115627.343a2847@lxorguk.ukuu.org.uk>
	<20080919110645.GO28615@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60285 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753425AbYISM5x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 08:57:53 -0400
In-Reply-To: <20080919110645.GO28615@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Wim Van Sebroeck <wim@iguana.be>, Andrew Morton <akpm@linux-foundation.org>, "George G. Davis" <gdavis@mvista.com>

> Sure, I'll update the patch. But if you look at patch 5/5, I'll need the
> structures to define the set_clock() function. Should I create then
> under <mach/omap_wdt.h> ??

I think that would be better - you are not creating a public general
interface to watchdogs but a specific interface between the OMAP platform
code and the OMAP watchdog.

Alan
