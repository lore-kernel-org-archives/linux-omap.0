From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 2/2] OMAP3: wdtimer: Fix CORE idle transition
Date: Mon, 14 Mar 2011 13:27:15 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1103141322460.4431@utopia.booyaka.com>
References: <1299759058-26342-1-git-send-email-kalle.jokiniemi@nokia.com> <1299759058-26342-3-git-send-email-kalle.jokiniemi@nokia.com> <alpine.DEB.2.00.1103100752370.15132@utopia.booyaka.com>
 <9D0D31AA57AAF5499AFDC63D6472631B067824@008-AM1MPN1-036.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39893 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab1CNT1Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 15:27:16 -0400
In-Reply-To: <9D0D31AA57AAF5499AFDC63D6472631B067824@008-AM1MPN1-036.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kalle.jokiniemi@nokia.com
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be, khilman@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, jhnikula@gmail.com, ilkka.koskinen@nokia.com, b-cousson@ti.com

Hello Kalle,

On Mon, 14 Mar 2011, kalle.jokiniemi@nokia.com wrote:

> What about the 1/2 patch? Is that going in, and to which kernel version 
> (our integrator would like to put in a note when we can remove the back 
> ported patch)

It's queued for Linus for the upcoming merge window:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=0503add9d251db22ba2f610fb8d9b7743a9786da

Thread here:

http://www.spinics.net/lists/linux-omap/msg48381.html

If there aren't further comments on the watchdog patch, and Linus is okay
with the branch, it should appear in 2.6.39.



- Paul
