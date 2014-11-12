From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3] omap clean-up for v3.19
Date: Wed, 12 Nov 2014 10:05:13 -0800
Message-ID: <14395.2494989664$1415815626@news.gmane.org>
References: <pull-1415814409-868361>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57114 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752957AbaKLSG5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2014 13:06:57 -0500
In-Reply-To: <pull-1415814409-868361>
In-Reply-To: <pull-1415814409-868361>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit 2dde3bccbf905548a17b8d440053f86454af54a9:

  Merge branch 'for-v3.19/gpmc-omap' of github.com:rogerq/linux into omap-for-v3.19/gpmc (2014-11-03 17:45:36 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/cleanup-part1

for you to fetch changes up to 1b383f44aabc8b69b8bc0d32b914f3d3cece9e04:

  ARM: OMAP2+: Drop board file for 3430sdp (2014-11-03 17:50:55 -0800)

----------------------------------------------------------------
Drop few unused omap board files. The support for ti81xx is known to
be incomplete and broken, and the 3430sdp is only used in few automated
boot test systems AFAIK and those have been booting in device tree only
mode for quite some time now.

Note that this branch has a dependency to the related device tree
changes and GPMC changes sent in a separate pull request.

----------------------------------------------------------------
Tony Lindgren (2):
      ARM: OMAP2+: Drop board file for ti8168evm
      ARM: OMAP2+: Drop board file for 3430sdp

 arch/arm/mach-omap2/Kconfig           |  16 -
 arch/arm/mach-omap2/Makefile          |   3 -
 arch/arm/mach-omap2/board-3430sdp.c   | 604 ----------------------------------
 arch/arm/mach-omap2/board-ti8168evm.c |  62 ----
 4 files changed, 685 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-3430sdp.c
 delete mode 100644 arch/arm/mach-omap2/board-ti8168evm.c
