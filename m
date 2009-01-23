From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: v2.6.28-omap1 tagged, some bugs remain
Date: Fri, 23 Jan 2009 09:49:47 +0200
Message-ID: <20090123094947.491eb750.jarkko.nikula@nokia.com>
References: <1231921649.13843.171.camel@eenurkka-desktop>
	<20090114152806.GP29324@atomide.com>
	<20090119095429.629b2606.jarkko.nikula@nokia.com>
	<20090123000220.GE7172@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25004 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbZAWHuP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 02:50:15 -0500
In-Reply-To: <20090123000220.GE7172@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>, linux-omap@vger.kernel.org, "ext Lopez Cruz, Misael" <x0052729@ti.com>

On Thu, 22 Jan 2009 16:02:21 -0800
"ext Tony Lindgren" <tony@atomide.com> wrote:

> > Probably we should revert the patch and split it into three
> > separate patches:
> > 
> > 1. Header change in linux-omap adding those registers (and queue it)
> > 2. Patch to alsa-devel setting default values to those registers
> > 3. Patch to linux-omap writing those registers
> 
> OK, I've reverted #3 above in l-o master and omap-2.6.28 branches.
> 
> > Or better: send those two patches to LKML, cc linux-omap and alsa-devel
> > and let it fall down from -mm or linux-next tree.
> 
> Well since #3 is already queued in omap-fixes, I'd rather let it go to
> mainline and not mess with that queue.
> 
I think that's fine for now since "accident" has happened and we are
aware the issues it will cause.

> Maybe after that you could try to get #1 & #2 above merged to mainline
> via alsa-devel list as one patch?
> 
Can you Misael send your ASoC part of the patch to alsa-devel with a
remark that it's waiting above patch before it can be applied?

Anyway, functionalities from these two patches are needed since
otherwise audio is not working on some boards where bootloader hasn't
set those XCCR and RCCR registers.


Jarkko
