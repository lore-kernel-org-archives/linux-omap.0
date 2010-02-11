From: Tony Lindgren <tony@atomide.com>
Subject: upcoming merge window: Board files merged, patchwork and omap
 inbox cleared
Date: Wed, 10 Feb 2010 18:58:00 -0800
Message-ID: <20100211025759.GA21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63368 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab0BKC5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 21:57:21 -0500
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1NfPF2-0004n4-PJ
	for linux-omap@vger.kernel.org; Thu, 11 Feb 2010 02:57:20 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I've merged all the patches I could from patchwork [1] into omap for-next
branch [2]. I've also updated the master branch so it has for-next merged
into it.

Please make sure your patches are in and applied properly. If you don't
see your patch in the for-next branch, and it does not show up in the
patchwork [1] queue either, please resend the whole series. I've nuked
my omap inbox, so I can't find the related patches otherwise :)

If your patch is not in for-next, one or more of your patches did not
apply, or had some other issues, or somehow it fell through the cracks.
I have not replied to all patches that did not apply, or applied but I
had to manually edit them first.

Kevin and Paul maintain separate queues that have not been merged in yet,
so for clock and PM patches see Paul's and Kevin's queues too.

Currently there are three patches in my patchwork queue:

-  [v4] OMAP: sDMA driver: descriptor autoloading feature
   is still waiting for a device driver patch to use it

- OMAP2/3: update default defconfig, towards smaller kernel
  is still under discussion, we'll update it as the last
  patch to get in all the new boards

- omap3evm: Doesn't boot at 4fa42e46
  we may still want to send a related patch as a fix once
  sorted out

For the regressions, looks like MMC only works for one of the slots
on n8x0, anybody got ideas why?

Regards,

Tony


[1] http://patchwork.kernel.org/project/linux-omap/list/
[2] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=shortlog;h=refs/heads/for-next
