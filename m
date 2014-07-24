From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] non-urgent omap fixes for v3.17 merge window
Date: Thu, 24 Jul 2014 04:51:41 -0700
Message-ID: <20140724115140.GB29045@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42820 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbaGXLxG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jul 2014 07:53:06 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit cd3de83f147601356395b57a8673e9c5ff1e59d1:

  Linux 3.16-rc4 (2014-07-06 12:37:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.17/fixes-not-urgent-signed

for you to fetch changes up to 00e4e5b5b0339bde4b0ecb23d7d7969a3bebd44d:

  Merge remote-tracking branch 'roger/for-v3.17/gpmc-omap' into omap-for-v3.17/fixes-not-urgent (2014-07-15 00:24:39 -0700)

----------------------------------------------------------------

Fixes for omaps that were not considered urgent enough for the
rc series. Mostly a fix for GPMC allocation and omap5 ABB
(Adaptive Body Bias).

----------------------------------------------------------------
Andrii.Tseglytskyi (1):
      ARM: dts: OMAP5: Add device nodes for ABB

Nicholas Krause (1):
      omap16xx: Removes fixme no longer needed in ocpi_enable()

Rickard Strandqvist (1):
      ARM: omap2+: usb-tusb6010.c: Cleaning up variable is set more than once

Rostislav Lisovy (1):
      ARM: omap2+: gpmc-nand: Use dynamic platform_device_alloc()

Tony Lindgren (1):
      Merge remote-tracking branch 'roger/for-v3.17/gpmc-omap' into omap-for-v3.17/fixes-not-urgent

 arch/arm/boot/dts/omap5.dtsi       | 60 +++++++++++++++++++++++++++++
 arch/arm/mach-omap1/ocpi.c         |  1 -
 arch/arm/mach-omap2/gpmc-nand.c    | 79 ++++++++++++++++++--------------------
 arch/arm/mach-omap2/usb-tusb6010.c |  1 -
 4 files changed, 97 insertions(+), 44 deletions(-)
