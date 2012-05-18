From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] gpio/omap: fix fallout from last cleanup series
Date: Fri, 18 May 2012 15:16:59 -0700
Message-ID: <87vcjtkuck.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:53126 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750885Ab2ERWQ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 18:16:58 -0400
Received: by dadv36 with SMTP id v36so4809224dad.13
        for <linux-omap@vger.kernel.org>; Fri, 18 May 2012 15:16:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Grant,

Here's the promised branch that fixes the fallout from the last cleanup
series which introduced a few new bugs in the cleanup. :(

I collected the acks/tested-bys from the list.

Thanks,

Kevin


The following changes since commit 1b1287032df3a69d3ef9a486b444f4ffcca50d01:

  gpio/omap: fix missing check in *_runtime_suspend() (2012-05-11 17:08:40 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.5/fixes/gpio-2

for you to fetch changes up to b3c64bc30af67ed328a8d919e41160942b870451:

  gpio/omap: (re)fix wakeups on level-triggered GPIOs (2012-05-18 07:05:06 -0700)

----------------------------------------------------------------
Kevin Hilman (2):
      gpio/omap: fix broken context restore for non-OFF mode transitions
      gpio/omap: (re)fix wakeups on level-triggered GPIOs

 drivers/gpio/gpio-omap.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)
