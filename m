From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/4] OMAP clock/hwmod fixes for 2.6.34-rc
Date: Tue, 30 Mar 2010 01:56:38 -0600
Message-ID: <20100330074801.11629.61888.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41371 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764Ab0C3H64 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Mar 2010 03:58:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

here are some OMAP clock and hwmod fix patches that we're planning to
send upstream soon; comments welcome.


- Paul


---

Rajendra Nayak (1):
      OMAP4: prcm: Use logical OR instead of bitwise OR

Ranjith Lohithakshan (1):
      OMAP3: clock: fix enable bit used for dpll4_m4x2 clock

Thara Gopinath (2):
      OMAP: HWMOD: Adding clockdomain check
      OMAP: HWMOD: Bug fixes in hwmod structure definitions


 arch/arm/mach-omap2/clock3xxx_data.c         |    2 +-
 arch/arm/mach-omap2/clockdomain.c            |    6 +++---
 arch/arm/mach-omap2/omap_hwmod.c             |    3 +++
 arch/arm/mach-omap2/powerdomain.c            |    2 +-
 arch/arm/mach-omap2/prcm.c                   |    4 ++--
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +-
 6 files changed, 11 insertions(+), 8 deletions(-)

