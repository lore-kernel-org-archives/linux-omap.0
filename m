From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/5] omap non critical fixes for v3.8 merge window
Date: Wed, 14 Nov 2012 18:56:43 -0800
Message-ID: <42472.5722907626$1352948223@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20336 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933167Ab2KOC4u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 21:56:50 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:

  Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/fixes-non-critical-v4-signed

for you to fetch changes up to 936407358759adb302df93ab61fa68141897270c:

  ARM: OMAP4: PM: fix errata handling when CONFIG_PM=n (2012-11-14 17:06:20 -0800)

----------------------------------------------------------------
Non critical omap fixes that were not considered urgent
for the -rc cycle.

----------------------------------------------------------------
Colin Cross (1):
      ARM: OMAP4: retrigger localtimers after re-enabling gic

Kevin Hilman (1):
      ARM: OMAP4: PM: fix errata handling when CONFIG_PM=n

Santosh Shilimkar (1):
      ARM: OMAP4460: Workaround for ROM bug because of CA9 r2pX GIC control register change.

Tero Kristo (1):
      ARM: OMAP4: PM: add errata support

Tony Lindgren (1):
      Merge tag 'for_3.8-fixes-pm' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.8/fixes-non-critical-v2

 arch/arm/mach-omap2/common.h              |  4 +++
 arch/arm/mach-omap2/omap-headsmp.S        | 38 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |  9 ++++++-
 arch/arm/mach-omap2/omap-smp.c            | 41 +++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/omap4-common.c        | 42 ++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/pm.h                  |  9 +++++++
 6 files changed, 140 insertions(+), 3 deletions(-)
