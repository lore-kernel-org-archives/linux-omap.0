From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: new 2.6.30-based PM branch
Date: Wed, 17 Jun 2009 16:39:26 -0700
Message-ID: <87ocsmv39t.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f192.google.com ([209.85.222.192]:46059 "EHLO
	mail-pz0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755599AbZFQXj1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 19:39:27 -0400
Received: by pzk30 with SMTP id 30so154706pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 17 Jun 2009 16:39:29 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

Now that 2.6.30 is out, the PM branch has been rebased onto current
linux-omap master which is 2.6.30 based.  The previous, 2.6.29-based
PM branch will continue to exist and be renamed to pm-2.6.29.  I will
continue to accept bugfixes against pm-2.6.29, but all new work should
be done on the new pm branch.

Both branches are available in my linux-omap-pm tree[1], but only the
2.6.30-based one (named 'pm') will be sync'd daily to Tony's
linux-omap repo.

This new PM branch has had basic testing on the following OMAP3
platforms

- 3430SDP (initramfs, NFS)
- OMAP3 EVM (initramfs, NFS)
- Beagle (MMC rootfs)
- RX51 (OneNAND rootfs)
- Zoom2 (initramfs, ** problems w/NFS, see below)

And is able to do full-chip retention and off in idle and suspend on
all of these platforms.

Rather than try to manage multiple defconfigs for these boards, there
is a now a new all-in-one defconfig that will work on all these
boards.  Well, almost.  

omap3_pm_defconfig will work out of the box on SDP and EVM, and will
boot on Beagle, Zoom2 and RX51 simply by changing
    
     System Type-->TI OMAP implementations-->Low-level debug console UART
    
from UART1 to UART3 (the LL_DEBUG support is still a little dumb and
needs some fixing, but that's for another day.)

Known problems:

- Zoom2 network doesn't work, not yet debugged
- ES3.0-based SDPs have problems with UART1 coming back from off-while-idle 
  UART 3 works fine.

Kevin

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git
