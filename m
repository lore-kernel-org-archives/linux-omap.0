From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [RFC/RFT v2 0/4] PRCM interrupt handler updates/fixes/cleanups
Date: Fri, 24 Jul 2009 10:54:24 -0700
Message-ID: <1248458068-21747-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f184.google.com ([209.85.216.184]:61046 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbZGXRyc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 13:54:32 -0400
Received: by pxi14 with SMTP id 14so494297pxi.33
        for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2009 10:54:31 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series incoporates various changes/updates/fixes to the PRCM
interrupt handler.  Applies to current PM branch.

These could use some extra review and especially some testing.

I did some basic testing on 3430SDP (es3.0) and Zoom2 (es3.1)

Updates from previous series: I added a reworked version of
Vikram's USBHOST fix.

Kevin


Jon Hunter (1):
  OMAP3: PM: Prevent hang in prcm_interrupt_handler

Paul Walmsley (2):
  OMAP3: PM: PRCM interrupt: check MPUGRPSEL register
  OMAP3: PM: PRCM interrupt: only handle selected PRCM interrupts

Vikram Pandita (1):
  OMAP3: PM: USBHOST: clear wakeup events on both hosts

 arch/arm/mach-omap2/pm34xx.c |  177 +++++++++++++++++++++++-------------------
 1 files changed, 96 insertions(+), 81 deletions(-)

