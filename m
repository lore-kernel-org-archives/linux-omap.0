From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: ARM SoC tree: OMAP PM dependency on tip irq/core
Date: Fri, 7 Oct 2011 20:53:41 +0200
Message-ID: <201110072053.41594.arnd@arndb.de>
References: <87aa9mm8ts.fsf@ti.com> <201110071804.11494.arnd@arndb.de> <87d3e8lmhp.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:63607 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab1JGSxt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 14:53:49 -0400
In-Reply-To: <87d3e8lmhp.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robherring2@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Friday 07 October 2011, Kevin Hilman wrote:
> > I've pulled in rmk/devel-stable as a dependency now, thanks for
> > reminding me of that.
> >
> > Thomas, where should I get the irq-core branch (or whichever
> > I should wait for) to pull in as another dependency. Is that
> > branch one that never gets rebased? 
> 
> git://tesla.tglx.de/git/linux-2.6-tip irq/core
> 
> I asked Thomas about this earlier when I was going to build up the
> dependencies myself, and he said it won't be rebased.

Ok, thanks for the info.

I think I've now also come up with a workflow for tracking the dependencies:
I have a depends/xxx branch for each other branch that I need to wait for
getting merged first. When I want to send a pull request, I first check
all the depends/* branches using 'git branch --merged next/xxx |
grep depends' to see what the dependencies are, and 'git branch --merged
torvalds/master | grep depends' to see if they are already merged upstream.
When a dependency is already merged, I can remove its tracking branch
from the arm-soc tree.

	Arnd
