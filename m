From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/5] Some OMAP clock/SCM patches for 2.6.34
Date: Mon, 11 Jan 2010 17:46:21 -0700
Message-ID: <20100112004326.24684.91321.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55129 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab0ALAra (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 19:47:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

these patches have been posted on the linux-omap mailing list and are
part of the planned queue for 2.6.34, but are being posted here in the event
that anyone else wishes to comment.  These patches include clock support for
the Sitara platform (AM35xx) and some minor clock code improvements.

- Paul


---

Paul Walmsley (3):
      OMAP3 clock: reorganize CK_* platform flags
      OMAP clock: make the fixed divisor clock code available for all OMAPs
      OMAP1 clock: convert armwdt_ck to use the fixed divisor recalc function

Ranjith Lohithakshan (2):
      AM35xx: Add AM35xx specific control module registers
      AM35xx: Clock table updates for AM3505/17


 arch/arm/mach-omap1/clock.c                   |    6 
 arch/arm/mach-omap1/clock_data.c              |    3 
 arch/arm/mach-omap2/clock.c                   |   11 -
 arch/arm/mach-omap2/clock.h                   |    1 
 arch/arm/mach-omap2/clock2xxx_data.c          |    4 
 arch/arm/mach-omap2/clock34xx_data.c          |  365 +++++++++++++------------
 arch/arm/plat-omap/clock.c                    |   11 +
 arch/arm/plat-omap/include/plat/clkdev_omap.h |   26 +-
 arch/arm/plat-omap/include/plat/clock.h       |    3 
 arch/arm/plat-omap/include/plat/control.h     |   17 +
 10 files changed, 237 insertions(+), 210 deletions(-)

