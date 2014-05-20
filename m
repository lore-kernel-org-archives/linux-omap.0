From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3] omap l3-noc bus driver changes for v3.16 merge
 window, resend
Date: Mon, 19 May 2014 19:13:00 -0700
Message-ID: <20140520021300.GM15793@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51622 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751517AbaETCNH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 22:13:07 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 455c6fdbd219161bd09b1165f11699d6d73de11c:

  Linux 3.14 (2014-03-30 20:40:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.16/l3-noc-signed

for you to fetch changes up to 27b7d5f3cc49f2e5cd6c005d73696058b7140c5c:

  bus: omap_l3_noc: Add AM4372 interconnect error data (2014-05-05 14:34:37 -0500)

----------------------------------------------------------------
Improvments to omap l3-noc bus driver for v3.16 merge window
to add support for am347x and dra7.

----------------------------------------------------------------
Afzal Mohammed (2):
      bus: omap_l3_noc: ignore masked out unclearable targets
      bus: omap_l3_noc: Add AM4372 interconnect error data

Nishanth Menon (14):
      bus: omap_l3_noc: Fix copyright information
      bus: omap_l3_noc: remove iclk from omap_l3 struct
      bus: omap_l3_noc: populate l3->dev and use it
      bus: omap_l3_noc: switch over to relaxed variants of readl/writel
      bus: omap_l3_noc: un-obfuscate l3_targ address computation
      bus: omap_l3_noc: move L3 master data structure out
      bus: omap_l3_noc: convert target information into a structure
      bus: omap_l3_noc: convert flagmux information into a structure
      bus: omap_l3_noc: fix masterid detection
      bus: omap_l3_noc: make error reporting and handling common
      bus: omap_l3_noc: improve readability by using helper for slave event parsing
      bus: omap_l3_noc: add information about the type of operation
      bus: omap_l3_noc: Add information about the context of operation
      bus: omap_l3_noc: introduce concept of submodule

Peter Ujfalusi (5):
      drivers: bus: omap_l3: Convert to use devm_kzalloc
      drivers: bus: omap_l3: Convert to use devm_ioremap_resource()
      drivers: bus: omap_l3: Convert to use devm_request_irq()
      drivers: bus: omap_l3: Remove the platform driver's remove function
      drivers: bus: omap_l3: Change pr_crit() to dev_err() when IRQ request fails

Rajendra Nayak (2):
      bus: omap_l3_noc: Add support for discountinous flag mux input numbers
      bus: omap_l3_noc: Add DRA7 interconnect error data

Sricharan R (2):
      bus: omap_l3_noc: rename functions and data to omap_l3
      bus: omap_l3_noc: use of_match_data to pick up SoC information

 .../devicetree/bindings/arm/omap/l3-noc.txt        |   2 +
 drivers/bus/omap_l3_noc.c                          | 406 ++++++++-------
 drivers/bus/omap_l3_noc.h                          | 545 ++++++++++++++++-----
 3 files changed, 653 insertions(+), 300 deletions(-)
