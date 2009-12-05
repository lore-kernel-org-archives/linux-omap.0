From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: dspbridge sync proposal for 0.1
Date: Sat, 5 Dec 2009 15:39:00 +0200
Message-ID: <20091205133900.GA17280@annwn.felipec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20364 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbZLENjD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Dec 2009 08:39:03 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Artem Bityutskiy <artem.bityutskiy@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Bhavin Shah <bshah@ti.com>, Tony Lindgren <tony@atomide.com>

Hi,

There is a proposal to get the dspbridge branch into a decent state for
the 0.1 release, so I've been trying to synchronize the internal maemo
branch with the upstream one.

Unfortunately, there are severe issues:
 * TI modified the patches sent by Nokia
 * Many patches have never been sent to l-o for review

And more importantly; I couldn't get it to work, neither on the N900,
nor the beagleboard (I didn't try very hard, though). So I decided to
compare the branches patch by patch.

First, I found the last synchronization point is:
6cc7482 DSPBRIDGE: Buffer size warning fixes

It's not exactly synchronized, as it's missing some patches from Nokia,
but it's as good as it gets.

Then I marked each patch as "ok" if they are in both branches, "needs
sync" if it was modified, "!l-m" if it was not in the maemo branch, and
"unrev" if it was never sent for review.

Next I tried to come up with something that could resemble the current
maemo branch, but I found no easy way. So, what I did is to pick each
patch that was somehow present on both branches (I used the Nokia
version for the patches that came from Nokia), then, pick all the
patches that were only in the upstream branch, but have been sent for
review, and finally, apply any other necessary patches. Needless to say;
this was not straightforward; I had to resolve many conflcts, and drop
many patches.

The end result is my proposal for 0.1 which is something that resembles
the maemo branch, works both on the N900 (based on 2.6.28), and the
beagleboard (using 2.6.32 without DVFS). There are still many patches
missing, both from the upstream and maemo branches, but I think those
should be tackled in 0.2.

The only change needed from 2.6.28 to 2.6.32 seems to be IO_ADDRESS ->
OMAP2_IO_ADDRESS, but I guess it would be much better to use ioremap
instead, so the same code works everywhere. Any volunteers? :)

All the branches are in:
http://gitorious.org/~felipec/linux-omap/felipec

 * dspbridge-0.1:: 0.1 proposal
 * dspbridge-0.1-base:: last synchronization point
 * dspbridge-0.1-step1:: first step: patches on both branches
 * dspbridge-0.1-step2:: second step: patches only on upstream
 * dspbridge-0.2-maemo:: maemo patches for 0.2

For more detail in my analysis of the current dspbridge branch check:
http://people.freedesktop.org/~felipec/dspbridge-0.1-sync.html

Comments?

-- 
Felipe Contreras
