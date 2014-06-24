From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/3] Misc. DSPBridge build/boot fixes
Date: Tue, 24 Jun 2014 00:24:24 -0500
Message-ID: <1403587467-59876-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35519 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbaFXFZJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 01:25:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Hi,

The following are couple of miscellaneous patches for fixing build and
boot issues when I attempted to build TI DSP/Bridge while doing the
adaptation and validation of OMAP mailbox driver against the mailbox
framework. The DSP/Bridge driver is disabled by default, so these can
be treated as non-urgent fixes.

Suman Anna (3):
  staging: tidspbridge: fix an erroneous removal of parentheses
  ARM: OMAP3: PRM/CM: Add back macros used by TI DSP/Bridge driver
  ARM: OMAP2+: create dsp device only on OMAP3 SoCs

 arch/arm/mach-omap2/cm-regbits-34xx.h         |  3 +++
 arch/arm/mach-omap2/dsp.c                     | 10 ++++++++++
 arch/arm/mach-omap2/prm-regbits-34xx.h        |  6 ++++++
 drivers/staging/tidspbridge/core/tiomap3430.c |  6 ++++--
 4 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.0.0

