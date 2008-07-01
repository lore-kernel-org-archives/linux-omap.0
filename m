From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Add support to Nokia N810 WiMAX
Date: Tue, 1 Jul 2008 08:11:41 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162035BBF87B7@dlee02.ent.ti.com>
References: <1214898819-12471-1-git-send-email-jarkko.nikula@nokia.com>
	<26a54b1545ac8acab8dae9c92cf3a285@felipebalbi.com>
	<20080701132539.b4f89f1a.jarkko.nikula@nokia.com>
	<13B9B4C6EF24D648824FF11BE8967162035BBF8741@dlee02.ent.ti.com>
 <20080701153907.55a7c131.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:34614 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688AbYGANLy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 09:11:54 -0400
In-Reply-To: <20080701153907.55a7c131.jarkko.nikula@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Felipe Balbi <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > > I forgot to mention that it seems that HS OMAP or something is
> > > ceasing the operation just few seconds after bootup. Initfs gets
> > > more scripts executed but Debian from mtdblock4 hangs just in init.
> >
> > That is an odd statement.  Are you commenting about an EMU/HS chip
> > resetting during startup?
> >
> Not resetting but the device seems to just stop during the process.
> Only idea what came to mind that probably HS OMAP in N810 WiMAX is
> causing this.

This is understandable actually.  Especially if you don't have some kind of reset sequence in your power chip linked up.

For instance on 3430 + T2 you need to add a reset sequence script into T2's internal memory.  If you don't and you have CPUFREQ (dvfs) running, you can reboot at a time when the voltage is to low.  The ROM code expects a nominal (1.2v) voltage at reset time.  So when the DPLL spins up you can lock up and die.

BTW, this also kills the a 'reboot' command which ultimately just does a warm reset sequence with a prcm write.

... actually in 2420 there are also errata around when its safe to issue a prcm based reset, this can also get you depending on your device.  This deals with the need to be in bypass at the time of the write.

> > There is a secure watch dog when needs to be taken care of and if you
> > program it right.  Generally your initial secure driver or stub ppa
> > will take care of this.
> >
> Secure driver at least was missing in this trial what is indeed found
> in our release :-)

That would do it.  You need to take care of a couple bits else it won't make it.  This is doubly true on 3430 as your full or stub security driver needs to do a bit more.

Regards,
Richard W.

