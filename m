From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] few omap randconfig fixes for v3.10
Date: Thu, 18 Apr 2013 10:54:25 -0700
Message-ID: <20130418175303.7436.75241.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:13679 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751153Ab3DRRy2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Apr 2013 13:54:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Few trivial fixes for randconfig found issues.

Regards,

Tony

---

Tony Lindgren (3):
      ARM: OMAP2+: Fix unmet direct dependencies for SERIAL_OMAP
      ARM: OMAP2+: Fix unused variable warning for am3517 crane
      ARM: OMAP2+: Fix is_gpmc_muxed warning for H4


 arch/arm/configs/omap2plus_defconfig    |    2 ++
 arch/arm/mach-omap2/Kconfig             |    2 --
 arch/arm/mach-omap2/board-am3517crane.c |    2 --
 arch/arm/mach-omap2/board-h4.c          |    4 ++--
 4 files changed, 4 insertions(+), 6 deletions(-)

-- 
Signature
