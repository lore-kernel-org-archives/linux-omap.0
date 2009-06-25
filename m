From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/2] fixup merge mistakes in l-o master
Date: Thu, 25 Jun 2009 14:50:14 -0700
Message-ID: <1245966616-26804-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f189.google.com ([209.85.222.189]:34852 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbZFYVuQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 17:50:16 -0400
Received: by pzk27 with SMTP id 27so1605018pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 14:50:19 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Here's a couple patches to undo some merge mistakes and fixup l-o
master so patches apply to l-o master and upstream.

Kevin Hilman (2):
  OMAP3: Kconfig: remove duplicate board entries
  OMAP3: omap3evm: undo ehci change to board-omap3evm.c

 arch/arm/mach-omap2/Kconfig          |   12 ------------
 arch/arm/mach-omap2/board-omap3evm.c |    1 -
 2 files changed, 0 insertions(+), 13 deletions(-)

