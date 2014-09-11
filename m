From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap regression fixes against v3.17-rc4
Date: Thu, 11 Sep 2014 14:10:18 -0700
Message-ID: <20140911211018.GJ18849@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63524 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbaIKVKZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 17:10:25 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 2ce7598c9a453e0acd0e07be7be3f5eb39608ebd:

  Linux 3.17-rc4 (2014-09-07 16:09:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/fixes-v3.17-rc4

for you to fetch changes up to 41fc619dd5584d438d1eb673bd82a722d627ad85:

  bus: omap_l3_noc: Fix connID for OMAP4 (2014-09-11 10:43:39 -0700)

----------------------------------------------------------------
Few regression fixes for omaps for the -rc cycle:

- Fix for omap_l3_noc bus code
- Serial console fix for cm-t53
- NAND timings fix for dra7-evm

----------------------------------------------------------------
Dmitry Lifshitz (1):
      ARM: dts: cm-t54: fix serial console power supply.

Nishanth Menon (1):
      bus: omap_l3_noc: Fix connID for OMAP4

Roger Quadros (1):
      ARM: dts: dra7-evm: Fix NAND GPMC timings

 arch/arm/boot/dts/dra7-evm.dts     | 27 +++++++++-----------
 arch/arm/boot/dts/omap5-cm-t54.dts |  5 ++--
 drivers/bus/omap_l3_noc.h          | 50 +++++++++++++++++++-------------------
 3 files changed, 39 insertions(+), 43 deletions(-)
