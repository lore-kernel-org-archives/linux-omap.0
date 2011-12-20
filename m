From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: device PM constraints: preparatory support
Date: Tue, 20 Dec 2011 12:53:42 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112201251010.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49777 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab1LTTxn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Dec 2011 14:53:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony

These patches prepare for the introduction of the powerdomain device PM 
constraints, via the standard Linux device PM mechanism that Rafael 
Wysocki introduced.

After the powerdomain device PM constraints go in, we should be able to 
remove some of the OMAP PM interface (currently via platform_data function 
pointers) currently in our tree.

The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:

  Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 jp_hwmod_pm_dev_lat_devel_3.3

Jean Pihet (2):
      ARM: OMAP2+: hwmod: manage the wake-up latency constraints
      ARM: OMAP: omap_device: register to the per-device PM QoS framework

 arch/arm/mach-omap2/omap_hwmod.c             |   54 ++++++++++++++++++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    5 ++
 arch/arm/plat-omap/omap_device.c             |   74 ++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 1 deletions(-)
