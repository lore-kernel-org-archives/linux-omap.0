From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/13] staging: ti dspbridge: deh rewrite
Date: Sun,  4 Jul 2010 16:34:26 +0300
Message-ID: <1278250479-16982-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40955 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757585Ab0GDNeo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jul 2010 09:34:44 -0400
Received: by bwz1 with SMTP id 1so2295322bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 04 Jul 2010 06:34:43 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg KH <greg@kroah.com>, Felipe Contreras <felipe.contreras@gmail.com>

Hi,

Investigating the MMU fault corruption issue I found a lot of areas of
improvements of the exception handling code.

Moreover, even though the obvious memory corruption is fixed on kernel side,
there are still some rare cases where corruption in user-space might be
possible if some buffers are still mapped. This came up in a discussion with
Fernando Lugo, and we both agreed on a fix (patch #7).

The rest is mostly reorganization.

(This is basically the same as the old one, but rebased to staging tree)

Felipe Contreras (13):
  staging: ti dspbridge: deh: trivial cleanups
  staging: ti dspbridge: mmufault: trivial cleanups
  staging: ti dspbridge: deh: free dummy page immediately
  staging: ti dspbridge: remove unused code
  staging: ti dspbridge: mmu: add hw_mmu_tlb_flush_all()
  staging: ti dspbridge: deh: ensure only tlb #0 is enabled
  staging: ti dspbridge: deh: refactor in mmu_fault_print_stack()
  staging: ti dspbridge: deh: remove get_info
  staging: ti dspbridge: deh: remove err_info
  staging: ti dspbridge: access deh directly
  staging: ti dspbridge: move mmufault to deh
  staging: ti dspbridge: deh: tidying up
  staging: ti dspbridge: deh: update copyright notice

 drivers/staging/tidspbridge/Makefile               |    2 +-
 drivers/staging/tidspbridge/core/_deh.h            |    2 +-
 drivers/staging/tidspbridge/core/_tiomap.h         |    6 +-
 drivers/staging/tidspbridge/core/mmu_fault.c       |  139 --------
 drivers/staging/tidspbridge/core/mmu_fault.h       |   36 --
 drivers/staging/tidspbridge/core/tiomap3430.c      |   17 +-
 drivers/staging/tidspbridge/core/ue_deh.c          |  336 +++++++++-----------
 drivers/staging/tidspbridge/hw/hw_mmu.c            |    6 +
 drivers/staging/tidspbridge/hw/hw_mmu.h            |    2 +
 .../staging/tidspbridge/include/dspbridge/dbdefs.h |    1 -
 .../tidspbridge/include/dspbridge/dspdefs.h        |   75 -----
 .../staging/tidspbridge/include/dspbridge/dspdeh.h |   20 +-
 drivers/staging/tidspbridge/pmgr/dev.c             |   17 +-
 drivers/staging/tidspbridge/rmgr/node.c            |    5 +-
 drivers/staging/tidspbridge/rmgr/proc.c            |   29 +--
 15 files changed, 184 insertions(+), 509 deletions(-)
 delete mode 100644 drivers/staging/tidspbridge/core/mmu_fault.c
 delete mode 100644 drivers/staging/tidspbridge/core/mmu_fault.h

