From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/1] dying serial console in PM branch
Date: Mon, 19 Oct 2009 15:14:41 -0700
Message-ID: <1255990482-16201-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:41757 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410AbZJSWOj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2009 18:14:39 -0400
Received: by pxi1 with SMTP id 1so734958pxi.33
        for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2009 15:14:44 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch fixes the problems in the PM branch where the serial
console on UART3 was not able to wakeup after the inactivity timer.

This fix has been pushed to the PM branch already, but should also
be queued as a fix upstream.

Tony, this is available in my pm-upstream/pm-fixes-32 branch based at
v2.6.32-rc5.  I shouldn't have any more PM fixes coming for 2.6.32.

Kevin Hilman (1):
  OMAP3: PM: enable UART3 module wakeups

 arch/arm/mach-omap2/pm34xx.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

