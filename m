From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [GIT PULL] omap iommu: fixes for 2.6.35-rc1
Date: Wed, 02 Jun 2010 10:50:46 +0300 (EEST)
Message-ID: <20100602.105046.39180136.Hiroshi.DOYU@nokia.com>
References: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
	<20100531122703.GD30216@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22472 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab0FBHvE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 03:51:04 -0400
In-Reply-To: <20100531122703.GD30216@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, x0124230@ti.com

Hi Tony,

Patches only for fixes for omap iommu module during -rc cycle.

The following changes since commit 67a3e12b05e055c0415c556a315a3d3eb637e29e:

  Linux 2.6.35-rc1 (2010-05-30 13:21:02 -0700)

are available in the git repository at:
  git://gitorious.org/~doyu/lk/mainline.git v2.6.35-rc1-iommu-fixes

Hiroshi DOYU (1):
      omap iommu: Make omap-iommu.o built-in

Kanigeri, Hari (1):
      omap iommu: update ducati mmu irq define name

Satish (1):
      omap iommu: Fix Memory leak

 arch/arm/mach-omap2/Makefile     |    5 ++++-
 arch/arm/mach-omap2/omap-iommu.c |    2 +-
 arch/arm/plat-omap/iovmm.c       |    4 +++-
 3 files changed, 8 insertions(+), 3 deletions(-)
