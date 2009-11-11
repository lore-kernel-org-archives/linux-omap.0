From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [GIT] pull request: PM CPUidle base support
Date: Wed, 11 Nov 2009 15:02:21 -0800
Message-ID: <87zl6szmv6.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:45179 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759589AbZKKXCS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 18:02:18 -0500
Received: by ywh40 with SMTP id 40so1435506ywh.33
        for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 15:02:24 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Tony,

Here's a pull request for the PM CPUidle support.  This branch
is based on the previous off-mode branch,

Kevin


The following changes since commit f265dc4c5d39f2bd369d97c87a7bd89061b159d4:
  Rajendra Nayak (1):
        OMAP3: PM: Program SDRC to send self refresh on timeout of AUTO_CNT

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-upstream/pm-cpuidle

Jouni Hogander (1):
      OMAP3: PM: Use pwrdm_set_next_pwrst instead of set_pwrdm_state in idle loop

Kalle Jokiniemi (1):
      OMAP3: PM: CPUidle: fix init sequencing

Kevin Hilman (2):
      OMAP3: PM: CPUidle: obey enable_off_mode flag
      OMAP3: PM: CPUidle: check activity for C2, C3, correct accounting

Peter 'p2' De Schrijver (2):
      OMAP3: PM: CPUidle: Add new lower-latency C1 state
      OMAP3: PM: idle: Remove fclk check for idle loop

Rajendra Nayak (2):
      OMAP3: PM: CPUidle: base driver and support for C1-C2
      OMAP3: PM: CPUidle: support retention and off-mode C-states

Sanjeev Premi (1):
      OMAP3: PM: CPUidle: Start C-state definitions from base 0

Tero Kristo (1):
      OMAP3: PM: Added resched check into idle calls

 arch/arm/mach-omap2/Makefile      |    2 +-
 arch/arm/mach-omap2/cpuidle34xx.c |  318 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h          |    4 +
 arch/arm/mach-omap2/pm34xx.c      |   55 +------
 4 files changed, 329 insertions(+), 50 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cpuidle34xx.c
