From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] OMAP PM fixes for 2.6.38-rc
Date: Wed, 02 Mar 2011 08:30:06 -0800
Message-ID: <8739n5eb8x.fsf@ti.com>
References: <87pqqae8mc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:51538 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751940Ab1CBQaK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 11:30:10 -0500
Received: by mail-gx0-f179.google.com with SMTP id 21so34732gxk.38
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 08:30:09 -0800 (PST)
In-Reply-To: <87pqqae8mc.fsf@ti.com> (Kevin Hilman's message of "Tue, 01 Mar
	2011 15:14:35 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony,

Kevin Hilman <khilman@ti.com> writes:

> Here's a final batch of PM fixes for the 2.6.38-rc cycle.

I just noticed that a couple of these were already queued in your last
pull request to Linus.

Here's an updated pull request based on .38-rc7.

Kevin

The following changes since commit dd9c1549edef02290edced639f67b54a25abbe0e:

  Linux 2.6.38-rc7 (2011-03-01 13:55:12 -0800)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_2.6.38/pm-fixes

Aaro Koskinen (1):
      arm: mach-omap2: smartreflex: fix another memory leak

Shweta Gulati (1):
      OMAP2+: PM: SmartReflex: fix memory leaks in Smartreflex driver

 arch/arm/mach-omap2/smartreflex.c |   33 +++++++++++++++------------------
 1 files changed, 15 insertions(+), 18 deletions(-)
