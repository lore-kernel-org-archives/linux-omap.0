From: Kevin Hilman <khilman@linaro.org>
Subject: [GIT PULL] CPUidle: OMAP cleanups for v3.10
Date: Tue, 09 Apr 2013 16:40:11 -0700
Message-ID: <87txnfz31g.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f47.google.com ([209.85.210.47]:65356 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936675Ab3DIXkP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 19:40:15 -0400
Received: by mail-da0-f47.google.com with SMTP id s35so3231317dak.34
        for <linux-omap@vger.kernel.org>; Tue, 09 Apr 2013 16:40:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

[resend with correct address for linux-pm]

Rafael,

Please pull the following OMAP CPUidle changes for v3.10.

Due to dependencies on other CPUidle changes that are already in your
linux-next branch, this branch is based on the commit where you merged
your pm-cpuidle-next branch into linux-next.

Kevin

The following changes since commit f69e44b2059f2238ac558b4a115ebcdefe20b9be:

  Merge branch 'pm-cpuidle-next' into linux-next (2013-04-08 12:32:07 +0200)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/omap-pm-v3.10/cleanup/cpuidle-v2

for you to fetch changes up to db4f3dab629109882170a7b1b8fb655a34c52846:

  ARM: OMAP4+: CPUidle: Consolidate idle driver for OMAP5 support (2013-04-09 09:48:21 -0700)

----------------------------------------------------------------
OMAP CPUidle cleanups for v3.10

----------------------------------------------------------------
Daniel Lezcano (1):
      ARM: omap3: cpuidle: enable time keeping

Santosh Shilimkar (5):
      ARM: OMAP4: CPUidle: Avoid double idle driver registration
      ARM: OMAP: CPUidle: Unregister drivere on device registration failure
      ARM: OMAP4: CPUidle: Make C-state description field more precise
      ARM: OMAP4+: CPUidle: Deprecate use of omap4_mpuss_read_prev_context_state()
      ARM: OMAP4+: CPUidle: Consolidate idle driver for OMAP5 support

 arch/arm/mach-omap2/common.h              |  5 ----
 arch/arm/mach-omap2/cpuidle34xx.c         | 11 +++++--
 arch/arm/mach-omap2/cpuidle44xx.c         | 48 +++++++++++++++++--------------
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 14 ---------
 4 files changed, 35 insertions(+), 43 deletions(-)
