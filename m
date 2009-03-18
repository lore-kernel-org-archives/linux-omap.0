From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH B 0/3] tidspbridge: don't flood the mailbox
Date: Wed, 18 Mar 2009 03:26:42 +0200
Message-ID: <1237339605-20697-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:26266 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbZCRB04 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:26:56 -0400
Received: by fk-out-0910.google.com with SMTP id 18so135955fkq.5
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:26:52 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

This patch series is meant to be applied on top of the previous one (A) and
fixes a very nasty problem that causes interrupts to be constantly dropped
since the mailbox is full most of the time. The details are explained in patch
0001.

Flooding the mailbox causes reliability issues (messages lost) and performance
issues (busy looping waiting for a slot in the mailbox).

Felipe Contreras (3):
  tidspbridge: don't flood the mailbox on MemUnMap
  tidspbridge: cleanup and remove HW_MMU_TLBFlushAll
  tidspbridge: decreate timeout to a saner value

 drivers/dsp/bridge/hw/MMUAccInt.h   |    3 --
 drivers/dsp/bridge/hw/MMURegAcM.h   |   14 ----------
 drivers/dsp/bridge/hw/hw_mmu.c      |    9 ------
 drivers/dsp/bridge/hw/hw_mmu.h      |    2 -
 drivers/dsp/bridge/wmd/tiomap3430.c |   50 +++++++++++++++++++++-------------
 drivers/dsp/bridge/wmd/tiomap_sm.c  |    2 +-
 6 files changed, 32 insertions(+), 48 deletions(-)

