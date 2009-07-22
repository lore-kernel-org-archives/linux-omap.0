From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFT 0/3] OMAP3: PM: PRCM interrupt updates
Date: Wed, 22 Jul 2009 11:48:19 -0700
Message-ID: <1248288502-3496-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:19773 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbZGVSsZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jul 2009 14:48:25 -0400
Received: by rv-out-0506.google.com with SMTP id f6so118285rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 22 Jul 2009 11:48:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series incoporates various changes/updates/fixes to the PRCM
interrupt handler.  Applies to current PM branch.

These could use some extra review and especially some testing.

I did some basic testing on 3430SDP (es3.0) and Zoom2 (es3.1)

Jon, I reworked your latest version a bit more, changing
the helper function (proposed by me) to take less args
in order to easily incoporate Paul's MPUGRPSEL fix.

Kevin



Jon Hunter (1):
  OMAP3: PM: Prevent hang in prcm_interrupt_handler

Paul Walmsley (2):
  OMAP3: PM: PRCM interrupt: check MPUGRPSEL register
  OMAP3: PM: PRCM interrupt: only handle selected PRCM interrupts

 arch/arm/mach-omap2/pm34xx.c |  170 ++++++++++++++++++++++--------------------
 1 files changed, 89 insertions(+), 81 deletions(-)

