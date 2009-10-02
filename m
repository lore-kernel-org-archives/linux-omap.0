From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/5] OMAP PM fixes for 2.6.32
Date: Fri,  2 Oct 2009 11:14:50 -0700
Message-ID: <1254507295-11381-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:44292 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757597AbZJBSOx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 14:14:53 -0400
Received: by pzk7 with SMTP id 7so1224757pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 02 Oct 2009 11:14:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

These fixes are primarily for PRCM interrupt handler bugs
and GPIO wakeup support.

Jon Hunter (1):
  OMAP3: PM: Prevent hang in prcm_interrupt_handler

Kevin Hilman (1):
  OMAP3: PM: Enable GPIO module-level wakeups

Paul Walmsley (2):
  OMAP3: PM: PRCM interrupt: check MPUGRPSEL register
  OMAP3: PM: PRCM interrupt: only handle selected PRCM interrupts

Vikram Pandita (1):
  OMAP3: PM: USBHOST: clear wakeup events on both hosts

 arch/arm/mach-omap2/pm34xx.c |  187 ++++++++++++++++++++++++------------------
 1 files changed, 106 insertions(+), 81 deletions(-)

