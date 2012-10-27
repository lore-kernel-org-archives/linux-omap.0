From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv9 0/8] ARM: OMAP4: core retention support
Date: Sat, 27 Oct 2012 03:02:10 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210270254220.27071@utopia.booyaka.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41471 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964814Ab2J0DCL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 23:02:11 -0400
In-Reply-To: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tero, Kevin,

On Thu, 18 Oct 2012, Tero Kristo wrote:

> Changes compared to previous version:
> - rebased on top of 3.7-rc1
> - applies on top of latest func pwrst code (v6)
> - added back patch #1 to this set (it wasn't queued yet after all)

That's because there was an interaction between it and the omap-serial 
changes in the last merge window that caused several failures :-( 
Hopefully it's good to go now...

> - added patch #7 for fixing a bug in the functional pwrst code
> - added patch #8 for fixing a regression with MUSB PHY power handling
>   (not quite sure if this is the correct way to fix this or not)
> 
> Tested with omap4460 gp panda + omap4430 emu blaze boards, with cpuidle +
> suspend.
> 
> Branch also available here:
> git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> branch: mainline-3.7-rc1-omap4-ret-v9

Looks like only patches #5 and #7 have dependencies on Jean's functional 
powerstate series, so those should be postponed until that rework is 
complete.  Looks like #6 and #8 should go in via Tony, assuming there are 
no dependencies on the rest of the patches.  Have just queued #1 for 3.8 
and kicked off a test to ensure that everything is working.

As far as the rest go, Kevin, do you want to take them? 


- Paul
