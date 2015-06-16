From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap generic wakeirq for v4.2 merge window
Date: Tue, 16 Jun 2015 04:46:45 -0700
Message-ID: <20150616114645.GA4156@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:58074 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910AbbFPLqs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jun 2015 07:46:48 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

Here's a late pull request that would be good to get into v4.2.
This series mostly just drops code that's now unnecessary, and
also fixes potential interrupt re-entrancy issues that the old
handling has.

The series changes omap hsmmc, 8250_omap and omap-serial to use
the Linux generic wakeirq. I had to redo the branch last week on
recent tty-next branch because of a merge conflict. Other than
that, these patches were already in Linux next earlier.

The pull request below also shows the related patches in Rafael's
pm-wakeirq branch as I did not create a separate merge commit to
base patches on.

This branch depends on both Rafael's pm-wakeirq and Greg's
tty-next, so it should be sent separately towards the end of the
merge window.

Regards,

Tony

8< ------------------

The following changes since commit 00fda1682efdbd62a20a8a21aee52d994c323c7f:

  Merge 4.1-rc7 into tty-next (2015-06-08 10:49:28 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/wakeirq-drivers-v2

for you to fetch changes up to 63e63a1981c7247fea41ce97b3144befc8f2fb7b:

  Merge branch 'wakeirq-8250' into omap-for-v4.2/wakeirq-v2 (2015-06-09 23:37:31 -0700)

----------------------------------------------------------------
Omap driver changes for v4.2 to switch drivers over to Linux generic
wake IRQ events for omap_hsmmc, 8250_omap and omap-serial
drivers.

The generic wake IRQs also fix issues that these drivers potentially
have with IRQ re-entrancy at least for serial-omap.

Note that because of dependencies and merge conflicts these are
based on Rafael's pm-wakeirq and Greg's tty-next branches.

----------------------------------------------------------------
Ben Dooks (1):
      PM / runtime: add note about re-calling in during device probe()

Tony Lindgren (6):
      PM / Runtime: Update last_busy in rpm_resume
      PM / Wakeirq: Add automated device wake IRQ handling
      mmc: omap_hsmmc: Change wake-up interrupt to use generic wakeirq
      serial: omap: Switch wake-up interrupt to generic wakeirq
      serial: 8250_omap: Move wake-up interrupt to generic wakeirq
      Merge branch 'wakeirq-8250' into omap-for-v4.2/wakeirq-v2

 Documentation/power/runtime_pm.txt  |   6 +
 drivers/base/power/Makefile         |   2 +-
 drivers/base/power/main.c           |   3 +
 drivers/base/power/power.h          |  48 +++++++
 drivers/base/power/runtime.c        |   6 +
 drivers/base/power/wakeirq.c        | 273 ++++++++++++++++++++++++++++++++++++
 drivers/base/power/wakeup.c         |  92 ++++++++++++
 drivers/mmc/host/omap_hsmmc.c       |  49 +------
 drivers/tty/serial/8250/8250_omap.c |  58 +-------
 drivers/tty/serial/omap-serial.c    |  35 +----
 include/linux/pm.h                  |   2 +
 include/linux/pm_wakeirq.h          |  52 +++++++
 include/linux/pm_wakeup.h           |   9 ++
 13 files changed, 506 insertions(+), 129 deletions(-)
 create mode 100644 drivers/base/power/wakeirq.c
 create mode 100644 include/linux/pm_wakeirq.h
